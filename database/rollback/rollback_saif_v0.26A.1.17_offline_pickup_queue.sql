-- Rollback SAIF v0.26A.1.17 staging only
-- Does not touch world_pickups.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;
SET @offline_session_key := _utf8mb4'ecbbfa867b491c93570b92e0c6d3ff34e1e916da9df914d83edb066c1eac52c3' COLLATE utf8mb4_unicode_ci;
SET @offline_session_id := (SELECT id FROM offline_import_sessions WHERE BINARY session_key=BINARY @offline_session_key LIMIT 1);
DELETE FROM offline_pickup_queue WHERE parser_version='saif-pickup-parser-v0.26A.1.17';
DELETE FROM offline_import_logs WHERE session_id=@offline_session_id AND component='PICKUP_QUEUE_PARSER';
COMMIT;
SELECT COUNT(*) AS remaining_should_be_zero FROM offline_pickup_queue WHERE parser_version='saif-pickup-parser-v0.26A.1.17';
