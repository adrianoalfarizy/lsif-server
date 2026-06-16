-- SAIF / LSIF v0.26A.1.31.5
-- Tracked rollback of latest complete global parking seed.
-- Required: SET @saif_confirm='ROLLBACK_GLOBAL_NEAREST_PARKING_SPAWN';
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_rollback_global_parking_v026A1315;
DELIMITER //
CREATE PROCEDURE saif_rollback_global_parking_v026A1315()
BEGIN
    DECLARE v_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_archive_rows INT UNSIGNED DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF COALESCE(@saif_confirm,'') <> 'ROLLBACK_GLOBAL_NEAREST_PARKING_SPAWN' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token missing: ROLLBACK_GLOBAL_NEAREST_PARKING_SPAWN';
    END IF;

    SELECT MAX(id) INTO v_session_id
    FROM vehicle_spawn_point_seed_sessions
    WHERE seed_version='v0.26A.1.31.5' AND status='complete';

    IF v_session_id IS NULL OR v_session_id=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No complete v0.26A.1.31.5 seed session available';
    END IF;

    START TRANSACTION;

    DELETE FROM vehicle_spawn_points
    WHERE source_tag='saif_global_parking_v0.26A.1.31.5';

    INSERT INTO vehicle_spawn_points
    (id,point_key,point_name,source_type,source_reference_id,pos_x,pos_y,pos_z,pos_a,
     interior_id,virtual_world,clear_radius,priority,enabled,source_tag)
    SELECT original_id,point_key,point_name,source_type,source_reference_id,pos_x,pos_y,pos_z,pos_a,
           interior_id,virtual_world,clear_radius,priority,enabled,source_tag
    FROM vehicle_spawn_point_seed_archive_rows
    WHERE seed_session_id=v_session_id
    ON DUPLICATE KEY UPDATE
      point_key=VALUES(point_key),point_name=VALUES(point_name),source_type=VALUES(source_type),
      source_reference_id=VALUES(source_reference_id),pos_x=VALUES(pos_x),pos_y=VALUES(pos_y),
      pos_z=VALUES(pos_z),pos_a=VALUES(pos_a),interior_id=VALUES(interior_id),
      virtual_world=VALUES(virtual_world),clear_radius=VALUES(clear_radius),priority=VALUES(priority),
      enabled=VALUES(enabled),source_tag=VALUES(source_tag);

    SELECT COUNT(*) INTO v_archive_rows
    FROM vehicle_spawn_point_seed_archive_rows
    WHERE seed_session_id=v_session_id;

    UPDATE vehicle_spawn_point_seed_sessions
    SET status='rolled_back',rolled_back_at=NOW()
    WHERE id=v_session_id;

    COMMIT;

    SELECT 'ROLLBACK_GATE' section,v_session_id seed_session_id,
           v_archive_rows restored_archive_rows,
           (SELECT COUNT(*) FROM vehicle_spawn_points WHERE source_tag='saif_global_parking_v0.26A.1.31.5') generated_rows_should_be_zero,
           (SELECT status FROM vehicle_spawn_point_seed_sessions WHERE id=v_session_id) status_expected_rolled_back;
END//
DELIMITER ;
CALL saif_rollback_global_parking_v026A1315();
DROP PROCEDURE IF EXISTS saif_rollback_global_parking_v026A1315;
