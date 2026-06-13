-- SAIF / LSIF Dev v0.26A.1.14
-- State check after a failed Full-130 apply attempt. SELECT only.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SELECT 'LIVE_APPLY_SESSIONS' AS section,
       COUNT(*) AS live_completed_apply_should_be_zero_before_first_success
FROM offline_runtime_apply_sessions
WHERE apply_scope='parked_vehicles_offline_130'
  AND apply_status='complete' AND rolled_back_at IS NULL;

SELECT 'INCOMPLETE_APPLY_SESSIONS' AS section,
       COUNT(*) AS applying_session_should_be_zero
FROM offline_runtime_apply_sessions
WHERE apply_scope='parked_vehicles_offline_130'
  AND apply_status='applying';

SELECT 'IMPORTED_RUNTIME' AS section,
       COUNT(*) AS imported_runtime_rows,
       SUM(enabled=1) AS imported_enabled_rows
FROM parked_vehicles
WHERE source_tag LIKE 'offline_gtasa_parkveh130_a%';

SELECT 'MAPPINGS' AS section,
       COUNT(*) AS apply_mapping_rows
FROM offline_parked_vehicle_apply_rows;

SELECT 'LATEST_ARCHIVE' AS section,id,archive_status,runtime_rows_total,active_rows_total,archived_rows,
       (archive_status='complete' AND runtime_rows_total=archived_rows) AS archive_ready_should_be_1
FROM offline_runtime_archive_sessions
WHERE archive_scope='parked_vehicles'
ORDER BY id DESC LIMIT 1;
