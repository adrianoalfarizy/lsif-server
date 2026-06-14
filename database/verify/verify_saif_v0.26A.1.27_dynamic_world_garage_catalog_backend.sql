-- SAIF / LSIF Dev v0.26A.1.27 verification
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @resolver_version := 'saif-garage-canonical-resolver-v0.26A.1.26';
SET @sid := (SELECT id FROM offline_garage_resolver_sessions WHERE BINARY resolver_version=BINARY @resolver_version AND status='complete' ORDER BY id DESC LIMIT 1);

SELECT 'SCHEMA_GATE' section,
       (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='garage_runtime_policy') policy_table_should_be_1,
       (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='garage_catalog') catalog_table_should_be_1,
       (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='house_garage_links') links_table_should_be_1,
       (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='garage_catalog' AND column_name IN ('bound_x1','bound_y1','bound_z1','bound_x2','bound_y2','bound_x3','bound_y3','bound_z2')) normalized_bounds_columns_should_be_8,
       (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='garage_catalog' AND column_name IN ('vehicle_spawn_x','vehicle_spawn_y','vehicle_spawn_z','vehicle_spawn_a','spawn_status')) spawn_columns_should_be_5;

SELECT 'POLICY_GATE' section,policy_key,enabled,max_catalog_rows,interaction_radius,vehicle_required,inherit_house_owner,
       store_enabled,retrieve_enabled,door_animation_enabled,
       (policy_key='offline_house_garage_bridge_v1' AND enabled=0 AND max_catalog_rows=64 AND vehicle_required=1 AND inherit_house_owner=1 AND store_enabled=0 AND retrieve_enabled=0 AND door_animation_enabled=0) ready_should_be_1
FROM garage_runtime_policy WHERE id=1;

SELECT 'SOURCE_READINESS_GATE' section,
       (SELECT COUNT(*) FROM offline_garage_canonical_plan WHERE resolver_session_id=@sid) canonical_garages_expected_52,
       (SELECT COUNT(*) FROM offline_garage_house_links WHERE resolver_session_id=@sid) all_house_links_expected_13,
       (SELECT COUNT(*) FROM offline_garage_house_links WHERE resolver_session_id=@sid AND link_class='baseline_savehouse_candidate') baseline_links_expected_12,
       (SELECT COUNT(*) FROM offline_garage_house_links WHERE resolver_session_id=@sid AND link_class='story_asset_deferred') story_links_expected_1,
       (SELECT COUNT(*) FROM offline_garage_house_links l LEFT JOIN house_catalog hc ON hc.canonical_slot=l.house_slot AND hc.enabled=1 WHERE l.resolver_session_id=@sid AND l.link_class='baseline_savehouse_candidate' AND hc.id IS NULL) missing_live_house_should_be_zero,
       (SELECT COUNT(*) FROM offline_garage_house_links l JOIN offline_garage_canonical_plan gp ON gp.id=l.garage_plan_id WHERE l.resolver_session_id=@sid AND l.link_class='baseline_savehouse_candidate' AND (JSON_VALID(gp.bounds_json)=0 OR JSON_LENGTH(JSON_EXTRACT(gp.bounds_json,'$.values'))<>8)) invalid_bounds_should_be_zero;

SELECT 'RUNTIME_UNTOUCHED_GATE' section,
       (SELECT COUNT(*) FROM garage_catalog) catalog_rows_should_be_zero,
       (SELECT COUNT(*) FROM garage_catalog WHERE enabled=1) enabled_catalog_should_be_zero,
       (SELECT COUNT(*) FROM garage_catalog WHERE apply_status<>'draft') nondraft_catalog_should_be_zero,
       (SELECT COUNT(*) FROM house_garage_links) link_rows_should_be_zero,
       (SELECT COUNT(*) FROM player_vehicles) player_vehicle_rows_informational,
       (SELECT COUNT(*) FROM player_houses) player_house_rows_informational;

SELECT 'FINAL_GATE' section,
       (
         @sid IS NOT NULL
         AND (SELECT COUNT(*) FROM offline_garage_canonical_plan WHERE resolver_session_id=@sid)=52
         AND (SELECT COUNT(*) FROM offline_garage_house_links WHERE resolver_session_id=@sid AND link_class='baseline_savehouse_candidate')=12
         AND (SELECT COUNT(*) FROM offline_garage_house_links l LEFT JOIN house_catalog hc ON hc.canonical_slot=l.house_slot AND hc.enabled=1 WHERE l.resolver_session_id=@sid AND l.link_class='baseline_savehouse_candidate' AND hc.id IS NULL)=0
         AND (SELECT COUNT(*) FROM garage_catalog)=0
         AND (SELECT COUNT(*) FROM house_garage_links)=0
         AND (SELECT enabled+store_enabled+retrieve_enabled+door_animation_enabled FROM garage_runtime_policy WHERE id=1)=0
       ) ready_should_be_1;
