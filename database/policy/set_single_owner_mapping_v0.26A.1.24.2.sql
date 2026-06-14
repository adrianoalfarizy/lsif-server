-- Controlled single-owner mapping policy staging.
-- Set @transition_id and @target_canonical_slot before running.
-- Does NOT mutate player_houses or house_catalog.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @required_token := _utf8mb4'MAPPING_ONE_LEGACY_OWNER_TO_CANONICAL_SLOT' COLLATE utf8mb4_unicode_ci;
SET @archive_session_id := (SELECT id FROM offline_runtime_archive_sessions WHERE archive_scope='house_catalog' AND archive_status='complete' ORDER BY id DESC LIMIT 1);

DROP PROCEDURE IF EXISTS saif_map_one_house_owner;
DELIMITER //
CREATE PROCEDURE saif_map_one_house_owner()
BEGIN
    DECLARE target_plan BIGINT UNSIGNED DEFAULT NULL;
    DECLARE transition_exists INT DEFAULT 0;
    DECLARE target_used INT DEFAULT 0;
    DECLARE old_status VARCHAR(32) DEFAULT '';

    IF @saif_confirm IS NULL OR BINARY @saif_confirm<>BINARY @required_token THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token mismatch.';
    END IF;
    IF @transition_id IS NULL OR @transition_id<=0 OR @target_canonical_slot IS NULL OR @target_canonical_slot<3 OR @target_canonical_slot>31 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Set valid @transition_id and @target_canonical_slot 3..31.';
    END IF;

    SELECT COUNT(*),MAX(policy_status) INTO transition_exists,old_status
    FROM offline_house_ownership_transition_plan
    WHERE id=@transition_id AND archive_session_id=@archive_session_id;
    IF transition_exists<>1 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Transition row not found in latest archive.'; END IF;

    SELECT id INTO target_plan FROM offline_property_canonical_plan
    WHERE resolver_version='saif-house-property-resolver-v0.26A.1.22' AND decision_code='baseline_ready' AND slot_index=@target_canonical_slot LIMIT 1;
    IF target_plan IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Target canonical slot is not baseline-ready.'; END IF;

    SELECT COUNT(*) INTO target_used FROM offline_house_ownership_transition_plan
    WHERE archive_session_id=@archive_session_id AND id<>@transition_id AND policy_status='mapped' AND target_canonical_slot=@target_canonical_slot;
    IF target_used<>0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Target canonical slot already assigned to another owner.'; END IF;

    START TRANSACTION;
    INSERT INTO offline_house_ownership_policy_events
      (archive_session_id,transition_id,old_policy_status,new_policy_status,target_canonical_slot,confirmation_token,notes)
    VALUES(@archive_session_id,@transition_id,old_status,'mapped',@target_canonical_slot,@required_token,'Explicit owner-to-canonical-slot staging decision.');
    UPDATE offline_house_ownership_transition_plan
    SET policy_status='mapped',target_canonical_slot=@target_canonical_slot,target_plan_id=target_plan,
        notes='Explicitly mapped to canonical GTA SA savehouse slot.',resolved_at=NOW()
    WHERE id=@transition_id AND archive_session_id=@archive_session_id;
    COMMIT;

    SELECT 'OWNER_MAPPING_POLICY' section,@transition_id transition_id,@target_canonical_slot target_canonical_slot,target_plan target_plan_id,'mapped' policy_status;
END//
DELIMITER ;
CALL saif_map_one_house_owner();
DROP PROCEDURE IF EXISTS saif_map_one_house_owner;
