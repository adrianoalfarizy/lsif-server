-- SAIF / LSIF v0.26A.1.30.1 verification
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SELECT 'POLICY_GATE' section,enabled,house_storage_enabled,public_garage_storage_enabled,impound_storage_enabled,business_storage_enabled,
 store_enabled,retrieve_enabled,alt_confirmation_required,driver_required,vehicle_owner_required,one_active_storage_per_vehicle,
 (enabled=1 AND house_storage_enabled=1 AND public_garage_storage_enabled=0 AND impound_storage_enabled=0 AND business_storage_enabled=0
  AND store_enabled=1 AND retrieve_enabled=1 AND alt_confirmation_required=1 AND driver_required=1 AND vehicle_owner_required=1
  AND one_active_storage_per_vehicle=1) ready_should_be_1
FROM vehicle_storage_policy WHERE id=1;

SELECT 'LOCATION_GATE' section,
 COUNT(*) house_locations_expected_29,
 SUM(enabled=1 AND geometry_status='ready') enabled_ready_expected_12,
 SUM(enabled=0 AND geometry_status='pending') pending_editor_expected_17,
 COUNT(DISTINCT reference_id) unique_houses_expected_29,
 SUM(capacity<1 OR capacity>10) invalid_capacity_should_be_zero,
 SUM(enabled=1 AND (interaction_x=0 OR interaction_y=0 OR interaction_z=0)) enabled_zero_checkpoint_should_be_zero,
 SUM(enabled=1 AND (spawn_x=0 OR spawn_y=0 OR spawn_z=0)) enabled_zero_spawn_should_be_zero,
 (COUNT(*)=29 AND SUM(enabled=1 AND geometry_status='ready')=12 AND SUM(enabled=0 AND geometry_status='pending')=17
  AND COUNT(DISTINCT reference_id)=29 AND SUM(capacity<1 OR capacity>10)=0
  AND SUM(enabled=1 AND (interaction_x=0 OR interaction_y=0 OR interaction_z=0))=0
  AND SUM(enabled=1 AND (spawn_x=0 OR spawn_y=0 OR spawn_z=0))=0) ready_should_be_1
FROM vehicle_storage_locations WHERE storage_type='house';

SELECT 'EXACT_LINK_GATE' section,
 COUNT(*) exact_links_expected_12,
 COUNT(DISTINCT vsl.reference_id) unique_houses_expected_12,
 SUM(vsl.enabled<>1 OR vsl.geometry_status<>'ready') invalid_runtime_should_be_zero,
 SUM(ABS(vsl.interaction_x-gc.interaction_x)>0.01 OR ABS(vsl.interaction_y-gc.interaction_y)>0.01 OR ABS(vsl.interaction_z-gc.interaction_z)>0.01) checkpoint_mismatch_should_be_zero,
 SUM(ABS(vsl.spawn_x-gc.vehicle_spawn_x)>0.01 OR ABS(vsl.spawn_y-gc.vehicle_spawn_y)>0.01 OR ABS(vsl.spawn_z-gc.vehicle_spawn_z)>0.01 OR ABS(vsl.spawn_a-gc.vehicle_spawn_a)>0.01) spawn_mismatch_should_be_zero,
 (COUNT(*)=12 AND COUNT(DISTINCT vsl.reference_id)=12 AND SUM(vsl.enabled<>1 OR vsl.geometry_status<>'ready')=0
  AND SUM(ABS(vsl.interaction_x-gc.interaction_x)>0.01 OR ABS(vsl.interaction_y-gc.interaction_y)>0.01 OR ABS(vsl.interaction_z-gc.interaction_z)>0.01)=0
  AND SUM(ABS(vsl.spawn_x-gc.vehicle_spawn_x)>0.01 OR ABS(vsl.spawn_y-gc.vehicle_spawn_y)>0.01 OR ABS(vsl.spawn_z-gc.vehicle_spawn_z)>0.01 OR ABS(vsl.spawn_a-gc.vehicle_spawn_a)>0.01)=0) ready_should_be_1
FROM house_garage_links hgl
JOIN garage_catalog gc ON gc.id=hgl.garage_catalog_id
JOIN vehicle_storage_locations vsl ON vsl.storage_type='house' AND vsl.reference_id=hgl.house_catalog_id
WHERE hgl.enabled=1 AND hgl.link_class='baseline_savehouse';

SELECT 'STATE_INTEGRITY_GATE' section,
 COUNT(*) stored_rows_informational,
 COALESCE(SUM(pv.id IS NULL),0) orphan_vehicle_should_be_zero,
 COALESCE(SUM(p.id IS NULL),0) orphan_owner_should_be_zero,
 COALESCE(SUM(vsl.id IS NULL OR vsl.enabled<>1),0) orphan_or_disabled_location_should_be_zero,
 COALESCE(SUM(pv.owner_id<>pvs.owner_player_id),0) owner_mismatch_should_be_zero,
 COALESCE(SUM(pvs.storage_status NOT IN ('stored','releasing')),0) wrong_status_should_be_zero
FROM player_vehicle_storage pvs
LEFT JOIN player_vehicles pv ON pv.id=pvs.player_vehicle_id
LEFT JOIN players p ON p.id=pvs.owner_player_id
LEFT JOIN vehicle_storage_locations vsl ON vsl.id=pvs.storage_location_id;

SELECT 'PLAYER_VEHICLE_IMMUTABILITY_GATE' section,
 (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='player_vehicles' AND column_name IN ('storage_type','storage_reference_id','storage_slot','storage_status')) storage_columns_added_should_be_zero,
 ((SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='player_vehicles' AND column_name IN ('storage_type','storage_reference_id','storage_slot','storage_status'))=0) ready_should_be_1;

SELECT 'FINAL_GATE' section,
 ((SELECT COUNT(*) FROM vehicle_storage_policy WHERE id=1 AND enabled=1 AND house_storage_enabled=1 AND store_enabled=1 AND retrieve_enabled=1)=1
  AND (SELECT COUNT(*) FROM vehicle_storage_locations WHERE storage_type='house')=29
  AND (SELECT COUNT(*) FROM vehicle_storage_locations WHERE storage_type='house' AND enabled=1 AND geometry_status='ready')>=12
  AND (SELECT COUNT(*) FROM vehicle_storage_locations vsl LEFT JOIN house_catalog hc ON hc.id=vsl.reference_id WHERE vsl.storage_type='house' AND hc.id IS NULL)=0) ready_should_be_1;
