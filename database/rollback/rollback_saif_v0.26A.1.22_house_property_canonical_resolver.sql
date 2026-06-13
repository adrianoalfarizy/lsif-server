-- SAIF v0.26A.1.22 rollback staging resolver only
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;
DELETE FROM offline_property_resolver_sessions WHERE resolver_version='saif-house-property-resolver-v0.26A.1.22';
SELECT ROW_COUNT() AS resolver_sessions_deleted_cascade_plans;
COMMIT;
-- No player_houses, public_interiors, world_pickups or ownership rows are changed.
