-- SAIF v0.26A.1.7 staging rollback preview
-- Review counts first. Change final ROLLBACK to COMMIT only when intentionally removing planner metadata.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;
SET @plan_version := _utf8mb4'saif_enex_pair_planner_v0.26A.1.7' COLLATE utf8mb4_unicode_ci;
SET @session_id := (SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1);
SELECT COUNT(*) plan_rows_to_remove FROM offline_interior_apply_plan WHERE session_id=@session_id AND plan_version=@plan_version;
SELECT COUNT(*) batch_rows_to_remove FROM offline_interior_apply_batches WHERE session_id=@session_id AND plan_version=@plan_version;
DELETE FROM offline_interior_apply_plan WHERE session_id=@session_id AND plan_version=@plan_version;
DELETE FROM offline_interior_apply_batches WHERE session_id=@session_id AND plan_version=@plan_version;
ROLLBACK;
