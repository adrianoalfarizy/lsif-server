-- Rollback preview for v0.26A.1.11 staging queue only
-- Default ROLLBACK. Change final statement to COMMIT only after reviewing @offline_session_id.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;
SET @offline_session_key := _utf8mb4'ecbbfa867b491c93570b92e0c6d3ff34e1e916da9df914d83edb066c1eac52c3' COLLATE utf8mb4_unicode_ci;
SET @offline_session_id := (SELECT id FROM offline_import_sessions WHERE session_key COLLATE utf8mb4_unicode_ci=@offline_session_key LIMIT 1);
SELECT @offline_session_id session_to_clean, COUNT(*) queue_rows_to_delete FROM offline_vehicle_queue WHERE session_id=@offline_session_id AND parser_version='saif-vehicle-parser-v0.26A.1.11';
DELETE FROM offline_import_logs WHERE session_id=@offline_session_id AND component='SCM_CARGEN_PARSER';
DELETE FROM offline_vehicle_queue WHERE session_id=@offline_session_id AND parser_version='saif-vehicle-parser-v0.26A.1.11';
ROLLBACK;
