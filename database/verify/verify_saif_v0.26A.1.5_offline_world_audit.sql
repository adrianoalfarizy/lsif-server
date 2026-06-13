-- SAIF / LSIF Dev v0.26A.1.5
-- Read-only verification for the latest GTA SA offline staging import.
-- Expected supplied-source baseline: 275 source files, 376 ENEX rows, 4 warnings, 0 enabled rows.

SELECT
    id,
    session_label,
    source_version,
    parser_version,
    status,
    total_files,
    parsed_files,
    total_records,
    warning_count,
    error_count,
    created_at
FROM offline_import_sessions
ORDER BY id DESC
LIMIT 5;

SET @offline_session_id := (SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1);

SELECT
    @offline_session_id AS latest_session_id,
    COUNT(*) AS registered_files,
    SUM(parse_status LIKE 'parsed%') AS parsed_files,
    SUM(record_count) AS source_record_count,
    CASE WHEN COUNT(*) = 275 THEN 'PASS' ELSE 'CHECK' END AS expected_275_files
FROM offline_source_files
WHERE session_id = @offline_session_id;

SELECT
    COUNT(*) AS total_enex,
    SUM(enabled = 1) AS enabled_rows_should_be_zero,
    SUM(review_status = 'pending') AS pending_review,
    SUM(apply_status = 'pending') AS pending_apply,
    SUM(source_file_id IS NULL) AS unlinked_source_file_rows_should_be_zero,
    SUM(confidence >= 90) AS confidence_90_plus,
    SUM(confidence < 50) AS confidence_below_50,
    SUM(raw_name = '') AS blank_names,
    SUM(ABS(entry_x) > 4000 OR ABS(entry_y) > 4000 OR entry_z < -1000 OR entry_z > 2000) AS invalid_entry_coordinates,
    CASE WHEN COUNT(*) = 376 THEN 'PASS' ELSE 'CHECK' END AS expected_376_enex,
    CASE WHEN SUM(enabled = 1) = 0 THEN 'PASS' ELSE 'FAIL' END AS staging_disabled_guard
FROM offline_interior_queue
WHERE session_id = @offline_session_id;

SELECT log_level, component, COUNT(*) AS total
FROM offline_import_logs
WHERE session_id = @offline_session_id
GROUP BY log_level, component
ORDER BY log_level, component;

SELECT category, context_type, COUNT(*) AS total
FROM offline_interior_queue
WHERE session_id = @offline_session_id
GROUP BY category, context_type
ORDER BY category, total DESC, context_type;

SELECT city_code, area_code, COUNT(*) AS total
FROM offline_interior_queue
WHERE session_id = @offline_session_id
GROUP BY city_code, area_code
ORDER BY total DESC, city_code, area_code
LIMIT 50;

SELECT id, raw_name, display_name, category, context_type, confidence,
       entry_x, entry_y, entry_z, interior_id, city_code, area_code,
       source_file, source_line, notes
FROM offline_interior_queue
WHERE session_id = @offline_session_id
  AND (confidence < 50 OR raw_name = '' OR notes <> '')
ORDER BY confidence ASC, id ASC
LIMIT 100;

SELECT session_id, record_hash, COUNT(*) AS duplicate_count
FROM offline_interior_queue
GROUP BY session_id, record_hash
HAVING COUNT(*) > 1;
