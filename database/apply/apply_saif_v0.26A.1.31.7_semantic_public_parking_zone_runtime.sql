-- SAIF / LSIF v0.26A.1.31.7
-- Controlled apply: semantic public parking zone runtime.
-- Required: SET @saif_confirm='APPLY_SEMANTIC_PUBLIC_PARKING';
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_apply_semantic_public_parking_v026A1317;
DELIMITER //
CREATE PROCEDURE saif_apply_semantic_public_parking_v026A1317()
BEGIN
    DECLARE v_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_previous_policy TINYINT DEFAULT 0;
    DECLARE v_previous_nearest TINYINT DEFAULT 0;
    DECLARE v_archived INT UNSIGNED DEFAULT 0;
    DECLARE v_disabled INT UNSIGNED DEFAULT 0;
    DECLARE v_candidate_zones INT UNSIGNED DEFAULT 0;
    DECLARE v_admin_zones INT UNSIGNED DEFAULT 0;
    DECLARE v_admin_slots INT UNSIGNED DEFAULT 0;
    DECLARE v_orphans INT UNSIGNED DEFAULT 0;
    DECLARE v_parked_slots INT UNSIGNED DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF COALESCE(@saif_confirm,'') <> 'APPLY_SEMANTIC_PUBLIC_PARKING' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token missing: APPLY_SEMANTIC_PUBLIC_PARKING';
    END IF;

    IF (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='public_parking_policy') <> 1
       OR (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='public_parking_zones') <> 1
       OR (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='public_parking_slots') <> 1
       OR (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='semantic_parking_apply_sessions') <> 1
       OR (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='semantic_parking_legacy_point_archive') <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Semantic parking schema missing; run v0.26A.1.31.7 migration first';
    END IF;
    IF (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='public_interiors') <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='public_interiors table is missing';
    END IF;
    IF (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_spawn_points') <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='vehicle_spawn_points table is missing';
    END IF;
    IF (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_storage_policy') <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='vehicle_storage_policy table is missing';
    END IF;

    SELECT COALESCE(enabled,0) INTO v_previous_policy FROM public_parking_policy WHERE id=1;
    SELECT COALESCE(nearest_spawn_enabled,0) INTO v_previous_nearest FROM vehicle_storage_policy WHERE id=1;

    START TRANSACTION;

    INSERT INTO semantic_parking_apply_sessions
    (apply_version,apply_status,previous_policy_enabled,previous_nearest_spawn_enabled,source_tag)
    VALUES
    ('v0.26A.1.31.7','running',v_previous_policy,v_previous_nearest,'saif_semantic_public_parking_v0.26A.1.31.7');
    SET v_session_id=LAST_INSERT_ID();

    INSERT INTO semantic_parking_legacy_point_archive
    (apply_session_id,vehicle_spawn_point_id,previous_enabled,source_type,source_tag)
    SELECT v_session_id,id,enabled,source_type,source_tag
    FROM vehicle_spawn_points;
    SET v_archived=ROW_COUNT();

    UPDATE vehicle_spawn_points
    SET enabled=0
    WHERE enabled=1
      AND source_type IN (
        'garage_storage_slot','parked_vehicle_origin','parked_vehicle_left',
        'parked_vehicle_right','parked_vehicle_offset','mission_default','mission_pool'
      );
    SET v_disabled=ROW_COUNT();

    INSERT INTO public_parking_zones
    (zone_key,zone_name,zone_type,facility_type,facility_reference_id,
     center_x,center_y,center_z,center_a,interior_id,virtual_world,
     search_radius,priority,review_status,enabled,source_tag)
    SELECT
      CONCAT('public_interior_',pi.id),
      LEFT(CONCAT(pi.display_name,' Parking'),64),
      CASE
        WHEN pi.interior_type IN ('burgershot','cluckinbell','pizzastack') THEN 'restaurant_parking'
        WHEN pi.interior_type='247' THEN 'shop_parking'
        WHEN pi.interior_type='hospital' THEN 'hospital_parking'
        WHEN pi.interior_type='police' THEN 'police_parking'
        WHEN pi.interior_type='gym' THEN 'gym_parking'
        WHEN pi.interior_type='casino' THEN 'casino_parking'
        WHEN pi.interior_type IN ('clothing','barber','tattoo','ammunation') THEN 'shop_parking'
        WHEN pi.interior_type='cityhall' THEN 'government_parking'
        ELSE 'facility_parking'
      END,
      pi.interior_type,
      pi.id,
      CASE WHEN pi.exterior_spawn_x<>0 THEN pi.exterior_spawn_x ELSE pi.exterior_x END,
      CASE WHEN pi.exterior_spawn_y<>0 THEN pi.exterior_spawn_y ELSE pi.exterior_y END,
      CASE WHEN pi.exterior_spawn_z<>0 THEN pi.exterior_spawn_z ELSE pi.exterior_z END,
      CASE WHEN pi.exterior_spawn_a<>0 THEN pi.exterior_spawn_a ELSE pi.exterior_a END,
      pi.exterior_interior,
      pi.exterior_virtual_world,
      180.0,
      50,
      'candidate',
      1,
      'saif_semantic_public_parking_v0.26A.1.31.7'
    FROM public_interiors pi
    WHERE pi.enabled=1
      AND pi.interior_type IN (
        'burgershot','cluckinbell','pizzastack','247','hospital','police',
        'gym','casino','clothing','barber','tattoo','ammunation','cityhall'
      )
      AND (pi.exterior_x<>0 OR pi.exterior_spawn_x<>0)
      AND (pi.exterior_y<>0 OR pi.exterior_spawn_y<>0)
      AND (pi.exterior_z<>0 OR pi.exterior_spawn_z<>0)
    ON DUPLICATE KEY UPDATE
      zone_name=VALUES(zone_name),zone_type=VALUES(zone_type),facility_type=VALUES(facility_type),
      facility_reference_id=VALUES(facility_reference_id),center_x=VALUES(center_x),center_y=VALUES(center_y),
      center_z=VALUES(center_z),center_a=VALUES(center_a),interior_id=VALUES(interior_id),
      virtual_world=VALUES(virtual_world),search_radius=VALUES(search_radius),priority=VALUES(priority),
      source_tag=VALUES(source_tag);

    INSERT INTO public_parking_zones
    (zone_key,zone_name,zone_type,facility_type,facility_reference_id,
     center_x,center_y,center_z,center_a,interior_id,virtual_world,
     search_radius,priority,review_status,enabled,source_tag)
    SELECT
      CONCAT('legacy_admin_point_',vsp.id),
      LEFT(vsp.point_name,64),
      'public_parking',
      'legacy_admin_custom',
      vsp.id,
      vsp.pos_x,vsp.pos_y,vsp.pos_z,vsp.pos_a,vsp.interior_id,vsp.virtual_world,
      180.0,40,'approved',1,'saif_semantic_public_parking_v0.26A.1.31.7'
    FROM vehicle_spawn_points vsp
    WHERE vsp.source_type='admin_custom'
      AND vsp.enabled=1
      AND vsp.pos_x<>0 AND vsp.pos_y<>0 AND vsp.pos_z<>0
    ON DUPLICATE KEY UPDATE
      zone_name=VALUES(zone_name),center_x=VALUES(center_x),center_y=VALUES(center_y),
      center_z=VALUES(center_z),center_a=VALUES(center_a),interior_id=VALUES(interior_id),
      virtual_world=VALUES(virtual_world),review_status='approved',enabled=1,source_tag=VALUES(source_tag);

    INSERT INTO public_parking_slots
    (zone_id,slot_number,slot_name,pos_x,pos_y,pos_z,pos_a,clear_radius,review_status,enabled,source_tag)
    SELECT
      z.id,1,'Slot 1',vsp.pos_x,vsp.pos_y,vsp.pos_z,vsp.pos_a,
      CASE WHEN vsp.clear_radius BETWEEN 2.5 AND 10.0 THEN vsp.clear_radius ELSE 4.5 END,
      'approved',1,'saif_semantic_public_parking_v0.26A.1.31.7'
    FROM vehicle_spawn_points vsp
    INNER JOIN public_parking_zones z ON z.zone_key=CONCAT('legacy_admin_point_',vsp.id)
    WHERE vsp.source_type='admin_custom'
      AND vsp.enabled=1
      AND vsp.pos_x<>0 AND vsp.pos_y<>0 AND vsp.pos_z<>0
    ON DUPLICATE KEY UPDATE
      pos_x=VALUES(pos_x),pos_y=VALUES(pos_y),pos_z=VALUES(pos_z),pos_a=VALUES(pos_a),
      clear_radius=VALUES(clear_radius),review_status='approved',enabled=1,source_tag=VALUES(source_tag);

    UPDATE public_parking_policy
    SET enabled=1,require_colandreas=1,reject_when_unavailable=1,
        search_near_radius=250.0,search_mid_radius=500.0,search_far_radius=1000.0,
        max_runtime_slots=1024,source_tag='saif_semantic_public_parking_v0.26A.1.31.7'
    WHERE id=1;

    UPDATE vehicle_storage_policy
    SET nearest_spawn_enabled=1,source_tag='saif_semantic_public_parking_v0.26A.1.31.7'
    WHERE id=1;

    SELECT COUNT(*) INTO v_candidate_zones
    FROM public_parking_zones
    WHERE source_tag='saif_semantic_public_parking_v0.26A.1.31.7'
      AND review_status='candidate';
    SELECT COUNT(*) INTO v_admin_zones
    FROM public_parking_zones
    WHERE source_tag='saif_semantic_public_parking_v0.26A.1.31.7'
      AND review_status='approved';
    SELECT COUNT(*) INTO v_admin_slots
    FROM public_parking_slots
    WHERE source_tag='saif_semantic_public_parking_v0.26A.1.31.7'
      AND review_status='approved' AND enabled=1;
    SELECT COUNT(*) INTO v_orphans
    FROM public_parking_slots s LEFT JOIN public_parking_zones z ON z.id=s.zone_id
    WHERE z.id IS NULL;
    SELECT COUNT(*) INTO v_parked_slots
    FROM public_parking_slots
    WHERE source_tag LIKE '%parked_vehicle%';

    IF (SELECT COUNT(*) FROM public_parking_zones WHERE enabled=1)=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No semantic parking zones generated';
    END IF;
    IF v_orphans<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Orphan semantic parking slots detected';
    END IF;
    IF v_parked_slots<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Parked-vehicle-derived semantic slots are forbidden';
    END IF;

    UPDATE semantic_parking_apply_sessions
    SET apply_status='complete',archived_legacy_points=v_archived,
        disabled_legacy_points=v_disabled,facility_candidate_zones=v_candidate_zones,
        approved_admin_zones=v_admin_zones,approved_admin_slots=v_admin_slots,
        completed_at=NOW()
    WHERE id=v_session_id;

    COMMIT;

    SELECT 'APPLY_GATE' section,v_session_id apply_session_id,'complete' apply_status,
           v_archived archived_legacy_points,v_disabled disabled_legacy_points,
           v_candidate_zones facility_candidate_zones,v_admin_zones approved_admin_zones,
           v_admin_slots approved_admin_slots,
           (v_orphans=0 AND v_parked_slots=0 AND v_candidate_zones+v_admin_zones>0) ready_should_be_1;
END//
DELIMITER ;
CALL saif_apply_semantic_public_parking_v026A1317();
DROP PROCEDURE IF EXISTS saif_apply_semantic_public_parking_v026A1317;
