CREATE DATABASE IF NOT EXISTS lsif_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE lsif_db;

CREATE TABLE IF NOT EXISTS players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(24) NOT NULL UNIQUE,
    password_hash VARCHAR(128) NOT NULL,

    money INT NOT NULL DEFAULT 500,
    xp INT NOT NULL DEFAULT 0,
    level INT NOT NULL DEFAULT 1,
    admin_level TINYINT NOT NULL DEFAULT 0,
    skin INT NOT NULL DEFAULT 0,

    current_job TINYINT NOT NULL DEFAULT 0,

    pos_x FLOAT NOT NULL DEFAULT 1958.3783,
    pos_y FLOAT NOT NULL DEFAULT 1343.1572,
    pos_z FLOAT NOT NULL DEFAULT 15.3746,
    pos_a FLOAT NOT NULL DEFAULT 269.1425,

    last_ip VARCHAR(45) DEFAULT NULL,
    last_login DATETIME DEFAULT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS player_vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL UNIQUE,
    model_id INT NOT NULL,
    color1 INT NOT NULL DEFAULT 1,
    color2 INT NOT NULL DEFAULT 1,

    pos_x FLOAT NOT NULL DEFAULT 1958.3783,
    pos_y FLOAT NOT NULL DEFAULT 1343.1572,
    pos_z FLOAT NOT NULL DEFAULT 15.3746,
    pos_a FLOAT NOT NULL DEFAULT 269.1425,

    health FLOAT NOT NULL DEFAULT 1000,
    locked TINYINT NOT NULL DEFAULT 0,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_owner_id (owner_id)
);

CREATE TABLE IF NOT EXISTS admin_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    admin_id INT NULL,
    admin_name VARCHAR(24) NOT NULL,
    target_id INT NULL,
    target_name VARCHAR(24) NULL,
    action VARCHAR(64) NOT NULL,
    detail TEXT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS bans (
    id INT AUTO_INCREMENT PRIMARY KEY,

    player_id INT NULL,
    player_name VARCHAR(24) NOT NULL,
    ip_address VARCHAR(45) NULL,

    admin_id INT NULL,
    admin_name VARCHAR(24) NOT NULL,

    reason VARCHAR(128) NOT NULL,
    duration_minutes INT NOT NULL DEFAULT 0,
    expires_at DATETIME NULL,

    active TINYINT NOT NULL DEFAULT 1,

    unbanned_by_id INT NULL,
    unbanned_by_name VARCHAR(24) NULL,
    unbanned_at DATETIME NULL,
    unban_reason VARCHAR(128) NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_player_name (player_name),
    INDEX idx_ip_address (ip_address),
    INDEX idx_active (active),
    INDEX idx_expires_at (expires_at)
);

CREATE TABLE IF NOT EXISTS reports (
    id INT AUTO_INCREMENT PRIMARY KEY,

    reporter_id INT NULL,
    reporter_name VARCHAR(24) NOT NULL,

    target_id INT NULL,
    target_name VARCHAR(24) NOT NULL,

    reason VARCHAR(255) NOT NULL,
    status VARCHAR(16) NOT NULL DEFAULT 'open',

    handled_by_id INT NULL,
    handled_by_name VARCHAR(24) NULL,
    close_note VARCHAR(255) NULL,
    closed_at DATETIME NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_status (status),
    INDEX idx_reporter_id (reporter_id),
    INDEX idx_target_id (target_id),
    INDEX idx_created_at (created_at)
);

CREATE TABLE IF NOT EXISTS race_records (
    id INT AUTO_INCREMENT PRIMARY KEY,

    player_id INT NOT NULL,
    race_code VARCHAR(32) NOT NULL,

    best_time_ms INT NOT NULL,
    total_finishes INT NOT NULL DEFAULT 1,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE KEY unique_player_race (player_id, race_code),
    INDEX idx_race_code (race_code),
    INDEX idx_best_time_ms (best_time_ms)
);

CREATE TABLE IF NOT EXISTS job_stats (
    id INT AUTO_INCREMENT PRIMARY KEY,

    player_id INT NOT NULL,
    job_code VARCHAR(32) NOT NULL,

    total_completed INT NOT NULL DEFAULT 0,
    total_earned INT NOT NULL DEFAULT 0,
    total_xp INT NOT NULL DEFAULT 0,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE KEY unique_player_job (player_id, job_code),
    INDEX idx_job_code (job_code),
    INDEX idx_total_earned (total_earned),
    INDEX idx_total_completed (total_completed)
);

ALTER TABLE players
ADD COLUMN bank_money INT NOT NULL DEFAULT 0
AFTER money;

ALTER TABLE players
ADD COLUMN spawn_house TINYINT NOT NULL DEFAULT 0
AFTER current_job;

CREATE TABLE IF NOT EXISTS player_houses (
    id INT AUTO_INCREMENT PRIMARY KEY,

    owner_id INT NOT NULL UNIQUE,
    house_index INT NOT NULL,
    house_name VARCHAR(64) NOT NULL,
    price INT NOT NULL,

    pos_x FLOAT NOT NULL,
    pos_y FLOAT NOT NULL,
    pos_z FLOAT NOT NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_owner_id (owner_id),
    INDEX idx_house_index (house_index)
);

ALTER TABLE player_houses
ADD COLUMN locked TINYINT NOT NULL DEFAULT 1
AFTER price;

CREATE TABLE IF NOT EXISTS organizations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL UNIQUE,
    owner_id INT NOT NULL,
    owner_name VARCHAR(24) NOT NULL,
    bank_money INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_owner_id (owner_id)
);

CREATE TABLE IF NOT EXISTS organization_members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    org_id INT NOT NULL,
    player_id INT NOT NULL UNIQUE,
    player_name VARCHAR(24) NOT NULL,
    rank_level TINYINT NOT NULL DEFAULT 1,
    joined_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_org_id (org_id),
    INDEX idx_player_id (player_id)
);

CREATE TABLE IF NOT EXISTS player_businesses (
    id INT AUTO_INCREMENT PRIMARY KEY,

    owner_id INT NOT NULL UNIQUE,
    business_index INT NOT NULL,
    business_name VARCHAR(64) NOT NULL,
    price INT NOT NULL,
    income_per_minute INT NOT NULL,

    pos_x FLOAT NOT NULL,
    pos_y FLOAT NOT NULL,
    pos_z FLOAT NOT NULL,

    last_collected DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_owner_id (owner_id),
    INDEX idx_business_index (business_index)
);

ALTER TABLE player_businesses
ADD COLUMN business_level INT NOT NULL DEFAULT 1
AFTER income_per_minute;

ALTER TABLE player_businesses
ADD COLUMN total_collected INT NOT NULL DEFAULT 0
AFTER business_level;

ALTER TABLE player_vehicles
ADD COLUMN slot INT NOT NULL DEFAULT 1
AFTER owner_id;

ALTER TABLE player_vehicles
DROP INDEX owner_id;

ALTER TABLE player_vehicles
ADD UNIQUE KEY unique_owner_slot (owner_id, slot);

ALTER TABLE player_vehicles
ADD COLUMN vehicle_name VARCHAR(32) NOT NULL DEFAULT 'Vehicle'
AFTER model_id;

ALTER TABLE player_vehicles
ADD COLUMN fuel INT NOT NULL DEFAULT 100
AFTER health;

CREATE TABLE IF NOT EXISTS beta_whitelist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(24) NOT NULL UNIQUE,
    added_by VARCHAR(24) NOT NULL DEFAULT 'SYSTEM',
    note VARCHAR(128) NULL,
    active TINYINT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_username (username),
    INDEX idx_active (active)
);

ALTER TABLE players
ADD COLUMN starter_pack_claimed TINYINT NOT NULL DEFAULT 0
AFTER spawn_house;

CREATE TABLE IF NOT EXISTS feedback_reports (
    id INT AUTO_INCREMENT PRIMARY KEY,

    reporter_id INT NOT NULL,
    reporter_name VARCHAR(24) NOT NULL,

    type VARCHAR(16) NOT NULL,
    message VARCHAR(255) NOT NULL,
    status VARCHAR(16) NOT NULL DEFAULT 'open',

    handled_by_id INT NULL,
    handled_by_name VARCHAR(24) NULL,
    close_note VARCHAR(128) NULL,
    closed_at DATETIME NULL,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_reporter_id (reporter_id),
    INDEX idx_type (type),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
);

ALTER TABLE players
ADD COLUMN starter_pack_claimed TINYINT NOT NULL DEFAULT 0
AFTER spawn_house;

-- LSIF Dev v0.19B - Weapon License & Saved Loadout

ALTER TABLE players
ADD COLUMN IF NOT EXISTS weapon_license TINYINT NOT NULL DEFAULT 1
AFTER starter_pack_claimed;

-- Closed beta default: existing players get basic weapon license active.
UPDATE players
SET weapon_license = 1
WHERE weapon_license IS NULL OR weapon_license = 0;

CREATE TABLE IF NOT EXISTS player_weapons (
    id INT AUTO_INCREMENT PRIMARY KEY,

    player_id INT NOT NULL,
    weapon_id INT NOT NULL,
    weapon_name VARCHAR(32) NOT NULL,
    ammo INT NOT NULL DEFAULT 0,
    total_purchased INT NOT NULL DEFAULT 0,

    last_purchased_at DATETIME NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE KEY unique_player_weapon (player_id, weapon_id),
    INDEX idx_player_id (player_id),
    INDEX idx_weapon_id (weapon_id)
);

ALTER TABLE organizations
ADD COLUMN IF NOT EXISTS gang_color INT NOT NULL DEFAULT -1
AFTER bank_money;

CREATE TABLE IF NOT EXISTS gang_territories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    territory_index INT NOT NULL UNIQUE,
    territory_name VARCHAR(64) NOT NULL,
    owner_org_id INT NOT NULL DEFAULT 0,
    owner_org_name VARCHAR(64) NOT NULL DEFAULT 'Neutral',
    owner_color INT NOT NULL DEFAULT -1431655681,

    center_x FLOAT NOT NULL,
    center_y FLOAT NOT NULL,
    center_z FLOAT NOT NULL,
    radius FLOAT NOT NULL DEFAULT 100,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_owner_org_id (owner_org_id),
    INDEX idx_territory_index (territory_index)
);

-- LSIF v0.20A.2 — Predefined Offline-like Gang HQ Join System
-- Organization tetap player-made untuk ekonomi/bisnis/job.
-- Gang adalah faction preset offline-like: tidak bisa dibuat, dihapus, atau diubah warnanya oleh player.

CREATE TABLE IF NOT EXISTS gangs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL UNIQUE,
    leader_id INT NOT NULL DEFAULT 0,
    leader_name VARCHAR(24) NOT NULL DEFAULT 'SYSTEM',
    gang_color INT NOT NULL DEFAULT -1,
    bank_money INT NOT NULL DEFAULT 0,
    reputation INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_leader_id (leader_id)
);

CREATE TABLE IF NOT EXISTS gang_members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    gang_id INT NOT NULL,
    player_id INT NOT NULL UNIQUE,
    player_name VARCHAR(24) NOT NULL,
    rank_level TINYINT NOT NULL DEFAULT 1,
    joined_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_gang_id (gang_id),
    INDEX idx_player_id (player_id)
);

CREATE TABLE IF NOT EXISTS gang_territories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    territory_index INT NOT NULL UNIQUE,
    territory_name VARCHAR(64) NOT NULL,
    owner_gang_id INT NOT NULL DEFAULT 0,
    owner_gang_name VARCHAR(64) NOT NULL DEFAULT 'Neutral',
    owner_color INT NOT NULL DEFAULT -1431655681,

    center_x FLOAT NOT NULL,
    center_y FLOAT NOT NULL,
    center_z FLOAT NOT NULL,
    radius FLOAT NOT NULL DEFAULT 100,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_owner_gang_id (owner_gang_id),
    INDEX idx_territory_index (territory_index)
);

ALTER TABLE gang_territories
ADD COLUMN IF NOT EXISTS owner_gang_id INT NOT NULL DEFAULT 0 AFTER territory_name;

ALTER TABLE gang_territories
ADD COLUMN IF NOT EXISTS owner_gang_name VARCHAR(64) NOT NULL DEFAULT 'Neutral' AFTER owner_gang_id;

ALTER TABLE gang_territories
ADD COLUMN IF NOT EXISTS owner_color INT NOT NULL DEFAULT -1431655681 AFTER owner_gang_name;

CREATE INDEX IF NOT EXISTS idx_owner_gang_id ON gang_territories (owner_gang_id);

-- Seed gang preset offline-like. ID dibuat fixed agar script bisa menganggap 1-4 sebagai gang resmi LS.
INSERT INTO gangs
    (id, name, leader_id, leader_name, gang_color, bank_money, reputation)
VALUES
    (1, 'Grove Street Families', 0, 'SYSTEM', 16711935, 0, 0),
    (2, 'Ballas', 0, 'SYSTEM', -1436103425, 0, 0),
    (3, 'Los Santos Vagos', 0, 'SYSTEM', -65281, 0, 0),
    (4, 'Varrios Los Aztecas', 0, 'SYSTEM', 16777215, 0, 0)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    leader_id = 0,
    leader_name = 'SYSTEM',
    gang_color = VALUES(gang_color),
    updated_at = NOW();

-- Seed / refresh territory dasar.
INSERT INTO gang_territories
    (territory_index, territory_name, owner_gang_id, owner_gang_name, owner_color, center_x, center_y, center_z, radius)
VALUES
    (1, 'Ganton Block', 0, 'Neutral', -1431655681, 2229.3215, -1159.7343, 25.7331, 110),
    (2, 'Idlewood District', 0, 'Neutral', -1431655681, 1833.8134, -1842.4136, 13.5781, 120),
    (3, 'Market Strip', 0, 'Neutral', -1431655681, 1368.9248, -1279.6914, 13.5469, 100),
    (4, 'East Los Santos', 0, 'Neutral', -1431655681, 2421.5427, -1224.3597, 25.3828, 110),
    (5, 'Vinewood Hills', 0, 'Neutral', -1431655681, 1000.5822, -919.9146, 42.3281, 120),
    (6, 'Pershing Square', 0, 'Neutral', -1431655681, 1554.8425, -1675.6542, 16.1953, 90)
ON DUPLICATE KEY UPDATE
    territory_name = VALUES(territory_name),
    center_x = VALUES(center_x),
    center_y = VALUES(center_y),
    center_z = VALUES(center_z),
    radius = VALUES(radius);

-- Bersihkan owner territory dari gang custom prototype lama jika ada.
UPDATE gang_territories
SET owner_gang_id = 0,
    owner_gang_name = 'Neutral',
    owner_color = -1431655681,
    updated_at = NOW()
WHERE owner_gang_id NOT IN (0, 1, 2, 3, 4);

-- Opsional: custom gang lama tidak dihapus otomatis agar tidak menghilangkan data tanpa sengaja.
-- Script v0.20A.2 hanya menampilkan/mengizinkan gang ID 1-4 sebagai gang resmi.

CREATE TABLE IF NOT EXISTS world_locations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    location_key VARCHAR(64) NOT NULL,
    location_type VARCHAR(24) NOT NULL,
    display_name VARCHAR(64) NOT NULL,

    pos_x FLOAT NOT NULL,
    pos_y FLOAT NOT NULL,
    pos_z FLOAT NOT NULL,
    pos_a FLOAT NOT NULL DEFAULT 0,

    interior INT NOT NULL DEFAULT 0,
    virtual_world INT NOT NULL DEFAULT 0,

    map_icon INT NOT NULL DEFAULT 51,
    pickup_model INT NOT NULL DEFAULT 1239,
    label_text VARCHAR(96) NULL,
    interaction_radius FLOAT NOT NULL DEFAULT 3.0,

    enabled TINYINT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_location_type (location_type),
    INDEX idx_enabled (enabled),
    INDEX idx_location_key (location_key)
);

ALTER TABLE world_locations
ADD COLUMN IF NOT EXISTS object_model INT NOT NULL DEFAULT 0
AFTER pickup_model;

-- v0.21A.1 uses pickup_model for scripted pickup markers and object_model for non-disappearing visual objects.
-- Existing dynamic locations can optionally be given a visual object:
-- UPDATE world_locations SET object_model = 1239 WHERE object_model = 0 AND enabled = 1;

CREATE TABLE IF NOT EXISTS world_objects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    object_name VARCHAR(64) NOT NULL DEFAULT 'Object',
    model_id INT NOT NULL,

    pos_x FLOAT NOT NULL,
    pos_y FLOAT NOT NULL,
    pos_z FLOAT NOT NULL,

    rot_x FLOAT NOT NULL DEFAULT 0,
    rot_y FLOAT NOT NULL DEFAULT 0,
    rot_z FLOAT NOT NULL DEFAULT 0,

    interior INT NOT NULL DEFAULT 0,
    virtual_world INT NOT NULL DEFAULT 0,
    enabled TINYINT NOT NULL DEFAULT 1,

    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_model_id (model_id),
    INDEX idx_enabled (enabled),
    INDEX idx_world_interior (virtual_world, interior)
);

ALTER TABLE world_locations
ADD COLUMN IF NOT EXISTS linked_object_id INT NOT NULL DEFAULT 0
AFTER object_model;

CREATE INDEX IF NOT EXISTS idx_world_locations_linked_object_id
ON world_locations (linked_object_id);

ALTER TABLE gang_territories
ADD COLUMN IF NOT EXISTS min_x FLOAT NOT NULL DEFAULT 0 AFTER radius,
ADD COLUMN IF NOT EXISTS min_y FLOAT NOT NULL DEFAULT 0 AFTER min_x,
ADD COLUMN IF NOT EXISTS max_x FLOAT NOT NULL DEFAULT 0 AFTER min_y,
ADD COLUMN IF NOT EXISTS max_y FLOAT NOT NULL DEFAULT 0 AFTER max_x,
ADD COLUMN IF NOT EXISTS enabled TINYINT NOT NULL DEFAULT 1 AFTER max_y;

UPDATE gang_territories
SET
    min_x = center_x - radius,
    min_y = center_y - radius,
    max_x = center_x + radius,
    max_y = center_y + radius,
    enabled = 1
WHERE min_x = 0 AND min_y = 0 AND max_x = 0 AND max_y = 0;

-- Optional sanity check
SELECT territory_index, territory_name, owner_gang_name, min_x, min_y, max_x, max_y, enabled
FROM gang_territories
ORDER BY territory_index ASC;


-- SAIF / LSIF Dev v0.22B — Turf War History & Gang Stats

CREATE TABLE IF NOT EXISTS turf_war_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    territory_index INT NOT NULL,
    territory_name VARCHAR(64) NOT NULL,
    attacker_gang_id INT NOT NULL DEFAULT 0,
    attacker_gang_name VARCHAR(64) NOT NULL DEFAULT 'Neutral',
    defender_gang_id INT NOT NULL DEFAULT 0,
    defender_gang_name VARCHAR(64) NOT NULL DEFAULT 'Neutral',
    result VARCHAR(24) NOT NULL,
    detail VARCHAR(255) NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_territory_index (territory_index),
    INDEX idx_attacker_gang_id (attacker_gang_id),
    INDEX idx_defender_gang_id (defender_gang_id),
    INDEX idx_result (result),
    INDEX idx_created_at (created_at)
);

CREATE TABLE IF NOT EXISTS gang_member_stats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    gang_id INT NOT NULL,
    player_id INT NOT NULL,
    player_name VARCHAR(24) NOT NULL,
    respect INT NOT NULL DEFAULT 0,
    captures INT NOT NULL DEFAULT 0,
    defends INT NOT NULL DEFAULT 0,
    wars_participated INT NOT NULL DEFAULT 0,
    last_activity_at DATETIME NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE KEY unique_gang_player (gang_id, player_id),
    INDEX idx_gang_id (gang_id),
    INDEX idx_player_id (player_id),
    INDEX idx_respect (respect)
);

INSERT INTO gang_member_stats (gang_id, player_id, player_name)
SELECT gm.gang_id, gm.player_id, gm.player_name
FROM gang_members gm
LEFT JOIN gang_member_stats gs ON gs.gang_id = gm.gang_id AND gs.player_id = gm.player_id
WHERE gs.id IS NULL;


CREATE TABLE IF NOT EXISTS server_settings (
    setting_key VARCHAR(64) NOT NULL PRIMARY KEY,
    setting_value VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO server_settings (setting_key, setting_value) VALUES
('turf_hold_seconds', '5'),
('turf_capture_seconds', '180'),
('turf_grace_seconds', '30'),
('turf_cooldown_seconds', '900')
ON DUPLICATE KEY UPDATE setting_value = setting_value;

-- SAIF / LSIF Dev v0.22E — Gang Weapon Stash & HQ Utility
-- Jalankan di database lsif_db sebelum compile/deploy v0.22E.

CREATE TABLE IF NOT EXISTS gang_weapon_stash (
    id INT AUTO_INCREMENT PRIMARY KEY,
    gang_id INT NOT NULL,
    weapon_id INT NOT NULL,
    weapon_name VARCHAR(32) NOT NULL,
    ammo INT NOT NULL DEFAULT 0,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_gang_weapon (gang_id, weapon_id),
    KEY idx_gang_id (gang_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS gang_weapon_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    gang_id INT NOT NULL,
    player_id INT NOT NULL,
    player_name VARCHAR(24) NOT NULL,
    action VARCHAR(24) NOT NULL,
    weapon_id INT NOT NULL,
    weapon_name VARCHAR(32) NOT NULL,
    ammo INT NOT NULL DEFAULT 0,
    cost INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    KEY idx_gang_id (gang_id),
    KEY idx_player_id (player_id),
    KEY idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Optional starter stock untuk beta test.
-- Hapus/ubah sesuai kebutuhan balance.
INSERT INTO gang_weapon_stash (gang_id, weapon_id, weapon_name, ammo) VALUES
(1, 22, 'Colt 45', 300),
(1, 25, 'Shotgun', 120),
(2, 22, 'Colt 45', 300),
(2, 28, 'Micro SMG', 300),
(3, 22, 'Colt 45', 300),
(3, 29, 'MP5', 240),
(4, 22, 'Colt 45', 300),
(4, 23, 'Silenced Pistol', 180)
ON DUPLICATE KEY UPDATE weapon_name=VALUES(weapon_name);
