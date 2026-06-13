-- SAIF / LSIF Dev v0.26A.1.13
-- PREVIEW ONLY: remove latest parked_vehicles archive snapshot.
-- SAFETY: ends with ROLLBACK. Review IDs/counts, then change final ROLLBACK to COMMIT only if intentionally discarding the snapshot.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @archive_session_id := (
    SELECT id FROM offline_runtime_archive_sessions
    WHERE archive_scope='parked_vehicles'
    ORDER BY id DESC LIMIT 1
);

SELECT * FROM offline_runtime_archive_sessions WHERE id=@archive_session_id;
SELECT COUNT(*) AS archive_rows_that_would_be_deleted
FROM offline_parked_vehicles_archive
WHERE archive_session_id=@archive_session_id;

DELETE FROM offline_parked_vehicles_archive WHERE archive_session_id=@archive_session_id;
DELETE FROM offline_runtime_archive_sessions WHERE id=@archive_session_id AND archive_scope='parked_vehicles';

SELECT ROW_COUNT() AS session_rows_deleted_inside_uncommitted_transaction;
ROLLBACK;
