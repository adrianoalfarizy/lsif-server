-- SAIF / LSIF Dev v0.26A.1.9 archive snapshot rollback preview
-- SAFETY: ends with ROLLBACK. Change to COMMIT only after checking @latest_archive_session_id.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @latest_archive_session_id := (
    SELECT id
    FROM offline_runtime_archive_sessions
    WHERE archive_scope='public_interiors'
    ORDER BY id DESC
    LIMIT 1
);

SELECT *
FROM offline_runtime_archive_sessions
WHERE id=@latest_archive_session_id;

SELECT COUNT(*) AS archive_rows_to_delete
FROM offline_public_interiors_archive
WHERE archive_session_id=@latest_archive_session_id;

DELETE FROM offline_public_interiors_archive
WHERE archive_session_id=@latest_archive_session_id;

DELETE FROM offline_runtime_archive_sessions
WHERE id=@latest_archive_session_id;

ROLLBACK;
