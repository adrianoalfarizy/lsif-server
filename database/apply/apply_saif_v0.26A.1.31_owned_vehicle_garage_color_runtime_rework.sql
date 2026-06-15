-- SAIF / LSIF v0.26A.1.31
-- Direct apply: owned vehicle lifecycle + garage save commit + nearest parking spawn + parked vehicle abandonment policy.
-- Required: SET @saif_confirm='APPLY_OWNED_VEHICLE_GARAGE_COLOR_RUNTIME';
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_apply_owned_vehicle_runtime_v026A131;
DELIMITER //
CREATE PROCEDURE saif_apply_owned_vehicle_runtime_v026A131()
BEGIN
    DECLARE v_exact INT DEFAULT 0;
    DECLARE v_houses INT DEFAULT 0;
    DECLARE v_bad_columns INT DEFAULT 0;
    DECLARE v_max_owned_per_player INT DEFAULT 0;
    DECLARE v_unsafe_legacy_slot_rows INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; RESIGNAL; END;

    IF @saif_confirm IS NULL OR BINARY @saif_confirm<>BINARY 'APPLY_OWNED_VEHICLE_GARAGE_COLOR_RUNTIME' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation missing: APPLY_OWNED_VEHICLE_GARAGE_COLOR_RUNTIME';
    END IF;

    SELECT COUNT(*) INTO v_exact
    FROM house_garage_links hgl
    JOIN garage_catalog gc ON gc.id=hgl.garage_catalog_id
    JOIN house_catalog hc ON hc.id=hgl.house_catalog_id
    WHERE hgl.enabled=1 AND hgl.link_class='baseline_savehouse'
      AND gc.enabled=1 AND gc.spawn_status='ready'
      AND gc.interaction_x<>0 AND gc.interaction_y<>0 AND gc.interaction_z<>0
      AND gc.vehicle_spawn_x<>0 AND gc.vehicle_spawn_y<>0 AND gc.vehicle_spawn_z<>0
      AND hc.enabled=1;

    SELECT COUNT(*) INTO v_houses
    FROM house_catalog
    WHERE enabled=1 AND canonical_slot BETWEEN 3 AND 31;

    SELECT 8-COUNT(*) INTO v_bad_columns
    FROM information_schema.columns
    WHERE table_schema=DATABASE() AND table_name='player_vehicles'
      AND column_name IN ('lifecycle_status','home_storage_location_id','home_storage_slot','purchase_origin',
                          'lifecycle_source_tag','first_garage_saved_at','destroyed_until','last_state_changed_at');

    IF v_exact<>12 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Expected exactly 12 ready baseline garage links.'; END IF;
    IF v_houses<>29 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Expected exactly 29 active canonical houses.'; END IF;
    IF v_bad_columns<>0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Migration incomplete: player_vehicles lifecycle columns missing.'; END IF;

    SELECT COALESCE(MAX(vehicle_count),0) INTO v_max_owned_per_player
    FROM (SELECT owner_id,COUNT(*) vehicle_count FROM player_vehicles GROUP BY owner_id) owned_counts;
    SELECT COUNT(*) INTO v_unsafe_legacy_slot_rows
    FROM player_vehicles
    WHERE slot BETWEEN 65 AND 96;

    IF v_max_owned_per_player>32 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='A player owns more than the temporary 32-vehicle compatibility ceiling.';
    END IF;
    IF v_unsafe_legacy_slot_rows<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Legacy slot values 65-96 detected; resequence safety range is occupied.';
    END IF;

    DROP TEMPORARY TABLE IF EXISTS tmp_saif_owned_vehicle_order_v131;
    CREATE TEMPORARY TABLE tmp_saif_owned_vehicle_order_v131 (
        vehicle_id INT UNSIGNED NOT NULL PRIMARY KEY,
        new_slot SMALLINT UNSIGNED NOT NULL,
        UNIQUE KEY uq_tmp_owner_order (vehicle_id,new_slot)
    ) ENGINE=MEMORY;

    INSERT INTO tmp_saif_owned_vehicle_order_v131 (vehicle_id,new_slot)
    SELECT id,
           ROW_NUMBER() OVER (
             PARTITION BY owner_id
             ORDER BY CASE WHEN slot BETWEEN 1 AND 32 THEN slot ELSE 999 END,id
           ) AS new_slot
    FROM player_vehicles;

    START TRANSACTION;

    -- Preserve every legacy vehicle while converting the old three-slot ordering into a 1..32 internal display order.
    -- The intermediate range avoids owner/slot unique-key collisions during the update.
    UPDATE player_vehicles pv
    JOIN tmp_saif_owned_vehicle_order_v131 tmp ON tmp.vehicle_id=pv.id
    SET pv.slot=64+tmp.new_slot;

    UPDATE player_vehicles pv
    JOIN tmp_saif_owned_vehicle_order_v131 tmp ON tmp.vehicle_id=pv.id
    SET pv.slot=tmp.new_slot;

    INSERT INTO vehicle_storage_locations
    (storage_key,storage_type,reference_id,location_name,ownership_mode,access_mode,capacity,
     interaction_x,interaction_y,interaction_z,interaction_radius,spawn_x,spawn_y,spawn_z,spawn_a,
     interior_id,virtual_world,geometry_status,enabled,apply_status,source_tag,row_checksum)
    SELECT CONCAT('house_',hc.id),'house',hc.id,CONCAT(hc.display_name,' Vehicle Storage'),
           'inherit_house_owner','house_owner_only',1,
           0,0,0,2.5,0,0,0,0,0,0,'pending',0,'draft','manual_house_storage_pending_v0.26A.1.31',NULL
    FROM house_catalog hc
    WHERE hc.enabled=1 AND hc.canonical_slot BETWEEN 3 AND 31
    ON DUPLICATE KEY UPDATE
      location_name=VALUES(location_name),ownership_mode='inherit_house_owner',access_mode='house_owner_only';

    INSERT INTO vehicle_storage_locations
    (storage_key,storage_type,reference_id,location_name,ownership_mode,access_mode,capacity,
     interaction_x,interaction_y,interaction_z,interaction_radius,spawn_x,spawn_y,spawn_z,spawn_a,
     interior_id,virtual_world,geometry_status,enabled,apply_status,source_tag,row_checksum)
    SELECT CONCAT('house_',hc.id),'house',hc.id,CONCAT(hc.display_name,' Vehicle Storage'),
           'inherit_house_owner','house_owner_only',1,
           gc.interaction_x,gc.interaction_y,gc.interaction_z,2.5,
           gc.vehicle_spawn_x,gc.vehicle_spawn_y,gc.vehicle_spawn_z,gc.vehicle_spawn_a,
           0,0,'ready',1,'applied','offline_exact_house_storage12_v0.26A.1.31',
           SHA2(CONCAT_WS('|',hc.id,gc.id,gc.interaction_x,gc.interaction_y,gc.interaction_z,
                              gc.vehicle_spawn_x,gc.vehicle_spawn_y,gc.vehicle_spawn_z,gc.vehicle_spawn_a),256)
    FROM house_garage_links hgl
    JOIN garage_catalog gc ON gc.id=hgl.garage_catalog_id
    JOIN house_catalog hc ON hc.id=hgl.house_catalog_id
    WHERE hgl.enabled=1 AND hgl.link_class='baseline_savehouse'
      AND gc.enabled=1 AND gc.spawn_status='ready' AND hc.enabled=1
    ON DUPLICATE KEY UPDATE
      location_name=VALUES(location_name),ownership_mode=VALUES(ownership_mode),access_mode=VALUES(access_mode),capacity=1,
      interaction_x=VALUES(interaction_x),interaction_y=VALUES(interaction_y),interaction_z=VALUES(interaction_z),interaction_radius=VALUES(interaction_radius),
      spawn_x=VALUES(spawn_x),spawn_y=VALUES(spawn_y),spawn_z=VALUES(spawn_z),spawn_a=VALUES(spawn_a),
      interior_id=0,virtual_world=0,geometry_status='ready',enabled=1,apply_status='applied',source_tag=VALUES(source_tag),row_checksum=VALUES(row_checksum);

    INSERT INTO vehicle_storage_slots
    (storage_location_id,slot_number,slot_name,pos_x,pos_y,pos_z,pos_a,interior_id,virtual_world,enabled,source_tag)
    SELECT id,1,CONCAT(location_name,' Slot 1'),spawn_x,spawn_y,spawn_z,spawn_a,interior_id,virtual_world,1,
           'saif_owned_vehicle_rework_v0.26A.1.31'
    FROM vehicle_storage_locations
    WHERE enabled=1 AND geometry_status='ready' AND spawn_x<>0 AND spawn_y<>0 AND spawn_z<>0
    ON DUPLICATE KEY UPDATE
      slot_name=VALUES(slot_name),pos_x=VALUES(pos_x),pos_y=VALUES(pos_y),pos_z=VALUES(pos_z),pos_a=VALUES(pos_a),
      interior_id=VALUES(interior_id),virtual_world=VALUES(virtual_world),enabled=1,source_tag=VALUES(source_tag);

    INSERT INTO vehicle_spawn_points
    (point_key,point_name,source_type,source_reference_id,pos_x,pos_y,pos_z,pos_a,interior_id,virtual_world,clear_radius,priority,enabled,source_tag)
    SELECT CONCAT('storage_',vss.storage_location_id,'_',vss.slot_number),vss.slot_name,'garage_storage_slot',vss.id,
           vss.pos_x,vss.pos_y,vss.pos_z,vss.pos_a,vss.interior_id,vss.virtual_world,4.5,10,1,
           'saif_owned_vehicle_rework_v0.26A.1.31'
    FROM vehicle_storage_slots vss
    WHERE vss.enabled=1
    ON DUPLICATE KEY UPDATE
      point_name=VALUES(point_name),pos_x=VALUES(pos_x),pos_y=VALUES(pos_y),pos_z=VALUES(pos_z),pos_a=VALUES(pos_a),
      interior_id=VALUES(interior_id),virtual_world=VALUES(virtual_world),clear_radius=4.5,priority=10,enabled=1,source_tag=VALUES(source_tag);

    -- Offset 4 metres to the side of GTA parked vehicles so the public vehicle itself does not occupy the spawn point.
    INSERT INTO vehicle_spawn_points
    (point_key,point_name,source_type,source_reference_id,pos_x,pos_y,pos_z,pos_a,interior_id,virtual_world,clear_radius,priority,enabled,source_tag)
    SELECT CONCAT('parked_offset_',pv.id),CONCAT('Public Parking ',pv.id),'parked_vehicle_offset',pv.id,
           pv.pos_x + COS(RADIANS(pv.pos_a+90))*4.0,
           pv.pos_y + SIN(RADIANS(pv.pos_a+90))*4.0,
           pv.pos_z,pv.pos_a,pv.interior,pv.virtual_world,4.5,50,1,
           'saif_owned_vehicle_rework_v0.26A.1.31'
    FROM parked_vehicles pv
    WHERE pv.enabled=1
    ON DUPLICATE KEY UPDATE
      point_name=VALUES(point_name),pos_x=VALUES(pos_x),pos_y=VALUES(pos_y),pos_z=VALUES(pos_z),pos_a=VALUES(pos_a),
      interior_id=VALUES(interior_id),virtual_world=VALUES(virtual_world),clear_radius=4.5,priority=50,enabled=1,source_tag=VALUES(source_tag);

    UPDATE player_vehicles pv
    LEFT JOIN player_vehicle_storage pvs ON pvs.player_vehicle_id=pv.id
    SET pv.lifecycle_status=CASE
            WHEN pvs.id IS NOT NULL THEN 'stored'
            WHEN pv.lifecycle_status IS NULL OR pv.lifecycle_status='' THEN 'legacy_unassigned'
            ELSE pv.lifecycle_status
        END,
        pv.home_storage_location_id=COALESCE(pv.home_storage_location_id,pvs.storage_location_id),
        pv.home_storage_slot=COALESCE(pv.home_storage_slot,pvs.storage_slot),
        pv.purchase_origin=CASE WHEN pv.purchase_origin IS NULL OR pv.purchase_origin='' THEN 'legacy' ELSE pv.purchase_origin END,
        pv.lifecycle_source_tag=CASE WHEN pvs.id IS NOT NULL THEN 'saif_owned_vehicle_rework_v0.26A.1.31' ELSE pv.lifecycle_source_tag END,
        pv.first_garage_saved_at=CASE WHEN pvs.id IS NOT NULL THEN COALESCE(pv.first_garage_saved_at,pvs.stored_at) ELSE pv.first_garage_saved_at END,
        pv.destroyed_until=CASE WHEN pvs.id IS NOT NULL THEN NULL ELSE pv.destroyed_until END,
        pv.last_state_changed_at=NOW();

    UPDATE player_vehicle_storage
    SET source_tag='saif_owned_vehicle_rework_v0.26A.1.31'
    WHERE source_tag LIKE 'saif_house_storage_runtime_v0.26A.1.30.1%';

    UPDATE vehicle_storage_policy
    SET enabled=1,
        house_storage_enabled=1,
        public_garage_storage_enabled=0,
        impound_storage_enabled=0,
        business_storage_enabled=0,
        store_enabled=1,
        retrieve_enabled=1,
        alt_confirmation_required=1,
        driver_required=1,
        vehicle_owner_required=1,
        one_active_storage_per_vehicle=1,
        max_locations=512,
        max_slots_per_location=10,
        dealer_pending_enabled=1,
        nearest_spawn_enabled=1,
        despawn_enabled=1,
        color_modification_enabled=1,
        parked_vehicle_lifecycle_enabled=1,
        destroyed_cooldown_seconds=120,
        parked_abandon_seconds=180,
        parked_home_radius=40.0,
        source_tag='saif_v0.26A.1.31'
    WHERE id=1;

    COMMIT;
    DROP TEMPORARY TABLE IF EXISTS tmp_saif_owned_vehicle_order_v131;

    SELECT 'APPLY_GATE' section,
      (SELECT COUNT(*) FROM vehicle_storage_locations WHERE storage_type='house') house_locations_expected_29,
      (SELECT COUNT(*) FROM vehicle_storage_locations WHERE storage_type='house' AND enabled=1 AND geometry_status='ready') exact_enabled_expected_12,
      (SELECT COUNT(*) FROM vehicle_storage_locations WHERE storage_type='house' AND enabled=0 AND geometry_status='pending') editor_pending_expected_17,
      (SELECT COUNT(*) FROM vehicle_storage_slots WHERE enabled=1) physical_slots_expected_at_least_12,
      (SELECT COUNT(*) FROM vehicle_spawn_points WHERE enabled=1) spawn_points_informational,
      (SELECT COUNT(*) FROM player_vehicles WHERE slot IS NULL OR slot<1 OR slot>32) invalid_internal_order_should_be_zero,
      (SELECT COUNT(*) FROM vehicle_storage_policy WHERE id=1 AND enabled=1 AND house_storage_enabled=1
        AND store_enabled=1 AND retrieve_enabled=1 AND dealer_pending_enabled=1 AND nearest_spawn_enabled=1
        AND despawn_enabled=1 AND color_modification_enabled=1 AND parked_vehicle_lifecycle_enabled=1) ready_should_be_1;
END//
DELIMITER ;
CALL saif_apply_owned_vehicle_runtime_v026A131();
DROP PROCEDURE IF EXISTS saif_apply_owned_vehicle_runtime_v026A131;
