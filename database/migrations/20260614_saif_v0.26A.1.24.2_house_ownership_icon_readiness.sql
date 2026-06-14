-- SAIF / LSIF Dev v0.26A.1.24.2
-- Ownership Transition & House Map-Icon Readiness Foundation
-- Safe scope: policy/config foundation + single-owner integrity. No 29-house apply.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS house_map_icon_policy (
    id TINYINT UNSIGNED NOT NULL,
    policy_key VARCHAR(64) NOT NULL,
    enabled TINYINT(1) NOT NULL DEFAULT 1,
    public_service_slots SMALLINT UNSIGNED NOT NULL DEFAULT 91,
    owned_house_slots SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    nearby_for_sale_slots SMALLINT UNSIGNED NOT NULL DEFAULT 8,
    nearby_radius DECIMAL(8,2) NOT NULL DEFAULT 1500.00,
    refresh_interval_ms INT UNSIGNED NOT NULL DEFAULT 8000,
    owned_icon_type SMALLINT NOT NULL DEFAULT 35,
    for_sale_icon_type SMALLINT NOT NULL DEFAULT 31,
    notes VARCHAR(512) NOT NULL DEFAULT '',
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_house_map_icon_policy_key (policy_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO house_map_icon_policy
(id,policy_key,enabled,public_service_slots,owned_house_slots,nearby_for_sale_slots,nearby_radius,refresh_interval_ms,owned_icon_type,for_sale_icon_type,notes)
VALUES
(1,'offline_owned_plus_nearest_v1',1,91,1,8,1500.00,8000,35,31,
 'Native 100-slot split: 91 permanent public/service icons, 1 owned savehouse icon, 8 nearest unowned property icons. MAPICON_LOCAL.')
ON DUPLICATE KEY UPDATE
 policy_key=VALUES(policy_key),enabled=VALUES(enabled),public_service_slots=VALUES(public_service_slots),
 owned_house_slots=VALUES(owned_house_slots),nearby_for_sale_slots=VALUES(nearby_for_sale_slots),
 nearby_radius=VALUES(nearby_radius),refresh_interval_ms=VALUES(refresh_interval_ms),
 owned_icon_type=VALUES(owned_icon_type),for_sale_icon_type=VALUES(for_sale_icon_type),notes=VALUES(notes);

ALTER TABLE offline_house_ownership_transition_plan
    ADD COLUMN IF NOT EXISTS resolved_at TIMESTAMP NULL DEFAULT NULL AFTER notes;

CREATE TABLE IF NOT EXISTS offline_house_ownership_policy_events (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    archive_session_id BIGINT UNSIGNED NOT NULL,
    transition_id BIGINT UNSIGNED NOT NULL,
    old_policy_status VARCHAR(32) NOT NULL,
    new_policy_status VARCHAR(32) NOT NULL,
    target_canonical_slot INT NULL,
    confirmation_token VARCHAR(96) NOT NULL,
    notes VARCHAR(512) NOT NULL DEFAULT '',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_house_policy_event_session (archive_session_id,created_at),
    KEY idx_house_policy_event_transition (transition_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP PROCEDURE IF EXISTS saif_add_house_single_owner_guard;
DELIMITER //
CREATE PROCEDURE saif_add_house_single_owner_guard()
BEGIN
    DECLARE duplicate_catalogs INT DEFAULT 0;
    DECLARE index_exists INT DEFAULT 0;

    SELECT COUNT(*) INTO duplicate_catalogs
    FROM (
        SELECT house_catalog_id
        FROM player_houses
        WHERE house_catalog_id IS NOT NULL
        GROUP BY house_catalog_id
        HAVING COUNT(*)>1
    ) d;

    IF duplicate_catalogs>0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cannot add single-owner guard: duplicate house_catalog_id ownership exists.';
    END IF;

    SELECT COUNT(*) INTO index_exists
    FROM information_schema.statistics
    WHERE table_schema=DATABASE() AND table_name='player_houses' AND index_name='uq_player_houses_catalog_single_owner';

    IF index_exists=0 THEN
        SET @sql_guard='ALTER TABLE player_houses ADD UNIQUE KEY uq_player_houses_catalog_single_owner (house_catalog_id)';
        PREPARE stmt_guard FROM @sql_guard;
        EXECUTE stmt_guard;
        DEALLOCATE PREPARE stmt_guard;
    END IF;
END//
DELIMITER ;
CALL saif_add_house_single_owner_guard();
DROP PROCEDURE IF EXISTS saif_add_house_single_owner_guard;

SELECT 'HOUSE_ICON_POLICY' section,policy_key,enabled,public_service_slots,owned_house_slots,nearby_for_sale_slots,
       (public_service_slots+owned_house_slots+nearby_for_sale_slots) total_slots_expected_100,
       nearby_radius,refresh_interval_ms
FROM house_map_icon_policy WHERE id=1;

SELECT 'SINGLE_OWNER_GUARD' section,
       (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema=DATABASE() AND table_name='player_houses' AND index_name='uq_player_houses_catalog_single_owner') guard_exists_should_be_1,
       (SELECT COUNT(*) FROM (SELECT house_catalog_id FROM player_houses WHERE house_catalog_id IS NOT NULL GROUP BY house_catalog_id HAVING COUNT(*)>1) x) duplicate_catalogs_should_be_zero;
