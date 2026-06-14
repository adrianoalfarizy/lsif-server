-- SAIF / LSIF Dev v0.26A.1.29
-- Roll back latest complete controlled 12-savehouse garage apply.
-- Required confirmation: SET @saif_confirm='ROLLBACK_LATEST_12_GTASA_SAVEHOUSE_GARAGES';
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @apply_version := _utf8mb4'saif-controlled-12-savehouse-garage-apply-v0.26A.1.29' COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_rollback_latest_gtasa12_savehouse_garages_v026A129;
DELIMITER //
CREATE PROCEDURE saif_rollback_latest_gtasa12_savehouse_garages_v026A129()
BEGIN
    DECLARE v_apply BIGINT UNSIGNED DEFAULT NULL;
    DECLARE v_archive BIGINT UNSIGNED DEFAULT NULL;
    DECLARE v_tracked INT DEFAULT 0;
    DECLARE v_missing_catalog INT DEFAULT 0;
    DECLARE v_missing_links INT DEFAULT 0;
    DECLARE v_catalog_mismatch INT DEFAULT 0;
    DECLARE v_link_mismatch INT DEFAULT 0;
    DECLARE v_archive_catalog INT DEFAULT 0;
    DECLARE v_archive_links INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF @saif_confirm IS NULL OR BINARY @saif_confirm<>BINARY 'ROLLBACK_LATEST_12_GTASA_SAVEHOUSE_GARAGES' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation missing. Set @saif_confirm=ROLLBACK_LATEST_12_GTASA_SAVEHOUSE_GARAGES.';
    END IF;

    SELECT id,archive_session_id INTO v_apply,v_archive
    FROM garage_catalog_apply_sessions
    WHERE BINARY apply_version=BINARY @apply_version AND status='complete'
    ORDER BY id DESC LIMIT 1;

    IF v_apply IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No complete v0.26A.1.29 garage apply session found.';
    END IF;

    SELECT COUNT(*) INTO v_tracked FROM garage_catalog_apply_rows WHERE apply_session_id=v_apply;
    IF v_tracked<>12 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Tracked apply rows are not exactly 12.';
    END IF;

    SELECT SUM(gc.id IS NULL),SUM(hgl.id IS NULL),
           SUM(gc.id IS NOT NULL AND BINARY gc.row_checksum<>BINARY ar.catalog_checksum),
           SUM(hgl.id IS NOT NULL AND BINARY SHA2(CONCAT_WS('|',hgl.house_catalog_id,hgl.garage_catalog_id,COALESCE(hgl.canonical_house_slot,''),
               hgl.link_class,hgl.ownership_mode,hgl.access_mode,hgl.enabled,hgl.source_tag),256)<>BINARY ar.link_checksum)
      INTO v_missing_catalog,v_missing_links,v_catalog_mismatch,v_link_mismatch
    FROM garage_catalog_apply_rows ar
    LEFT JOIN garage_catalog gc ON gc.id=ar.garage_catalog_id
    LEFT JOIN house_garage_links hgl ON hgl.id=ar.house_garage_link_id
    WHERE ar.apply_session_id=v_apply;

    IF v_missing_catalog<>0 OR v_missing_links<>0 OR v_catalog_mismatch<>0 OR v_link_mismatch<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Applied garage rows changed after apply. Manual review required before rollback.';
    END IF;

    SELECT COUNT(*) INTO v_archive_catalog FROM garage_catalog_runtime_archive_rows WHERE archive_session_id=v_archive;
    SELECT COUNT(*) INTO v_archive_links FROM garage_house_link_runtime_archive_rows WHERE archive_session_id=v_archive;

    START TRANSACTION;

    DELETE hgl FROM house_garage_links hgl
    JOIN garage_catalog_apply_rows ar ON ar.house_garage_link_id=hgl.id
    WHERE ar.apply_session_id=v_apply;

    DELETE gc FROM garage_catalog gc
    JOIN garage_catalog_apply_rows ar ON ar.garage_catalog_id=gc.id
    WHERE ar.apply_session_id=v_apply;

    INSERT INTO garage_catalog
    (id,canonical_garage_plan_id,source_queue_id,garage_key,garage_name,runtime_class,safety_class,garage_type,garage_door_type,
     center_x,center_y,center_z,bound_x1,bound_y1,bound_z1,bound_x2,bound_y2,bound_x3,bound_y3,bound_z2,
     interaction_x,interaction_y,interaction_z,vehicle_spawn_x,vehicle_spawn_y,vehicle_spawn_z,vehicle_spawn_a,spawn_status,
     source_file,source_line,source_record_hash,city_region,area_code,enabled,apply_status,sort_order,source_tag,row_checksum,created_at,updated_at)
    SELECT original_id,canonical_garage_plan_id,source_queue_id,garage_key,garage_name,runtime_class,safety_class,garage_type,garage_door_type,
           center_x,center_y,center_z,bound_x1,bound_y1,bound_z1,bound_x2,bound_y2,bound_x3,bound_y3,bound_z2,
           interaction_x,interaction_y,interaction_z,vehicle_spawn_x,vehicle_spawn_y,vehicle_spawn_z,vehicle_spawn_a,spawn_status,
           source_file,source_line,source_record_hash,city_region,area_code,enabled,apply_status,sort_order,source_tag,row_checksum,
           original_created_at,original_updated_at
    FROM garage_catalog_runtime_archive_rows
    WHERE archive_session_id=v_archive
    ORDER BY original_id;

    INSERT INTO house_garage_links
    (id,house_catalog_id,garage_catalog_id,canonical_house_slot,link_class,ownership_mode,access_mode,enabled,source_tag,created_at,updated_at)
    SELECT original_id,house_catalog_id,garage_catalog_id,canonical_house_slot,link_class,ownership_mode,access_mode,enabled,source_tag,
           original_created_at,original_updated_at
    FROM garage_house_link_runtime_archive_rows
    WHERE archive_session_id=v_archive
    ORDER BY original_id;

    UPDATE garage_runtime_policy p
    JOIN garage_catalog_runtime_archive_sessions a ON a.id=v_archive
    SET p.policy_key=a.policy_key,
        p.enabled=a.policy_enabled,
        p.max_catalog_rows=a.policy_max_catalog_rows,
        p.interaction_radius=a.policy_interaction_radius,
        p.vehicle_required=a.policy_vehicle_required,
        p.inherit_house_owner=a.policy_inherit_house_owner,
        p.store_enabled=a.policy_store_enabled,
        p.retrieve_enabled=a.policy_retrieve_enabled,
        p.door_animation_enabled=a.policy_door_animation_enabled,
        p.notes=CONCAT('Restored by v0.26A.1.29 rollback from archive session ',a.id,'.')
    WHERE p.id=1;

    UPDATE garage_catalog_apply_rows SET row_status='rolled_back' WHERE apply_session_id=v_apply;
    UPDATE garage_catalog_apply_sessions
    SET status='rolled_back',rolled_back_at=CURRENT_TIMESTAMP,
        notes=CONCAT(notes,' Rollback restored archive session ',v_archive,
                     ' with catalog=',v_archive_catalog,' links=',v_archive_links,'.')
    WHERE id=v_apply;

    COMMIT;

    SELECT 'ROLLBACK_GATE' section,v_apply apply_session_id,v_archive archive_session_id,
           (SELECT COUNT(*) FROM garage_catalog_runtime_archive_rows WHERE archive_session_id=v_archive) restored_catalog_expected,
           (SELECT COUNT(*) FROM garage_house_link_runtime_archive_rows WHERE archive_session_id=v_archive) restored_links_expected,
           (SELECT COUNT(*) FROM garage_catalog_apply_rows WHERE apply_session_id=v_apply AND row_status='rolled_back') tracked_rows_rolled_back_expected_12,
           (SELECT status FROM garage_catalog_apply_sessions WHERE id=v_apply) apply_status_expected_rolled_back;
END//
DELIMITER ;
CALL saif_rollback_latest_gtasa12_savehouse_garages_v026A129();
DROP PROCEDURE IF EXISTS saif_rollback_latest_gtasa12_savehouse_garages_v026A129;
