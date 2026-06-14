-- SAIF / LSIF Dev v0.26A.1.27
-- Read-only mapping dry-run: 12 baseline savehouse garage links -> live house_catalog.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @resolver_version := 'saif-garage-canonical-resolver-v0.26A.1.26';
SET @garage_resolver_session_id := (
    SELECT id FROM offline_garage_resolver_sessions
    WHERE BINARY resolver_version=BINARY @resolver_version AND status='complete'
    ORDER BY id DESC LIMIT 1
);

SELECT 'SOURCE_SESSION' section,id,status,total_garages,linked_house_plans,baseline_house_links,story_asset_links,invalid_bounds
FROM offline_garage_resolver_sessions WHERE id=@garage_resolver_session_id;

SELECT 'BASELINE_MAPPING_GATE' section,
       COUNT(*) source_links_expected_12,
       COUNT(DISTINCT l.house_slot) unique_house_slots_expected_12,
       COUNT(DISTINCT l.garage_plan_id) unique_garage_plans_informational,
       SUM(hc.id IS NULL) missing_live_house_should_be_zero,
       SUM(hc.enabled<>1) disabled_live_house_should_be_zero,
       SUM(gp.id IS NULL) missing_garage_plan_should_be_zero,
       SUM(gp.safety_class<>'baseline_savehouse_candidate') wrong_safety_class_should_be_zero,
       SUM(JSON_VALID(gp.bounds_json)=0 OR JSON_LENGTH(JSON_EXTRACT(gp.bounds_json,'$.values'))<>8) invalid_bounds_should_be_zero,
       SUM(gp.center_x=0 AND gp.center_y=0 AND gp.center_z=0) zero_center_should_be_zero
FROM offline_garage_house_links l
JOIN offline_garage_canonical_plan gp ON gp.id=l.garage_plan_id AND gp.resolver_session_id=l.resolver_session_id
LEFT JOIN house_catalog hc ON hc.canonical_slot=l.house_slot AND hc.enabled=1
WHERE l.resolver_session_id=@garage_resolver_session_id
  AND l.link_class='baseline_savehouse_candidate';

SELECT 'RUNTIME_EMPTY_GATE' section,
       (SELECT COUNT(*) FROM garage_catalog) catalog_rows_should_be_zero,
       (SELECT COUNT(*) FROM garage_catalog WHERE enabled=1) enabled_catalog_should_be_zero,
       (SELECT COUNT(*) FROM house_garage_links) runtime_links_should_be_zero,
       (SELECT COUNT(*) FROM house_garage_links WHERE enabled=1) enabled_links_should_be_zero,
       (SELECT enabled FROM garage_runtime_policy WHERE id=1) policy_enabled_should_be_zero,
       (SELECT store_enabled FROM garage_runtime_policy WHERE id=1) store_enabled_should_be_zero,
       (SELECT retrieve_enabled FROM garage_runtime_policy WHERE id=1) retrieve_enabled_should_be_zero,
       (SELECT door_animation_enabled FROM garage_runtime_policy WHERE id=1) door_enabled_should_be_zero;

SELECT 'PROJECTED_APPLY' section,
       12 projected_catalog_rows,
       12 projected_house_links,
       64 compiled_capacity,
       52 exact_source_garages_retained,
       40 nonbaseline_garages_deferred,
       0 projected_enabled_rows,
       0 projected_vehicle_mutations;

SELECT 'BASELINE_MAPPING_DETAIL' section,
       l.house_slot canonical_house_slot,
       hc.id house_catalog_id,
       hc.display_name house_name,
       gp.id canonical_garage_plan_id,
       gp.source_queue_id,
       gp.garage_name,
       gp.garage_type,
       gp.garage_door_type,
       gp.center_x,gp.center_y,gp.center_z,
       l.garage_distance,
       gp.source_file,gp.source_line,
       'spawn_unresolved' projected_spawn_status,
       0 projected_enabled
FROM offline_garage_house_links l
JOIN offline_garage_canonical_plan gp ON gp.id=l.garage_plan_id AND gp.resolver_session_id=l.resolver_session_id
LEFT JOIN house_catalog hc ON hc.canonical_slot=l.house_slot AND hc.enabled=1
WHERE l.resolver_session_id=@garage_resolver_session_id
  AND l.link_class='baseline_savehouse_candidate'
ORDER BY l.house_slot;

SELECT 'FINAL_GATE' section,
       (
         @garage_resolver_session_id IS NOT NULL
         AND (SELECT COUNT(*) FROM offline_garage_house_links WHERE resolver_session_id=@garage_resolver_session_id AND link_class='baseline_savehouse_candidate')=12
         AND (SELECT COUNT(*) FROM offline_garage_house_links l LEFT JOIN house_catalog hc ON hc.canonical_slot=l.house_slot AND hc.enabled=1 WHERE l.resolver_session_id=@garage_resolver_session_id AND l.link_class='baseline_savehouse_candidate' AND hc.id IS NULL)=0
         AND (SELECT COUNT(*) FROM garage_catalog)=0
         AND (SELECT COUNT(*) FROM house_garage_links)=0
         AND (SELECT enabled+store_enabled+retrieve_enabled+door_animation_enabled FROM garage_runtime_policy WHERE id=1)=0
       ) ready_for_spawn_planner_should_be_1;
