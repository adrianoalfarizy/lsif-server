-- SAIF / LSIF Dev v0.26A.1.2
-- Ammu-Nation Offline Catalog UX
-- Scope: archive current weapon_shop_config then upsert offline-style GTA SA Ammu-Nation defaults.

CREATE TABLE IF NOT EXISTS weapon_shop_config_archive_v0_26A_1_2 AS
SELECT * FROM weapon_shop_config WHERE 1 = 0;

INSERT INTO weapon_shop_config_archive_v0_26A_1_2
SELECT * FROM weapon_shop_config;

INSERT INTO weapon_shop_config (weapon_id, weapon_name, price, ammo_per_purchase, enabled)
VALUES
    (22, '9mm', 200, 68, 1),
    (23, 'Silenced 9mm', 600, 68, 1),
    (24, 'Desert Eagle', 1200, 35, 1),
    (25, 'Shotgun', 600, 24, 1),
    (26, 'Sawnoff Shotgun', 800, 24, 1),
    (27, 'Combat Shotgun', 1000, 24, 1),
    (28, 'Micro SMG', 500, 150, 1),
    (29, 'SMG', 2000, 150, 1),
    (32, 'Tec-9', 300, 150, 1),
    (30, 'AK-47', 3500, 120, 1),
    (31, 'M4', 4500, 120, 1),
    (33, 'Country Rifle', 1000, 30, 1),
    (34, 'Sniper Rifle', 5000, 20, 1),
    (16, 'Grenade', 300, 5, 1),
    (39, 'Satchel Charge', 2000, 5, 1),
    (1000, 'Body Armor', 200, 100, 1)
ON DUPLICATE KEY UPDATE
    weapon_name = VALUES(weapon_name),
    price = VALUES(price),
    ammo_per_purchase = VALUES(ammo_per_purchase),
    enabled = VALUES(enabled),
    updated_at = CURRENT_TIMESTAMP;
