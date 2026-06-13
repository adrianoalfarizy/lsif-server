-- SAIF / LSIF Dev v0.26A.1.19
-- PREVIEW ONLY: discard the latest world_pickups archive snapshot.
-- SAFETY: ends with ROLLBACK. Change final ROLLBACK to COMMIT only when intentionally deleting the snapshot.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;
SET @archive_session_id := (SELECT id FROM offline_runtime_archive_sessions WHERE archive_scope='world_pickups' ORDER BY id DESC LIMIT 1);
SELECT * FROM offline_runtime_archive_sessions WHERE id=@archive_session_id;
SELECT COUNT(*) archive_rows_that_would_be_deleted FROM offline_world_pickups_archive WHERE archive_session_id=@archive_session_id;
DELETE FROM offline_world_pickups_archive WHERE archive_session_id=@archive_session_id;
DELETE FROM offline_runtime_archive_sessions WHERE id=@archive_session_id AND archive_scope='world_pickups';
SELECT ROW_COUNT() session_rows_deleted_inside_uncommitted_transaction;
ROLLBACK;
