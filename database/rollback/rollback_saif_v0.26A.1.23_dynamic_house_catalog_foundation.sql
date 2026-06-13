-- Controlled rollback SAIF v0.26A.1.23 Dynamic House Catalog Foundation
-- Use only together with a PWN rollback to v0.26A.1.22 or earlier.
-- It restores house_catalog_id values captured before the bridge.
-- It does NOT drop tables/columns and does NOT delete ownership.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

DELIMITER $$
DROP PROCEDURE IF EXISTS saif_rollback_house_catalog_foundation_v026A123$$
CREATE PROCEDURE saif_rollback_house_catalog_foundation_v026A123()
BEGIN
    IF BINARY COALESCE(@saif_confirm,'') <> BINARY 'ROLLBACK_DYNAMIC_HOUSE_CATALOG_FOUNDATION' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Confirmation token invalid.';
    END IF;

    START TRANSACTION;

    UPDATE player_houses ph
    JOIN house_catalog_bridge_backup b
      ON b.player_house_id=ph.id
     AND b.patch_key='saif-v0.26A.1.23-house-catalog-foundation'
    SET ph.house_catalog_id=b.old_house_catalog_id;

    UPDATE house_catalog
    SET enabled=0
    WHERE source_tag='legacy_house_catalog_v0.26A.1.23';

    COMMIT;

    SELECT
        'ROLLED_BACK' AS rollback_status,
        ROW_COUNT() AS last_statement_rows,
        (SELECT COUNT(*) FROM player_houses) AS ownership_rows_preserved,
        (SELECT COUNT(*) FROM house_catalog WHERE source_tag='legacy_house_catalog_v0.26A.1.23' AND enabled=1) AS enabled_seed_rows_should_be_zero;
END$$
DELIMITER ;

CALL saif_rollback_house_catalog_foundation_v026A123();
DROP PROCEDURE IF EXISTS saif_rollback_house_catalog_foundation_v026A123;
