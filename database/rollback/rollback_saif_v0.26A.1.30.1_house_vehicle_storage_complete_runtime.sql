-- SAIF / LSIF v0.26A.1.30.1 rollback
-- Refuses rollback while any vehicle is stored.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
DROP PROCEDURE IF EXISTS saif_rollback_house_vehicle_storage_v026A1301;
DELIMITER //
CREATE PROCEDURE saif_rollback_house_vehicle_storage_v026A1301()
BEGIN
  IF EXISTS (SELECT 1 FROM player_vehicle_storage) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Rollback refused: retrieve all stored vehicles first.';
  END IF;
  START TRANSACTION;
  UPDATE vehicle_storage_policy SET enabled=0,house_storage_enabled=0,store_enabled=0,retrieve_enabled=0 WHERE id=1;
  DELETE FROM vehicle_storage_locations WHERE storage_type='house' AND source_tag IN ('offline_exact_house_storage12_v0.26A.1.30.1','manual_house_storage_pending_v0.26A.1.30.1','manual_house_storage_editor_v0.26A.1.30.1');
  COMMIT;
  SELECT 'ROLLBACK_GATE' section,
    (SELECT enabled FROM vehicle_storage_policy WHERE id=1) policy_enabled_should_be_zero,
    (SELECT house_storage_enabled FROM vehicle_storage_policy WHERE id=1) house_enabled_should_be_zero,
    (SELECT store_enabled FROM vehicle_storage_policy WHERE id=1) store_enabled_should_be_zero,
    (SELECT retrieve_enabled FROM vehicle_storage_policy WHERE id=1) retrieve_enabled_should_be_zero,
    (SELECT COUNT(*) FROM vehicle_storage_locations WHERE storage_type='house') house_locations_should_be_zero;
END//
DELIMITER ;
CALL saif_rollback_house_vehicle_storage_v026A1301();
DROP PROCEDURE IF EXISTS saif_rollback_house_vehicle_storage_v026A1301;
