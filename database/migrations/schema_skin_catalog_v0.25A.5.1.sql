-- SAIF / LSIF Dev v0.25A.5.1 — Skin Catalog Baseline
-- Run after appending to database/schema.sql and before deploying the PWN.

ALTER TABLE players
    ADD COLUMN IF NOT EXISTS skin SMALLINT NOT NULL DEFAULT 0 AFTER admin_level;

UPDATE players
SET skin = 0
WHERE skin IS NULL OR skin < 0 OR skin > 311;

CREATE TABLE IF NOT EXISTS skin_catalog (
    id INT NOT NULL AUTO_INCREMENT,
    skin_id SMALLINT NOT NULL,
    display_name VARCHAR(64) NOT NULL,
    category VARCHAR(32) NOT NULL DEFAULT 'civilian',
    price INT NOT NULL DEFAULT 0,
    movement_profile VARCHAR(32) NOT NULL DEFAULT 'cj_like',
    anim_profile VARCHAR(32) NOT NULL DEFAULT 'default',
    enabled TINYINT NOT NULL DEFAULT 1,
    sort_order INT NOT NULL DEFAULT 0,
    source_tag VARCHAR(32) NOT NULL DEFAULT 'saif_seed',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_skin_catalog_skin_id (skin_id),
    KEY idx_skin_catalog_enabled_sort (enabled, sort_order),
    KEY idx_skin_catalog_category_enabled (category, enabled)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO skin_catalog
(skin_id, display_name, category, price, movement_profile, anim_profile, enabled, sort_order, source_tag)
VALUES
(0, 'CJ Default', 'default', 0, 'cj_like', 'default', 1, 1, 'saif_seed'),
(1, 'Civilian Style 1', 'civilian', 500, 'cj_like', 'default', 1, 2, 'saif_seed'),
(7, 'Casual Male', 'civilian', 750, 'cj_like', 'default', 1, 3, 'saif_seed'),
(9, 'Casual Female', 'civilian', 750, 'cj_like', 'default', 1, 4, 'saif_seed'),
(15, 'Business Male', 'business', 1200, 'cj_like', 'default', 1, 5, 'saif_seed'),
(46, 'Runner Outfit', 'sport', 900, 'cj_like', 'default', 1, 6, 'saif_seed'),
(60, 'Pilot Outfit', 'work', 1500, 'cj_like', 'default', 1, 7, 'saif_seed'),
(93, 'Business Female', 'business', 1200, 'cj_like', 'default', 1, 8, 'saif_seed'),
(101, 'Street Civilian', 'street', 1000, 'cj_like', 'default', 1, 9, 'saif_seed'),
(170, 'Biker Style', 'street', 1300, 'cj_like', 'default', 1, 10, 'saif_seed'),
(240, 'Smart Casual', 'civilian', 1100, 'cj_like', 'default', 1, 11, 'saif_seed'),
(250, 'Mechanic Style', 'work', 1000, 'cj_like', 'default', 1, 12, 'saif_seed')
ON DUPLICATE KEY UPDATE
    display_name = VALUES(display_name),
    category = VALUES(category),
    movement_profile = VALUES(movement_profile),
    anim_profile = VALUES(anim_profile),
    source_tag = VALUES(source_tag);
