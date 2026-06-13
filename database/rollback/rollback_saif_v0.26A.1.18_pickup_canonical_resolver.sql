-- SAIF v0.26A.1.18 rollback: canonical staging only
-- Does not touch world_pickups.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;
SET @resolver_version := _utf8mb4'saif-pickup-resolver-v0.26A.1.18' COLLATE utf8mb4_unicode_ci;
SET @queue_session_id := (SELECT MAX(session_id) FROM offline_pickup_queue WHERE parser_version='saif-pickup-parser-v0.26A.1.17');
DELETE FROM offline_import_logs WHERE session_id=@queue_session_id AND component='PICKUP_CANONICAL_RESOLVER';
DELETE FROM offline_pickup_resolver_sessions WHERE BINARY resolver_version=BINARY @resolver_version;
COMMIT;
SELECT COUNT(*) AS remaining_should_be_zero
FROM offline_pickup_canonical_plan WHERE BINARY resolver_version=BINARY @resolver_version;
