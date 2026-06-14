-- Controlled rollback of v0.26A.1.24.2 policy staging/config only.
-- Does not alter player_houses or house_catalog.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @required_token := _utf8mb4'ROLLBACK_HOUSE_OWNERSHIP_ICON_READINESS' COLLATE utf8mb4_unicode_ci;
SET @archive_session_id := (SELECT id FROM offline_runtime_archive_sessions WHERE archive_scope='house_catalog' ORDER BY id DESC LIMIT 1);
DROP PROCEDURE IF EXISTS saif_rollback_house_readiness;
DELIMITER //
CREATE PROCEDURE saif_rollback_house_readiness()
BEGIN
 IF @saif_confirm IS NULL OR BINARY @saif_confirm<>BINARY @required_token THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token mismatch.'; END IF;
 START TRANSACTION;
 UPDATE offline_house_ownership_transition_plan
 SET policy_status=CASE WHEN old_house_catalog_id IS NULL THEN 'invalid_source' ELSE 'pending_mapping' END,
     target_canonical_slot=NULL,target_plan_id=NULL,notes='Readiness policy staging rolled back.',resolved_at=NULL
 WHERE archive_session_id=@archive_session_id;
 UPDATE house_map_icon_policy SET enabled=0,notes='Disabled by readiness rollback.' WHERE id=1;
 COMMIT;
 SELECT 'ROLLBACK_READINESS' section,@archive_session_id archive_session_id,
        (SELECT COUNT(*) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='pending_mapping') pending_rows,
        (SELECT enabled FROM house_map_icon_policy WHERE id=1) icon_policy_enabled_should_be_zero;
END//
DELIMITER ;
CALL saif_rollback_house_readiness();
DROP PROCEDURE IF EXISTS saif_rollback_house_readiness;
