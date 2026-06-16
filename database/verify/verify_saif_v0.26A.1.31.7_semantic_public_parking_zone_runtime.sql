-- SAIF / LSIF v0.26A.1.31.7
-- Verify semantic public parking zone runtime.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @latest_session=(
  SELECT MAX(id) FROM semantic_parking_apply_sessions
  WHERE apply_version='v0.26A.1.31.7' AND apply_status='complete'
);

SELECT 'SESSION_GATE' section,id apply_session_id,apply_status,
       archived_legacy_points,disabled_legacy_points,facility_candidate_zones,
       approved_admin_zones,approved_admin_slots,
       (apply_status='complete') ready_should_be_1
FROM semantic_parking_apply_sessions
WHERE id=@latest_session;

SELECT 'POLICY_GATE' section,enabled,require_colandreas,reject_when_unavailable,
       search_near_radius,search_mid_radius,search_far_radius,max_runtime_slots,
       (enabled=1 AND require_colandreas=1 AND reject_when_unavailable=1
        AND search_near_radius>0 AND search_mid_radius>=search_near_radius
        AND search_far_radius>=search_mid_radius AND max_runtime_slots=1024) ready_should_be_1
FROM public_parking_policy WHERE id=1;

SELECT 'ZONE_GATE' section,
       COUNT(*) total_zones,
       COALESCE(SUM(enabled=1),0) enabled_zones,
       COALESCE(SUM(enabled=1 AND review_status='approved'),0) approved_zones,
       COALESCE(SUM(enabled=1 AND review_status='candidate'),0) candidate_zones,
       COALESCE(SUM(enabled=1 AND (center_x=0 OR center_y=0 OR center_z=0)),0) zero_center_should_be_zero,
       COALESCE(SUM(zone_type NOT IN (
         'restaurant_parking','shop_parking','hospital_parking','police_parking',
         'government_parking','mall_parking','hotel_parking','gym_parking',
         'casino_parking','facility_parking','public_parking'
       )),0) invalid_type_should_be_zero,
       (COUNT(*)>0
        AND COALESCE(SUM(enabled=1 AND (center_x=0 OR center_y=0 OR center_z=0)),0)=0
        AND COALESCE(SUM(zone_type NOT IN (
          'restaurant_parking','shop_parking','hospital_parking','police_parking',
          'government_parking','mall_parking','hotel_parking','gym_parking',
          'casino_parking','facility_parking','public_parking'
        )),0)=0) ready_should_be_1
FROM public_parking_zones;

SELECT 'SLOT_GATE' section,
       COUNT(*) total_slots,
       COALESCE(SUM(enabled=1),0) enabled_slots,
       COALESCE(SUM(enabled=1 AND review_status='approved'),0) approved_runtime_slots,
       COALESCE(SUM(enabled=1 AND (pos_x=0 OR pos_y=0 OR pos_z=0)),0) zero_transform_should_be_zero,
       COALESCE(SUM(enabled=1 AND (clear_radius<2.5 OR clear_radius>10.0)),0) invalid_radius_should_be_zero,
       (SELECT COUNT(*) FROM public_parking_slots s LEFT JOIN public_parking_zones z ON z.id=s.zone_id WHERE z.id IS NULL) orphan_should_be_zero,
       COALESCE(SUM(source_tag LIKE '%parked_vehicle%'),0) parked_vehicle_source_should_be_zero,
       ((SELECT COUNT(*) FROM public_parking_slots s LEFT JOIN public_parking_zones z ON z.id=s.zone_id WHERE z.id IS NULL)=0
        AND COALESCE(SUM(enabled=1 AND (pos_x=0 OR pos_y=0 OR pos_z=0)),0)=0
        AND COALESCE(SUM(enabled=1 AND (clear_radius<2.5 OR clear_radius>10.0)),0)=0
        AND COALESCE(SUM(source_tag LIKE '%parked_vehicle%'),0)=0) ready_should_be_1
FROM public_parking_slots;

SELECT 'LEGACY_EXCLUSION_GATE' section,
       COALESCE(SUM(enabled=1 AND source_type IN (
        'garage_storage_slot','parked_vehicle_origin','parked_vehicle_left',
        'parked_vehicle_right','parked_vehicle_offset','mission_default','mission_pool'
       )),0) forbidden_enabled_legacy_rows_should_be_zero,
       COALESCE(SUM(enabled=1 AND source_type='admin_custom'),0) legacy_admin_rows_informational,
       (COALESCE(SUM(enabled=1 AND source_type IN (
        'garage_storage_slot','parked_vehicle_origin','parked_vehicle_left',
        'parked_vehicle_right','parked_vehicle_offset','mission_default','mission_pool'
       )),0)=0) ready_should_be_1
FROM vehicle_spawn_points;

SELECT 'FACILITY_COVERAGE_GATE' section,
       (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND interior_type IN (
        'burgershot','cluckinbell','pizzastack','247','hospital','police','gym',
        'casino','clothing','barber','tattoo','ammunation','cityhall'
       ) AND (exterior_x<>0 OR exterior_spawn_x<>0)
         AND (exterior_y<>0 OR exterior_spawn_y<>0)
         AND (exterior_z<>0 OR exterior_spawn_z<>0)) target_public_interiors,
       COALESCE(SUM(facility_type IN (
        'burgershot','cluckinbell','pizzastack','247','hospital','police','gym',
        'casino','clothing','barber','tattoo','ammunation','cityhall'
       )),0) imported_facility_zones,
       ((SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND interior_type IN (
        'burgershot','cluckinbell','pizzastack','247','hospital','police','gym',
        'casino','clothing','barber','tattoo','ammunation','cityhall'
       ) AND (exterior_x<>0 OR exterior_spawn_x<>0)
         AND (exterior_y<>0 OR exterior_spawn_y<>0)
         AND (exterior_z<>0 OR exterior_spawn_z<>0))=
        COALESCE(SUM(facility_type IN (
        'burgershot','cluckinbell','pizzastack','247','hospital','police','gym',
        'casino','clothing','barber','tattoo','ammunation','cityhall'
       )),0)) ready_should_be_1
FROM public_parking_zones
WHERE source_tag='saif_semantic_public_parking_v0.26A.1.31.7';

SELECT 'FINAL_GATE' section,
       ((SELECT COUNT(*) FROM semantic_parking_apply_sessions WHERE id=@latest_session AND apply_status='complete')=1
        AND (SELECT COUNT(*) FROM public_parking_policy WHERE id=1 AND enabled=1)=1
        AND (SELECT COUNT(*) FROM public_parking_zones WHERE enabled=1)>0
        AND (SELECT COUNT(*) FROM public_parking_slots s LEFT JOIN public_parking_zones z ON z.id=s.zone_id WHERE z.id IS NULL)=0
        AND (SELECT COUNT(*) FROM public_parking_slots WHERE source_tag LIKE '%parked_vehicle%')=0
        AND (SELECT COUNT(*) FROM vehicle_spawn_points WHERE enabled=1 AND source_type IN (
          'garage_storage_slot','parked_vehicle_origin','parked_vehicle_left',
          'parked_vehicle_right','parked_vehicle_offset','mission_default','mission_pool'
        ))=0) ready_should_be_1,
       (SELECT COUNT(*) FROM public_parking_slots WHERE enabled=1 AND review_status='approved') approved_runtime_slots_informational;
