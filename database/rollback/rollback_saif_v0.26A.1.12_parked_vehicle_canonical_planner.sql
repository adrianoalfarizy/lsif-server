-- Rollback preview SAIF v0.26A.1.12 planner metadata only
-- Review result, then replace ROLLBACK with COMMIT to execute.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;
SET @offline_session_key := _utf8mb4'ecbbfa867b491c93570b92e0c6d3ff34e1e916da9df914d83edb066c1eac52c3' COLLATE utf8mb4_unicode_ci;
SET @offline_session_id := (SELECT id FROM offline_import_sessions WHERE session_key COLLATE utf8mb4_unicode_ci=@offline_session_key LIMIT 1);
DELETE FROM offline_vehicle_apply_plan WHERE session_id=@offline_session_id AND planner_version='saif-vehicle-canonical-planner-v0.26A.1.12';
DELETE FROM offline_vehicle_apply_batches WHERE session_id=@offline_session_id AND planner_version='saif-vehicle-canonical-planner-v0.26A.1.12';
SELECT ROW_COUNT() AS last_delete_count;
ROLLBACK;
