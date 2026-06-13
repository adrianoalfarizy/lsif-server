-- SAIF v0.26A.1.21 rollback: staging queue only
-- Does not touch player_houses/public_interiors/world_pickups/garage runtime.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;
DELETE q FROM offline_property_source_queue q JOIN offline_property_source_sessions s ON s.id=q.session_id WHERE BINARY s.parser_version=BINARY 'saif-property-source-parser-v0.26A.1.21';
DELETE FROM offline_property_source_sessions WHERE BINARY parser_version=BINARY 'saif-property-source-parser-v0.26A.1.21';
COMMIT;
SELECT 'ROLLBACK_COMPLETE' AS section,'saif-property-source-parser-v0.26A.1.21' AS removed_parser_version;
