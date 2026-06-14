-- SAIF / LSIF Dev v0.26A.1.28
-- Verify deterministic garage interaction/entry/spawn geometry planner.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @planner_version := 'saif-garage-geometry-planner-v0.26A.1.28';
SET @geometry_session_id := (
    SELECT id FROM offline_garage_geometry_sessions
    WHERE BINARY planner_version=BINARY @planner_version
    ORDER BY id DESC LIMIT 1
);

SELECT 'SESSION_GATE' section,id,status,total_rows,baseline_rows,baseline_ready_rows,story_rows,service_rows,world_reference_rows,
       invalid_bounds,invalid_dimensions,invalid_spawn,
       (status='complete' AND total_rows=52 AND baseline_rows=12 AND baseline_ready_rows=12
        AND invalid_bounds=0 AND invalid_dimensions=0 AND invalid_spawn=0) ready_should_be_1
FROM offline_garage_geometry_sessions WHERE id=@geometry_session_id;

SELECT 'PLAN_GATE' section,
       COUNT(*) total_expected_52,
       COUNT(DISTINCT garage_plan_id) unique_garage_plans_expected_52,
       COUNT(DISTINCT source_queue_id) unique_source_rows_expected_52,
       SUM(safety_class='baseline_savehouse_candidate') baseline_expected_12,
       SUM(safety_class='baseline_savehouse_candidate' AND geometry_status='baseline_ready') baseline_ready_expected_12,
       SUM(enabled<>0) enabled_should_be_zero,
       SUM(apply_status<>'draft') nondraft_should_be_zero,
       SUM(geometry_status='invalid_bounds') invalid_bounds_should_be_zero,
       SUM(geometry_status='invalid_dimensions') invalid_dimensions_should_be_zero,
       SUM(geometry_status='invalid_spawn') invalid_spawn_should_be_zero
FROM offline_garage_geometry_plan WHERE geometry_session_id=@geometry_session_id;

SELECT 'DIMENSION_GATE' section,
       SUM(front_width<=0 OR depth_length<=0 OR height_clearance<=0) nonpositive_dimensions_should_be_zero,
       SUM(safety_class='baseline_savehouse_candidate' AND front_width<3.50) baseline_narrow_should_be_zero,
       SUM(safety_class='baseline_savehouse_candidate' AND depth_length<4.50) baseline_short_should_be_zero,
       SUM(safety_class='baseline_savehouse_candidate' AND height_clearance<2.20) baseline_low_should_be_zero,
       ROUND(MIN(CASE WHEN safety_class='baseline_savehouse_candidate' THEN front_width END),3) baseline_min_width,
       ROUND(MIN(CASE WHEN safety_class='baseline_savehouse_candidate' THEN depth_length END),3) baseline_min_depth,
       ROUND(MIN(CASE WHEN safety_class='baseline_savehouse_candidate' THEN height_clearance END),3) baseline_min_height
FROM offline_garage_geometry_plan WHERE geometry_session_id=@geometry_session_id;

SELECT 'TRANSFORM_GATE' section,
       SUM(ABS(SQRT(POW(depth_unit_x,2)+POW(depth_unit_y,2))-1.0)>0.001) nonunit_depth_vector_should_be_zero,
       SUM(vehicle_spawn_x=0 AND vehicle_spawn_y=0 AND vehicle_spawn_z=0) zero_spawn_should_be_zero,
       SUM(interaction_x=0 AND interaction_y=0 AND interaction_z=0) zero_interaction_should_be_zero,
       SUM(vehicle_entry_a<0 OR vehicle_entry_a>=360 OR vehicle_spawn_a<0 OR vehicle_spawn_a>=360) invalid_heading_should_be_zero,
       SUM(ABS(MOD((vehicle_spawn_a-vehicle_entry_a)+360.0,360.0)-180.0)>0.01) heading_delta_should_be_zero,
       SUM(((vehicle_spawn_x-front_mid_x)*depth_unit_x+(vehicle_spawn_y-front_mid_y)*depth_unit_y)<=0) spawn_not_inside_should_be_zero,
       SUM(((vehicle_spawn_x-front_mid_x)*depth_unit_x+(vehicle_spawn_y-front_mid_y)*depth_unit_y)>=depth_length) spawn_beyond_depth_should_be_zero,
       SUM(((vehicle_entry_x-front_mid_x)*depth_unit_x+(vehicle_entry_y-front_mid_y)*depth_unit_y)>=0) entry_not_outside_should_be_zero,
       SUM(((interaction_x-front_mid_x)*depth_unit_x+(interaction_y-front_mid_y)*depth_unit_y)>=0) interaction_not_outside_should_be_zero
FROM offline_garage_geometry_plan WHERE geometry_session_id=@geometry_session_id;

SELECT 'SOURCE_LINKAGE_GATE' section,
       SUM(p.id IS NULL) missing_garage_plan_should_be_zero,
       SUM(g.source_queue_id<>p.source_queue_id) source_queue_mismatch_should_be_zero,
       SUM(BINARY g.garage_key<>BINARY p.garage_key) garage_key_mismatch_should_be_zero,
       SUM(BINARY g.garage_name<>BINARY p.garage_name) garage_name_mismatch_should_be_zero,
       SUM(BINARY g.safety_class<>BINARY p.safety_class) safety_class_mismatch_should_be_zero
FROM offline_garage_geometry_plan g
LEFT JOIN offline_garage_canonical_plan p ON p.id=g.garage_plan_id
WHERE g.geometry_session_id=@geometry_session_id;

SELECT 'BASELINE_HOUSE_GEOMETRY_DETAIL' section,
       l.house_slot canonical_house_slot,
       l.house_display_name house_name,
       g.id geometry_id,
       g.garage_name,
       ROUND(g.front_width,3) front_width,
       ROUND(g.depth_length,3) depth_length,
       ROUND(g.height_clearance,3) height_clearance,
       ROUND(g.interaction_x,4) interaction_x,ROUND(g.interaction_y,4) interaction_y,ROUND(g.interaction_z,4) interaction_z,
       ROUND(g.vehicle_entry_x,4) vehicle_entry_x,ROUND(g.vehicle_entry_y,4) vehicle_entry_y,ROUND(g.vehicle_entry_z,4) vehicle_entry_z,ROUND(g.vehicle_entry_a,3) vehicle_entry_a,
       ROUND(g.vehicle_spawn_x,4) vehicle_spawn_x,ROUND(g.vehicle_spawn_y,4) vehicle_spawn_y,ROUND(g.vehicle_spawn_z,4) vehicle_spawn_z,ROUND(g.vehicle_spawn_a,3) vehicle_spawn_a,
       g.geometry_status
FROM offline_garage_geometry_plan g
JOIN offline_garage_geometry_sessions s ON s.id=g.geometry_session_id
JOIN offline_garage_house_links l ON l.resolver_session_id=s.garage_resolver_session_id AND l.garage_plan_id=g.garage_plan_id
WHERE g.geometry_session_id=@geometry_session_id
  AND l.link_class='baseline_savehouse_candidate'
ORDER BY l.house_slot;

SELECT 'RUNTIME_UNTOUCHED_GATE' section,
       (SELECT COUNT(*) FROM garage_catalog) garage_catalog_rows_should_be_zero,
       (SELECT COUNT(*) FROM house_garage_links) runtime_house_links_should_be_zero,
       (SELECT enabled FROM garage_runtime_policy WHERE id=1) runtime_policy_should_be_zero,
       (SELECT store_enabled FROM garage_runtime_policy WHERE id=1) store_policy_should_be_zero,
       (SELECT retrieve_enabled FROM garage_runtime_policy WHERE id=1) retrieve_policy_should_be_zero,
       (SELECT door_animation_enabled FROM garage_runtime_policy WHERE id=1) door_policy_should_be_zero,
       (SELECT COUNT(*) FROM player_vehicles) player_vehicle_rows_reference,
       (SELECT COUNT(*) FROM player_houses) player_house_rows_reference;

SELECT 'FINAL_GATE' section,
       (
         @geometry_session_id IS NOT NULL
         AND (SELECT status FROM offline_garage_geometry_sessions WHERE id=@geometry_session_id)='complete'
         AND (SELECT COUNT(*) FROM offline_garage_geometry_plan WHERE geometry_session_id=@geometry_session_id)=52
         AND (SELECT COUNT(*) FROM offline_garage_geometry_plan WHERE geometry_session_id=@geometry_session_id AND safety_class='baseline_savehouse_candidate' AND geometry_status='baseline_ready')=12
         AND (SELECT COUNT(*) FROM offline_garage_geometry_plan WHERE geometry_session_id=@geometry_session_id AND geometry_status IN ('invalid_bounds','invalid_dimensions','invalid_spawn'))=0
         AND (SELECT COUNT(*) FROM offline_garage_geometry_plan WHERE geometry_session_id=@geometry_session_id AND (enabled<>0 OR apply_status<>'draft'))=0
         AND (SELECT COUNT(*) FROM garage_catalog)=0
         AND (SELECT COUNT(*) FROM house_garage_links)=0
         AND (SELECT enabled+store_enabled+retrieve_enabled+door_animation_enabled FROM garage_runtime_policy WHERE id=1)=0
       ) ready_for_controlled_12_garage_apply_should_be_1;
