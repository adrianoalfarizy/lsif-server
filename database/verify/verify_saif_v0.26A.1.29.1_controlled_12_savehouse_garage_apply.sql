-- SAIF / LSIF Dev v0.26A.1.29.1
-- Verify controlled 12 baseline savehouse garage catalog apply.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @apply_version := _utf8mb4'saif-controlled-12-savehouse-garage-apply-v0.26A.1.29' COLLATE utf8mb4_unicode_ci;
SET @catalog_source_tag := _utf8mb4'offline_gtasa_savehouse_garage12_a1' COLLATE utf8mb4_unicode_ci;
SET @link_source_tag := _utf8mb4'offline_gtasa_savehouse_garage12_link_a1' COLLATE utf8mb4_unicode_ci;
SET @apply_session_id := (
    SELECT id FROM garage_catalog_apply_sessions
    WHERE BINARY apply_version=BINARY @apply_version AND status='complete'
    ORDER BY id DESC LIMIT 1
);
SET @geometry_session_id := (SELECT geometry_session_id FROM garage_catalog_apply_sessions WHERE id=@apply_session_id);
SET @resolver_session_id := (SELECT garage_resolver_session_id FROM garage_catalog_apply_sessions WHERE id=@apply_session_id);

SELECT 'APPLY_SESSION_GATE' section,id apply_session_id,status,archive_session_id,geometry_session_id,garage_resolver_session_id,
       expected_catalog_rows,applied_catalog_rows,expected_link_rows,applied_link_rows,
       policy_enabled_after,policy_store_enabled_after,policy_retrieve_enabled_after,policy_door_enabled_after,
       (status='complete' AND expected_catalog_rows=12 AND applied_catalog_rows=12
        AND expected_link_rows=12 AND applied_link_rows=12
        AND policy_enabled_after=0 AND policy_store_enabled_after=0
        AND policy_retrieve_enabled_after=0 AND policy_door_enabled_after=0) ready_should_be_1
FROM garage_catalog_apply_sessions WHERE id=@apply_session_id;

SELECT 'CATALOG_GATE' section,
       COUNT(*) catalog_rows_expected_12,
       COUNT(DISTINCT canonical_garage_plan_id) unique_garage_plans_expected_12,
       COUNT(DISTINCT source_queue_id) unique_source_rows_expected_12,
       SUM(enabled=1) enabled_rows_expected_12,
       SUM(apply_status='applied') applied_rows_expected_12,
       SUM(spawn_status='ready') spawn_ready_expected_12,
       SUM(runtime_class<>'house_garage') wrong_runtime_class_should_be_zero,
       SUM(safety_class<>'baseline_savehouse') wrong_safety_class_should_be_zero,
       SUM(vehicle_spawn_x IS NULL OR vehicle_spawn_y IS NULL OR vehicle_spawn_z IS NULL OR vehicle_spawn_a IS NULL) missing_spawn_should_be_zero,
       SUM(interaction_x=0 AND interaction_y=0 AND interaction_z=0) zero_interaction_should_be_zero,
       SUM(row_checksum='') missing_checksum_should_be_zero,
       (COUNT(*)=12
        AND COUNT(DISTINCT canonical_garage_plan_id)=12
        AND COUNT(DISTINCT source_queue_id)=12
        AND SUM(enabled=1)=12
        AND SUM(apply_status='applied')=12
        AND SUM(spawn_status='ready')=12
        AND SUM(runtime_class<>'house_garage')=0
        AND SUM(safety_class<>'baseline_savehouse')=0
        AND SUM(vehicle_spawn_x IS NULL OR vehicle_spawn_y IS NULL OR vehicle_spawn_z IS NULL OR vehicle_spawn_a IS NULL)=0
        AND SUM(interaction_x=0 AND interaction_y=0 AND interaction_z=0)=0
        AND SUM(row_checksum='')=0) ready_should_be_1
FROM garage_catalog WHERE BINARY source_tag=BINARY @catalog_source_tag;

SELECT 'HOUSE_LINK_GATE' section,
       COUNT(*) link_rows_expected_12,
       COUNT(DISTINCT hgl.house_catalog_id) unique_houses_expected_12,
       COUNT(DISTINCT hgl.garage_catalog_id) unique_garages_expected_12,
       COUNT(DISTINCT hgl.canonical_house_slot) unique_slots_expected_12,
       SUM(hgl.enabled=1) enabled_links_expected_12,
       SUM(hgl.link_class<>'baseline_savehouse') wrong_link_class_should_be_zero,
       SUM(hgl.ownership_mode<>'inherit_house_owner') wrong_ownership_mode_should_be_zero,
       SUM(hgl.access_mode<>'house_owner_only') wrong_access_mode_should_be_zero,
       SUM(hc.id IS NULL) orphan_house_should_be_zero,
       SUM(gc.id IS NULL) orphan_garage_should_be_zero,
       SUM(hc.id IS NOT NULL AND hc.enabled<>1) disabled_house_should_be_zero,
       (COUNT(*)=12
        AND COUNT(DISTINCT hgl.house_catalog_id)=12
        AND COUNT(DISTINCT hgl.garage_catalog_id)=12
        AND COUNT(DISTINCT hgl.canonical_house_slot)=12
        AND SUM(hgl.enabled=1)=12
        AND SUM(hgl.link_class<>'baseline_savehouse')=0
        AND SUM(hgl.ownership_mode<>'inherit_house_owner')=0
        AND SUM(hgl.access_mode<>'house_owner_only')=0
        AND SUM(hc.id IS NULL)=0
        AND SUM(gc.id IS NULL)=0
        AND SUM(hc.id IS NOT NULL AND hc.enabled<>1)=0) ready_should_be_1
FROM house_garage_links hgl
LEFT JOIN house_catalog hc ON hc.id=hgl.house_catalog_id
LEFT JOIN garage_catalog gc ON gc.id=hgl.garage_catalog_id
WHERE BINARY hgl.source_tag=BINARY @link_source_tag;

SELECT 'TRACKING_GATE' section,
       COUNT(*) tracked_rows_expected_12,
       COUNT(DISTINCT geometry_plan_id) unique_geometry_expected_12,
       COUNT(DISTINCT garage_catalog_id) unique_catalog_expected_12,
       COUNT(DISTINCT house_garage_link_id) unique_links_expected_12,
       COUNT(DISTINCT house_catalog_id) unique_houses_expected_12,
       SUM(row_status<>'applied') wrong_status_should_be_zero,
       SUM(geometry_checksum='') missing_geometry_checksum_should_be_zero,
       SUM(catalog_checksum='') missing_catalog_checksum_should_be_zero,
       SUM(link_checksum='') missing_link_checksum_should_be_zero
FROM garage_catalog_apply_rows WHERE apply_session_id=@apply_session_id;

SELECT 'SOURCE_LINKAGE_GATE' section,
       SUM(gp.id IS NULL) missing_geometry_should_be_zero,
       SUM(cp.id IS NULL) missing_canonical_plan_should_be_zero,
       SUM(l.id IS NULL) missing_source_house_link_should_be_zero,
       SUM(hc.id IS NULL) missing_live_house_should_be_zero,
       SUM(gc.id IS NULL) missing_runtime_catalog_should_be_zero,
       SUM(hgl.id IS NULL) missing_runtime_link_should_be_zero,
       SUM(gp.id IS NOT NULL AND gp.geometry_status<>'baseline_ready') wrong_geometry_status_should_be_zero,
       SUM(gp.id IS NOT NULL AND gp.safety_class<>'baseline_savehouse_candidate') wrong_geometry_safety_should_be_zero,
       SUM(l.id IS NOT NULL AND l.link_class<>'baseline_savehouse_candidate') wrong_source_link_class_should_be_zero,
       SUM(hc.id IS NOT NULL AND hc.canonical_slot<>ar.canonical_house_slot) house_slot_mismatch_should_be_zero,
       SUM(gc.id IS NOT NULL AND gc.source_queue_id<>ar.source_queue_id) source_queue_mismatch_should_be_zero,
       SUM(gc.id IS NOT NULL AND BINARY gc.garage_key<>BINARY ar.garage_key) garage_key_mismatch_should_be_zero,
       SUM(gp.id IS NOT NULL AND BINARY gp.row_checksum<>BINARY ar.geometry_checksum) geometry_checksum_mismatch_should_be_zero
FROM garage_catalog_apply_rows ar
LEFT JOIN offline_garage_geometry_plan gp ON gp.id=ar.geometry_plan_id AND gp.geometry_session_id=@geometry_session_id
LEFT JOIN offline_garage_canonical_plan cp ON cp.id=ar.garage_plan_id
LEFT JOIN offline_garage_house_links l ON l.house_plan_id=ar.house_plan_id AND l.garage_plan_id=ar.garage_plan_id AND l.resolver_session_id=@resolver_session_id
LEFT JOIN house_catalog hc ON hc.id=ar.house_catalog_id
LEFT JOIN garage_catalog gc ON gc.id=ar.garage_catalog_id
LEFT JOIN house_garage_links hgl ON hgl.id=ar.house_garage_link_id
WHERE ar.apply_session_id=@apply_session_id;

SELECT 'CHECKSUM_GATE' section,
       SUM(BINARY ar.catalog_checksum<>BINARY SHA2(CONCAT_WS('|',gc.canonical_garage_plan_id,gc.source_queue_id,gc.garage_key,gc.garage_name,gc.runtime_class,gc.safety_class,
           gc.garage_type,gc.garage_door_type,gc.center_x,gc.center_y,gc.center_z,gc.bound_x1,gc.bound_y1,gc.bound_z1,gc.bound_x2,gc.bound_y2,gc.bound_x3,gc.bound_y3,gc.bound_z2,
           gc.interaction_x,gc.interaction_y,gc.interaction_z,COALESCE(gc.vehicle_spawn_x,''),COALESCE(gc.vehicle_spawn_y,''),COALESCE(gc.vehicle_spawn_z,''),
           COALESCE(gc.vehicle_spawn_a,''),gc.spawn_status,gc.source_file,gc.source_line,gc.source_record_hash,gc.city_region,gc.area_code,gc.enabled,gc.apply_status,gc.sort_order,gc.source_tag),256)) catalog_checksum_mismatch_should_be_zero,
       SUM(BINARY ar.link_checksum<>BINARY SHA2(CONCAT_WS('|',hgl.house_catalog_id,hgl.garage_catalog_id,COALESCE(hgl.canonical_house_slot,''),hgl.link_class,
           hgl.ownership_mode,hgl.access_mode,hgl.enabled,hgl.source_tag),256)) link_checksum_mismatch_should_be_zero
FROM garage_catalog_apply_rows ar
JOIN garage_catalog gc ON gc.id=ar.garage_catalog_id
JOIN house_garage_links hgl ON hgl.id=ar.house_garage_link_id
WHERE ar.apply_session_id=@apply_session_id;

SELECT 'POLICY_SAFETY_GATE' section,policy_key,enabled,store_enabled,retrieve_enabled,door_animation_enabled,max_catalog_rows,
       (enabled=0 AND store_enabled=0 AND retrieve_enabled=0 AND door_animation_enabled=0 AND max_catalog_rows>=12) ready_should_be_1
FROM garage_runtime_policy WHERE id=1;

SELECT 'CONTROLLED_12_DETAIL' section,
       ar.canonical_house_slot,
       hc.id house_catalog_id,
       hc.display_name house_name,
       gc.id garage_catalog_id,
       gc.garage_name,
       gc.garage_type,
       gc.garage_door_type,
       gc.interaction_x,gc.interaction_y,gc.interaction_z,
       gc.vehicle_spawn_x,gc.vehicle_spawn_y,gc.vehicle_spawn_z,gc.vehicle_spawn_a,
       gc.spawn_status,gc.enabled,gc.apply_status
FROM garage_catalog_apply_rows ar
JOIN house_catalog hc ON hc.id=ar.house_catalog_id
JOIN garage_catalog gc ON gc.id=ar.garage_catalog_id
WHERE ar.apply_session_id=@apply_session_id
ORDER BY ar.canonical_house_slot;

SELECT 'FINAL_GATE' section,
       (
        @apply_session_id IS NOT NULL
        AND (SELECT COUNT(*) FROM garage_catalog_apply_rows WHERE apply_session_id=@apply_session_id)=12
        AND (SELECT COUNT(*) FROM garage_catalog WHERE BINARY source_tag=BINARY @catalog_source_tag AND enabled=1 AND apply_status='applied' AND spawn_status='ready')=12
        AND (SELECT COUNT(*) FROM house_garage_links WHERE BINARY source_tag=BINARY @link_source_tag AND enabled=1)=12
        AND (SELECT enabled=0 AND store_enabled=0 AND retrieve_enabled=0 AND door_animation_enabled=0 FROM garage_runtime_policy WHERE id=1)=1
        AND (SELECT COUNT(*) FROM garage_catalog_apply_rows ar JOIN garage_catalog gc ON gc.id=ar.garage_catalog_id
             WHERE ar.apply_session_id=@apply_session_id AND BINARY ar.catalog_checksum<>BINARY gc.row_checksum)=0
       ) ready_should_be_1;
