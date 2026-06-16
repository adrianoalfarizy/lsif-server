-- SAIF / LSIF v0.26A.1.31.5
-- Verify global nearest parking spawn catalog.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @seed_tag='saif_global_parking_v0.26A.1.31.5';
SET @latest_session=(SELECT MAX(id) FROM vehicle_spawn_point_seed_sessions WHERE seed_version='v0.26A.1.31.5' AND status='complete');

SELECT 'SESSION_GATE' section,id seed_session_id,status,archive_rows,generated_rows,enabled_rows,
       parked_origin_rows,parked_left_rows,parked_right_rows,garage_rows,
       mission_default_rows,mission_pool_rows,admin_rows_preserved,
       (status='complete' AND enabled_rows BETWEEN 1 AND 1024) ready_should_be_1
FROM vehicle_spawn_point_seed_sessions
WHERE id=@latest_session;

SELECT 'CATALOG_GATE' section,
       COUNT(*) enabled_rows_should_be_1_to_1024,
       COUNT(DISTINCT point_key) unique_keys_should_equal_total,
       SUM(pos_x=0 OR pos_y=0 OR pos_z=0) zero_transform_should_be_zero,
       SUM(clear_radius<2.5 OR clear_radius>10.0) invalid_radius_should_be_zero,
       SUM(priority<0 OR priority>1000) invalid_priority_should_be_zero,
       (COUNT(*) BETWEEN 1 AND 1024
        AND COUNT(DISTINCT point_key)=COUNT(*)
        AND SUM(pos_x=0 OR pos_y=0 OR pos_z=0)=0
        AND SUM(clear_radius<2.5 OR clear_radius>10.0)=0
        AND SUM(priority<0 OR priority>1000)=0) ready_should_be_1
FROM vehicle_spawn_points
WHERE enabled=1;

SELECT 'PARKED_COVERAGE_GATE' section,
       (SELECT COUNT(*) FROM parked_vehicles WHERE enabled=1 AND pos_x<>0 AND pos_y<>0 AND pos_z<>0) parked_sources,
       SUM(source_type='parked_vehicle_origin') origin_rows,
       SUM(source_type='parked_vehicle_left') left_rows,
       SUM(source_type='parked_vehicle_right') right_rows,
       ((SELECT COUNT(*) FROM parked_vehicles WHERE enabled=1 AND pos_x<>0 AND pos_y<>0 AND pos_z<>0)=SUM(source_type='parked_vehicle_origin')
        AND (SELECT COUNT(*) FROM parked_vehicles WHERE enabled=1 AND pos_x<>0 AND pos_y<>0 AND pos_z<>0)=SUM(source_type='parked_vehicle_left')
        AND (SELECT COUNT(*) FROM parked_vehicles WHERE enabled=1 AND pos_x<>0 AND pos_y<>0 AND pos_z<>0)=SUM(source_type='parked_vehicle_right')) ready_should_be_1
FROM vehicle_spawn_points
WHERE enabled=1;

SELECT 'SOURCE_GATE' section,
       SUM(source_type='garage_storage_slot') garage_rows,
       SUM(source_type='parked_vehicle_origin') parked_origin_rows,
       SUM(source_type='parked_vehicle_left') parked_left_rows,
       SUM(source_type='parked_vehicle_right') parked_right_rows,
       SUM(source_type='mission_default') mission_default_rows,
       SUM(source_type='mission_pool') mission_pool_rows,
       SUM(source_type='admin_custom') admin_custom_rows,
       SUM(source_type NOT IN ('garage_storage_slot','parked_vehicle_origin','parked_vehicle_left','parked_vehicle_right','mission_default','mission_pool','admin_custom')) other_rows_informational
FROM vehicle_spawn_points
WHERE enabled=1;

SELECT 'POLICY_GATE' section,enabled,house_storage_enabled,nearest_spawn_enabled,despawn_enabled,
       (enabled=1 AND house_storage_enabled=1 AND nearest_spawn_enabled=1 AND despawn_enabled=1) ready_should_be_1
FROM vehicle_storage_policy
WHERE id=1;

SELECT 'ARCHIVE_GATE' section,
       (SELECT COUNT(*) FROM vehicle_spawn_point_seed_archive_rows WHERE seed_session_id=@latest_session) archived_rows,
       (SELECT archive_rows FROM vehicle_spawn_point_seed_sessions WHERE id=@latest_session) expected_archive_rows,
       ((SELECT COUNT(*) FROM vehicle_spawn_point_seed_archive_rows WHERE seed_session_id=@latest_session)=
        (SELECT archive_rows FROM vehicle_spawn_point_seed_sessions WHERE id=@latest_session)) ready_should_be_1;

SELECT 'FINAL_GATE' section,
       ((SELECT COUNT(*) FROM vehicle_spawn_point_seed_sessions WHERE id=@latest_session AND status='complete')=1
        AND (SELECT COUNT(*) FROM vehicle_spawn_points WHERE enabled=1) BETWEEN 1 AND 1024
        AND (SELECT COUNT(*) FROM vehicle_spawn_points WHERE enabled=1 AND (pos_x=0 OR pos_y=0 OR pos_z=0))=0
        AND (SELECT COUNT(*) FROM vehicle_storage_policy WHERE id=1 AND enabled=1 AND nearest_spawn_enabled=1)=1) ready_should_be_1;
