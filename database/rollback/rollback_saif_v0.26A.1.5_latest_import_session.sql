-- Roll back ONLY the latest staging import session.
-- Does not touch public_interiors, world_pickups, parked_vehicles, or other runtime tables.
-- Review @offline_session_id before COMMIT.

START TRANSACTION;

SET @offline_session_id := (SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1);
SELECT @offline_session_id AS session_to_remove;

DELETE FROM offline_import_logs WHERE session_id = @offline_session_id;
DELETE FROM offline_interior_queue WHERE session_id = @offline_session_id;
DELETE FROM offline_source_files WHERE session_id = @offline_session_id;
DELETE FROM offline_import_sessions WHERE id = @offline_session_id;

-- Replace ROLLBACK with COMMIT only after reviewing the selected session id.
ROLLBACK;
