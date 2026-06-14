-- SAIF / LSIF Dev v0.26A.1.24
-- PREVIEW ONLY: discard the latest house_catalog + ownership archive snapshot.
-- SAFETY: ends with ROLLBACK. Replace final ROLLBACK with COMMIT only when intentionally deleting the snapshot.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;
SET @archive_session_id := (SELECT id FROM offline_runtime_archive_sessions WHERE archive_scope='house_catalog' ORDER BY id DESC LIMIT 1);

SELECT * FROM offline_runtime_archive_sessions WHERE id=@archive_session_id;
SELECT COUNT(*) catalog_archive_rows_that_would_be_deleted FROM offline_house_catalog_archive WHERE archive_session_id=@archive_session_id;
SELECT COUNT(*) ownership_archive_rows_that_would_be_deleted FROM offline_house_ownership_archive WHERE archive_session_id=@archive_session_id;
SELECT COUNT(*) ownership_transition_rows_that_would_be_deleted FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id;

DELETE FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id;
DELETE FROM offline_house_ownership_archive WHERE archive_session_id=@archive_session_id;
DELETE FROM offline_house_catalog_archive WHERE archive_session_id=@archive_session_id;
DELETE FROM offline_runtime_archive_sessions WHERE id=@archive_session_id AND archive_scope='house_catalog';
SELECT ROW_COUNT() session_rows_deleted_inside_uncommitted_transaction;
ROLLBACK;
