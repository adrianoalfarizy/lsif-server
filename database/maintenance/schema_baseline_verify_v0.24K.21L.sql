-- ==========================================================
-- SAIF / LSIF v0.24K.21L Clean Schema Baseline Verify
-- READ ONLY. Safe for live DB.
-- Purpose: verify actual live DB still matches runtime-table assumptions.
-- ==========================================================

SELECT 'absent_legacy_tables_should_be_0' AS check_name, COUNT(*) AS result
FROM information_schema.tables
WHERE table_schema = DATABASE()
  AND table_name IN ('turf_config', 'business', 'businesses');

SELECT 'runtime_tables_present_should_be_35' AS check_name, COUNT(*) AS result
FROM information_schema.tables
WHERE table_schema = DATABASE()
  AND table_name IN (
    'admin_logs','bans','beta_whitelist','business_preset_config','feedback_reports',
    'gang_hq_interiors','gang_member_stats','gang_members','gang_preset_config','gang_territories',
    'gang_weapon_logs','gang_weapon_stash','gangs','job_stats','organization_members','organizations',
    'parked_vehicle_import_queue','parked_vehicles','player_businesses','player_houses',
    'player_vehicles','player_weapons','players','public_interior_import_queue','public_interiors',
    'public_service_config','race_records','reports','server_settings','turf_war_logs',
    'weapon_shop_config','world_locations','world_objects','world_pickup_import_queue','world_pickups'
  );

SELECT 'archive_tables_present_info' AS check_name, COUNT(*) AS result
FROM information_schema.tables
WHERE table_schema = DATABASE()
  AND table_name LIKE 'saif_archive_%';

SELECT 'gang_hq_door_columns_present_should_be_8' AS check_name, COUNT(*) AS result
FROM information_schema.columns
WHERE table_schema = DATABASE()
  AND table_name = 'gang_hq_interiors'
  AND column_name IN ('door_x','door_y','door_z','door_a','int_exit_x','int_exit_y','int_exit_z','int_exit_a');

SELECT 'active_deprecated_world_locations_should_be_0' AS check_name, COUNT(*) AS result
FROM world_locations
WHERE enabled = 1
  AND source_tag IN ('legacy_static_migrated', 'offline_template_ls', 'curated_template', 'unknown');

SELECT 'active_runtime_marker_world_locations_info' AS check_name, COUNT(*) AS result
FROM world_locations
WHERE enabled = 1
  AND source_tag = 'saif_runtime_marker';

SELECT 'disabled_manual_or_legacy_runtime_rows_should_be_0' AS check_name,
    (
      SELECT COUNT(*) FROM world_locations WHERE enabled = 0 AND source_tag IN ('legacy_static_migrated','manual')
    ) +
    (
      SELECT COUNT(*) FROM parked_vehicles WHERE enabled = 0 AND source_tag = 'manual'
    ) +
    (
      SELECT COUNT(*) FROM public_interiors WHERE enabled = 0 AND source_tag = 'manual'
    ) AS result;
