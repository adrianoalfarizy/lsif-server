-- SAIF / LSIF Dev v0.26A.1.14
-- Roll back latest live Full-130 parked vehicle apply.
-- Imported rows are disabled; previous active rows are restored. No DELETE.
-- REQUIRED: SET @saif_confirm='ROLLBACK_LATEST_130_OFFLINE_PARKED_VEHICLES';
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_rollback_full_parked_vehicles_v026A114;
DELIMITER //
CREATE PROCEDURE saif_rollback_full_parked_vehicles_v026A114()
main: BEGIN
    DECLARE v_confirm VARBINARY(96) DEFAULT X'';
    DECLARE v_apply_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_source_tag VARCHAR(96) DEFAULT '';
    DECLARE v_inserted_expected INT DEFAULT 0;
    DECLARE v_disabled_expected INT DEFAULT 0;
    DECLARE v_inserted_present INT DEFAULT 0;
    DECLARE v_disabled_present INT DEFAULT 0;
    DECLARE v_runtime_active_after INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET v_confirm=BINARY COALESCE(@saif_confirm,'');
    IF v_confirm<>_binary'ROLLBACK_LATEST_130_OFFLINE_PARKED_VEHICLES' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token missing. Required: ROLLBACK_LATEST_130_OFFLINE_PARKED_VEHICLES';
    END IF;

    SELECT COALESCE(MAX(id),0) INTO v_apply_session_id
    FROM offline_runtime_apply_sessions
    WHERE apply_scope='parked_vehicles_offline_130'
      AND apply_status='complete' AND rolled_back_at IS NULL;
    IF v_apply_session_id=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No live completed Full-130 parked vehicle apply found.';
    END IF;

    SELECT source_tag,new_rows_inserted,old_rows_disabled
      INTO v_source_tag,v_inserted_expected,v_disabled_expected
    FROM offline_runtime_apply_sessions WHERE id=v_apply_session_id;

    SELECT COUNT(*) INTO v_inserted_present
    FROM offline_parked_vehicle_apply_rows r
    INNER JOIN parked_vehicles p ON p.id=r.parked_vehicle_id
    WHERE r.apply_session_id=v_apply_session_id;
    SELECT COUNT(*) INTO v_disabled_present
    FROM offline_parked_vehicle_disabled_rows d
    INNER JOIN parked_vehicles p ON p.id=d.parked_vehicle_id
    WHERE d.apply_session_id=v_apply_session_id;

    IF v_inserted_present<>v_inserted_expected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Inserted parked vehicle mapping mismatch. Rollback aborted for safety.';
    END IF;
    IF v_disabled_present<>v_disabled_expected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Previously disabled parked vehicle mapping mismatch. Rollback aborted for safety.';
    END IF;

    START TRANSACTION;

    UPDATE parked_vehicles p
    INNER JOIN offline_parked_vehicle_apply_rows r
      ON r.parked_vehicle_id=p.id AND r.apply_session_id=v_apply_session_id
    SET p.enabled=0;

    UPDATE parked_vehicles p
    INNER JOIN offline_parked_vehicle_disabled_rows d
      ON d.parked_vehicle_id=p.id AND d.apply_session_id=v_apply_session_id
    SET p.enabled=d.previous_enabled;

    UPDATE offline_vehicle_apply_plan p
    INNER JOIN offline_parked_vehicle_apply_rows r
      ON r.plan_id=p.id AND r.apply_session_id=v_apply_session_id
    SET p.apply_status='draft';

    UPDATE offline_vehicle_queue q
    INNER JOIN offline_parked_vehicle_apply_rows r
      ON r.queue_id=q.id AND r.apply_session_id=v_apply_session_id
    SET q.apply_status='pending';

    UPDATE offline_vehicle_apply_batches
    SET apply_status='draft'
    WHERE session_id=(SELECT import_session_id FROM offline_runtime_apply_sessions WHERE id=v_apply_session_id)
      AND planner_version='saif-vehicle-canonical-planner-v0.26A.1.12'
      AND batch_key IN ('baseline_ready','progression_optional');

    SELECT COALESCE(SUM(enabled=1),0) INTO v_runtime_active_after FROM parked_vehicles;

    UPDATE offline_runtime_apply_sessions
    SET apply_status='rolled_back',runtime_active_after=v_runtime_active_after,
        rolled_back_at=CURRENT_TIMESTAMP,
        notes=CONCAT(notes,' Rollback complete: 130 imported rows disabled; previous active parked vehicles restored.')
    WHERE id=v_apply_session_id;

    COMMIT;

    SELECT v_apply_session_id AS rolled_back_apply_session_id,v_source_tag AS disabled_import_source_tag,
           v_inserted_expected AS imported_rows_disabled,v_disabled_expected AS previous_rows_restored,
           v_runtime_active_after AS runtime_active_after,'ROLLED_BACK' AS rollback_status;
END//
DELIMITER ;

CALL saif_rollback_full_parked_vehicles_v026A114();
DROP PROCEDURE IF EXISTS saif_rollback_full_parked_vehicles_v026A114;
