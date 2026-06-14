-- SAIF / LSIF v0.26A.1.30.1
-- Direct apply: 12 exact house storage locations enabled + 17 pending editor rows + runtime policy enabled.
-- Required: SET @saif_confirm='APPLY_HOUSE_VEHICLE_STORAGE_RUNTIME';
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_apply_house_vehicle_storage_v026A1301;
DELIMITER //
CREATE PROCEDURE saif_apply_house_vehicle_storage_v026A1301()
BEGIN
    DECLARE v_exact INT DEFAULT 0;
    DECLARE v_houses INT DEFAULT 0;
    DECLARE v_existing_state INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; RESIGNAL; END;

    IF @saif_confirm IS NULL OR BINARY @saif_confirm<>BINARY 'APPLY_HOUSE_VEHICLE_STORAGE_RUNTIME' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation missing: APPLY_HOUSE_VEHICLE_STORAGE_RUNTIME';
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
    SELECT COUNT(*) INTO v_houses FROM house_catalog WHERE enabled=1 AND canonical_slot BETWEEN 3 AND 31;
    SELECT COUNT(*) INTO v_existing_state FROM player_vehicle_storage;

    IF v_exact<>12 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Expected exactly 12 ready baseline garage links.'; END IF;
    IF v_houses<>29 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Expected exactly 29 active canonical houses.'; END IF;
    IF v_existing_state<>0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Storage state already exists; do not re-apply blindly.'; END IF;

    START TRANSACTION;

    INSERT INTO vehicle_storage_locations
    (storage_key,storage_type,reference_id,location_name,ownership_mode,access_mode,capacity,
     interaction_x,interaction_y,interaction_z,interaction_radius,spawn_x,spawn_y,spawn_z,spawn_a,
     interior_id,virtual_world,geometry_status,enabled,apply_status,source_tag,row_checksum)
    SELECT CONCAT('house_',hc.id),'house',hc.id,CONCAT(hc.display_name,' Vehicle Storage'),
           'inherit_house_owner','house_owner_only',1,
           0,0,0,2.5,0,0,0,0,0,0,'pending',0,'draft','manual_house_storage_pending_v0.26A.1.30.1',NULL
    FROM house_catalog hc
    WHERE hc.enabled=1 AND hc.canonical_slot BETWEEN 3 AND 31
    ON DUPLICATE KEY UPDATE location_name=VALUES(location_name),ownership_mode='inherit_house_owner',access_mode='house_owner_only';

    INSERT INTO vehicle_storage_locations
    (storage_key,storage_type,reference_id,location_name,ownership_mode,access_mode,capacity,
     interaction_x,interaction_y,interaction_z,interaction_radius,spawn_x,spawn_y,spawn_z,spawn_a,
     interior_id,virtual_world,geometry_status,enabled,apply_status,source_tag,row_checksum)
    SELECT CONCAT('house_',hc.id),'house',hc.id,CONCAT(hc.display_name,' Vehicle Storage'),
           'inherit_house_owner','house_owner_only',1,
           gc.interaction_x,gc.interaction_y,gc.interaction_z,2.5,
           gc.vehicle_spawn_x,gc.vehicle_spawn_y,gc.vehicle_spawn_z,gc.vehicle_spawn_a,
           0,0,'ready',1,'applied','offline_exact_house_storage12_v0.26A.1.30.1',
           SHA2(CONCAT_WS('|',hc.id,gc.id,gc.interaction_x,gc.interaction_y,gc.interaction_z,gc.vehicle_spawn_x,gc.vehicle_spawn_y,gc.vehicle_spawn_z,gc.vehicle_spawn_a),256)
    FROM house_garage_links hgl
    JOIN garage_catalog gc ON gc.id=hgl.garage_catalog_id
    JOIN house_catalog hc ON hc.id=hgl.house_catalog_id
    WHERE hgl.enabled=1 AND hgl.link_class='baseline_savehouse'
      AND gc.enabled=1 AND gc.spawn_status='ready' AND hc.enabled=1
    ON DUPLICATE KEY UPDATE
      location_name=VALUES(location_name),ownership_mode=VALUES(ownership_mode),access_mode=VALUES(access_mode),capacity=VALUES(capacity),
      interaction_x=VALUES(interaction_x),interaction_y=VALUES(interaction_y),interaction_z=VALUES(interaction_z),interaction_radius=VALUES(interaction_radius),
      spawn_x=VALUES(spawn_x),spawn_y=VALUES(spawn_y),spawn_z=VALUES(spawn_z),spawn_a=VALUES(spawn_a),
      interior_id=0,virtual_world=0,geometry_status='ready',enabled=1,apply_status='applied',source_tag=VALUES(source_tag),row_checksum=VALUES(row_checksum);

    UPDATE vehicle_storage_policy
    SET enabled=1,house_storage_enabled=1,public_garage_storage_enabled=0,impound_storage_enabled=0,business_storage_enabled=0,
        store_enabled=1,retrieve_enabled=1,alt_confirmation_required=1,driver_required=1,vehicle_owner_required=1,
        one_active_storage_per_vehicle=1,max_locations=512,max_slots_per_location=10,source_tag='saif_v0.26A.1.30.1'
    WHERE id=1;

    COMMIT;

    SELECT 'APPLY_GATE' section,
      (SELECT COUNT(*) FROM vehicle_storage_locations WHERE storage_type='house') house_locations_expected_29,
      (SELECT COUNT(*) FROM vehicle_storage_locations WHERE storage_type='house' AND enabled=1 AND geometry_status='ready') exact_enabled_expected_12,
      (SELECT COUNT(*) FROM vehicle_storage_locations WHERE storage_type='house' AND enabled=0 AND geometry_status='pending') editor_pending_expected_17,
      (SELECT COUNT(*) FROM vehicle_storage_policy WHERE id=1 AND enabled=1 AND house_storage_enabled=1 AND store_enabled=1 AND retrieve_enabled=1) policy_ready_should_be_1;
END//
DELIMITER ;
CALL saif_apply_house_vehicle_storage_v026A1301();
DROP PROCEDURE IF EXISTS saif_apply_house_vehicle_storage_v026A1301;
