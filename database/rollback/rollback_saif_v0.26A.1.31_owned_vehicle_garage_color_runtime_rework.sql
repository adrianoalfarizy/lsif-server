-- SAIF / LSIF v0.26A.1.31 non-destructive emergency rollback
-- Required: SET @saif_confirm='ROLLBACK_OWNED_VEHICLE_GARAGE_COLOR_RUNTIME';
-- Keeps owned vehicles, garage assignments, transactions, and schema. It only disables v0.26A.1.31 runtime flags.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_rollback_owned_vehicle_runtime_v026A131;
DELIMITER //
CREATE PROCEDURE saif_rollback_owned_vehicle_runtime_v026A131()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; RESIGNAL; END;

    IF @saif_confirm IS NULL OR BINARY @saif_confirm<>BINARY 'ROLLBACK_OWNED_VEHICLE_GARAGE_COLOR_RUNTIME' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation missing: ROLLBACK_OWNED_VEHICLE_GARAGE_COLOR_RUNTIME';
    END IF;

    START TRANSACTION;

    UPDATE vehicle_storage_policy
    SET dealer_pending_enabled=0,
        nearest_spawn_enabled=0,
        despawn_enabled=0,
        color_modification_enabled=0,
        parked_vehicle_lifecycle_enabled=0,
        source_tag='saif_v0.26A.1.31_rollback'
    WHERE id=1;

    -- Revert transient runtime states only. Permanent ownership and home garage assignments remain intact.
    UPDATE player_vehicles
    SET lifecycle_status=CASE WHEN home_storage_location_id IS NOT NULL THEN 'stored' ELSE 'legacy_unassigned' END,
        destroyed_until=NULL,
        last_state_changed_at=NOW()
    WHERE lifecycle_status IN ('active','destroyed_cooldown','dealer_pending');

    UPDATE player_vehicle_storage
    SET storage_status='stored',released_at=NULL
    WHERE storage_status IN ('active','releasing','destroyed_cooldown');

    COMMIT;

    SELECT 'ROLLBACK_GATE' section,
      (SELECT dealer_pending_enabled FROM vehicle_storage_policy WHERE id=1) dealer_pending_should_be_zero,
      (SELECT nearest_spawn_enabled FROM vehicle_storage_policy WHERE id=1) nearest_spawn_should_be_zero,
      (SELECT despawn_enabled FROM vehicle_storage_policy WHERE id=1) despawn_should_be_zero,
      (SELECT color_modification_enabled FROM vehicle_storage_policy WHERE id=1) color_mod_should_be_zero,
      (SELECT parked_vehicle_lifecycle_enabled FROM vehicle_storage_policy WHERE id=1) parked_lifecycle_should_be_zero,
      (SELECT COUNT(*) FROM player_vehicles WHERE lifecycle_status IN ('active','destroyed_cooldown','dealer_pending')) transient_rows_should_be_zero;
END//
DELIMITER ;
CALL saif_rollback_owned_vehicle_runtime_v026A131();
DROP PROCEDURE IF EXISTS saif_rollback_owned_vehicle_runtime_v026A131;
