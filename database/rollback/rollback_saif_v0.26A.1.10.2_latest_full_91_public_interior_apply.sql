-- SAIF / LSIF Dev v0.26A.1.10.2
-- HOTFIX: binary-safe rollback confirmation token
-- ROLLBACK latest live full-91 public interior apply.
-- Does NOT delete inserted rows; it disables them and restores previous enabled states.
-- REQUIRED SESSION VARIABLE:
--   @saif_confirm = 'ROLLBACK_LATEST_91_OFFLINE_PUBLIC_INTERIORS'

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_rollback_full_public_interiors_v026A110;
DELIMITER //
CREATE PROCEDURE saif_rollback_full_public_interiors_v026A110()
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
    IF v_confirm<>_binary'ROLLBACK_LATEST_91_OFFLINE_PUBLIC_INTERIORS' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token missing. Required: ROLLBACK_LATEST_91_OFFLINE_PUBLIC_INTERIORS';
    END IF;

    SELECT COALESCE(MAX(id),0)
      INTO v_apply_session_id
    FROM offline_runtime_apply_sessions
    WHERE apply_scope='public_interiors_offline_91'
      AND apply_status='complete'
      AND rolled_back_at IS NULL;

    IF v_apply_session_id=0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No live completed full-91 public interior apply found.';
    END IF;

    SELECT source_tag,new_rows_inserted,old_rows_disabled
      INTO v_source_tag,v_inserted_expected,v_disabled_expected
    FROM offline_runtime_apply_sessions
    WHERE id=v_apply_session_id;

    SELECT COUNT(*) INTO v_inserted_present
    FROM offline_public_interior_apply_rows r
    INNER JOIN public_interiors p ON p.id=r.public_interior_id
    WHERE r.apply_session_id=v_apply_session_id;

    SELECT COUNT(*) INTO v_disabled_present
    FROM offline_public_interior_disabled_rows d
    INNER JOIN public_interiors p ON p.id=d.public_interior_id
    WHERE d.apply_session_id=v_apply_session_id;

    IF v_inserted_present<>v_inserted_expected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Inserted runtime row mapping mismatch. Rollback aborted for safety.';
    END IF;

    IF v_disabled_present<>v_disabled_expected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Previously disabled runtime row mapping mismatch. Rollback aborted for safety.';
    END IF;

    START TRANSACTION;

    UPDATE public_interiors p
    INNER JOIN offline_public_interior_apply_rows r
        ON r.public_interior_id=p.id
       AND r.apply_session_id=v_apply_session_id
    SET p.enabled=0;

    UPDATE public_interiors p
    INNER JOIN offline_public_interior_disabled_rows d
        ON d.public_interior_id=p.id
       AND d.apply_session_id=v_apply_session_id
    SET p.enabled=d.previous_enabled;

    UPDATE offline_interior_apply_plan p
    INNER JOIN offline_public_interior_apply_rows r
        ON r.plan_id=p.id
       AND r.apply_session_id=v_apply_session_id
    SET p.apply_status='draft';

    UPDATE offline_interior_service_points sp
    INNER JOIN offline_public_interior_apply_rows r
        ON r.service_point_id=sp.id
       AND r.apply_session_id=v_apply_session_id
    SET sp.apply_status='draft';

    SELECT COALESCE(SUM(enabled=1),0)
      INTO v_runtime_active_after
    FROM public_interiors;

    UPDATE offline_runtime_apply_sessions
    SET apply_status='rolled_back',
        runtime_active_after=v_runtime_active_after,
        rolled_back_at=CURRENT_TIMESTAMP,
        notes=CONCAT(notes,' Rollback complete: all 91 imported rows disabled; prior target-family rows restored.')
    WHERE id=v_apply_session_id;

    COMMIT;

    SELECT
        v_apply_session_id AS rolled_back_apply_session_id,
        v_source_tag AS disabled_import_source_tag,
        v_inserted_expected AS imported_rows_disabled,
        v_disabled_expected AS previous_rows_restored,
        v_runtime_active_after AS runtime_active_after,
        'ROLLED_BACK' AS rollback_status;
END//
DELIMITER ;

CALL saif_rollback_full_public_interiors_v026A110();
DROP PROCEDURE IF EXISTS saif_rollback_full_public_interiors_v026A110;
