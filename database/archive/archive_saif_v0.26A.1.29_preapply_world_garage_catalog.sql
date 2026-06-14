-- SAIF / LSIF Dev v0.26A.1.29
-- Capture current world garage runtime before controlled 12-savehouse apply.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @archive_version := _utf8mb4'saif-world-garage-runtime-archive-v0.26A.1.29' COLLATE utf8mb4_unicode_ci;
SET @geometry_planner_version := _utf8mb4'saif-garage-geometry-planner-v0.26A.1.28' COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_archive_world_garage_runtime_v026A129;
DELIMITER //
CREATE PROCEDURE saif_archive_world_garage_runtime_v026A129()
BEGIN
    DECLARE v_geometry_session BIGINT UNSIGNED DEFAULT NULL;
    DECLARE v_archive BIGINT UNSIGNED DEFAULT NULL;
    DECLARE v_catalog_total INT DEFAULT 0;
    DECLARE v_catalog_active INT DEFAULT 0;
    DECLARE v_link_total INT DEFAULT 0;
    DECLARE v_link_active INT DEFAULT 0;
    DECLARE v_archived_catalog INT DEFAULT 0;
    DECLARE v_archived_links INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SELECT id INTO v_geometry_session
    FROM offline_garage_geometry_sessions
    WHERE BINARY planner_version=BINARY @geometry_planner_version
      AND status='complete'
      AND total_rows=52
      AND baseline_rows=12
      AND baseline_ready_rows=12
      AND invalid_bounds=0
      AND invalid_dimensions=0
      AND invalid_spawn=0
    ORDER BY id DESC LIMIT 1;

    IF v_geometry_session IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Complete v0.26A.1.28 geometry session not found.';
    END IF;

    SELECT COUNT(*),COALESCE(SUM(enabled=1),0) INTO v_catalog_total,v_catalog_active FROM garage_catalog;
    SELECT COUNT(*),COALESCE(SUM(enabled=1),0) INTO v_link_total,v_link_active FROM house_garage_links;

    START TRANSACTION;

    INSERT INTO garage_catalog_runtime_archive_sessions
    (archive_version,geometry_session_id,status,runtime_rows_total,active_rows_total,link_rows_total,active_link_rows_total,
     policy_key,policy_enabled,policy_max_catalog_rows,policy_interaction_radius,policy_vehicle_required,
     policy_inherit_house_owner,policy_store_enabled,policy_retrieve_enabled,policy_door_animation_enabled,notes)
    SELECT @archive_version,v_geometry_session,'building',v_catalog_total,v_catalog_active,v_link_total,v_link_active,
           policy_key,enabled,max_catalog_rows,interaction_radius,vehicle_required,inherit_house_owner,
           store_enabled,retrieve_enabled,door_animation_enabled,
           'Pre-apply snapshot for controlled 12 baseline savehouse garage catalog apply.'
    FROM garage_runtime_policy WHERE id=1;

    IF ROW_COUNT()<>1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='garage_runtime_policy id=1 is missing.';
    END IF;

    SET v_archive=LAST_INSERT_ID();

    INSERT INTO garage_catalog_runtime_archive_rows
    (archive_session_id,original_id,canonical_garage_plan_id,source_queue_id,garage_key,garage_name,runtime_class,safety_class,
     garage_type,garage_door_type,center_x,center_y,center_z,bound_x1,bound_y1,bound_z1,bound_x2,bound_y2,bound_x3,bound_y3,bound_z2,
     interaction_x,interaction_y,interaction_z,vehicle_spawn_x,vehicle_spawn_y,vehicle_spawn_z,vehicle_spawn_a,spawn_status,
     source_file,source_line,source_record_hash,city_region,area_code,enabled,apply_status,sort_order,source_tag,row_checksum,
     original_created_at,original_updated_at)
    SELECT v_archive,id,canonical_garage_plan_id,source_queue_id,garage_key,garage_name,runtime_class,safety_class,
           garage_type,garage_door_type,center_x,center_y,center_z,bound_x1,bound_y1,bound_z1,bound_x2,bound_y2,bound_x3,bound_y3,bound_z2,
           interaction_x,interaction_y,interaction_z,vehicle_spawn_x,vehicle_spawn_y,vehicle_spawn_z,vehicle_spawn_a,spawn_status,
           source_file,source_line,source_record_hash,city_region,area_code,enabled,apply_status,sort_order,source_tag,row_checksum,
           created_at,updated_at
    FROM garage_catalog ORDER BY id;

    INSERT INTO garage_house_link_runtime_archive_rows
    (archive_session_id,original_id,house_catalog_id,garage_catalog_id,canonical_house_slot,link_class,ownership_mode,access_mode,
     enabled,source_tag,original_created_at,original_updated_at)
    SELECT v_archive,id,house_catalog_id,garage_catalog_id,canonical_house_slot,link_class,ownership_mode,access_mode,
           enabled,source_tag,created_at,updated_at
    FROM house_garage_links ORDER BY id;

    SELECT COUNT(*) INTO v_archived_catalog FROM garage_catalog_runtime_archive_rows WHERE archive_session_id=v_archive;
    SELECT COUNT(*) INTO v_archived_links FROM garage_house_link_runtime_archive_rows WHERE archive_session_id=v_archive;

    IF v_archived_catalog<>v_catalog_total OR v_archived_links<>v_link_total THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Garage runtime archive count mismatch.';
    END IF;

    UPDATE garage_catalog_runtime_archive_sessions
    SET status='complete',completed_at=CURRENT_TIMESTAMP,
        notes=CONCAT('Archived catalog=',v_catalog_total,' active=',v_catalog_active,
                     '; links=',v_link_total,' active links=',v_link_active,
                     '; policy preserved. Ready for controlled apply gate.')
    WHERE id=v_archive;

    COMMIT;

    SELECT 'ARCHIVE_GATE' section,id archive_session_id,status archive_status,runtime_rows_total,active_rows_total,
           link_rows_total,active_link_rows_total,
           (status='complete') ready_should_be_1
    FROM garage_catalog_runtime_archive_sessions WHERE id=v_archive;
END//
DELIMITER ;
CALL saif_archive_world_garage_runtime_v026A129();
DROP PROCEDURE IF EXISTS saif_archive_world_garage_runtime_v026A129;
