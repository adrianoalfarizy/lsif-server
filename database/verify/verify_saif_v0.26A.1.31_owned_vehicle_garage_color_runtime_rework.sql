-- SAIF / LSIF v0.26A.1.31 verification
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SELECT 'SCHEMA_GATE' section,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_storage_policy') policy_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_storage_locations') locations_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='player_vehicle_storage') state_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_storage_transactions') transactions_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_storage_slots') physical_slots_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_spawn_points') spawn_points_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='player_vehicles' AND column_name IN
  ('lifecycle_status','home_storage_location_id','home_storage_slot','purchase_origin','lifecycle_source_tag','first_garage_saved_at','destroyed_until','last_state_changed_at')) lifecycle_columns_expected_8;

SELECT 'POLICY_GATE' section,
 enabled,house_storage_enabled,public_garage_storage_enabled,impound_storage_enabled,business_storage_enabled,
 store_enabled,retrieve_enabled,dealer_pending_enabled,nearest_spawn_enabled,despawn_enabled,
 color_modification_enabled,parked_vehicle_lifecycle_enabled,destroyed_cooldown_seconds,
 parked_abandon_seconds,parked_home_radius,
 (enabled=1 AND house_storage_enabled=1 AND public_garage_storage_enabled=0
  AND impound_storage_enabled=0 AND business_storage_enabled=0
  AND store_enabled=1 AND retrieve_enabled=1 AND dealer_pending_enabled=1
  AND nearest_spawn_enabled=1 AND despawn_enabled=1 AND color_modification_enabled=1
  AND parked_vehicle_lifecycle_enabled=1 AND destroyed_cooldown_seconds BETWEEN 30 AND 3600
  AND parked_abandon_seconds BETWEEN 30 AND 3600 AND parked_home_radius BETWEEN 10 AND 200) ready_should_be_1
FROM vehicle_storage_policy WHERE id=1;

SELECT 'HOUSE_STORAGE_GATE' section,
 COUNT(*) house_locations_expected_29,
 COALESCE(SUM(enabled=1 AND geometry_status='ready'),0) exact_enabled_expected_12,
 COALESCE(SUM(enabled=0 AND geometry_status='pending'),0) pending_editor_expected_17,
 COUNT(DISTINCT reference_id) unique_house_references_expected_29,
 COALESCE(SUM(capacity<>1),0) invalid_capacity_should_be_zero,
 COALESCE(SUM(enabled=1 AND (interaction_x=0 OR interaction_y=0 OR interaction_z=0)),0) enabled_zero_checkpoint_should_be_zero,
 COALESCE(SUM(enabled=1 AND (spawn_x=0 OR spawn_y=0 OR spawn_z=0)),0) enabled_zero_spawn_should_be_zero,
 (COUNT(*)=29 AND COALESCE(SUM(enabled=1 AND geometry_status='ready'),0)=12
  AND COALESCE(SUM(enabled=0 AND geometry_status='pending'),0)=17
  AND COUNT(DISTINCT reference_id)=29
  AND COALESCE(SUM(capacity<>1),0)=0
  AND COALESCE(SUM(enabled=1 AND (interaction_x=0 OR interaction_y=0 OR interaction_z=0)),0)=0
  AND COALESCE(SUM(enabled=1 AND (spawn_x=0 OR spawn_y=0 OR spawn_z=0)),0)=0) ready_should_be_1
FROM vehicle_storage_locations
WHERE storage_type='house';

SELECT 'PHYSICAL_SLOT_GATE' section,
 COUNT(*) enabled_physical_slots_informational,
 COUNT(DISTINCT vss.storage_location_id) locations_with_slots_expected_at_least_12,
 COALESCE(SUM(vss.slot_number<1),0) invalid_slot_number_should_be_zero,
 COALESCE(SUM(vss.pos_x=0 OR vss.pos_y=0 OR vss.pos_z=0),0) zero_transform_should_be_zero,
 COALESCE(SUM(vsl.id IS NULL),0) orphan_location_should_be_zero,
 (COUNT(DISTINCT vss.storage_location_id)>=12
  AND COALESCE(SUM(vss.slot_number<1),0)=0
  AND COALESCE(SUM(vss.pos_x=0 OR vss.pos_y=0 OR vss.pos_z=0),0)=0
  AND COALESCE(SUM(vsl.id IS NULL),0)=0) ready_should_be_1
FROM vehicle_storage_slots vss
LEFT JOIN vehicle_storage_locations vsl ON vsl.id=vss.storage_location_id
WHERE vss.enabled=1;

SELECT 'SPAWN_POINT_GATE' section,
 COUNT(*) enabled_spawn_points_should_be_greater_than_zero,
 COALESCE(SUM(pos_x=0 OR pos_y=0 OR pos_z=0),0) zero_transform_should_be_zero,
 COALESCE(SUM(clear_radius<2 OR clear_radius>20),0) invalid_clear_radius_should_be_zero,
 COUNT(DISTINCT point_key) unique_keys_should_equal_total,
 (COUNT(*)>0
  AND COALESCE(SUM(pos_x=0 OR pos_y=0 OR pos_z=0),0)=0
  AND COALESCE(SUM(clear_radius<2 OR clear_radius>20),0)=0
  AND COUNT(DISTINCT point_key)=COUNT(*)) ready_should_be_1
FROM vehicle_spawn_points
WHERE enabled=1;

SELECT 'LIFECYCLE_GATE' section,
 COUNT(*) owned_vehicle_rows_informational,
 COALESCE(SUM(pv.lifecycle_status NOT IN ('legacy_unassigned','dealer_pending','stored','active','destroyed_cooldown')),0) invalid_status_should_be_zero,
 COALESCE(SUM(pv.lifecycle_status='dealer_pending' AND (pv.home_storage_location_id IS NOT NULL OR pv.home_storage_slot IS NOT NULL)),0) pending_with_home_should_be_zero,
 COALESCE(SUM(pv.lifecycle_status IN ('stored','active','destroyed_cooldown') AND pv.home_storage_location_id IS NOT NULL AND pv.home_storage_slot IS NULL),0) home_without_slot_should_be_zero,
 COALESCE(SUM(pv.home_storage_location_id IS NOT NULL AND vsl.id IS NULL),0) orphan_home_location_should_be_zero,
 COALESCE(SUM(pv.home_storage_location_id IS NOT NULL AND pv.home_storage_slot<1),0) invalid_home_slot_should_be_zero,
 COALESCE(SUM(pv.color1<-1 OR pv.color1>255 OR pv.color2<-1 OR pv.color2>255),0) invalid_saved_color_should_be_zero,
 (COALESCE(SUM(pv.lifecycle_status NOT IN ('legacy_unassigned','dealer_pending','stored','active','destroyed_cooldown')),0)=0
  AND COALESCE(SUM(pv.lifecycle_status='dealer_pending' AND (pv.home_storage_location_id IS NOT NULL OR pv.home_storage_slot IS NOT NULL)),0)=0
  AND COALESCE(SUM(pv.lifecycle_status IN ('stored','active','destroyed_cooldown') AND pv.home_storage_location_id IS NOT NULL AND pv.home_storage_slot IS NULL),0)=0
  AND COALESCE(SUM(pv.home_storage_location_id IS NOT NULL AND vsl.id IS NULL),0)=0
  AND COALESCE(SUM(pv.home_storage_location_id IS NOT NULL AND pv.home_storage_slot<1),0)=0
  AND COALESCE(SUM(pv.color1<-1 OR pv.color1>255 OR pv.color2<-1 OR pv.color2>255),0)=0) ready_should_be_1
FROM player_vehicles pv
LEFT JOIN vehicle_storage_locations vsl ON vsl.id=pv.home_storage_location_id;

SELECT 'STORAGE_STATE_GATE' section,
 COUNT(*) storage_rows_informational,
 COALESCE(SUM(pvs.storage_status NOT IN ('stored','active','releasing','destroyed_cooldown')),0) invalid_status_should_be_zero,
 COALESCE(SUM(pv.id IS NULL),0) orphan_vehicle_should_be_zero,
 COALESCE(SUM(p.id IS NULL),0) orphan_owner_should_be_zero,
 COALESCE(SUM(vsl.id IS NULL),0) orphan_location_should_be_zero,
 COALESCE(SUM(pv.owner_id<>pvs.owner_player_id),0) owner_mismatch_should_be_zero,
 COALESCE(SUM(pv.home_storage_location_id IS NOT NULL AND pv.home_storage_location_id<>pvs.storage_location_id),0) home_location_mismatch_should_be_zero,
 COALESCE(SUM(pv.home_storage_slot IS NOT NULL AND pv.home_storage_slot<>pvs.storage_slot),0) home_slot_mismatch_should_be_zero,
 (COALESCE(SUM(pvs.storage_status NOT IN ('stored','active','releasing','destroyed_cooldown')),0)=0
  AND COALESCE(SUM(pv.id IS NULL),0)=0
  AND COALESCE(SUM(p.id IS NULL),0)=0
  AND COALESCE(SUM(vsl.id IS NULL),0)=0
  AND COALESCE(SUM(pv.owner_id<>pvs.owner_player_id),0)=0
  AND COALESCE(SUM(pv.home_storage_location_id IS NOT NULL AND pv.home_storage_location_id<>pvs.storage_location_id),0)=0
  AND COALESCE(SUM(pv.home_storage_slot IS NOT NULL AND pv.home_storage_slot<>pvs.storage_slot),0)=0) ready_should_be_1
FROM player_vehicle_storage pvs
LEFT JOIN player_vehicles pv ON pv.id=pvs.player_vehicle_id
LEFT JOIN players p ON p.id=pvs.owner_player_id
LEFT JOIN vehicle_storage_locations vsl ON vsl.id=pvs.storage_location_id;

SELECT 'LEGACY_SLOT_GATE' section,
 COUNT(*) rows_informational,
 COALESCE(SUM(slot IS NULL OR slot<1 OR slot>32),0) invalid_internal_order_should_be_zero,
 COUNT(DISTINCT CONCAT(owner_id,':',slot)) unique_owner_slot_count,
 (COALESCE(SUM(slot IS NULL OR slot<1 OR slot>32),0)=0
  AND COUNT(DISTINCT CONCAT(owner_id,':',slot))=COUNT(*)) ready_should_be_1
FROM player_vehicles;

SELECT 'FINAL_GATE' section,
 (
  (SELECT COUNT(*) FROM vehicle_storage_policy WHERE id=1 AND enabled=1 AND house_storage_enabled=1
    AND public_garage_storage_enabled=0 AND store_enabled=1 AND retrieve_enabled=1
    AND dealer_pending_enabled=1 AND nearest_spawn_enabled=1 AND despawn_enabled=1
    AND color_modification_enabled=1 AND parked_vehicle_lifecycle_enabled=1)=1
  AND (SELECT COUNT(*) FROM vehicle_storage_locations WHERE storage_type='house')=29
  AND (SELECT COUNT(*) FROM vehicle_storage_locations WHERE storage_type='house' AND enabled=1 AND geometry_status='ready')=12
  AND (SELECT COUNT(*) FROM vehicle_spawn_points WHERE enabled=1)>0
  AND (SELECT COUNT(*) FROM player_vehicles WHERE slot IS NULL OR slot<1 OR slot>32)=0
  AND (SELECT COUNT(*) FROM player_vehicles WHERE lifecycle_status NOT IN ('legacy_unassigned','dealer_pending','stored','active','destroyed_cooldown'))=0
 ) ready_should_be_1;
