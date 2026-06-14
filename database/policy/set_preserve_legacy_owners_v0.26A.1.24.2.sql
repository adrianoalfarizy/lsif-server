-- Controlled policy staging: preserve all current legacy owners.
-- Does NOT mutate player_houses or house_catalog.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @required_token := _utf8mb4'PRESERVE_CURRENT_LEGACY_HOUSE_OWNERS' COLLATE utf8mb4_unicode_ci;
SET @archive_session_id := (SELECT id FROM offline_runtime_archive_sessions WHERE archive_scope='house_catalog' AND archive_status='complete' ORDER BY id DESC LIMIT 1);

DROP PROCEDURE IF EXISTS saif_preserve_legacy_house_owners;
DELIMITER //
CREATE PROCEDURE saif_preserve_legacy_house_owners()
BEGIN
    DECLARE pending_rows INT DEFAULT 0;
    DECLARE invalid_rows INT DEFAULT 0;

    IF @saif_confirm IS NULL OR BINARY @saif_confirm<>BINARY @required_token THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token mismatch.';
    END IF;
    IF @archive_session_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No complete house_catalog archive.';
    END IF;

    SELECT COUNT(*) INTO invalid_rows FROM offline_house_ownership_transition_plan
    WHERE archive_session_id=@archive_session_id AND policy_status='invalid_source';
    IF invalid_rows<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Invalid ownership source exists; inspect before policy staging.';
    END IF;

    SELECT COUNT(*) INTO pending_rows FROM offline_house_ownership_transition_plan
    WHERE archive_session_id=@archive_session_id AND policy_status='pending_mapping';

    START TRANSACTION;
    INSERT INTO offline_house_ownership_policy_events
      (archive_session_id,transition_id,old_policy_status,new_policy_status,target_canonical_slot,confirmation_token,notes)
    SELECT archive_session_id,id,policy_status,'preserve_legacy',NULL,@required_token,
           'Safe default: keep currently owned legacy catalog definition active during GTA SA 29-house apply.'
    FROM offline_house_ownership_transition_plan
    WHERE archive_session_id=@archive_session_id AND policy_status='pending_mapping';

    UPDATE offline_house_ownership_transition_plan
    SET policy_status='preserve_legacy',target_canonical_slot=NULL,target_plan_id=NULL,
        notes='Safe default selected: preserve currently owned legacy house definition during future apply.',resolved_at=NOW()
    WHERE archive_session_id=@archive_session_id AND policy_status='pending_mapping';
    COMMIT;

    SELECT 'PRESERVE_LEGACY_POLICY' section,@archive_session_id archive_session_id,pending_rows rows_resolved,
           (SELECT COUNT(*) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='preserve_legacy') preserve_legacy_rows,
           (SELECT COUNT(*) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='pending_mapping') pending_should_be_zero;
END//
DELIMITER ;
CALL saif_preserve_legacy_house_owners();
DROP PROCEDURE IF EXISTS saif_preserve_legacy_house_owners;
