-- SAIF v0.26A.1.23 - Dynamic House Catalog Backend Foundation
-- Safe scope: create world-definition catalog, seed five legacy definitions,
-- and bridge existing player_houses ownership rows. No GTA SA 29-house apply.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

START TRANSACTION;

ALTER TABLE player_houses
    ADD COLUMN IF NOT EXISTS house_catalog_id INT UNSIGNED NULL AFTER house_index;

CREATE TABLE IF NOT EXISTS house_catalog (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    legacy_house_index INT NULL,
    canonical_slot INT NULL,
    display_name VARCHAR(64) NOT NULL,
    price INT NOT NULL DEFAULT 0,

    exterior_pickup_x DECIMAL(11,4) NOT NULL,
    exterior_pickup_y DECIMAL(11,4) NOT NULL,
    exterior_pickup_z DECIMAL(11,4) NOT NULL,
    exterior_facing DECIMAL(8,4) NOT NULL DEFAULT 0.0000,

    exterior_spawn_x DECIMAL(11,4) NOT NULL,
    exterior_spawn_y DECIMAL(11,4) NOT NULL,
    exterior_spawn_z DECIMAL(11,4) NOT NULL,
    exterior_spawn_a DECIMAL(8,4) NOT NULL DEFAULT 0.0000,

    interior_id INT NOT NULL DEFAULT 3,
    interior_exit_x DECIMAL(11,4) NOT NULL,
    interior_exit_y DECIMAL(11,4) NOT NULL,
    interior_exit_z DECIMAL(11,4) NOT NULL,
    interior_spawn_x DECIMAL(11,4) NOT NULL,
    interior_spawn_y DECIMAL(11,4) NOT NULL,
    interior_spawn_z DECIMAL(11,4) NOT NULL,
    interior_spawn_a DECIMAL(8,4) NOT NULL DEFAULT 180.0000,

    savepoint_x DECIMAL(11,4) NULL,
    savepoint_y DECIMAL(11,4) NULL,
    savepoint_z DECIMAL(11,4) NULL,
    garage_source_evidence_id BIGINT UNSIGNED NULL,

    map_icon_type SMALLINT NOT NULL DEFAULT 31,
    pickup_model INT NOT NULL DEFAULT 1318,
    pickup_type INT NOT NULL DEFAULT 1,
    private_vw_required TINYINT(1) NOT NULL DEFAULT 1,
    enabled TINYINT(1) NOT NULL DEFAULT 1,
    sort_order INT NOT NULL DEFAULT 0,
    source_tag VARCHAR(64) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE KEY uq_house_catalog_legacy_index (legacy_house_index),
    UNIQUE KEY uq_house_catalog_canonical_slot (canonical_slot),
    KEY idx_house_catalog_enabled_sort (enabled, sort_order, id),
    KEY idx_house_catalog_source_tag (source_tag)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS house_catalog_bridge_backup (
    patch_key VARCHAR(64) NOT NULL,
    player_house_id INT UNSIGNED NOT NULL,
    owner_id INT UNSIGNED NOT NULL,
    old_house_index INT NOT NULL,
    old_house_catalog_id INT UNSIGNED NULL,
    captured_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (patch_key, player_house_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO house_catalog_bridge_backup
    (patch_key, player_house_id, owner_id, old_house_index, old_house_catalog_id)
SELECT
    'saif-v0.26A.1.23-house-catalog-foundation',
    id,
    owner_id,
    house_index,
    house_catalog_id
FROM player_houses;

INSERT IGNORE INTO house_catalog
(
    legacy_house_index, canonical_slot, display_name, price,
    exterior_pickup_x, exterior_pickup_y, exterior_pickup_z, exterior_facing,
    exterior_spawn_x, exterior_spawn_y, exterior_spawn_z, exterior_spawn_a,
    interior_id,
    interior_exit_x, interior_exit_y, interior_exit_z,
    interior_spawn_x, interior_spawn_y, interior_spawn_z, interior_spawn_a,
    map_icon_type, pickup_model, pickup_type, private_vw_required,
    enabled, sort_order, source_tag
)
VALUES
(0, NULL, 'Ganton Starter House',   50000, 2243.9121,-1638.2314,15.9074,0.0000, 2243.9121,-1638.2314,15.9074,0.0000, 3, 2496.0498,-1697.2382,1014.7422, 2496.0498,-1695.2382,1014.7422,180.0000, 31,1318,1,1,1,0,'legacy_house_catalog_v0.26A.1.23'),
(1, NULL, 'Idlewood Family House',  75000, 2362.7712,-1643.1138,13.5234,0.0000, 2362.7712,-1643.1138,13.5234,0.0000, 3, 2496.0498,-1697.2382,1014.7422, 2496.0498,-1695.2382,1014.7422,180.0000, 31,1318,1,1,1,1,'legacy_house_catalog_v0.26A.1.23'),
(2, NULL, 'Market Hill House',     120000, 1412.1656, -920.2480,35.0781,0.0000, 1412.1656, -920.2480,35.0781,0.0000, 3, 2496.0498,-1697.2382,1014.7422, 2496.0498,-1695.2382,1014.7422,180.0000, 31,1318,1,1,1,2,'legacy_house_catalog_v0.26A.1.23'),
(3, NULL, 'Mulholland View House',180000, 1095.4482, -647.5122,113.6484,0.0000,1095.4482, -647.5122,113.6484,0.0000,3, 2496.0498,-1697.2382,1014.7422, 2496.0498,-1695.2382,1014.7422,180.0000, 31,1318,1,1,1,3,'legacy_house_catalog_v0.26A.1.23'),
(4, NULL, 'Richman Small Villa',  250000,  827.9244, -858.1049,70.3308,0.0000, 827.9244, -858.1049,70.3308,0.0000, 3, 2496.0498,-1697.2382,1014.7422, 2496.0498,-1695.2382,1014.7422,180.0000, 31,1318,1,1,1,4,'legacy_house_catalog_v0.26A.1.23');

UPDATE player_houses ph
JOIN house_catalog hc
  ON hc.legacy_house_index = ph.house_index
SET ph.house_catalog_id = hc.id
WHERE ph.house_catalog_id IS NULL
  AND ph.house_index BETWEEN 0 AND 4;

COMMIT;

SELECT
    'HOUSE_CATALOG_FOUNDATION' AS section,
    COUNT(*) AS total_catalog_rows,
    SUM(enabled=1) AS enabled_catalog_rows,
    SUM(legacy_house_index BETWEEN 0 AND 4) AS legacy_rows_expected_5,
    SUM(canonical_slot IS NOT NULL) AS gta_sa_rows_should_be_zero
FROM house_catalog;

SELECT
    'OWNERSHIP_BRIDGE' AS section,
    COUNT(*) AS ownership_rows,
    COALESCE(SUM(house_catalog_id IS NOT NULL),0) AS mapped_rows,
    COALESCE(SUM(house_catalog_id IS NULL),0) AS unmapped_rows_should_be_zero
FROM player_houses;
