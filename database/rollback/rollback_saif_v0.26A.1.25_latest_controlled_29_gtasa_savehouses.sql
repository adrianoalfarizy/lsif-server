-- Roll back latest live controlled GTA SA 29-savehouse apply.
-- Imported catalog rows are disabled; previous enabled states and mapped ownership fields are restored. No DELETE.
-- REQUIRED: SET @saif_confirm='ROLLBACK_LATEST_29_GTASA_SAVEHOUSES';
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_rollback_gtasa29_savehouses_v026A125;
DELIMITER //
CREATE PROCEDURE saif_rollback_gtasa29_savehouses_v026A125()
main: BEGIN
    DECLARE v_confirm VARBINARY(96) DEFAULT X'';
    DECLARE v_apply_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_archive_session_id BIGINT UNSIGNED DEFAULT 0;
    DECLARE v_inserted_expected INT DEFAULT 0;
    DECLARE v_disabled_expected INT DEFAULT 0;
    DECLARE v_ownership_expected INT DEFAULT 0;
    DECLARE v_active_before_expected INT DEFAULT 0;
    DECLARE v_inserted_present INT DEFAULT 0;
    DECLARE v_disabled_present INT DEFAULT 0;
    DECLARE v_ownership_present INT DEFAULT 0;
    DECLARE v_inserted_checksum_mismatch INT DEFAULT 0;
    DECLARE v_disabled_checksum_mismatch INT DEFAULT 0;
    DECLARE v_ownership_checksum_mismatch INT DEFAULT 0;
    DECLARE v_current_ownership_rows INT DEFAULT 0;
    DECLARE v_active_after INT DEFAULT 0;
    DECLARE v_archive_checksum_after INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET v_confirm=BINARY COALESCE(@saif_confirm,'');
    IF v_confirm<>_binary'ROLLBACK_LATEST_29_GTASA_SAVEHOUSES' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token missing. Required: ROLLBACK_LATEST_29_GTASA_SAVEHOUSES';
    END IF;

    SELECT COALESCE(MAX(id),0) INTO v_apply_session_id FROM offline_house_catalog_apply_sessions WHERE apply_status='complete' AND rolled_back_at IS NULL;
    IF v_apply_session_id=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No live completed GTA SA 29-savehouse apply found.'; END IF;

    SELECT archive_session_id,canonical_rows_inserted,legacy_rows_disabled,ownership_rows_before,catalog_active_before
      INTO v_archive_session_id,v_inserted_expected,v_disabled_expected,v_ownership_expected,v_active_before_expected
    FROM offline_house_catalog_apply_sessions WHERE id=v_apply_session_id;

    SELECT COUNT(*) INTO v_inserted_present FROM offline_house_catalog_apply_rows r JOIN house_catalog h ON h.id=r.house_catalog_id WHERE r.apply_session_id=v_apply_session_id;
    SELECT COUNT(*) INTO v_disabled_present FROM offline_house_catalog_disabled_rows d JOIN house_catalog h ON h.id=d.house_catalog_id WHERE d.apply_session_id=v_apply_session_id;
    SELECT COUNT(*) INTO v_ownership_present FROM offline_house_ownership_apply_rows r JOIN player_houses ph ON ph.id=r.player_house_id WHERE r.apply_session_id=v_apply_session_id;
    SELECT COUNT(*) INTO v_current_ownership_rows FROM player_houses;
    IF v_inserted_present<>v_inserted_expected OR v_disabled_present<>v_disabled_expected OR v_ownership_present<>v_ownership_expected OR v_current_ownership_rows<>v_ownership_expected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Apply mapping/current ownership count changed. Rollback aborted for safety.';
    END IF;

    SELECT COUNT(*) INTO v_inserted_checksum_mismatch FROM offline_house_catalog_apply_rows r JOIN house_catalog h ON h.id=r.house_catalog_id
    WHERE r.apply_session_id=v_apply_session_id AND BINARY r.row_checksum<>BINARY SHA2(CONCAT_WS('|',h.id,COALESCE(h.legacy_house_index,'NULL'),COALESCE(h.canonical_slot,'NULL'),COALESCE(h.display_name,''),COALESCE(h.price,0),COALESCE(h.exterior_pickup_x,0),COALESCE(h.exterior_pickup_y,0),COALESCE(h.exterior_pickup_z,0),COALESCE(h.exterior_facing,0),COALESCE(h.exterior_spawn_x,0),COALESCE(h.exterior_spawn_y,0),COALESCE(h.exterior_spawn_z,0),COALESCE(h.exterior_spawn_a,0),COALESCE(h.interior_id,0),COALESCE(h.interior_exit_x,0),COALESCE(h.interior_exit_y,0),COALESCE(h.interior_exit_z,0),COALESCE(h.interior_spawn_x,0),COALESCE(h.interior_spawn_y,0),COALESCE(h.interior_spawn_z,0),COALESCE(h.interior_spawn_a,0),COALESCE(h.savepoint_x,'NULL'),COALESCE(h.savepoint_y,'NULL'),COALESCE(h.savepoint_z,'NULL'),COALESCE(h.garage_source_evidence_id,'NULL'),COALESCE(h.map_icon_type,0),COALESCE(h.pickup_model,0),COALESCE(h.pickup_type,0),COALESCE(h.private_vw_required,0),COALESCE(h.enabled,0),COALESCE(h.sort_order,0),COALESCE(h.source_tag,'')),256);
    SELECT COUNT(*) INTO v_disabled_checksum_mismatch FROM offline_house_catalog_disabled_rows d JOIN house_catalog h ON h.id=d.house_catalog_id
    WHERE d.apply_session_id=v_apply_session_id AND BINARY d.row_checksum<>BINARY SHA2(CONCAT_WS('|',h.id,COALESCE(h.legacy_house_index,'NULL'),COALESCE(h.canonical_slot,'NULL'),COALESCE(h.display_name,''),COALESCE(h.price,0),COALESCE(h.exterior_pickup_x,0),COALESCE(h.exterior_pickup_y,0),COALESCE(h.exterior_pickup_z,0),COALESCE(h.exterior_facing,0),COALESCE(h.exterior_spawn_x,0),COALESCE(h.exterior_spawn_y,0),COALESCE(h.exterior_spawn_z,0),COALESCE(h.exterior_spawn_a,0),COALESCE(h.interior_id,0),COALESCE(h.interior_exit_x,0),COALESCE(h.interior_exit_y,0),COALESCE(h.interior_exit_z,0),COALESCE(h.interior_spawn_x,0),COALESCE(h.interior_spawn_y,0),COALESCE(h.interior_spawn_z,0),COALESCE(h.interior_spawn_a,0),COALESCE(h.savepoint_x,'NULL'),COALESCE(h.savepoint_y,'NULL'),COALESCE(h.savepoint_z,'NULL'),COALESCE(h.garage_source_evidence_id,'NULL'),COALESCE(h.map_icon_type,0),COALESCE(h.pickup_model,0),COALESCE(h.pickup_type,0),COALESCE(h.private_vw_required,0),d.previous_enabled,COALESCE(h.sort_order,0),COALESCE(h.source_tag,'')),256);
    SELECT COUNT(*) INTO v_ownership_checksum_mismatch FROM offline_house_ownership_apply_rows r JOIN player_houses ph ON ph.id=r.player_house_id
    WHERE r.apply_session_id=v_apply_session_id AND BINARY r.after_checksum<>BINARY SHA2(CONCAT_WS('|',ph.id,ph.owner_id,COALESCE(ph.house_catalog_id,'NULL'),ph.house_index,COALESCE(ph.house_name,''),COALESCE(ph.price,0),COALESCE(ph.locked,1),COALESCE(ph.pos_x,0),COALESCE(ph.pos_y,0),COALESCE(ph.pos_z,0)),256);
    IF v_inserted_checksum_mismatch<>0 OR v_disabled_checksum_mismatch<>0 OR v_ownership_checksum_mismatch<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Catalog/ownership changed after apply. Rollback aborted for manual review.';
    END IF;

    START TRANSACTION;

    UPDATE player_houses ph JOIN offline_house_ownership_apply_rows r ON r.player_house_id=ph.id AND r.apply_session_id=v_apply_session_id
    SET ph.house_catalog_id=r.old_house_catalog_id,ph.house_index=r.old_house_index,ph.house_name=r.old_house_name,
        ph.price=r.old_price,ph.locked=r.old_locked,ph.pos_x=r.old_pos_x,ph.pos_y=r.old_pos_y,ph.pos_z=r.old_pos_z;

    UPDATE house_catalog h JOIN offline_house_catalog_apply_rows r ON r.house_catalog_id=h.id AND r.apply_session_id=v_apply_session_id SET h.enabled=0;
    UPDATE house_catalog h JOIN offline_house_catalog_disabled_rows d ON d.house_catalog_id=h.id AND d.apply_session_id=v_apply_session_id SET h.enabled=d.previous_enabled;
    UPDATE offline_property_canonical_plan p JOIN offline_house_catalog_apply_rows r ON r.plan_id=p.id AND r.apply_session_id=v_apply_session_id SET p.apply_status='draft';

    SELECT COALESCE(SUM(enabled=1),0) INTO v_active_after FROM house_catalog;
    IF v_active_after<>v_active_before_expected THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Restored active catalog count differs from pre-apply state.'; END IF;

    SELECT COUNT(*) INTO v_archive_checksum_after FROM offline_house_ownership_archive a JOIN player_houses ph ON ph.id=a.player_house_id
    WHERE a.archive_session_id=v_archive_session_id AND BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',ph.id,ph.owner_id,COALESCE(ph.house_catalog_id,'NULL'),ph.house_index,COALESCE(ph.house_name,''),COALESCE(ph.price,0),COALESCE(ph.locked,1),COALESCE(ph.pos_x,0),COALESCE(ph.pos_y,0),COALESCE(ph.pos_z,0)),256);
    IF v_archive_checksum_after<>0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Ownership restore does not match archive checksum.'; END IF;

    UPDATE offline_house_catalog_apply_sessions SET apply_status='rolled_back',catalog_active_after=v_active_after,ownership_rows_after=v_current_ownership_rows,rolled_back_at=CURRENT_TIMESTAMP,
        notes=CONCAT(notes,' Rollback complete: 29 imported definitions disabled; previous enabled states and ownership fields restored.')
    WHERE id=v_apply_session_id;

    COMMIT;

    SELECT v_apply_session_id rolled_back_apply_session_id,v_inserted_expected imported_rows_disabled,v_disabled_expected previous_rows_restored,
           v_active_after active_catalog_after,'ROLLED_BACK' rollback_status;
END//
DELIMITER ;
CALL saif_rollback_gtasa29_savehouses_v026A125();
DROP PROCEDURE IF EXISTS saif_rollback_gtasa29_savehouses_v026A125;
