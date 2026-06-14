-- SAIF / LSIF Dev v0.26A.1.27 rollback
-- Safe only before controlled garage catalog apply.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
DROP PROCEDURE IF EXISTS saif_rollback_world_garage_backend_v026A127;
DELIMITER //
CREATE PROCEDURE saif_rollback_world_garage_backend_v026A127()
BEGIN
    DECLARE catalog_rows INT DEFAULT 0;
    DECLARE link_rows INT DEFAULT 0;
    DECLARE policy_active INT DEFAULT 0;

    SELECT COUNT(*) INTO catalog_rows FROM garage_catalog;
    SELECT COUNT(*) INTO link_rows FROM house_garage_links;
    SELECT COALESCE(enabled+store_enabled+retrieve_enabled+door_animation_enabled,0) INTO policy_active FROM garage_runtime_policy WHERE id=1;

    IF catalog_rows<>0 OR link_rows<>0 OR policy_active<>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Rollback blocked: garage backend contains applied rows or active policy. Use tracked controlled rollback instead.';
    END IF;

    DROP TABLE IF EXISTS house_garage_links;
    DROP TABLE IF EXISTS garage_catalog;
    DROP TABLE IF EXISTS garage_runtime_policy;
END//
DELIMITER ;
CALL saif_rollback_world_garage_backend_v026A127();
DROP PROCEDURE IF EXISTS saif_rollback_world_garage_backend_v026A127;

SELECT 'ROLLBACK_COMPLETE' section,
       (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='garage_runtime_policy') policy_table_should_be_zero,
       (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='garage_catalog') catalog_table_should_be_zero,
       (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='house_garage_links') links_table_should_be_zero;
