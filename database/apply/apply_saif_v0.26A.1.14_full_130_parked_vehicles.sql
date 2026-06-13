-- SAIF / LSIF Dev v0.26A.1.14
-- APPLY exactly 130 GTA SA canonical parked vehicles.
-- Includes 68 baseline startup-ON + 62 progression-optional exact locations.
-- REQUIRED: SET @saif_confirm='APPLY_130_OFFLINE_PARKED_VEHICLES';

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_apply_full_parked_vehicles_v026A114;
DELIMITER //
CREATE PROCEDURE saif_apply_full_parked_vehicles_v026A114()
main: BEGIN
    DECLARE v_done INT DEFAULT 0;
    DECLARE v_confirm VARBINARY(96) DEFAULT X'';
    DECLARE v_archive_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_import_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_apply_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_runtime_total_before INT DEFAULT 0;
    DECLARE v_runtime_active_before INT DEFAULT 0;
    DECLARE v_runtime_active_after INT DEFAULT 0;
    DECLARE v_archive_meta_total INT DEFAULT 0;
    DECLARE v_archive_rows INT DEFAULT 0;
    DECLARE v_checksum_mismatch INT DEFAULT 0;
    DECLARE v_live_apply_count INT DEFAULT 0;
    DECLARE v_orphan_import_count INT DEFAULT 0;
    DECLARE v_total_plan_count INT DEFAULT 0;
    DECLARE v_baseline_plan_count INT DEFAULT 0;
    DECLARE v_progression_plan_count INT DEFAULT 0;
    DECLARE v_deferred_plan_count INT DEFAULT 0;
    DECLARE v_invalid_selected_count INT DEFAULT 0;
    DECLARE v_disabled_count INT DEFAULT 0;
    DECLARE v_inserted_count INT DEFAULT 0;
    DECLARE v_baseline_inserted INT DEFAULT 0;
    DECLARE v_progression_inserted INT DEFAULT 0;
    DECLARE v_parked_vehicle_id INT DEFAULT 0;
    DECLARE v_apply_key VARCHAR(96) DEFAULT '';
    DECLARE v_source_tag VARCHAR(96) DEFAULT '';

    DECLARE v_plan_id BIGINT UNSIGNED;
    DECLARE v_queue_id BIGINT UNSIGNED;
    DECLARE v_decision_code VARCHAR(48);
    DECLARE v_generator_name VARCHAR(128);
    DECLARE v_modelid INT;
    DECLARE v_color1 INT;
    DECLARE v_color2 INT;
    DECLARE v_pos_x DOUBLE;
    DECLARE v_pos_y DOUBLE;
    DECLARE v_pos_z DOUBLE;
    DECLARE v_pos_a DOUBLE;
    DECLARE v_respawn_delay INT;
    DECLARE v_locked TINYINT;

    DECLARE cur_selected CURSOR FOR
        SELECT p.id,p.queue_id,p.decision_code,q.generator_name,
               p.runtime_modelid,p.runtime_color1,p.runtime_color2,
               q.pos_x,q.pos_y,q.pos_z,q.pos_a,
               p.runtime_respawn_delay,p.runtime_locked
        FROM offline_vehicle_apply_plan p
        INNER JOIN offline_vehicle_queue q ON q.id=p.queue_id
        WHERE p.session_id=v_import_session_id
          AND p.planner_version='saif-vehicle-canonical-planner-v0.26A.1.12'
          AND p.apply_status='draft'
          AND p.decision_code IN ('baseline_ready','progression_optional')
        ORDER BY p.decision_code,q.city_region,q.area_code,p.id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done=1;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET v_confirm=BINARY COALESCE(@saif_confirm,'');
    IF v_confirm<>_binary'APPLY_130_OFFLINE_PARKED_VEHICLES' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token missing. Required: APPLY_130_OFFLINE_PARKED_VEHICLES';
    END IF;

    SELECT COALESCE(MAX(id),0) INTO v_archive_session_id
    FROM offline_runtime_archive_sessions
    WHERE archive_scope='parked_vehicles' AND archive_status='complete';
    IF v_archive_session_id=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No complete parked_vehicles archive found. Capture a fresh archive first.';
    END IF;

    SELECT COALESCE(MAX(session_id),0) INTO v_import_session_id
    FROM offline_vehicle_apply_plan
    WHERE planner_version='saif-vehicle-canonical-planner-v0.26A.1.12';
    IF v_import_session_id=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Parked vehicle canonical planner session not found.';
    END IF;

    SELECT COUNT(*) INTO v_live_apply_count
    FROM offline_runtime_apply_sessions
    WHERE apply_scope='parked_vehicles_offline_130'
      AND apply_status='complete' AND rolled_back_at IS NULL;
    IF v_live_apply_count>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='A completed Full-130 parked vehicle apply is already live. Roll it back before applying again.';
    END IF;

    SELECT COUNT(*) INTO v_orphan_import_count
    FROM parked_vehicles
    WHERE enabled=1 AND source_tag LIKE 'offline_gtasa_parkveh130_a%';
    IF v_orphan_import_count>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Active Full-130 source-tag rows exist without a live tracked apply. Resolve them before applying.';
    END IF;

    SELECT COUNT(*),COALESCE(SUM(enabled=1),0)
      INTO v_runtime_total_before,v_runtime_active_before
    FROM parked_vehicles;

    SELECT runtime_rows_total,archived_rows
      INTO v_archive_meta_total,v_archive_rows
    FROM offline_runtime_archive_sessions
    WHERE id=v_archive_session_id;
    IF v_archive_meta_total<>v_runtime_total_before OR v_archive_rows<>v_runtime_total_before THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Archive row count no longer matches runtime. Capture a fresh archive before apply.';
    END IF;

    SELECT COUNT(*) INTO v_checksum_mismatch
    FROM offline_parked_vehicles_archive a
    LEFT JOIN parked_vehicles p ON p.id=a.original_id
    WHERE a.archive_session_id=v_archive_session_id
      AND (p.id IS NULL OR BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',
          p.id,COALESCE(p.modelid,400),COALESCE(p.color1,-1),COALESCE(p.color2,-1),
          COALESCE(p.pos_x,0),COALESCE(p.pos_y,0),COALESCE(p.pos_z,0),COALESCE(p.pos_a,0),
          COALESCE(p.interior,0),COALESCE(p.virtual_world,0),COALESCE(p.respawn_delay,300),
          COALESCE(p.locked,0),COALESCE(p.source_tag,''),COALESCE(p.enabled,0)
      ),256));
    IF v_checksum_mismatch<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Runtime parked_vehicles changed after archive capture. Capture a fresh archive before apply.';
    END IF;

    SELECT COUNT(*),
           SUM(decision_code='baseline_ready' AND apply_status='draft'),
           SUM(decision_code='progression_optional' AND apply_status='draft'),
           SUM(decision_code NOT IN ('baseline_ready','progression_optional'))
      INTO v_total_plan_count,v_baseline_plan_count,v_progression_plan_count,v_deferred_plan_count
    FROM offline_vehicle_apply_plan
    WHERE session_id=v_import_session_id
      AND planner_version='saif-vehicle-canonical-planner-v0.26A.1.12';

    IF v_total_plan_count<>211 OR v_baseline_plan_count<>68 OR v_progression_plan_count<>62 OR v_deferred_plan_count<>81 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Planner gate mismatch. Expected total=211, baseline=68, progression=62, deferred=81.';
    END IF;

    SELECT COUNT(*) INTO v_invalid_selected_count
    FROM offline_vehicle_apply_plan p
    INNER JOIN offline_vehicle_queue q ON q.id=p.queue_id
    WHERE p.session_id=v_import_session_id
      AND p.planner_version='saif-vehicle-canonical-planner-v0.26A.1.12'
      AND p.decision_code IN ('baseline_ready','progression_optional')
      AND (p.runtime_modelid<400 OR p.runtime_modelid>611
           OR (ABS(q.pos_x)<0.001 AND ABS(q.pos_y)<0.001 AND ABS(q.pos_z)<0.001)
           OR p.requires_model_resolution<>0 OR p.requires_state_bridge<>0
           OR p.duplicate_of_queue_id IS NOT NULL);
    IF v_invalid_selected_count<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Selected parked vehicle plan contains invalid/unresolved rows.';
    END IF;

    IF 130>256 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Projected active parked vehicles exceed compiled capacity 256.';
    END IF;

    START TRANSACTION;

    SET v_apply_key=CONCAT('parkveh_offline130_',DATE_FORMAT(NOW(6),'%Y%m%d%H%i%s%f'));
    INSERT INTO offline_runtime_apply_sessions
    (
        apply_key,apply_scope,apply_label,archive_session_id,import_session_id,
        plan_version,resolver_version,source_tag,apply_status,
        runtime_active_before,blocked_rows_skipped,deferred_rows_skipped,notes
    )
    VALUES
    (
        v_apply_key,'parked_vehicles_offline_130','GTA SA parked vehicles: 68 baseline + 62 progression',
        v_archive_session_id,v_import_session_id,
        'saif-vehicle-canonical-planner-v0.26A.1.12','saif-vehicle-parser-v0.26A.1.11','',
        'applying',v_runtime_active_before,13,v_deferred_plan_count,
        'Full canonical replacement: disable every active previous parked vehicle and insert exactly 130 GTA SA SCM locations.'
    );

    SET v_apply_session_id=LAST_INSERT_ID();
    SET v_source_tag=CONCAT('offline_gtasa_parkveh130_a',v_apply_session_id);
    UPDATE offline_runtime_apply_sessions SET source_tag=v_source_tag WHERE id=v_apply_session_id;

    INSERT INTO offline_parked_vehicle_disabled_rows
    (apply_session_id,parked_vehicle_id,previous_enabled,previous_source_tag,row_checksum)
    SELECT v_apply_session_id,p.id,p.enabled,COALESCE(p.source_tag,''),
           SHA2(CONCAT_WS('|',p.id,COALESCE(p.modelid,400),COALESCE(p.color1,-1),COALESCE(p.color2,-1),
               COALESCE(p.pos_x,0),COALESCE(p.pos_y,0),COALESCE(p.pos_z,0),COALESCE(p.pos_a,0),
               COALESCE(p.interior,0),COALESCE(p.virtual_world,0),COALESCE(p.respawn_delay,300),
               COALESCE(p.locked,0),COALESCE(p.source_tag,''),COALESCE(p.enabled,0)),256)
    FROM parked_vehicles p
    WHERE p.enabled=1;
    SET v_disabled_count=ROW_COUNT();

    UPDATE parked_vehicles p
    INNER JOIN offline_parked_vehicle_disabled_rows d
      ON d.parked_vehicle_id=p.id AND d.apply_session_id=v_apply_session_id
    SET p.enabled=0;

    SET v_done=0;
    OPEN cur_selected;
    selected_loop: LOOP
        FETCH cur_selected INTO v_plan_id,v_queue_id,v_decision_code,v_generator_name,
            v_modelid,v_color1,v_color2,v_pos_x,v_pos_y,v_pos_z,v_pos_a,v_respawn_delay,v_locked;
        IF v_done=1 THEN LEAVE selected_loop; END IF;

        INSERT INTO parked_vehicles
        (modelid,color1,color2,pos_x,pos_y,pos_z,pos_a,interior,virtual_world,respawn_delay,locked,source_tag,enabled)
        VALUES
        (v_modelid,v_color1,v_color2,v_pos_x,v_pos_y,v_pos_z,v_pos_a,0,0,v_respawn_delay,v_locked,v_source_tag,1);
        SET v_parked_vehicle_id=LAST_INSERT_ID();

        INSERT INTO offline_parked_vehicle_apply_rows
        (apply_session_id,plan_id,queue_id,parked_vehicle_id,decision_code,generator_name,modelid,source_tag,row_checksum)
        VALUES
        (v_apply_session_id,v_plan_id,v_queue_id,v_parked_vehicle_id,v_decision_code,v_generator_name,v_modelid,v_source_tag,
         SHA2(CONCAT_WS('|',v_parked_vehicle_id,v_plan_id,v_queue_id,v_decision_code,v_generator_name,v_modelid,v_source_tag),256));

        SET v_inserted_count=v_inserted_count+1;
        IF v_decision_code='baseline_ready' THEN
            SET v_baseline_inserted=v_baseline_inserted+1;
        ELSEIF v_decision_code='progression_optional' THEN
            SET v_progression_inserted=v_progression_inserted+1;
        END IF;
    END LOOP;
    CLOSE cur_selected;

    IF v_inserted_count<>130 OR v_baseline_inserted<>68 OR v_progression_inserted<>62 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Inserted parked vehicle count mismatch; transaction rolled back.';
    END IF;

    UPDATE offline_vehicle_apply_plan p
    INNER JOIN offline_parked_vehicle_apply_rows r
      ON r.plan_id=p.id AND r.apply_session_id=v_apply_session_id
    SET p.apply_status='applied';

    UPDATE offline_vehicle_queue q
    INNER JOIN offline_parked_vehicle_apply_rows r
      ON r.queue_id=q.id AND r.apply_session_id=v_apply_session_id
    SET q.apply_status='applied';

    UPDATE offline_vehicle_apply_batches
    SET apply_status='applied'
    WHERE session_id=v_import_session_id
      AND planner_version='saif-vehicle-canonical-planner-v0.26A.1.12'
      AND batch_key IN ('baseline_ready','progression_optional');

    SELECT COALESCE(SUM(enabled=1),0) INTO v_runtime_active_after FROM parked_vehicles;
    IF v_runtime_active_after<>130 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Runtime active parked vehicle count differs from expected 130; transaction rolled back.';
    END IF;

    UPDATE offline_runtime_apply_sessions
    SET apply_status='complete',old_rows_disabled=v_disabled_count,new_rows_inserted=v_inserted_count,
        baseline_rows_inserted=v_baseline_inserted,progression_rows_inserted=v_progression_inserted,
        exact_rows_inserted=v_inserted_count,runtime_active_after=v_runtime_active_after,
        completed_at=CURRENT_TIMESTAMP,
        notes=CONCAT('Complete. Disabled ',v_disabled_count,' previous active rows; inserted 68 baseline + 62 progression parked vehicles.')
    WHERE id=v_apply_session_id;

    COMMIT;

    SELECT v_apply_session_id AS apply_session_id,v_archive_session_id AS archive_session_id,
           v_source_tag AS source_tag,v_runtime_active_before AS runtime_active_before,
           v_disabled_count AS old_rows_disabled,v_baseline_inserted AS baseline_rows_inserted,
           v_progression_inserted AS progression_rows_inserted,v_inserted_count AS total_rows_inserted,
           v_runtime_active_after AS runtime_active_after,'COMPLETE' AS apply_status;

    SELECT r.decision_code,COUNT(*) AS inserted_rows
    FROM offline_parked_vehicle_apply_rows r
    WHERE r.apply_session_id=v_apply_session_id
    GROUP BY r.decision_code;
END//
DELIMITER ;

CALL saif_apply_full_parked_vehicles_v026A114();
DROP PROCEDURE IF EXISTS saif_apply_full_parked_vehicles_v026A114;
