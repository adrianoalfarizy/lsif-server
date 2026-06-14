-- SAIF / LSIF Dev v0.26A.1.29
-- Dry-run gate for controlled 12 baseline savehouse garage catalog apply.
-- Read-only. No runtime mutation.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @apply_version := _utf8mb4'saif-controlled-12-savehouse-garage-apply-v0.26A.1.29' COLLATE utf8mb4_unicode_ci;
SET @archive_version := _utf8mb4'saif-world-garage-runtime-archive-v0.26A.1.29' COLLATE utf8mb4_unicode_ci;
SET @geometry_planner_version := _utf8mb4'saif-garage-geometry-planner-v0.26A.1.28' COLLATE utf8mb4_unicode_ci;
SET @garage_resolver_version := _utf8mb4'saif-garage-canonical-resolver-v0.26A.1.26' COLLATE utf8mb4_unicode_ci;

SET @geometry_session_id := (
    SELECT id FROM offline_garage_geometry_sessions
    WHERE BINARY planner_version=BINARY @geometry_planner_version AND status='complete'
    ORDER BY id DESC LIMIT 1
);
SET @garage_resolver_session_id := (
    SELECT garage_resolver_session_id FROM offline_garage_geometry_sessions WHERE id=@geometry_session_id
);
SET @archive_session_id := (
    SELECT id FROM garage_catalog_runtime_archive_sessions
    WHERE BINARY archive_version=BINARY @archive_version AND status='complete'
    ORDER BY id DESC LIMIT 1
);

SELECT 'SESSION_GATE' section,
       @geometry_session_id geometry_session_id,
       @garage_resolver_session_id garage_resolver_session_id,
       @archive_session_id archive_session_id,
       (@geometry_session_id IS NOT NULL AND @garage_resolver_session_id IS NOT NULL AND @archive_session_id IS NOT NULL) ready_should_be_1;

SELECT 'GEOMETRY_SOURCE_GATE' section,
       COUNT(*) baseline_ready_expected_12,
       COUNT(DISTINCT gp.garage_plan_id) unique_garage_plans_expected_12,
       COUNT(DISTINCT l.house_plan_id) unique_house_plans_expected_12,
       COUNT(DISTINCT l.house_slot) unique_house_slots_expected_12,
       SUM(gp.geometry_status<>'baseline_ready') wrong_geometry_status_should_be_zero,
       SUM(gp.safety_class<>'baseline_savehouse_candidate') wrong_safety_class_should_be_zero,
       SUM(gp.row_checksum='') missing_geometry_checksum_should_be_zero,
       SUM(cp.id IS NULL) missing_canonical_garage_should_be_zero,
       SUM(hc.id IS NULL) missing_live_house_should_be_zero,
       SUM(hc.id IS NOT NULL AND hc.enabled<>1) disabled_live_house_should_be_zero,
       SUM(gp.vehicle_spawn_x=0 AND gp.vehicle_spawn_y=0 AND gp.vehicle_spawn_z=0) zero_spawn_should_be_zero,
       SUM(gp.interaction_x=0 AND gp.interaction_y=0 AND gp.interaction_z=0) zero_interaction_should_be_zero,
       (COUNT(*)=12
        AND COUNT(DISTINCT gp.garage_plan_id)=12
        AND COUNT(DISTINCT l.house_plan_id)=12
        AND COUNT(DISTINCT l.house_slot)=12
        AND SUM(gp.geometry_status<>'baseline_ready')=0
        AND SUM(gp.safety_class<>'baseline_savehouse_candidate')=0
        AND SUM(gp.row_checksum='')=0
        AND SUM(cp.id IS NULL)=0
        AND SUM(hc.id IS NULL)=0
        AND SUM(hc.id IS NOT NULL AND hc.enabled<>1)=0
        AND SUM(gp.vehicle_spawn_x=0 AND gp.vehicle_spawn_y=0 AND gp.vehicle_spawn_z=0)=0
        AND SUM(gp.interaction_x=0 AND gp.interaction_y=0 AND gp.interaction_z=0)=0) ready_should_be_1
FROM offline_garage_geometry_plan gp
JOIN offline_garage_house_links l
  ON l.resolver_session_id=@garage_resolver_session_id
 AND l.garage_plan_id=gp.garage_plan_id
 AND l.link_class='baseline_savehouse_candidate'
LEFT JOIN offline_garage_canonical_plan cp ON cp.id=gp.garage_plan_id
LEFT JOIN house_catalog hc ON hc.canonical_slot=l.house_slot
WHERE gp.geometry_session_id=@geometry_session_id
  AND gp.safety_class='baseline_savehouse_candidate';

SELECT 'RUNTIME_EMPTY_GATE' section,
       (SELECT COUNT(*) FROM garage_catalog) catalog_rows_should_be_zero,
       (SELECT COUNT(*) FROM house_garage_links) link_rows_should_be_zero,
       (SELECT COUNT(*) FROM garage_catalog_apply_sessions WHERE BINARY apply_version=BINARY @apply_version AND status='complete') prior_complete_apply_should_be_zero,
       ((SELECT COUNT(*) FROM garage_catalog)=0
        AND (SELECT COUNT(*) FROM house_garage_links)=0
        AND (SELECT COUNT(*) FROM garage_catalog_apply_sessions WHERE BINARY apply_version=BINARY @apply_version AND status='complete')=0) ready_should_be_1;

SELECT 'ARCHIVE_MATCH_GATE' section,
       a.runtime_rows_total archive_catalog_rows,
       a.link_rows_total archive_link_rows,
       (SELECT COUNT(*) FROM garage_catalog) current_catalog_rows,
       (SELECT COUNT(*) FROM house_garage_links) current_link_rows,
       ((SELECT COUNT(*) FROM garage_catalog)=a.runtime_rows_total
        AND (SELECT COUNT(*) FROM house_garage_links)=a.link_rows_total) ready_should_be_1
FROM garage_catalog_runtime_archive_sessions a
WHERE a.id=@archive_session_id;

SELECT 'POLICY_SAFETY_GATE' section,
       policy_key,enabled,store_enabled,retrieve_enabled,door_animation_enabled,max_catalog_rows,
       (enabled=0 AND store_enabled=0 AND retrieve_enabled=0 AND door_animation_enabled=0 AND max_catalog_rows>=12) ready_should_be_1
FROM garage_runtime_policy WHERE id=1;

SELECT 'TARGET_DETAIL' section,
       l.house_slot canonical_house_slot,
       hc.id house_catalog_id,
       hc.display_name house_name,
       gp.id geometry_plan_id,
       cp.id garage_plan_id,
       cp.garage_name,
       cp.garage_type,
       cp.garage_door_type,
       gp.front_width,gp.depth_length,gp.height_clearance,
       gp.interaction_x,gp.interaction_y,gp.interaction_z,
       gp.vehicle_spawn_x,gp.vehicle_spawn_y,gp.vehicle_spawn_z,gp.vehicle_spawn_a,
       gp.geometry_status
FROM offline_garage_geometry_plan gp
JOIN offline_garage_house_links l
  ON l.resolver_session_id=@garage_resolver_session_id
 AND l.garage_plan_id=gp.garage_plan_id
 AND l.link_class='baseline_savehouse_candidate'
JOIN offline_garage_canonical_plan cp ON cp.id=gp.garage_plan_id
JOIN house_catalog hc ON hc.canonical_slot=l.house_slot AND hc.enabled=1
WHERE gp.geometry_session_id=@geometry_session_id
  AND gp.safety_class='baseline_savehouse_candidate'
ORDER BY l.house_slot;

SELECT 'FINAL_GATE' section,
       (
        @geometry_session_id IS NOT NULL
        AND @garage_resolver_session_id IS NOT NULL
        AND @archive_session_id IS NOT NULL
        AND (SELECT COUNT(*) FROM garage_catalog)=0
        AND (SELECT COUNT(*) FROM house_garage_links)=0
        AND (SELECT COUNT(*) FROM garage_catalog_apply_sessions WHERE BINARY apply_version=BINARY @apply_version AND status='complete')=0
        AND (SELECT COUNT(*) FROM offline_garage_geometry_plan gp
             JOIN offline_garage_house_links l ON l.resolver_session_id=@garage_resolver_session_id
              AND l.garage_plan_id=gp.garage_plan_id AND l.link_class='baseline_savehouse_candidate'
             JOIN offline_garage_canonical_plan cp ON cp.id=gp.garage_plan_id
             JOIN house_catalog hc ON hc.canonical_slot=l.house_slot AND hc.enabled=1
             WHERE gp.geometry_session_id=@geometry_session_id
               AND gp.safety_class='baseline_savehouse_candidate'
               AND gp.geometry_status='baseline_ready')=12
        AND (SELECT COUNT(DISTINCT gp.garage_plan_id) FROM offline_garage_geometry_plan gp
             JOIN offline_garage_house_links l ON l.resolver_session_id=@garage_resolver_session_id
              AND l.garage_plan_id=gp.garage_plan_id AND l.link_class='baseline_savehouse_candidate'
             WHERE gp.geometry_session_id=@geometry_session_id
               AND gp.safety_class='baseline_savehouse_candidate'
               AND gp.geometry_status='baseline_ready')=12
        AND (SELECT COUNT(DISTINCT l.house_slot) FROM offline_garage_house_links l
             JOIN offline_garage_geometry_plan gp ON gp.geometry_session_id=@geometry_session_id AND gp.garage_plan_id=l.garage_plan_id
             WHERE l.resolver_session_id=@garage_resolver_session_id
               AND l.link_class='baseline_savehouse_candidate'
               AND gp.geometry_status='baseline_ready')=12
        AND (SELECT enabled=0 AND store_enabled=0 AND retrieve_enabled=0 AND door_animation_enabled=0 FROM garage_runtime_policy WHERE id=1)=1
       ) ready_for_controlled_apply_should_be_1;
