-- SAIF / LSIF Dev v0.26A.1.20
-- Roll back latest live Baseline-89 world pickup apply.
-- Imported rows are disabled; previous active rows are restored. No DELETE.
-- REQUIRED: SET @saif_confirm='ROLLBACK_LATEST_89_OFFLINE_WORLD_PICKUPS';
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_rollback_baseline89_world_pickups_v026A120;
DELIMITER //
CREATE PROCEDURE saif_rollback_baseline89_world_pickups_v026A120()
main: BEGIN
    DECLARE v_confirm VARBINARY(96) DEFAULT X'';
    DECLARE v_apply_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_source_tag VARCHAR(96) DEFAULT '';
    DECLARE v_inserted_expected INT DEFAULT 0;
    DECLARE v_disabled_expected INT DEFAULT 0;
    DECLARE v_runtime_before_expected INT DEFAULT 0;
    DECLARE v_inserted_present INT DEFAULT 0;
    DECLARE v_disabled_present INT DEFAULT 0;
    DECLARE v_inserted_checksum_mismatch INT DEFAULT 0;
    DECLARE v_old_checksum_mismatch INT DEFAULT 0;
    DECLARE v_runtime_active_after INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET v_confirm=BINARY COALESCE(@saif_confirm,'');
    IF v_confirm<>_binary'ROLLBACK_LATEST_89_OFFLINE_WORLD_PICKUPS' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token missing. Required: ROLLBACK_LATEST_89_OFFLINE_WORLD_PICKUPS';
    END IF;

    SELECT COALESCE(MAX(id),0) INTO v_apply_session_id
    FROM offline_runtime_apply_sessions
    WHERE apply_scope='world_pickups_offline_baseline89'
      AND apply_status='complete' AND rolled_back_at IS NULL;
    IF v_apply_session_id=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No live completed Baseline-89 world pickup apply found.';
    END IF;

    SELECT source_tag,new_rows_inserted,old_rows_disabled,runtime_active_before
      INTO v_source_tag,v_inserted_expected,v_disabled_expected,v_runtime_before_expected
    FROM offline_runtime_apply_sessions WHERE id=v_apply_session_id;

    SELECT COUNT(*) INTO v_inserted_present
    FROM offline_world_pickup_apply_rows r
    JOIN world_pickups w ON w.id=r.world_pickup_id
    WHERE r.apply_session_id=v_apply_session_id;

    SELECT COUNT(*) INTO v_disabled_present
    FROM offline_world_pickup_disabled_rows d
    JOIN world_pickups w ON w.id=d.world_pickup_id
    WHERE d.apply_session_id=v_apply_session_id;

    IF v_inserted_present<>v_inserted_expected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Inserted world pickup mapping mismatch. Rollback aborted for safety.';
    END IF;
    IF v_disabled_present<>v_disabled_expected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Previously disabled world pickup mapping mismatch. Rollback aborted for safety.';
    END IF;

    SELECT COUNT(*) INTO v_inserted_checksum_mismatch
    FROM offline_world_pickup_apply_rows r
    JOIN world_pickups w ON w.id=r.world_pickup_id
    WHERE r.apply_session_id=v_apply_session_id
      AND BINARY r.row_checksum<>BINARY SHA2(CONCAT_WS('|',w.id,COALESCE(w.pickup_type,''),COALESCE(w.display_name,''),COALESCE(w.model_id,0),COALESCE(w.pos_x,0),COALESCE(w.pos_y,0),COALESCE(w.pos_z,0),COALESCE(w.interior,0),COALESCE(w.virtual_world,0),COALESCE(w.amount,0),COALESCE(w.cooldown_seconds,60),COALESCE(w.source_tag,''),COALESCE(w.enabled,0)),256);
    IF v_inserted_checksum_mismatch<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Imported world pickup rows changed after apply. Rollback aborted for manual review.';
    END IF;

    SELECT COUNT(*) INTO v_old_checksum_mismatch
    FROM offline_world_pickup_disabled_rows d
    JOIN world_pickups w ON w.id=d.world_pickup_id
    WHERE d.apply_session_id=v_apply_session_id
      AND BINARY d.row_checksum<>BINARY SHA2(CONCAT_WS('|',w.id,COALESCE(w.pickup_type,''),COALESCE(w.display_name,''),COALESCE(w.model_id,0),COALESCE(w.pos_x,0),COALESCE(w.pos_y,0),COALESCE(w.pos_z,0),COALESCE(w.interior,0),COALESCE(w.virtual_world,0),COALESCE(w.amount,0),COALESCE(w.cooldown_seconds,60),COALESCE(w.source_tag,''),d.previous_enabled),256);
    IF v_old_checksum_mismatch<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Previously active world pickup rows changed after apply. Rollback aborted for manual review.';
    END IF;

    START TRANSACTION;

    UPDATE world_pickups w
    JOIN offline_world_pickup_apply_rows r
      ON r.world_pickup_id=w.id AND r.apply_session_id=v_apply_session_id
    SET w.enabled=0;

    UPDATE world_pickups w
    JOIN offline_world_pickup_disabled_rows d
      ON d.world_pickup_id=w.id AND d.apply_session_id=v_apply_session_id
    SET w.enabled=d.previous_enabled;

    UPDATE offline_pickup_canonical_plan p
    JOIN offline_world_pickup_apply_rows r
      ON r.plan_id=p.id AND r.apply_session_id=v_apply_session_id
    SET p.apply_status='draft';

    UPDATE offline_pickup_queue q
    JOIN offline_world_pickup_apply_rows r
      ON r.queue_id=q.id AND r.apply_session_id=v_apply_session_id
    SET q.apply_status='pending';

    SELECT COALESCE(SUM(enabled=1),0) INTO v_runtime_active_after FROM world_pickups;
    IF v_runtime_active_after<>v_runtime_before_expected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Restored active world pickup count differs from pre-apply state.';
    END IF;

    UPDATE offline_runtime_apply_sessions
    SET apply_status='rolled_back',runtime_active_after=v_runtime_active_after,
        rolled_back_at=CURRENT_TIMESTAMP,
        notes=CONCAT(notes,' Rollback complete: 89 imported rows disabled; previous active world pickups restored.')
    WHERE id=v_apply_session_id;

    COMMIT;

    SELECT v_apply_session_id AS rolled_back_apply_session_id,v_source_tag AS disabled_import_source_tag,
           v_inserted_expected AS imported_rows_disabled,v_disabled_expected AS previous_rows_restored,
           v_runtime_active_after AS runtime_active_after,'ROLLED_BACK' AS rollback_status;
END//
DELIMITER ;

CALL saif_rollback_baseline89_world_pickups_v026A120();
DROP PROCEDURE IF EXISTS saif_rollback_baseline89_world_pickups_v026A120;
