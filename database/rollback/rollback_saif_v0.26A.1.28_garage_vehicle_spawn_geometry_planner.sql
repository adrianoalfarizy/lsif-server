-- SAIF / LSIF Dev v0.26A.1.28 rollback
-- Removes only v0.26A.1.28 staging geometry sessions/plans.
-- Does not touch offline_garage_canonical_plan, garage_catalog, house_garage_links, player_vehicles, player_houses, house_catalog, doors, objects, or checkpoints.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @planner_version := 'saif-garage-geometry-planner-v0.26A.1.28';
START TRANSACTION;
DELETE p FROM offline_garage_geometry_plan p
JOIN offline_garage_geometry_sessions s ON s.id=p.geometry_session_id
WHERE BINARY s.planner_version=BINARY @planner_version;
DELETE FROM offline_garage_geometry_sessions WHERE BINARY planner_version=BINARY @planner_version;
COMMIT;
SELECT 'ROLLBACK_COMPLETE' section,
       (SELECT COUNT(*) FROM offline_garage_geometry_sessions WHERE BINARY planner_version=BINARY @planner_version) sessions_should_be_zero,
       (SELECT COUNT(*) FROM offline_garage_geometry_plan p JOIN offline_garage_geometry_sessions s ON s.id=p.geometry_session_id WHERE BINARY s.planner_version=BINARY @planner_version) plans_should_be_zero,
       'Runtime garage/vehicle/house tables untouched.' safety_contract;
