-- SAIF / LSIF Dev v0.24K.21F - Schema Consolidation Verification (READ ONLY)
-- Run this after v0.24K.21A-E cleanup to verify live DB structure/inventory.

SELECT 'tables_total' AS check_name, COUNT(*) AS value
FROM information_schema.tables
WHERE table_schema = DATABASE();

SELECT 'runtime_tables_expected_35' AS check_name, COUNT(*) AS value
FROM information_schema.tables
WHERE table_schema = DATABASE()
  AND table_name IN (
    'players','player_vehicles','admin_logs','bans','reports','race_records','job_stats',
    'player_houses','organizations','organization_members','gangs','gang_members','gang_member_stats',
    'gang_territories','turf_war_logs','feedback_reports','beta_whitelist','player_businesses',
    'business_preset_config','gang_preset_config','parked_vehicles','world_pickups','public_interiors',
    'world_locations','world_objects','parked_vehicle_import_queue','world_pickup_import_queue',
    'public_interior_import_queue','server_settings','player_weapons','weapon_shop_config',
    'gang_weapon_stash','gang_weapon_logs','gang_hq_interiors','public_service_config'
  );

SELECT 'duplicate_source_tag_indexes_should_be_0' AS check_name, COUNT(*) AS value
FROM information_schema.statistics
WHERE table_schema = DATABASE()
  AND index_name IN ('idx_parked_vehicles_source_tag','idx_public_interiors_source_tag');

SELECT 'needed_audit_indexes_present_should_be_3' AS check_name, COUNT(*) AS value
FROM information_schema.statistics
WHERE table_schema = DATABASE()
  AND index_name IN ('idx_world_locations_source_tag','idx_gang_territories_enabled','idx_gang_territories_source_tag');

SELECT 'gang_hq_door_columns_present_should_be_8' AS check_name, COUNT(*) AS value
FROM information_schema.columns
WHERE table_schema = DATABASE()
  AND table_name = 'gang_hq_interiors'
  AND column_name IN ('door_x','door_y','door_z','door_a','int_exit_x','int_exit_y','int_exit_z','int_exit_a');

SELECT 'archive_tables_present_info' AS check_name, COUNT(*) AS value
FROM information_schema.tables
WHERE table_schema = DATABASE()
  AND table_name LIKE 'saif_archive_%';
