-- SAIF v0.26A.1.6 ENEX Context Resolver verification
SET NAMES utf8mb4;
SET @offline_session_id := (SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1);

SELECT @offline_session_id AS latest_session_id;
SELECT status, parser_version, total_records, warning_count, error_count
FROM offline_import_sessions WHERE id=@offline_session_id;

SELECT
    COUNT(*) AS total_enex,
    SUM(resolver_status='resolved') AS resolved_rows,
    SUM(resolver_status='partial') AS partial_rows,
    SUM(resolver_status='review_required') AS review_required_rows,
    SUM(resolver_status='pending') AS pending_rows_should_be_zero,
    SUM(enabled=1) AS enabled_rows_should_be_zero,
    SUM(apply_status <> 'pending') AS non_pending_apply_rows_should_be_zero,
    SUM(resolver_version='saif-enex-context-resolver-v0.26A.1.6') AS resolver_version_rows,
    SUM(resolved_at IS NULL) AS unresolved_timestamp_rows_should_be_zero
FROM offline_interior_queue
WHERE session_id=@offline_session_id;

SELECT resolver_status, COUNT(*) AS total
FROM offline_interior_queue
WHERE session_id=@offline_session_id
GROUP BY resolver_status
ORDER BY resolver_status;

SELECT access_scope, COUNT(*) AS total
FROM offline_interior_queue
WHERE session_id=@offline_session_id
GROUP BY access_scope
ORDER BY total DESC, access_scope;

SELECT recommended_runtime_target, COUNT(*) AS total
FROM offline_interior_queue
WHERE session_id=@offline_session_id
GROUP BY recommended_runtime_target
ORDER BY total DESC, recommended_runtime_target;

SELECT resolved_context_type, COUNT(*) AS total
FROM offline_interior_queue
WHERE session_id=@offline_session_id
GROUP BY resolved_context_type
ORDER BY total DESC, resolved_context_type;

SELECT pair_status, COUNT(*) AS total
FROM offline_interior_queue
WHERE session_id=@offline_session_id
GROUP BY pair_status
ORDER BY total DESC, pair_status;

SELECT COUNT(*) AS evidence_rows
FROM offline_interior_context_evidence
WHERE session_id=@offline_session_id
  AND resolver_version='saif-enex-context-resolver-v0.26A.1.6';

SELECT id, raw_name, resolved_display_name, resolved_context_type,
       access_scope, recommended_runtime_target, resolver_confidence,
       resolver_reason, source_file, source_line
FROM offline_interior_queue
WHERE session_id=@offline_session_id
  AND resolver_status='review_required'
ORDER BY raw_name, id;

-- Confirm runtime tables were not part of this patch manually with /livedbaudit.
