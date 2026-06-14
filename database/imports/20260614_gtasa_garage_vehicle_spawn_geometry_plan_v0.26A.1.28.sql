-- SAIF / LSIF Dev v0.26A.1.28
-- Derive deterministic interaction, entry and vehicle-spawn transforms from exact IPL GRGE boundaries.
-- SAFETY: staging planner only. No runtime garage, vehicle, object, checkpoint, ownership, house_catalog, or player_vehicles mutation.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @geometry_planner_version := _utf8mb4'saif-garage-geometry-planner-v0.26A.1.28' COLLATE utf8mb4_unicode_ci;
SET @garage_resolver_version := _utf8mb4'saif-garage-canonical-resolver-v0.26A.1.26' COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_plan_gtasa_garage_geometry_v026A128;
DELIMITER //
CREATE PROCEDURE saif_plan_gtasa_garage_geometry_v026A128()
BEGIN
    DECLARE v_resolver_session BIGINT UNSIGNED DEFAULT NULL;
    DECLARE v_session BIGINT UNSIGNED DEFAULT NULL;
    DECLARE v_total INT DEFAULT 0;
    DECLARE v_baseline INT DEFAULT 0;
    DECLARE v_baseline_ready INT DEFAULT 0;
    DECLARE v_story INT DEFAULT 0;
    DECLARE v_service INT DEFAULT 0;
    DECLARE v_world INT DEFAULT 0;
    DECLARE v_invalid_bounds INT DEFAULT 0;
    DECLARE v_invalid_dimensions INT DEFAULT 0;
    DECLARE v_invalid_spawn INT DEFAULT 0;
    DECLARE v_enabled INT DEFAULT 0;
    DECLARE v_nondraft INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SELECT id INTO v_resolver_session
    FROM offline_garage_resolver_sessions
    WHERE BINARY resolver_version=BINARY @garage_resolver_version
      AND status='complete'
    ORDER BY id DESC LIMIT 1;

    IF v_resolver_session IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Complete v0.26A.1.26 garage resolver session not found.';
    END IF;

    IF (SELECT COUNT(*) FROM offline_garage_canonical_plan WHERE resolver_session_id=v_resolver_session)<>52 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Canonical garage count is not 52. Do not plan geometry.';
    END IF;

    IF (SELECT COUNT(*) FROM offline_garage_house_links WHERE resolver_session_id=v_resolver_session AND link_class='baseline_savehouse_candidate')<>12 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Baseline savehouse garage link count is not 12. Do not plan geometry.';
    END IF;

    START TRANSACTION;

    DELETE p FROM offline_garage_geometry_plan p
    JOIN offline_garage_geometry_sessions s ON s.id=p.geometry_session_id
    WHERE BINARY s.planner_version=BINARY @geometry_planner_version;

    DELETE FROM offline_garage_geometry_sessions
    WHERE BINARY planner_version=BINARY @geometry_planner_version;

    INSERT INTO offline_garage_geometry_sessions
    (garage_resolver_session_id,planner_version,source_resolver_version,status,notes)
    VALUES
    (v_resolver_session,@geometry_planner_version,@garage_resolver_version,'building',
     'Deterministic GRGE geometry planner. Point1->Point2 is treated as the front/door edge; Point1->Point3 is the depth direction. Staging only.');
    SET v_session=LAST_INSERT_ID();

    INSERT INTO offline_garage_geometry_plan
    (geometry_session_id,garage_plan_id,source_queue_id,garage_key,garage_name,runtime_class,safety_class,
     point1_x,point1_y,floor_z,point2_x,point2_y,point3_x,point3_y,ceiling_z,
     front_width,depth_length,height_clearance,depth_unit_x,depth_unit_y,
     front_mid_x,front_mid_y,front_mid_z,interaction_x,interaction_y,interaction_z,
     vehicle_entry_x,vehicle_entry_y,vehicle_entry_z,vehicle_entry_a,
     vehicle_spawn_x,vehicle_spawn_y,vehicle_spawn_z,vehicle_spawn_a,checkpoint_radius,
     geometry_status,review_reason,enabled,apply_status,row_checksum)
    SELECT
       v_session,g.garage_plan_id,g.source_queue_id,g.garage_key,g.garage_name,g.runtime_class,g.safety_class,
       g.x1,g.y1,g.z1,g.x2,g.y2,g.x3,g.y3,g.z2,
       g.front_width,g.depth_length,g.height_clearance,g.depth_unit_x,g.depth_unit_y,
       g.front_mid_x,g.front_mid_y,g.z1+0.75,
       g.front_mid_x-(g.depth_unit_x*2.50),g.front_mid_y-(g.depth_unit_y*2.50),g.z1+1.00,
       g.front_mid_x-(g.depth_unit_x*4.50),g.front_mid_y-(g.depth_unit_y*4.50),g.z1+0.75,
       MOD(DEGREES(ATAN2(-g.depth_unit_x,g.depth_unit_y))+360.0,360.0),
       g.front_mid_x+(g.depth_unit_x*g.spawn_offset),g.front_mid_y+(g.depth_unit_y*g.spawn_offset),g.z1+0.75,
       MOD(DEGREES(ATAN2(-g.depth_unit_x,g.depth_unit_y))+540.0,360.0),
       LEAST(3.50,GREATEST(1.80,g.front_width*0.35)),
       CASE
         WHEN g.bounds_valid=0 THEN 'invalid_bounds'
         WHEN g.front_width<=0.50 OR g.depth_length<=0.50 OR g.height_clearance<=0.50 THEN 'invalid_dimensions'
         WHEN g.spawn_offset<=0 OR g.spawn_offset>=g.depth_length THEN 'invalid_spawn'
         WHEN g.safety_class='baseline_savehouse_candidate' AND g.front_width>=3.50 AND g.depth_length>=4.50 AND g.height_clearance>=2.20 THEN 'baseline_ready'
         WHEN g.safety_class='baseline_savehouse_candidate' THEN 'baseline_review'
         WHEN g.safety_class='story_asset_deferred' THEN 'deferred_story'
         WHEN g.safety_class='service_reference' THEN 'reference_service'
         ELSE 'reference_world'
       END,
       CASE
         WHEN g.bounds_valid=0 THEN 'GRGE bounds_json is missing, invalid, or does not contain exactly eight values.'
         WHEN g.front_width<=0.50 OR g.depth_length<=0.50 OR g.height_clearance<=0.50 THEN 'GRGE contains non-usable structural dimensions.'
         WHEN g.spawn_offset<=0 OR g.spawn_offset>=g.depth_length THEN 'Derived vehicle spawn falls outside the Point1->Point3 depth segment.'
         WHEN g.safety_class='baseline_savehouse_candidate' AND g.front_width<3.50 THEN 'Baseline front/door edge is below the minimum 3.50m vehicle width gate.'
         WHEN g.safety_class='baseline_savehouse_candidate' AND g.depth_length<4.50 THEN 'Baseline garage depth is below the minimum 4.50m vehicle length gate.'
         WHEN g.safety_class='baseline_savehouse_candidate' AND g.height_clearance<2.20 THEN 'Baseline vertical clearance is below the minimum 2.20m vehicle height gate.'
         WHEN g.safety_class='baseline_savehouse_candidate' THEN 'Baseline savehouse candidate geometry is source-derived and ready for visual preview/dry-run; runtime apply remains disabled.'
         WHEN g.safety_class='story_asset_deferred' THEN 'Geometry is valid but story asset remains deferred.'
         WHEN g.safety_class='service_reference' THEN 'Geometry is retained as service reference only.'
         ELSE 'Geometry is retained as world reference only.'
       END,
       0,'draft',''
    FROM (
      SELECT v.*,
             (v.x1+v.x2)/2.0 front_mid_x,
             (v.y1+v.y2)/2.0 front_mid_y,
             CASE WHEN v.depth_length>0 THEN v.depth_dx/v.depth_length ELSE 0 END depth_unit_x,
             CASE WHEN v.depth_length>0 THEN v.depth_dy/v.depth_length ELSE 0 END depth_unit_y,
             LEAST(GREATEST(v.depth_length*0.55,2.25),GREATEST(v.depth_length-1.25,1.00)) spawn_offset
      FROM (
        SELECT r.*,
               SQRT(POW(r.x2-r.x1,2)+POW(r.y2-r.y1,2)) front_width,
               SQRT(POW(r.x3-r.x1,2)+POW(r.y3-r.y1,2)) depth_length,
               r.z2-r.z1 height_clearance,
               r.x3-r.x1 depth_dx,
               r.y3-r.y1 depth_dy
        FROM (
          SELECT p.id garage_plan_id,p.source_queue_id,p.garage_key,p.garage_name,p.runtime_class,p.safety_class,
                 CASE WHEN p.bounds_json IS NOT NULL AND JSON_VALID(p.bounds_json)=1 AND JSON_LENGTH(JSON_EXTRACT(p.bounds_json,'$.values'))=8 THEN 1 ELSE 0 END bounds_valid,
                 CAST(JSON_UNQUOTE(JSON_EXTRACT(p.bounds_json,'$.values[0]')) AS DECIMAL(18,6)) x1,
                 CAST(JSON_UNQUOTE(JSON_EXTRACT(p.bounds_json,'$.values[1]')) AS DECIMAL(18,6)) y1,
                 CAST(JSON_UNQUOTE(JSON_EXTRACT(p.bounds_json,'$.values[2]')) AS DECIMAL(18,6)) z1,
                 CAST(JSON_UNQUOTE(JSON_EXTRACT(p.bounds_json,'$.values[3]')) AS DECIMAL(18,6)) x2,
                 CAST(JSON_UNQUOTE(JSON_EXTRACT(p.bounds_json,'$.values[4]')) AS DECIMAL(18,6)) y2,
                 CAST(JSON_UNQUOTE(JSON_EXTRACT(p.bounds_json,'$.values[5]')) AS DECIMAL(18,6)) x3,
                 CAST(JSON_UNQUOTE(JSON_EXTRACT(p.bounds_json,'$.values[6]')) AS DECIMAL(18,6)) y3,
                 CAST(JSON_UNQUOTE(JSON_EXTRACT(p.bounds_json,'$.values[7]')) AS DECIMAL(18,6)) z2
          FROM offline_garage_canonical_plan p
          WHERE p.resolver_session_id=v_resolver_session
        ) r
      ) v
    ) g
    ORDER BY FIELD(g.safety_class,'baseline_savehouse_candidate','story_asset_deferred','service_reference','world_reference'),g.garage_name,g.garage_plan_id;

    UPDATE offline_garage_geometry_plan
    SET row_checksum=SHA2(CONCAT_WS('|',garage_plan_id,source_queue_id,garage_key,garage_name,runtime_class,safety_class,
        point1_x,point1_y,floor_z,point2_x,point2_y,point3_x,point3_y,ceiling_z,
        front_width,depth_length,height_clearance,depth_unit_x,depth_unit_y,
        front_mid_x,front_mid_y,front_mid_z,interaction_x,interaction_y,interaction_z,
        vehicle_entry_x,vehicle_entry_y,vehicle_entry_z,vehicle_entry_a,
        vehicle_spawn_x,vehicle_spawn_y,vehicle_spawn_z,vehicle_spawn_a,checkpoint_radius,
        geometry_status,review_reason,enabled,apply_status),256)
    WHERE geometry_session_id=v_session;

    SELECT COUNT(*) INTO v_total FROM offline_garage_geometry_plan WHERE geometry_session_id=v_session;
    SELECT COUNT(*) INTO v_baseline FROM offline_garage_geometry_plan WHERE geometry_session_id=v_session AND safety_class='baseline_savehouse_candidate';
    SELECT COUNT(*) INTO v_baseline_ready FROM offline_garage_geometry_plan WHERE geometry_session_id=v_session AND safety_class='baseline_savehouse_candidate' AND geometry_status='baseline_ready';
    SELECT COUNT(*) INTO v_story FROM offline_garage_geometry_plan WHERE geometry_session_id=v_session AND geometry_status='deferred_story';
    SELECT COUNT(*) INTO v_service FROM offline_garage_geometry_plan WHERE geometry_session_id=v_session AND geometry_status='reference_service';
    SELECT COUNT(*) INTO v_world FROM offline_garage_geometry_plan WHERE geometry_session_id=v_session AND geometry_status='reference_world';
    SELECT COUNT(*) INTO v_invalid_bounds FROM offline_garage_geometry_plan WHERE geometry_session_id=v_session AND geometry_status='invalid_bounds';
    SELECT COUNT(*) INTO v_invalid_dimensions FROM offline_garage_geometry_plan WHERE geometry_session_id=v_session AND geometry_status='invalid_dimensions';
    SELECT COUNT(*) INTO v_invalid_spawn FROM offline_garage_geometry_plan WHERE geometry_session_id=v_session AND geometry_status='invalid_spawn';
    SELECT COUNT(*) INTO v_enabled FROM offline_garage_geometry_plan WHERE geometry_session_id=v_session AND enabled<>0;
    SELECT COUNT(*) INTO v_nondraft FROM offline_garage_geometry_plan WHERE geometry_session_id=v_session AND apply_status<>'draft';

    UPDATE offline_garage_geometry_sessions
    SET total_rows=v_total,
        baseline_rows=v_baseline,
        baseline_ready_rows=v_baseline_ready,
        story_rows=v_story,
        service_rows=v_service,
        world_reference_rows=v_world,
        invalid_bounds=v_invalid_bounds,
        invalid_dimensions=v_invalid_dimensions,
        invalid_spawn=v_invalid_spawn,
        status=CASE WHEN v_total=52 AND v_baseline=12 AND v_baseline_ready=12
                         AND v_invalid_bounds=0 AND v_invalid_dimensions=0 AND v_invalid_spawn=0
                         AND v_enabled=0 AND v_nondraft=0
                    THEN 'complete' ELSE 'geometry_review' END,
        completed_at=CURRENT_TIMESTAMP,
        notes=CONCAT('Total=',v_total,'; baseline=',v_baseline,'; baseline ready=',v_baseline_ready,
                     '; story=',v_story,'; service=',v_service,'; world=',v_world,
                     '; invalid bounds=',v_invalid_bounds,'; invalid dimensions=',v_invalid_dimensions,
                     '; invalid spawn=',v_invalid_spawn,'. Runtime mutation: none.')
    WHERE id=v_session;

    COMMIT;

    SELECT * FROM offline_garage_geometry_sessions WHERE id=v_session;
    SELECT 'SAFETY_GATE' section,v_enabled enabled_should_be_zero,v_nondraft nondraft_should_be_zero,
           'No garage_catalog/house_garage_links/vehicle/door/checkpoint/ownership mutation.' safety_contract;
END//
DELIMITER ;
CALL saif_plan_gtasa_garage_geometry_v026A128();
DROP PROCEDURE IF EXISTS saif_plan_gtasa_garage_geometry_v026A128;
