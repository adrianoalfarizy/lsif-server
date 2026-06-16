-- SAIF / LSIF v0.26A.1.31.5
-- Direct apply: global nearest parking spawn catalog.
-- Required: SET @saif_confirm='APPLY_GLOBAL_NEAREST_PARKING_SPAWN';
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_apply_global_parking_v026A1315;
DELIMITER //
CREATE PROCEDURE saif_apply_global_parking_v026A1315()
BEGIN
    DECLARE v_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_archive_rows INT UNSIGNED DEFAULT 0;
    DECLARE v_generated_rows INT UNSIGNED DEFAULT 0;
    DECLARE v_enabled_rows INT UNSIGNED DEFAULT 0;
    DECLARE v_parked_origin INT UNSIGNED DEFAULT 0;
    DECLARE v_parked_left INT UNSIGNED DEFAULT 0;
    DECLARE v_parked_right INT UNSIGNED DEFAULT 0;
    DECLARE v_garage INT UNSIGNED DEFAULT 0;
    DECLARE v_mission_default INT UNSIGNED DEFAULT 0;
    DECLARE v_mission_pool INT UNSIGNED DEFAULT 0;
    DECLARE v_admin INT UNSIGNED DEFAULT 0;
    DECLARE v_zero INT UNSIGNED DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF COALESCE(@saif_confirm,'') <> 'APPLY_GLOBAL_NEAREST_PARKING_SPAWN' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token missing: APPLY_GLOBAL_NEAREST_PARKING_SPAWN';
    END IF;

    IF (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_spawn_points') <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='vehicle_spawn_points table is missing';
    END IF;
    IF (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='parked_vehicles') <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='parked_vehicles table is missing';
    END IF;
    IF (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_storage_slots') <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='vehicle_storage_slots table is missing';
    END IF;

    START TRANSACTION;

    INSERT INTO vehicle_spawn_point_seed_sessions
    (seed_version,status,source_tag)
    VALUES ('v0.26A.1.31.5','running','saif_global_parking_v0.26A.1.31.5');
    SET v_session_id=LAST_INSERT_ID();

    INSERT INTO vehicle_spawn_point_seed_archive_rows
    (seed_session_id,original_id,point_key,point_name,source_type,source_reference_id,
     pos_x,pos_y,pos_z,pos_a,interior_id,virtual_world,clear_radius,priority,enabled,source_tag)
    SELECT v_session_id,id,point_key,point_name,source_type,source_reference_id,
           pos_x,pos_y,pos_z,pos_a,interior_id,virtual_world,clear_radius,priority,enabled,source_tag
    FROM vehicle_spawn_points;
    SET v_archive_rows=ROW_COUNT();

    UPDATE vehicle_spawn_points
    SET enabled=0
    WHERE source_tag='saif_owned_vehicle_rework_v0.26A.1.31'
      AND source_type IN ('garage_storage_slot','parked_vehicle_offset');

    INSERT INTO vehicle_spawn_points
    (point_key,point_name,source_type,source_reference_id,pos_x,pos_y,pos_z,pos_a,
     interior_id,virtual_world,clear_radius,priority,enabled,source_tag)
    SELECT CONCAT('storage_',vss.storage_location_id,'_',vss.slot_number),
           LEFT(CONCAT('Garage Slot ',vss.storage_location_id,'-',vss.slot_number),64),
           'garage_storage_slot',vss.id,
           vss.pos_x,vss.pos_y,vss.pos_z,vss.pos_a,vss.interior_id,vss.virtual_world,
           4.5,30,1,'saif_global_parking_v0.26A.1.31.5'
    FROM vehicle_storage_slots vss
    WHERE vss.enabled=1 AND vss.pos_x<>0 AND vss.pos_y<>0 AND vss.pos_z<>0
    ON DUPLICATE KEY UPDATE
      point_name=VALUES(point_name),source_type=VALUES(source_type),source_reference_id=VALUES(source_reference_id),
      pos_x=VALUES(pos_x),pos_y=VALUES(pos_y),pos_z=VALUES(pos_z),pos_a=VALUES(pos_a),
      interior_id=VALUES(interior_id),virtual_world=VALUES(virtual_world),clear_radius=VALUES(clear_radius),
      priority=VALUES(priority),enabled=1,source_tag=VALUES(source_tag);

    INSERT INTO vehicle_spawn_points
    (point_key,point_name,source_type,source_reference_id,pos_x,pos_y,pos_z,pos_a,
     interior_id,virtual_world,clear_radius,priority,enabled,source_tag)
    SELECT CONCAT('parked_origin_',pv.id),LEFT(CONCAT('Public Parking Origin ',pv.id),64),
           'parked_vehicle_origin',pv.id,
           pv.pos_x,pv.pos_y,pv.pos_z,pv.pos_a,pv.interior,pv.virtual_world,
           4.5,50,1,'saif_global_parking_v0.26A.1.31.5'
    FROM parked_vehicles pv
    WHERE pv.enabled=1 AND pv.pos_x<>0 AND pv.pos_y<>0 AND pv.pos_z<>0
    ON DUPLICATE KEY UPDATE
      point_name=VALUES(point_name),source_type=VALUES(source_type),source_reference_id=VALUES(source_reference_id),
      pos_x=VALUES(pos_x),pos_y=VALUES(pos_y),pos_z=VALUES(pos_z),pos_a=VALUES(pos_a),
      interior_id=VALUES(interior_id),virtual_world=VALUES(virtual_world),clear_radius=VALUES(clear_radius),
      priority=VALUES(priority),enabled=1,source_tag=VALUES(source_tag);

    INSERT INTO vehicle_spawn_points
    (point_key,point_name,source_type,source_reference_id,pos_x,pos_y,pos_z,pos_a,
     interior_id,virtual_world,clear_radius,priority,enabled,source_tag)
    SELECT CONCAT('parked_left_',pv.id),LEFT(CONCAT('Public Parking Left ',pv.id),64),
           'parked_vehicle_left',pv.id,
           pv.pos_x + COS(RADIANS(pv.pos_a+90))*4.5,
           pv.pos_y + SIN(RADIANS(pv.pos_a+90))*4.5,
           pv.pos_z,pv.pos_a,pv.interior,pv.virtual_world,
           4.5,60,1,'saif_global_parking_v0.26A.1.31.5'
    FROM parked_vehicles pv
    WHERE pv.enabled=1 AND pv.pos_x<>0 AND pv.pos_y<>0 AND pv.pos_z<>0
    ON DUPLICATE KEY UPDATE
      point_name=VALUES(point_name),source_type=VALUES(source_type),source_reference_id=VALUES(source_reference_id),
      pos_x=VALUES(pos_x),pos_y=VALUES(pos_y),pos_z=VALUES(pos_z),pos_a=VALUES(pos_a),
      interior_id=VALUES(interior_id),virtual_world=VALUES(virtual_world),clear_radius=VALUES(clear_radius),
      priority=VALUES(priority),enabled=1,source_tag=VALUES(source_tag);

    INSERT INTO vehicle_spawn_points
    (point_key,point_name,source_type,source_reference_id,pos_x,pos_y,pos_z,pos_a,
     interior_id,virtual_world,clear_radius,priority,enabled,source_tag)
    SELECT CONCAT('parked_right_',pv.id),LEFT(CONCAT('Public Parking Right ',pv.id),64),
           'parked_vehicle_right',pv.id,
           pv.pos_x + COS(RADIANS(pv.pos_a-90))*4.5,
           pv.pos_y + SIN(RADIANS(pv.pos_a-90))*4.5,
           pv.pos_z,pv.pos_a,pv.interior,pv.virtual_world,
           4.5,60,1,'saif_global_parking_v0.26A.1.31.5'
    FROM parked_vehicles pv
    WHERE pv.enabled=1 AND pv.pos_x<>0 AND pv.pos_y<>0 AND pv.pos_z<>0
    ON DUPLICATE KEY UPDATE
      point_name=VALUES(point_name),source_type=VALUES(source_type),source_reference_id=VALUES(source_reference_id),
      pos_x=VALUES(pos_x),pos_y=VALUES(pos_y),pos_z=VALUES(pos_z),pos_a=VALUES(pos_a),
      interior_id=VALUES(interior_id),virtual_world=VALUES(virtual_world),clear_radius=VALUES(clear_radius),
      priority=VALUES(priority),enabled=1,source_tag=VALUES(source_tag);

    IF (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_mission_points')=1 THEN
        INSERT INTO vehicle_spawn_points
        (point_key,point_name,source_type,source_reference_id,pos_x,pos_y,pos_z,pos_a,
         interior_id,virtual_world,clear_radius,priority,enabled,source_tag)
        SELECT CONCAT('mission_default_',vmp.id),LEFT(CONCAT('Mission Parking ',vmp.mission_code),64),
               'mission_default',vmp.id,
               vmp.spawn_x,vmp.spawn_y,vmp.spawn_z,vmp.spawn_a,0,0,
               4.5,70,1,'saif_global_parking_v0.26A.1.31.5'
        FROM vehicle_mission_points vmp
        WHERE vmp.enabled=1 AND vmp.spawn_x<>0 AND vmp.spawn_y<>0 AND vmp.spawn_z<>0
        ON DUPLICATE KEY UPDATE
          point_name=VALUES(point_name),source_type=VALUES(source_type),source_reference_id=VALUES(source_reference_id),
          pos_x=VALUES(pos_x),pos_y=VALUES(pos_y),pos_z=VALUES(pos_z),pos_a=VALUES(pos_a),
          interior_id=VALUES(interior_id),virtual_world=VALUES(virtual_world),clear_radius=VALUES(clear_radius),
          priority=VALUES(priority),enabled=1,source_tag=VALUES(source_tag);
    END IF;

    IF (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_mission_point_pool')=1 THEN
        INSERT INTO vehicle_spawn_points
        (point_key,point_name,source_type,source_reference_id,pos_x,pos_y,pos_z,pos_a,
         interior_id,virtual_world,clear_radius,priority,enabled,source_tag)
        SELECT CONCAT('mission_pool_',vmpp.id),LEFT(CONCAT('Mission Pool ',vmpp.point_name),64),
               'mission_pool',vmpp.id,
               vmpp.spawn_x,vmpp.spawn_y,vmpp.spawn_z,vmpp.spawn_a,0,0,
               4.5,75,1,'saif_global_parking_v0.26A.1.31.5'
        FROM vehicle_mission_point_pool vmpp
        WHERE vmpp.enabled=1 AND vmpp.spawn_x<>0 AND vmpp.spawn_y<>0 AND vmpp.spawn_z<>0
        ON DUPLICATE KEY UPDATE
          point_name=VALUES(point_name),source_type=VALUES(source_type),source_reference_id=VALUES(source_reference_id),
          pos_x=VALUES(pos_x),pos_y=VALUES(pos_y),pos_z=VALUES(pos_z),pos_a=VALUES(pos_a),
          interior_id=VALUES(interior_id),virtual_world=VALUES(virtual_world),clear_radius=VALUES(clear_radius),
          priority=VALUES(priority),enabled=1,source_tag=VALUES(source_tag);
    END IF;

    UPDATE vehicle_storage_policy
    SET nearest_spawn_enabled=1,source_tag='saif_global_parking_v0.26A.1.31.5'
    WHERE id=1;

    SELECT COUNT(*) INTO v_generated_rows
    FROM vehicle_spawn_points
    WHERE source_tag='saif_global_parking_v0.26A.1.31.5';
    SELECT COUNT(*) INTO v_enabled_rows FROM vehicle_spawn_points WHERE enabled=1;
    SELECT COUNT(*) INTO v_parked_origin FROM vehicle_spawn_points WHERE enabled=1 AND source_type='parked_vehicle_origin';
    SELECT COUNT(*) INTO v_parked_left FROM vehicle_spawn_points WHERE enabled=1 AND source_type='parked_vehicle_left';
    SELECT COUNT(*) INTO v_parked_right FROM vehicle_spawn_points WHERE enabled=1 AND source_type='parked_vehicle_right';
    SELECT COUNT(*) INTO v_garage FROM vehicle_spawn_points WHERE enabled=1 AND source_type='garage_storage_slot';
    SELECT COUNT(*) INTO v_mission_default FROM vehicle_spawn_points WHERE enabled=1 AND source_type='mission_default';
    SELECT COUNT(*) INTO v_mission_pool FROM vehicle_spawn_points WHERE enabled=1 AND source_type='mission_pool';
    SELECT COUNT(*) INTO v_admin FROM vehicle_spawn_points WHERE enabled=1 AND source_type='admin_custom';
    SELECT COUNT(*) INTO v_zero FROM vehicle_spawn_points WHERE enabled=1 AND (pos_x=0 OR pos_y=0 OR pos_z=0);

    IF v_enabled_rows=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Global parking catalog is empty';
    END IF;
    IF v_enabled_rows>1024 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Enabled global parking catalog exceeds runtime limit 1024';
    END IF;
    IF v_zero<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Global parking catalog contains zero transforms';
    END IF;

    UPDATE vehicle_spawn_point_seed_sessions
    SET status='complete',archive_rows=v_archive_rows,generated_rows=v_generated_rows,
        enabled_rows=v_enabled_rows,parked_origin_rows=v_parked_origin,
        parked_left_rows=v_parked_left,parked_right_rows=v_parked_right,
        garage_rows=v_garage,mission_default_rows=v_mission_default,
        mission_pool_rows=v_mission_pool,admin_rows_preserved=v_admin,
        completed_at=NOW()
    WHERE id=v_session_id;

    COMMIT;

    SELECT 'APPLY_GATE' section,v_session_id seed_session_id,'complete' status,
           v_archive_rows archive_rows,v_generated_rows generated_rows,
           v_enabled_rows enabled_rows,v_parked_origin parked_origin_rows,
           v_parked_left parked_left_rows,v_parked_right parked_right_rows,
           v_garage garage_rows,v_mission_default mission_default_rows,
           v_mission_pool mission_pool_rows,v_admin admin_rows_preserved,
           (v_enabled_rows BETWEEN 1 AND 1024 AND v_zero=0) ready_should_be_1;
END//
DELIMITER ;
CALL saif_apply_global_parking_v026A1315();
DROP PROCEDURE IF EXISTS saif_apply_global_parking_v026A1315;
