-- SAIF / LSIF Dev v0.26A.1.29
-- Controlled apply: 12 baseline savehouse garage definitions + 12 house links.
-- Required confirmation: SET @saif_confirm='APPLY_12_GTASA_SAVEHOUSE_GARAGES';
-- SAFETY: garage policy remains disabled. No checkpoint, door object, vehicle storage/retrieval, or ownership mutation.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @apply_version := _utf8mb4'saif-controlled-12-savehouse-garage-apply-v0.26A.1.29' COLLATE utf8mb4_unicode_ci;
SET @archive_version := _utf8mb4'saif-world-garage-runtime-archive-v0.26A.1.29' COLLATE utf8mb4_unicode_ci;
SET @geometry_planner_version := _utf8mb4'saif-garage-geometry-planner-v0.26A.1.28' COLLATE utf8mb4_unicode_ci;
SET @catalog_source_tag := _utf8mb4'offline_gtasa_savehouse_garage12_a1' COLLATE utf8mb4_unicode_ci;
SET @link_source_tag := _utf8mb4'offline_gtasa_savehouse_garage12_link_a1' COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_apply_gtasa12_savehouse_garages_v026A129;
DELIMITER //
CREATE PROCEDURE saif_apply_gtasa12_savehouse_garages_v026A129()
BEGIN
    DECLARE v_geometry_session BIGINT UNSIGNED DEFAULT NULL;
    DECLARE v_resolver_session BIGINT UNSIGNED DEFAULT NULL;
    DECLARE v_archive_session BIGINT UNSIGNED DEFAULT NULL;
    DECLARE v_apply_session BIGINT UNSIGNED DEFAULT NULL;
    DECLARE v_candidates INT DEFAULT 0;
    DECLARE v_unique_garages INT DEFAULT 0;
    DECLARE v_unique_houses INT DEFAULT 0;
    DECLARE v_missing_houses INT DEFAULT 0;
    DECLARE v_catalog_before INT DEFAULT 0;
    DECLARE v_links_before INT DEFAULT 0;
    DECLARE v_catalog_after INT DEFAULT 0;
    DECLARE v_links_after INT DEFAULT 0;
    DECLARE v_policy_bad INT DEFAULT 0;
    DECLARE v_prior_apply INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF @saif_confirm IS NULL OR BINARY @saif_confirm<>BINARY 'APPLY_12_GTASA_SAVEHOUSE_GARAGES' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation missing. Set @saif_confirm=APPLY_12_GTASA_SAVEHOUSE_GARAGES.';
    END IF;

    SELECT id,garage_resolver_session_id INTO v_geometry_session,v_resolver_session
    FROM offline_garage_geometry_sessions
    WHERE BINARY planner_version=BINARY @geometry_planner_version
      AND status='complete' AND total_rows=52 AND baseline_rows=12 AND baseline_ready_rows=12
      AND invalid_bounds=0 AND invalid_dimensions=0 AND invalid_spawn=0
    ORDER BY id DESC LIMIT 1;

    IF v_geometry_session IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Complete v0.26A.1.28 geometry session not found.';
    END IF;

    SELECT id INTO v_archive_session
    FROM garage_catalog_runtime_archive_sessions
    WHERE BINARY archive_version=BINARY @archive_version AND status='complete'
    ORDER BY id DESC LIMIT 1;

    IF v_archive_session IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Complete v0.26A.1.29 pre-apply garage archive not found.';
    END IF;

    SELECT COUNT(*) INTO v_prior_apply
    FROM garage_catalog_apply_sessions
    WHERE BINARY apply_version=BINARY @apply_version AND status='complete';

    IF v_prior_apply<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Controlled 12-garage apply is already complete.';
    END IF;

    SELECT COUNT(*) INTO v_catalog_before FROM garage_catalog;
    SELECT COUNT(*) INTO v_links_before FROM house_garage_links;

    IF v_catalog_before<>0 OR v_links_before<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='garage_catalog/house_garage_links are not empty. Do not merge blindly.';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM garage_catalog_runtime_archive_sessions a
        WHERE a.id=v_archive_session AND a.runtime_rows_total=v_catalog_before AND a.link_rows_total=v_links_before
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Current garage runtime counts changed after archive. Capture fresh archive.';
    END IF;

    SELECT COUNT(*) INTO v_policy_bad
    FROM garage_runtime_policy
    WHERE id=1 AND (enabled<>0 OR store_enabled<>0 OR retrieve_enabled<>0 OR door_animation_enabled<>0 OR max_catalog_rows<12);

    IF v_policy_bad<>0 OR NOT EXISTS (SELECT 1 FROM garage_runtime_policy WHERE id=1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Garage runtime policy is not safely disabled.';
    END IF;

    SELECT COUNT(*),COUNT(DISTINCT gp.garage_plan_id),COUNT(DISTINCT l.house_slot),SUM(hc.id IS NULL OR hc.enabled<>1)
      INTO v_candidates,v_unique_garages,v_unique_houses,v_missing_houses
    FROM offline_garage_geometry_plan gp
    JOIN offline_garage_house_links l
      ON l.resolver_session_id=v_resolver_session
     AND l.garage_plan_id=gp.garage_plan_id
     AND l.link_class='baseline_savehouse_candidate'
    JOIN offline_garage_canonical_plan cp ON cp.id=gp.garage_plan_id
    LEFT JOIN house_catalog hc ON hc.canonical_slot=l.house_slot
    WHERE gp.geometry_session_id=v_geometry_session
      AND gp.safety_class='baseline_savehouse_candidate'
      AND gp.geometry_status='baseline_ready'
      AND gp.row_checksum<>'';

    IF v_candidates<>12 OR v_unique_garages<>12 OR v_unique_houses<>12 OR v_missing_houses<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Controlled target must be exactly 12 unique ready garages linked to 12 active houses.';
    END IF;

    START TRANSACTION;

    INSERT INTO garage_catalog_apply_sessions
    (apply_version,archive_session_id,geometry_session_id,garage_resolver_session_id,status,
     expected_catalog_rows,expected_link_rows,notes)
    VALUES
    (@apply_version,v_archive_session,v_geometry_session,v_resolver_session,'applying',12,12,
     'Controlled 12 baseline savehouse garage catalog apply. Policy remains disabled; no storage/retrieval/door/checkpoint runtime.');
    SET v_apply_session=LAST_INSERT_ID();

    INSERT INTO garage_catalog
    (canonical_garage_plan_id,source_queue_id,garage_key,garage_name,runtime_class,safety_class,
     garage_type,garage_door_type,center_x,center_y,center_z,
     bound_x1,bound_y1,bound_z1,bound_x2,bound_y2,bound_x3,bound_y3,bound_z2,
     interaction_x,interaction_y,interaction_z,
     vehicle_spawn_x,vehicle_spawn_y,vehicle_spawn_z,vehicle_spawn_a,spawn_status,
     source_file,source_line,source_record_hash,city_region,area_code,
     enabled,apply_status,sort_order,source_tag,row_checksum)
    SELECT gp.garage_plan_id,cp.source_queue_id,cp.garage_key,cp.garage_name,'house_garage','baseline_savehouse',
           cp.garage_type,cp.garage_door_type,cp.center_x,cp.center_y,cp.center_z,
           gp.point1_x,gp.point1_y,gp.floor_z,gp.point2_x,gp.point2_y,gp.point3_x,gp.point3_y,gp.ceiling_z,
           gp.interaction_x,gp.interaction_y,gp.interaction_z,
           gp.vehicle_spawn_x,gp.vehicle_spawn_y,gp.vehicle_spawn_z,gp.vehicle_spawn_a,'ready',
           cp.source_file,cp.source_line,cp.source_record_hash,cp.city_region,cp.area_code,
           1,'applied',l.house_slot,@catalog_source_tag,''
    FROM offline_garage_geometry_plan gp
    JOIN offline_garage_house_links l
      ON l.resolver_session_id=v_resolver_session
     AND l.garage_plan_id=gp.garage_plan_id
     AND l.link_class='baseline_savehouse_candidate'
    JOIN offline_garage_canonical_plan cp ON cp.id=gp.garage_plan_id
    JOIN house_catalog hc ON hc.canonical_slot=l.house_slot AND hc.enabled=1
    WHERE gp.geometry_session_id=v_geometry_session
      AND gp.safety_class='baseline_savehouse_candidate'
      AND gp.geometry_status='baseline_ready'
    ORDER BY l.house_slot;

    UPDATE garage_catalog
    SET row_checksum=SHA2(CONCAT_WS('|',canonical_garage_plan_id,source_queue_id,garage_key,garage_name,runtime_class,safety_class,
        garage_type,garage_door_type,center_x,center_y,center_z,bound_x1,bound_y1,bound_z1,bound_x2,bound_y2,bound_x3,bound_y3,bound_z2,
        interaction_x,interaction_y,interaction_z,COALESCE(vehicle_spawn_x,''),COALESCE(vehicle_spawn_y,''),COALESCE(vehicle_spawn_z,''),
        COALESCE(vehicle_spawn_a,''),spawn_status,source_file,source_line,source_record_hash,city_region,area_code,enabled,apply_status,sort_order,source_tag),256)
    WHERE BINARY source_tag=BINARY @catalog_source_tag;

    INSERT INTO house_garage_links
    (house_catalog_id,garage_catalog_id,canonical_house_slot,link_class,ownership_mode,access_mode,enabled,source_tag)
    SELECT hc.id,gc.id,l.house_slot,'baseline_savehouse','inherit_house_owner','house_owner_only',1,@link_source_tag
    FROM offline_garage_geometry_plan gp
    JOIN offline_garage_house_links l
      ON l.resolver_session_id=v_resolver_session
     AND l.garage_plan_id=gp.garage_plan_id
     AND l.link_class='baseline_savehouse_candidate'
    JOIN house_catalog hc ON hc.canonical_slot=l.house_slot AND hc.enabled=1
    JOIN garage_catalog gc ON gc.canonical_garage_plan_id=gp.garage_plan_id AND BINARY gc.source_tag=BINARY @catalog_source_tag
    WHERE gp.geometry_session_id=v_geometry_session
      AND gp.safety_class='baseline_savehouse_candidate'
      AND gp.geometry_status='baseline_ready'
    ORDER BY l.house_slot;

    INSERT INTO garage_catalog_apply_rows
    (apply_session_id,geometry_plan_id,garage_plan_id,house_plan_id,house_catalog_id,garage_catalog_id,house_garage_link_id,
     canonical_house_slot,source_queue_id,garage_key,garage_name,geometry_checksum,catalog_checksum,link_checksum,row_status)
    SELECT v_apply_session,gp.id,gp.garage_plan_id,l.house_plan_id,hc.id,gc.id,hgl.id,l.house_slot,
           gp.source_queue_id,gp.garage_key,gp.garage_name,gp.row_checksum,gc.row_checksum,
           SHA2(CONCAT_WS('|',hgl.house_catalog_id,hgl.garage_catalog_id,COALESCE(hgl.canonical_house_slot,''),hgl.link_class,
                          hgl.ownership_mode,hgl.access_mode,hgl.enabled,hgl.source_tag),256),
           'applied'
    FROM offline_garage_geometry_plan gp
    JOIN offline_garage_house_links l
      ON l.resolver_session_id=v_resolver_session
     AND l.garage_plan_id=gp.garage_plan_id
     AND l.link_class='baseline_savehouse_candidate'
    JOIN house_catalog hc ON hc.canonical_slot=l.house_slot AND hc.enabled=1
    JOIN garage_catalog gc ON gc.canonical_garage_plan_id=gp.garage_plan_id AND BINARY gc.source_tag=BINARY @catalog_source_tag
    JOIN house_garage_links hgl ON hgl.house_catalog_id=hc.id AND hgl.garage_catalog_id=gc.id AND BINARY hgl.source_tag=BINARY @link_source_tag
    WHERE gp.geometry_session_id=v_geometry_session
      AND gp.safety_class='baseline_savehouse_candidate'
      AND gp.geometry_status='baseline_ready'
    ORDER BY l.house_slot;

    SELECT COUNT(*) INTO v_catalog_after FROM garage_catalog WHERE BINARY source_tag=BINARY @catalog_source_tag;
    SELECT COUNT(*) INTO v_links_after FROM house_garage_links WHERE BINARY source_tag=BINARY @link_source_tag;

    IF v_catalog_after<>12 OR v_links_after<>12 OR
       (SELECT COUNT(*) FROM garage_catalog_apply_rows WHERE apply_session_id=v_apply_session)<>12 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Controlled garage apply row count mismatch.';
    END IF;

    IF EXISTS (SELECT 1 FROM garage_runtime_policy WHERE id=1 AND (enabled<>0 OR store_enabled<>0 OR retrieve_enabled<>0 OR door_animation_enabled<>0)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Garage policy changed during apply.';
    END IF;

    UPDATE garage_catalog_apply_sessions
    SET status='complete',applied_catalog_rows=v_catalog_after,applied_link_rows=v_links_after,
        policy_enabled_after=0,policy_store_enabled_after=0,policy_retrieve_enabled_after=0,policy_door_enabled_after=0,
        completed_at=CURRENT_TIMESTAMP,
        notes=CONCAT('Applied catalog=',v_catalog_after,'; links=',v_links_after,
                     '; loader may read 12 rows; all interaction/storage/retrieval/door policy remains disabled.')
    WHERE id=v_apply_session;

    COMMIT;

    SELECT 'APPLY_GATE' section,id apply_session_id,status apply_status,expected_catalog_rows,applied_catalog_rows,
           expected_link_rows,applied_link_rows,
           (status='complete' AND applied_catalog_rows=12 AND applied_link_rows=12) ready_should_be_1
    FROM garage_catalog_apply_sessions WHERE id=v_apply_session;

    SELECT 'POLICY_SAFETY_GATE' section,enabled,store_enabled,retrieve_enabled,door_animation_enabled,
           (enabled=0 AND store_enabled=0 AND retrieve_enabled=0 AND door_animation_enabled=0) ready_should_be_1
    FROM garage_runtime_policy WHERE id=1;
END//
DELIMITER ;
CALL saif_apply_gtasa12_savehouse_garages_v026A129();
DROP PROCEDURE IF EXISTS saif_apply_gtasa12_savehouse_garages_v026A129;
