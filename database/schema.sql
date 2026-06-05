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

-- SAIF / LSIF Dev v0.22F — Gang HQ Interior & Shared Utility
-- Jalankan / gabungkan ke database/schema.sql sebelum deploy.

CREATE TABLE IF NOT EXISTS gang_hq_interiors (
    gang_id INT NOT NULL PRIMARY KEY,
    gang_name VARCHAR(64) NOT NULL,
    interior_id INT NOT NULL DEFAULT 3,
    virtual_world INT NOT NULL DEFAULT 0,
    int_x FLOAT NOT NULL DEFAULT 2496.0498,
    int_y FLOAT NOT NULL DEFAULT -1695.2382,
    int_z FLOAT NOT NULL DEFAULT 1014.7422,
    int_a FLOAT NOT NULL DEFAULT 180.0000,
    exit_x FLOAT NOT NULL DEFAULT 0,
    exit_y FLOAT NOT NULL DEFAULT 0,
    exit_z FLOAT NOT NULL DEFAULT 0,
    exit_a FLOAT NOT NULL DEFAULT 0,
    enabled TINYINT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO gang_hq_interiors
(gang_id, gang_name, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
VALUES
(1, 'Grove Street Families', 3, 42001, 2496.0498, -1695.2382, 1014.7422, 180.0000, 2495.4094, -1686.1682, 13.5153, 0.0000, 1),
(2, 'Ballas', 3, 42002, 2496.0498, -1695.2382, 1014.7422, 180.0000, 2229.3215, -1159.7343, 25.7331, 0.0000, 1),
(3, 'Los Santos Vagos', 3, 42003, 2496.0498, -1695.2382, 1014.7422, 180.0000, 2421.5427, -1224.3597, 25.3828, 0.0000, 1),
(4, 'Varrios Los Aztecas', 3, 42004, 2496.0498, -1695.2382, 1014.7422, 180.0000, 1766.6000, -1918.3000, 13.5600, 0.0000, 1)
ON DUPLICATE KEY UPDATE
    gang_name = VALUES(gang_name),
    updated_at = NOW();


-- SAIF / LSIF Dev v0.23A — Dynamic Parked Vehicle System

CREATE TABLE IF NOT EXISTS parked_vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    modelid INT NOT NULL,
    color1 INT NOT NULL DEFAULT 1,
    color2 INT NOT NULL DEFAULT 1,
    pos_x FLOAT NOT NULL,
    pos_y FLOAT NOT NULL,
    pos_z FLOAT NOT NULL,
    pos_a FLOAT NOT NULL DEFAULT 0,
    interior INT NOT NULL DEFAULT 0,
    virtual_world INT NOT NULL DEFAULT 0,
    respawn_delay INT NOT NULL DEFAULT 300,
    locked TINYINT NOT NULL DEFAULT 0,
    enabled TINYINT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_parked_enabled (enabled),
    INDEX idx_parked_model (modelid)
);

-- SAIF / LSIF Dev v0.23E — Offline Pickup System
-- Jalankan sekali, atau masukkan ke database/schema.sql.

CREATE TABLE IF NOT EXISTS world_pickups (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pickup_type VARCHAR(32) NOT NULL,
    display_name VARCHAR(64) NOT NULL DEFAULT '',
    model_id INT NOT NULL DEFAULT 1239,
    pos_x FLOAT NOT NULL DEFAULT 0,
    pos_y FLOAT NOT NULL DEFAULT 0,
    pos_z FLOAT NOT NULL DEFAULT 0,
    interior INT NOT NULL DEFAULT 0,
    virtual_world INT NOT NULL DEFAULT 0,
    amount INT NOT NULL DEFAULT 1,
    cooldown_seconds INT NOT NULL DEFAULT 60,
    source_tag VARCHAR(64) NOT NULL DEFAULT 'manual',
    enabled TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_world_pickups_enabled (enabled),
    INDEX idx_world_pickups_type (pickup_type),
    INDEX idx_world_pickups_source (source_tag)
);

-- Type yang dipakai v0.23E:
-- bribe  = police bribe / wanted-star pickup, default model 1247, amount = wanted level reduction
-- health = health pickup, default model 1240, amount = health add
-- armor  = armor pickup, default model 1242, amount = armor add
-- hidden = hidden/world pickup, default model 1274, amount = cash reward

-- Catatan roadmap:
-- source_tag disiapkan untuk bulk seed/importer offline-like nanti.
-- Contoh source_tag: 'manual', 'offline_ls_bribe_seed', 'offline_health_seed', 'offline_hidden_seed'.

-- SAIF / LSIF Dev v0.23E.1 — Offline Pickup Template Seeder
-- Optional seed SQL. Tidak wajib dijalankan kalau memakai /wpickupseed in-game.
-- Script ini refresh seed dengan source_tag='offline_template_ls'.

UPDATE world_pickups SET enabled=0 WHERE source_tag='offline_template_ls';

INSERT INTO world_pickups
(pickup_type, display_name, model_id, pos_x, pos_y, pos_z, interior, virtual_world, amount, cooldown_seconds, source_tag, enabled)
VALUES
('bribe', 'LS Bribe - LSPD Alley', 1247, 1566.20, -1695.10, 5.90, 0, 0, 1, 180, 'offline_template_ls', 1),
('bribe', 'LS Bribe - Pershing Square', 1247, 1484.30, -1744.60, 13.55, 0, 0, 1, 180, 'offline_template_ls', 1),
('bribe', 'LS Bribe - Unity Station', 1247, 1815.60, -1893.80, 13.58, 0, 0, 1, 180, 'offline_template_ls', 1),
('bribe', 'LS Bribe - Jefferson Backstreet', 1247, 2182.40, -1161.70, 23.82, 0, 0, 1, 180, 'offline_template_ls', 1),
('bribe', 'LS Bribe - Ocean Docks', 1247, 2574.30, -2218.50, 13.54, 0, 0, 1, 180, 'offline_template_ls', 1),
('bribe', 'LS Bribe - Market Alley', 1247, 1114.50, -1494.80, 15.79, 0, 0, 1, 180, 'offline_template_ls', 1),
('bribe', 'LS Bribe - Santa Maria Beach', 1247, 367.50, -2048.70, 7.83, 0, 0, 1, 180, 'offline_template_ls', 1),
('bribe', 'LS Bribe - LS Airport Lot', 1247, 1952.20, -2182.40, 13.55, 0, 0, 1, 180, 'offline_template_ls', 1),
('health', 'LS Health - County General', 1240, 1176.70, -1323.80, 14.07, 0, 0, 35, 120, 'offline_template_ls', 1),
('health', 'LS Health - Jefferson Hospital', 1240, 2034.20, -1403.40, 17.25, 0, 0, 35, 120, 'offline_template_ls', 1),
('health', 'LS Health - Grove Street', 1240, 2495.30, -1687.90, 13.52, 0, 0, 35, 120, 'offline_template_ls', 1),
('health', 'LS Health - Idlewood', 1240, 1957.40, -1714.20, 15.97, 0, 0, 35, 120, 'offline_template_ls', 1),
('health', 'LS Health - Santa Maria', 1240, 332.80, -1809.40, 4.47, 0, 0, 35, 120, 'offline_template_ls', 1),
('health', 'LS Health - East Beach', 1240, 2737.80, -1765.30, 44.67, 0, 0, 35, 120, 'offline_template_ls', 1),
('armor', 'LS Armor - LSPD Garage', 1242, 1548.60, -1632.20, 13.38, 0, 0, 50, 240, 'offline_template_ls', 1),
('armor', 'LS Armor - Grove Backyard', 1242, 2522.40, -1679.60, 15.50, 0, 0, 50, 240, 'offline_template_ls', 1),
('armor', 'LS Armor - Ocean Docks Warehouse', 1242, 2465.80, -2117.40, 13.55, 0, 0, 50, 240, 'offline_template_ls', 1),
('armor', 'LS Armor - East Los Santos', 1242, 2385.70, -1281.40, 25.13, 0, 0, 50, 240, 'offline_template_ls', 1),
('armor', 'LS Armor - Verdant Bluffs', 1242, 1335.50, -631.80, 109.13, 0, 0, 50, 240, 'offline_template_ls', 1),
('hidden', 'LS Hidden - Vinewood Sign Trail', 1274, 1382.90, -806.10, 86.12, 0, 0, 500, 300, 'offline_template_ls', 1),
('hidden', 'LS Hidden - Mulholland Overlook', 1274, 1263.30, -781.20, 92.03, 0, 0, 500, 300, 'offline_template_ls', 1),
('hidden', 'LS Hidden - Verona Beach Pier', 1274, 850.20, -2067.30, 12.86, 0, 0, 500, 300, 'offline_template_ls', 1),
('hidden', 'LS Hidden - Airport Service Road', 1274, 1701.30, -2347.80, 13.55, 0, 0, 500, 300, 'offline_template_ls', 1),
('hidden', 'LS Hidden - LS Docks Crane', 1274, 2773.90, -2455.30, 13.63, 0, 0, 500, 300, 'offline_template_ls', 1),
('hidden', 'LS Hidden - Downtown Rooftop', 1274, 1407.30, -1367.50, 34.50, 0, 0, 500, 300, 'offline_template_ls', 1);

-- Command in-game yang tersedia pada patch v0.23E.1:
-- /wpickupseed       = refresh seed lewat server
-- /wpickupclearseed  = nonaktifkan seed source_tag offline_template_ls
-- /wpickupseedinfo   = cek jumlah seed aktif per type

CREATE TABLE IF NOT EXISTS public_interiors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    interior_type VARCHAR(32) NOT NULL,
    display_name VARCHAR(64) NOT NULL,
    exterior_x FLOAT NOT NULL,
    exterior_y FLOAT NOT NULL,
    exterior_z FLOAT NOT NULL,
    exterior_a FLOAT NOT NULL DEFAULT 0,
    exterior_interior INT NOT NULL DEFAULT 0,
    exterior_virtual_world INT NOT NULL DEFAULT 0,
    interior_id INT NOT NULL DEFAULT 0,
    interior_virtual_world INT NOT NULL DEFAULT 0,
    interior_x FLOAT NOT NULL,
    interior_y FLOAT NOT NULL,
    interior_z FLOAT NOT NULL,
    interior_a FLOAT NOT NULL DEFAULT 0,
    exit_x FLOAT NOT NULL,
    exit_y FLOAT NOT NULL,
    exit_z FLOAT NOT NULL,
    source_tag VARCHAR(64) NOT NULL DEFAULT 'manual',
    enabled TINYINT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_public_interiors_enabled (enabled),
    INDEX idx_public_interiors_type (interior_type),
    INDEX idx_public_interiors_source (source_tag)
);

-- SAIF / LSIF Dev v0.23F.1 — Public Interior Template Fix
-- Fix existing public_interiors rows created by v0.23F so they use safer SA-MP interior-id + coordinate pairs.
-- This keeps exterior positions, names, shared virtual worlds, and enabled state unchanged.

UPDATE public_interiors SET interior_id=1,  interior_x=286.1489,  interior_y=-40.6443,   interior_z=1001.5156, interior_a=90.0,  exit_x=286.1489,  exit_y=-38.8443,   exit_z=1001.5156 WHERE interior_type='ammunation';
UPDATE public_interiors SET interior_id=17, interior_x=-25.8845,  interior_y=-185.8690,  interior_z=1003.5469, interior_a=0.0,   exit_x=-25.8845,  exit_y=-184.0690,  exit_z=1003.5469 WHERE interior_type='247';
UPDATE public_interiors SET interior_id=10, interior_x=363.1348,  interior_y=-74.8465,   interior_z=1001.5078, interior_a=315.0, exit_x=363.1348,  exit_y=-73.0465,   exit_z=1001.5078 WHERE interior_type='burgershot';
UPDATE public_interiors SET interior_id=9,  interior_x=364.9583,  interior_y=-11.7446,   interior_z=1001.8516, interior_a=0.0,   exit_x=364.9583,  exit_y=-9.9446,    exit_z=1001.8516 WHERE interior_type='cluckinbell';
UPDATE public_interiors SET interior_id=5,  interior_x=372.3520,  interior_y=-133.5247,  interior_z=1001.4922, interior_a=0.0,   exit_x=372.3520,  exit_y=-131.7247,  exit_z=1001.4922 WHERE interior_type='pizzastack';
UPDATE public_interiors SET interior_id=5,  interior_x=772.1119,  interior_y=-3.8986,    interior_z=1000.7288, interior_a=90.0,  exit_x=772.1119,  exit_y=-2.0986,    exit_z=1000.7288 WHERE interior_type='gym';
UPDATE public_interiors SET interior_id=2,  interior_x=411.6260,  interior_y=-21.4333,   interior_z=1001.8047, interior_a=0.0,   exit_x=411.6260,  exit_y=-19.6333,   exit_z=1001.8047 WHERE interior_type='barber';
UPDATE public_interiors SET interior_id=16, interior_x=-204.4399, interior_y=-26.4539,   interior_z=1002.2734, interior_a=0.0,   exit_x=-204.4399, exit_y=-24.6539,   exit_z=1002.2734 WHERE interior_type='tattoo';
UPDATE public_interiors SET interior_id=6,  interior_x=246.7839,  interior_y=63.9001,    interior_z=1003.6406, interior_a=0.0,   exit_x=246.7839,  exit_y=65.7001,    exit_z=1003.6406 WHERE interior_type='police';
UPDATE public_interiors SET interior_id=3,  interior_x=390.7699,  interior_y=173.8040,   interior_z=1008.3828, interior_a=0.0,   exit_x=390.7699,  exit_y=175.6040,   exit_z=1008.3828 WHERE interior_type='hospital';
UPDATE public_interiors SET interior_id=3,  interior_x=386.5259,  interior_y=173.6381,   interior_z=1008.3828, interior_a=0.0,   exit_x=386.5259,  exit_y=175.4381,   exit_z=1008.3828 WHERE interior_type='cityhall';
UPDATE public_interiors SET interior_id=1,  interior_x=2233.9360, interior_y=1711.8038,  interior_z=1011.6312, interior_a=180.0, exit_x=2233.9360, exit_y=1713.6038,  exit_z=1011.6312 WHERE interior_type='casino';

-- SAIF / LSIF Dev v0.23F.3 — Public Interior Checkpoint Interaction Fix
-- Moves player spawn a little away from the exit door so the exit arrow can sit closer to the door.
-- Service interaction checkpoint is generated by gamemode based on interior_type, no new DB columns required.

UPDATE public_interiors SET interior_x=288.3489,  interior_y=-40.6443,   interior_z=1001.5156, exit_x=286.1489,  exit_y=-40.6443,   exit_z=1001.5156 WHERE interior_type='ammunation';
UPDATE public_interiors SET interior_x=-25.8845,  interior_y=-183.6690,  interior_z=1003.5469, exit_x=-25.8845,  exit_y=-185.8690,  exit_z=1003.5469 WHERE interior_type='247';
UPDATE public_interiors SET interior_x=363.1348,  interior_y=-72.6465,   interior_z=1001.5078, exit_x=363.1348,  exit_y=-74.8465,   exit_z=1001.5078 WHERE interior_type='burgershot';
UPDATE public_interiors SET interior_x=364.9583,  interior_y=-9.5446,    interior_z=1001.8516, exit_x=364.9583,  exit_y=-11.7446,   exit_z=1001.8516 WHERE interior_type='cluckinbell';
UPDATE public_interiors SET interior_x=372.3520,  interior_y=-131.3247,  interior_z=1001.4922, exit_x=372.3520,  exit_y=-133.5247,  exit_z=1001.4922 WHERE interior_type='pizzastack';
UPDATE public_interiors SET interior_x=774.3119,  interior_y=-3.8986,    interior_z=1000.7288, exit_x=772.1119,  exit_y=-3.8986,    exit_z=1000.7288 WHERE interior_type='gym';
UPDATE public_interiors SET interior_x=411.6260,  interior_y=-19.2333,   interior_z=1001.8047, exit_x=411.6260,  exit_y=-21.4333,   exit_z=1001.8047 WHERE interior_type='barber';
UPDATE public_interiors SET interior_x=-204.4399, interior_y=-24.2539,   interior_z=1002.2734, exit_x=-204.4399, exit_y=-26.4539,   exit_z=1002.2734 WHERE interior_type='tattoo';
UPDATE public_interiors SET interior_x=246.7839,  interior_y=66.1001,    interior_z=1003.6406, exit_x=246.7839,  exit_y=63.9001,    exit_z=1003.6406 WHERE interior_type='police';
UPDATE public_interiors SET interior_x=390.7699,  interior_y=176.0040,   interior_z=1008.3828, exit_x=390.7699,  exit_y=173.8040,   exit_z=1008.3828 WHERE interior_type='hospital';
UPDATE public_interiors SET interior_x=386.5259,  interior_y=175.8381,   interior_z=1008.3828, exit_x=386.5259,  exit_y=173.6381,   exit_z=1008.3828 WHERE interior_type='cityhall';
UPDATE public_interiors SET interior_x=2233.9360, interior_y=1709.6038,  interior_z=1011.6312, exit_x=2233.9360, exit_y=1711.8038,  exit_z=1011.6312 WHERE interior_type='casino';

-- SAIF / LSIF Dev v0.24A — Offline Parked Vehicle Template Seeder
-- Required schema patch for /parkvehseed, /parkvehclearseed, /parkvehseedinfo.

ALTER TABLE parked_vehicles
ADD COLUMN IF NOT EXISTS source_tag VARCHAR(64) NOT NULL DEFAULT 'manual' AFTER enabled;

UPDATE parked_vehicles
SET source_tag = 'manual'
WHERE source_tag IS NULL OR source_tag = '';

-- Optional helper index. If your MariaDB version rejects this, skip it; the feature still works.
CREATE INDEX IF NOT EXISTS idx_parked_source_tag ON parked_vehicles (source_tag);

ALTER TABLE players
    ADD COLUMN IF NOT EXISTS pos_interior INT NOT NULL DEFAULT 0 AFTER pos_a,
    ADD COLUMN IF NOT EXISTS pos_virtual_world INT NOT NULL DEFAULT 0 AFTER pos_interior;

-- SAIF / LSIF Dev v0.24B — Exact Offline Parked Vehicle Importer
-- Purpose:
-- 1) Keep v0.24A curated seed intact.
-- 2) Add DB staging table for exact/offline extracted parked vehicle data.
-- 3) Import rows into parked_vehicles in-game with /parkvehimportdb.

ALTER TABLE parked_vehicles
ADD COLUMN IF NOT EXISTS source_tag VARCHAR(64) NOT NULL DEFAULT 'manual';

CREATE TABLE IF NOT EXISTS parked_vehicle_import_queue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    batch_name VARCHAR(64) NOT NULL DEFAULT 'offline_exact_ls',
    source_tag VARCHAR(64) NOT NULL DEFAULT 'offline_exact_ls',
    modelid INT NOT NULL,
    color1 INT NOT NULL DEFAULT 1,
    color2 INT NOT NULL DEFAULT 1,
    pos_x FLOAT NOT NULL,
    pos_y FLOAT NOT NULL,
    pos_z FLOAT NOT NULL,
    pos_a FLOAT NOT NULL DEFAULT 0,
    interior INT NOT NULL DEFAULT 0,
    virtual_world INT NOT NULL DEFAULT 0,
    respawn_delay INT NOT NULL DEFAULT 300,
    locked TINYINT NOT NULL DEFAULT 0,
    enabled TINYINT NOT NULL DEFAULT 1,
    note VARCHAR(128) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_parked_vehicle_import_queue_source_enabled
ON parked_vehicle_import_queue (source_tag, enabled);

CREATE INDEX IF NOT EXISTS idx_parked_vehicles_source_tag
ON parked_vehicles (source_tag);

-- SAMPLE ONLY. Do not run as final exact data unless you want sample rows.
-- Exact workflow:
-- 1. Extract/decompile offline parked vehicle generator data from your legal GTA SA copy.
-- 2. Convert rows to INSERT INTO parked_vehicle_import_queue with source_tag='offline_exact_ls'.
-- 3. Import in-game using /parkvehimportdb.
--
-- Example row format:
-- INSERT INTO parked_vehicle_import_queue
-- (batch_name, source_tag, modelid, color1, color2, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, respawn_delay, locked, enabled, note)
-- VALUES
-- ('offline_exact_ls', 'offline_exact_ls', 420, 6, 1, 1777.52, -1905.11, 13.23, 270.0, 0, 0, 300, 0, 1, 'sample taxi stand');

-- SAIF / LSIF v0.24B Exact Offline Parked Vehicle Queue - Safe Land Only
-- Generated from uploaded main.scm by extracting literal 014B / 09E2 parked car generator opcodes.
-- Candidate rows included: 132
-- Run only one queue SQL option at a time. This file uses source_tag='offline_exact_ls'.

UPDATE parked_vehicle_import_queue SET enabled=0 WHERE source_tag='offline_exact_ls';

INSERT INTO parked_vehicle_import_queue
(batch_name, source_tag, modelid, color1, color2, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, respawn_delay, locked, enabled, note)
VALUES
('offline_exact_ls','offline_exact_ls',463,-1,-1,1174.759644,1364.831909,10.1203,280.035492,0,0,300,0,1,'SCM literal 014B offset 201916, Freeway, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',521,-1,-1,1174.998779,1366.478516,10.1203,282.2258,0,0,300,0,1,'SCM literal 014B offset 201959, FCR-900, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',522,-1,-1,1174.467041,1368.358521,10.1203,283.054596,0,0,300,0,1,'SCM literal 014B offset 202002, NRG-500, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',556,-1,-1,2692.028564,-1674.024292,9.4656,178.827896,0,0,300,0,1,'SCM literal 014B offset 215198, Monster A, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',494,-1,-1,2676.695312,-1673.756104,9.4038,178.827896,0,0,300,0,1,'SCM literal 014B offset 215255, Hotring Racer, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',424,-1,-1,1104.932251,1614.807617,12.5546,85.643501,0,0,300,0,1,'SCM literal 014B offset 215312, BF Injection, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',468,-1,-1,-1460.869873,-1566.736816,101.057899,2,0,0,300,0,1,'SCM literal 014B offset 215369, Sanchez, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',478,-1,-1,-1446.239014,-1494.731445,101.051399,6,0,0,300,0,1,'SCM literal 014B offset 215426, Walton, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',531,-1,-1,-1439.642822,-1576.822998,101.0578,264.118286,0,0,300,0,1,'SCM literal 014B offset 215483, Tractor, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',481,-1,-1,2412.52002,-1326.48999,23.74,177.919998,0,0,300,0,1,'SCM literal 014B offset 215658, BMX, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',542,-1,-1,2445.5,-1340.800049,23.5,180,0,0,300,0,1,'SCM literal 014B offset 215715, Clover, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',481,-1,-1,2499.179932,-1648.26001,13,158.610001,0,0,300,0,1,'SCM literal 014B offset 215765, BMX, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',567,-1,-1,2685.980713,-2016.209717,12.5501,0.337,0,0,300,0,1,'SCM literal 014B offset 215815, Savanna, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',536,-1,-1,1772.095947,-2125.102783,13.0469,0.3441,0,0,300,0,1,'SCM literal 014B offset 215865, Blade, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',468,-1,-1,-2048.855957,-2521.275635,31.125,171.023193,0,0,300,0,1,'SCM literal 014B offset 215915, Sanchez, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',558,-1,-1,-1956.300049,297.700012,34.299999,64.800003,0,0,300,0,1,'SCM literal 014B offset 215965, Uranus, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',562,-1,-1,-1952.599976,265.700012,39.900002,292.799988,0,0,300,0,1,'SCM literal 014B offset 216008, Elegy, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',560,-1,-1,-1957.699951,277,34.299999,133.399994,0,0,300,0,1,'SCM literal 014B offset 216051, Sultan, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',567,-1,-1,-1952.800049,258.799988,39.900002,259.100006,0,0,300,0,1,'SCM literal 014B offset 216094, Savanna, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',561,-1,-1,-1950.5,259.700012,34.299999,53.799999,0,0,300,0,1,'SCM literal 014B offset 216137, Stratum, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',544,-1,-1,-2057,58,28,90,0,0,300,0,1,'SCM literal 014B offset 216432, Firetruck Ladder, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',407,-1,-1,-2057,64,28,90,0,0,300,0,1,'SCM literal 014B offset 216482, Firetruck, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',407,-1,-1,1763.824463,2075.756592,9.9093,179.475296,0,0,300,0,1,'SCM literal 014B offset 216532, Firetruck, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',407,-1,-1,1751.511719,-1455.101562,12.5547,263.558899,0,0,300,0,1,'SCM literal 014B offset 216582, Firetruck, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',416,-1,-1,2033.887939,-1432.6698,16.6453,177.828995,0,0,300,0,1,'SCM literal 014B offset 216632, Ambulance, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',416,-1,-1,1178.047729,-1338.175415,13.405,269.49231,0,0,300,0,1,'SCM literal 014B offset 216682, Ambulance, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',416,-1,-1,-303.781403,1032.325562,19.086,268.501587,0,0,300,0,1,'SCM literal 014B offset 216732, Ambulance, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',416,-1,-1,-1507.164185,2525.455322,55.1875,358.572815,0,0,300,0,1,'SCM literal 014B offset 216782, Ambulance, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',416,-1,-1,1229.664795,297.688293,19.054701,154.955307,0,0,300,0,1,'SCM literal 014B offset 216832, Ambulance, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',416,-1,-1,-2202.519531,-2315.985596,30.117201,319.681488,0,0,300,0,1,'SCM literal 014B offset 216882, Ambulance, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',402,-1,-1,886.378174,-25.667101,63.243999,157.621201,0,0,300,0,1,'SCM literal 014B offset 216932, Buffalo, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',406,-1,-1,687.373291,890.669983,-40.428501,35.139999,0,0,300,0,1,'SCM literal 014B offset 217026, Dumper, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',486,-1,-1,620.882019,861.245178,-43.9534,298.742798,0,0,300,0,1,'SCM literal 014B offset 217076, Dozer, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',468,-1,-1,623.34021,887.094421,-43.5625,347.296692,0,0,300,0,1,'SCM literal 014B offset 217126, Sanchez, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',468,-1,-1,-2486.045654,59.183998,24.8284,180,0,0,300,0,1,'SCM literal 014B offset 217176, Sanchez, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',492,-1,-1,2216.902344,-1160.403442,24.7265,270.8013,0,0,300,0,1,'SCM literal 014B offset 217446, Greenwood, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',492,-1,-1,2216.902344,-1160.403442,24.7265,270.8013,0,0,300,0,1,'SCM literal 014B offset 217489, Greenwood, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',481,-1,-1,2229.001465,-1173.79834,24.733101,90.5569,0,0,300,0,1,'SCM literal 014B offset 217532, BMX, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',609,-1,-1,2251.028076,-1788.661011,12.7625,358.959106,0,0,300,0,1,'SCM literal 014B offset 217575, Boxburg, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',609,-1,-1,-2118.170654,-4.0948,35.020302,270.141998,0,0,300,0,1,'SCM literal 014B offset 217625, Boxburg, original_delay=0, alarm=0, door=0');

INSERT INTO parked_vehicle_import_queue
(batch_name, source_tag, modelid, color1, color2, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, respawn_delay, locked, enabled, note)
VALUES
('offline_exact_ls','offline_exact_ls',609,-1,-1,2596.74707,1444.245239,10.3203,178.271194,0,0,300,0,1,'SCM literal 014B offset 217675, Boxburg, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',545,83,1,2408.15625,-1719.463013,13.6665,0.5881,0,0,300,1,1,'SCM literal 014B offset 217725, Hustler, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',557,-1,-1,-1778.177734,1207.074463,25.1194,91.935699,0,0,300,1,1,'SCM literal 014B offset 217768, Monster B, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',599,-1,-1,-1399.717407,2628.589844,55.782299,271.794098,0,0,300,1,1,'SCM literal 014B offset 217811, Police Ranger, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',568,-1,-1,-379.5,-1443.115356,25.726601,88.9244,0,0,300,1,1,'SCM literal 014B offset 217854, Bandito, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',442,1,1,-2572.039795,1148.564453,55.733299,337.843414,0,0,300,1,1,'SCM literal 014B offset 217897, Romero, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',589,126,1,2028.445923,2731.102051,10.53,268.993988,0,0,300,1,1,'SCM literal 014B offset 217940, Club, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',402,-1,-1,-1673.939941,439.019989,7.01,136,0,0,300,1,1,'SCM literal 014B offset 218427, Buffalo, original_delay=0, alarm=70, door=40'),
('offline_exact_ls','offline_exact_ls',405,-1,-1,926.450012,-1292.290039,13.6,270,0,0,300,1,1,'SCM literal 014B offset 218470, Sentinel, original_delay=0, alarm=60, door=30'),
('offline_exact_ls','offline_exact_ls',411,-1,-1,-2665.439941,990.77002,64.449997,51,0,0,300,1,1,'SCM literal 014B offset 218513, Infernus, original_delay=0, alarm=80, door=50'),
('offline_exact_ls','offline_exact_ls',483,-1,-1,-2516.5979,1228.919189,36.428299,211.5,0,0,300,1,1,'SCM literal 014B offset 218556, Camper, original_delay=0, alarm=30, door=10'),
('offline_exact_ls','offline_exact_ls',445,-1,-1,1122.290039,-1699.76001,13.43,270,0,0,300,1,1,'SCM literal 014B offset 218599, Admiral, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',470,-1,-1,-1006.409973,-628.27002,32,270,0,0,300,1,1,'SCM literal 014B offset 218642, Patriot, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',468,-1,-1,-2085.22998,-2437.52002,30.309999,142,0,0,300,1,1,'SCM literal 014B offset 218685, Sanchez, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',409,-1,-1,-1922.189941,288.339996,40.84,180,0,0,300,1,1,'SCM literal 014B offset 218728, Stretch, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',533,-1,-1,-16.66,-2521.169922,36.369999,210,0,0,300,1,1,'SCM literal 014B offset 218771, Feltzer, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',534,-1,-1,1803.380005,-1931.050049,13.66,0,0,0,300,1,1,'SCM literal 014B offset 218814, Remington, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',415,-1,-1,1272.23999,2603.030029,10.49,117,0,0,300,1,1,'SCM literal 014B offset 218857, Cheetah, original_delay=0, alarm=90, door=30'),
('offline_exact_ls','offline_exact_ls',489,-1,-1,-112.400002,-41.82,3.26,160,0,0,300,1,1,'SCM literal 014B offset 218900, Rancher, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',439,-1,-1,-2456.100098,741.650024,34.919998,180,0,0,300,1,1,'SCM literal 014B offset 218943, Stallion, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',514,-1,-1,-1951.810059,2393.830078,50.080002,292,0,0,300,1,1,'SCM literal 014B offset 218986, Tanker, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',480,-1,-1,-2751.790039,-281.5,6.81,0,0,0,300,1,1,'SCM literal 014B offset 219029, Comet, original_delay=0, alarm=90, door=40'),
('offline_exact_ls','offline_exact_ls',535,-1,-1,1923.930054,-2118.889893,13.35,0,0,0,300,1,1,'SCM literal 014B offset 219072, Slamvan, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',496,-1,-1,-1675.939941,-618.73999,13.86,256,0,0,300,1,1,'SCM literal 014B offset 219115, Blista Compact, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',580,-1,-1,-2430.219971,320.839996,34.970001,245,0,0,300,1,1,'SCM literal 014B offset 219158, Stafford, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',475,-1,-1,-2265.330078,200.649994,34.970001,270,0,0,300,1,1,'SCM literal 014B offset 219201, Sabre, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',521,-1,-1,2282.699951,2535.879883,10.39,180,0,0,300,1,1,'SCM literal 014B offset 219244, FCR-900, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',429,-1,-1,2133.040039,1009.75,10.49,270,0,0,300,1,1,'SCM literal 014B offset 219287, Banshee, original_delay=0, alarm=90, door=50'),
('offline_exact_ls','offline_exact_ls',506,-1,-1,2229.300049,1402.98999,10.82,180,0,0,300,1,1,'SCM literal 014B offset 219330, Super GT, original_delay=0, alarm=90, door=50'),
('offline_exact_ls','offline_exact_ls',508,-1,-1,-1550.400024,2687.540039,56.220001,90,0,0,300,1,1,'SCM literal 014B offset 219373, Journey, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',579,-1,-1,-2068.689941,-83.75,35.099998,0,0,0,300,1,1,'SCM literal 014B offset 219416, Huntley, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',424,-1,-1,682.169983,-1867.459961,4.82,180,0,0,300,1,1,'SCM literal 014B offset 219459, BF Injection, original_delay=0, alarm=70, door=10'),
('offline_exact_ls','offline_exact_ls',536,-1,-1,1747.869995,-2098.030029,13.28,180,0,0,300,1,1,'SCM literal 014B offset 219502, Blade, original_delay=0, alarm=80, door=10'),
('offline_exact_ls','offline_exact_ls',463,-1,-1,1144.459961,-1101.26001,25.35,300,0,0,300,1,1,'SCM literal 014B offset 219545, Freeway, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',500,-1,-1,-2406.25,-2180.840088,33.389999,180,0,0,300,1,1,'SCM literal 014B offset 219588, Mesa, original_delay=0, alarm=70, door=10'),
('offline_exact_ls','offline_exact_ls',477,-1,-1,2163.790039,1810.22998,10.58,180,0,0,300,1,1,'SCM literal 014B offset 219631, ZR-350, original_delay=0, alarm=80, door=10'),
('offline_exact_ls','offline_exact_ls',587,-1,-1,2207.429932,1286.130005,10.57,180,0,0,300,1,1,'SCM literal 014B offset 219674, Euros, original_delay=0, alarm=50, door=10'),
('offline_exact_ls','offline_exact_ls',532,-1,-1,-540.044128,-1396.146729,15,0,0,0,300,1,1,'SCM literal 014B offset 219927, Combine Harvester, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',532,-1,-1,-289.551697,-1389.627319,10,0,0,0,300,1,1,'SCM literal 014B offset 219970, Combine Harvester, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',532,-1,-1,-192.899994,-1331.306763,21.5,0,0,0,300,1,1,'SCM literal 014B offset 220013, Combine Harvester, original_delay=0, alarm=0, door=100');

INSERT INTO parked_vehicle_import_queue
(batch_name, source_tag, modelid, color1, color2, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, respawn_delay, locked, enabled, note)
VALUES
('offline_exact_ls','offline_exact_ls',531,-1,-1,-273.962891,-1507.596069,5,0,0,0,300,1,1,'SCM literal 014B offset 220056, Tractor, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',531,-1,-1,-395.19519,-1293.189697,30.799999,0,0,0,300,1,1,'SCM literal 014B offset 220099, Tractor, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',531,-1,-1,-186.649399,-1339.2146,6,0,0,0,300,1,1,'SCM literal 014B offset 220142, Tractor, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',532,-1,-1,-1030.248901,-1050.18811,129,0,0,0,300,1,1,'SCM literal 014B offset 220185, Combine Harvester, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',532,-1,-1,-1169.425171,-989.63092,129,0,0,0,300,1,1,'SCM literal 014B offset 220228, Combine Harvester, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',531,-1,-1,-1110.789795,-947.79248,129,0,0,0,300,1,1,'SCM literal 014B offset 220271, Tractor, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',532,-1,-1,16.876801,49.991001,3,0,0,0,300,1,1,'SCM literal 014B offset 220314, Combine Harvester, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',532,-1,-1,81.051003,3.3203,1.5,0,0,0,300,1,1,'SCM literal 014B offset 220357, Combine Harvester, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',532,-1,-1,-15.2986,-84.653297,3,0,0,0,300,1,1,'SCM literal 014B offset 220400, Combine Harvester, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',531,-1,-1,81.053299,3.3234,1.5,0,0,0,300,1,1,'SCM literal 014B offset 220443, Tractor, original_delay=0, alarm=0, door=100'),
('offline_exact_ls','offline_exact_ls',506,31,0,-2093.899902,-83.699997,33.900002,359.100006,0,0,300,0,1,'SCM literal 014B offset 269871, Super GT, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',541,15,15,-2076.800049,-84,33.700001,1.1,0,0,300,0,1,'SCM literal 014B offset 269921, Bullet, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',504,-1,-1,-2151,-409.100006,34.099998,307.200012,0,0,300,0,1,'SCM literal 014B offset 270151, Bloodring Banger, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',457,-1,-1,927.721313,-1185.04187,16.5,123.305496,0,0,300,0,1,'SCM literal 014B offset 272401, Caddy, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',457,-1,-1,927.523315,-1182.365112,16.5,123.305496,0,0,300,0,1,'SCM literal 014B offset 272444, Caddy, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',457,-1,-1,926.917908,-1178.949951,16.5,123.305496,0,0,300,0,1,'SCM literal 014B offset 272487, Caddy, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',457,-1,-1,861.353516,-1240.758911,14.5,180.130798,0,0,300,0,1,'SCM literal 014B offset 272530, Caddy, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',508,-1,-1,837.74939,-1206.573608,16.5,153.263199,0,0,300,0,1,'SCM literal 014B offset 272573, Journey, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',508,-1,-1,897.516785,-1207.991211,16.5,86.5989,0,0,300,0,1,'SCM literal 014B offset 272616, Journey, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',508,-1,-1,736.239807,-1334.19519,13.5411,267.810913,0,0,300,0,1,'SCM literal 014B offset 272659, Journey, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',508,-1,-1,736.96228,-1343.90686,13.5197,273.772095,0,0,300,0,1,'SCM literal 014B offset 272702, Journey, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',468,-1,-1,-2408.510986,-2186.023926,32.889999,321.691986,0,0,300,0,1,'SCM literal 014B offset 272905, Sanchez, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',510,-1,-1,-2407.605713,-2177.092041,32.889999,321.691986,0,0,300,0,1,'SCM literal 014B offset 272948, Mountain Bike, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',508,-1,-1,-2338.56543,-1593.832886,482.945099,20.750999,0,0,300,0,1,'SCM literal 014B offset 272991, Journey, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',483,-1,-1,-2343.370361,-1613.942993,482.975708,105.529999,0,0,300,0,1,'SCM literal 014B offset 273034, Camper, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,-2213.555908,112.767097,34.9203,88.472,0,0,300,0,1,'SCM literal 014B offset 273105, Kart, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,-2693.385986,-139.456406,3.93359,90.085602,0,0,300,0,1,'SCM literal 014B offset 273148, Kart, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,-2796.467529,-94.178802,6.9875,42.6945,0,0,300,0,1,'SCM literal 014B offset 273191, Kart, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,-2206.050781,701.216125,48.945301,183.417404,0,0,300,0,1,'SCM literal 014B offset 273234, Kart, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,-810.559875,2430.362793,156.964905,336.53299,0,0,300,0,1,'SCM literal 014B offset 273277, Kart, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,-1693.441284,432.285187,6.9914,300.903015,0,0,300,0,1,'SCM literal 014B offset 273320, Kart, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,-2116.138428,924.806824,85.979103,94.929298,0,0,300,0,1,'SCM literal 014B offset 273363, Kart, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,-1483.689941,2614.835449,58.2812,337.938293,0,0,300,0,1,'SCM literal 014B offset 273406, Kart, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,1419.698364,1947.995972,10.9531,6.9689,0,0,300,0,1,'SCM literal 014B offset 273449, Kart, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,1567.389038,2691.118408,10.265,279.987488,0,0,300,0,1,'SCM literal 014B offset 273492, Kart, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,-2087.366699,-2519.015869,29.924999,90.917801,0,0,300,0,1,'SCM literal 014B offset 273535, Kart, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,2615.317139,1939.700684,10.129,148.175705,0,0,300,0,1,'SCM literal 014B offset 273578, Kart, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,1074.963989,1395.417725,5.303,36.7673,0,0,300,0,1,'SCM literal 014B offset 273621, Kart, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,2615.23877,-1731.225342,5.9486,140.821304,0,0,300,0,1,'SCM literal 014B offset 273664, Kart, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',571,-1,-1,1305.175781,-796.695496,83.947701,185.991135,0,0,300,0,1,'SCM literal 014B offset 273707, Kart, original_delay=0, alarm=0, door=0');

INSERT INTO parked_vehicle_import_queue
(batch_name, source_tag, modelid, color1, color2, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, respawn_delay, locked, enabled, note)
VALUES
('offline_exact_ls','offline_exact_ls',539,-1,-1,-2294.926025,2546.978271,5.9175,290.933899,0,0,300,0,1,'SCM literal 014B offset 273855, Vortex, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',539,-1,-1,714.343628,-1488.272705,0.9343,270,0,0,300,0,1,'SCM literal 014B offset 273898, Vortex, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',539,-1,-1,-1426.411987,506.839111,2.9463,144.610001,0,0,300,0,1,'SCM literal 014B offset 273941, Vortex, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',539,-1,-1,1971.919678,1560.665283,10.9635,262.61499,0,0,300,0,1,'SCM literal 014B offset 273984, Vortex, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',539,-1,-1,-535.412598,-60.888401,63.592201,276.975586,0,0,300,0,1,'SCM literal 014B offset 274027, Vortex, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',539,-1,-1,-910.27002,2699.060059,42.799999,110.873802,0,0,300,0,1,'SCM literal 014B offset 274070, Vortex, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',461,-1,-1,435.275085,2527.522705,16.371,90,0,0,300,0,1,'SCM literal 014B offset 274205, PCJ-600, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',573,-1,-1,1091.890015,1612.630005,13,206.758301,0,0,300,0,1,'SCM literal 014B offset 274262, Dune, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',412,-1,-1,1772.660034,-2096.590088,13.99,182.758301,0,0,300,0,1,'SCM literal 014B offset 274312, Voodoo, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',515,-1,-1,-2000.241943,-2415.509033,29.767,-132,0,0,300,0,1,'SCM literal 014B offset 274509, Roadtrain, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',578,-1,-1,-1969.80603,-2437.938965,29.767,-82.5,0,0,300,0,1,'SCM literal 014B offset 274552, DFT-30, original_delay=0, alarm=0, door=0'),
('offline_exact_ls','offline_exact_ls',530,-1,-1,-1969.80603,-2443.907959,29.767,-19,0,0,300,0,1,'SCM literal 014B offset 274595, Forklift, original_delay=0, alarm=0, door=0');

-- SAIF / LSIF Dev v0.24C — Offline Source Cleanup & Curated Template Disable
-- Purpose: disable inaccurate self-made curated templates and make exact offline-source import the default workflow.

UPDATE parked_vehicles
SET enabled = 0
WHERE source_tag = 'offline_template_ls';

UPDATE world_pickups
SET enabled = 0
WHERE source_tag = 'offline_template_ls';

-- Manual rows and exact imported rows are intentionally preserved.
-- Manual source_tag is usually manual/empty. Exact parked vehicle import uses offline_exact_ls.

-- SAIF / LSIF v0.24D - SCM exact world pickup import queue SAFE EXTERIOR
-- Source: uploaded main.scm direct opcode 0213 constant weapon pickup candidates
-- This safe file excludes z>=200 interior/high-altitude candidates because interior id is not reliable from binary-only scan.

CREATE TABLE IF NOT EXISTS world_pickup_import_queue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pickup_type VARCHAR(32) NOT NULL DEFAULT 'weapon',
    display_name VARCHAR(64) NOT NULL,
    model_id INT NOT NULL,
    pos_x FLOAT NOT NULL,
    pos_y FLOAT NOT NULL,
    pos_z FLOAT NOT NULL,
    interior INT NOT NULL DEFAULT 0,
    virtual_world INT NOT NULL DEFAULT 0,
    amount INT NOT NULL DEFAULT 30,
    cooldown_seconds INT NOT NULL DEFAULT 300,
    source_tag VARCHAR(64) NOT NULL DEFAULT 'offline_exact_scm',
    enabled TINYINT NOT NULL DEFAULT 1,
    imported_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    KEY idx_source_tag (source_tag),
    KEY idx_enabled (enabled)
);

UPDATE world_pickup_import_queue SET enabled=0 WHERE source_tag='offline_exact_scm';

INSERT INTO world_pickup_import_queue (pickup_type, display_name, model_id, pos_x, pos_y, pos_z, interior, virtual_world, amount, cooldown_seconds, source_tag, enabled) VALUES
('weapon','SCM Weapon - Molotov',344,-366.2235,-1429.0878,25.5000,0,0,3,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Chainsaw',341,-365.7906,-1425.2526,25.5000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Pool Cue',338,2854.0000,944.0000,11.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Nightstick',334,2241.0000,2425.0000,11.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Golf Club',333,1418.0000,2774.0000,15.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Shovel',337,1393.0000,2174.0000,10.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Chainsaw',341,1061.0000,2074.0000,11.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Parachute',371,2057.0000,2434.0000,166.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Katana',339,2000.0000,1526.0000,15.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Shovel',337,1997.0000,1658.0000,12.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Golf Club',333,1457.0000,-792.0000,90.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Chainsaw',341,2371.0000,-2543.0000,3.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Knife',335,1124.0000,-1335.0000,13.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Katana',339,1862.0000,-1862.0000,14.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Brass Knuckles',331,1339.0000,-1765.0000,14.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Chainsaw',341,2192.2429,-1988.7507,13.4185,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Shovel',337,2459.0000,-1708.0000,13.6000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Chainsaw',341,-2083.0000,298.0000,42.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Baseball Bat',336,-2306.0000,93.0000,35.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Shovel',337,-2796.4155,123.6860,6.8440,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Pool Cue',338,-2135.0000,197.0000,35.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Katana',339,-2208.0000,696.0000,50.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Brass Knuckles',331,-2206.0000,961.0000,80.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Nightstick',334,-2222.0000,-302.0000,43.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Knife',335,-1871.0000,351.0000,26.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Golf Club',333,-2715.0000,-314.0000,7.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Chainsaw',341,-2359.0000,-82.0000,35.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Shovel',337,-532.0000,-106.0000,63.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Shovel',337,-1809.0000,-1662.0000,24.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Golf Club',333,-2227.0000,-2401.0000,31.4000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Shovel',337,2240.0000,-83.0000,27.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Pool Cue',338,294.0000,-188.0000,2.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Chainsaw',341,-761.0000,-126.0000,66.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Katana',339,-1568.0000,2718.0000,56.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Gift Weapon 11',322,-2401.0000,2360.0000,5.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Shovel',337,637.0000,832.0000,-43.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Chainsaw',341,680.0000,826.0000,-39.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Chainsaw',341,752.0000,260.0000,27.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Brass Knuckles',331,-246.0000,2725.0000,63.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Knife',335,-23.0000,2322.0000,24.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Parachute',371,-1542.8567,698.4825,139.2658,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Parachute',371,-225.6758,1394.2562,172.0143,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Parachute',371,-773.0379,2423.4993,157.0856,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Shovel',337,842.9783,-17.3791,64.2000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,-2677.7261,-192.3469,6.8518,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Chainsaw',341,-2752.2429,-272.2891,6.5956,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,-2617.4731,-97.0801,4.0030,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,-2777.1921,-25.2984,6.8721,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,-2774.1130,87.8845,6.7987,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,-2770.6235,389.0772,4.2818,0,0,1,300,'offline_exact_scm',1);

INSERT INTO world_pickup_import_queue (pickup_type, display_name, model_id, pos_x, pos_y, pos_z, interior, virtual_world, amount, cooldown_seconds, source_tag, enabled) VALUES
('weapon','SCM Weapon - Katana',339,-2535.6311,51.7034,8.6512,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,-2530.9580,-34.1009,25.2855,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,-1691.6486,946.7679,24.8084,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,-2664.5183,636.5673,14.2474,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,-377.2184,-1048.0535,58.9125,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,-45.5928,-1148.5286,1.3953,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Brass Knuckles',331,2428.4990,-1679.2703,13.1633,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,1296.1552,-1081.8922,26.1502,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,1390.6113,-800.4332,81.7795,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Baseball Bat',336,1308.4662,2111.2886,10.7221,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,2183.1160,2396.8269,10.7722,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Baseball Bat',336,1081.1333,1603.6969,5.6000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Knife',335,777.8668,1948.1228,5.3634,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Shovel',337,1888.2698,2877.2617,10.1621,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,1420.9449,2519.8816,10.6199,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,1372.9963,2605.7576,10.8776,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Katana',339,2631.2629,1722.3947,11.0312,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,2490.4966,1522.4697,10.5760,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Cane',326,455.4583,-1485.8964,30.9717,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Katana',339,2002.2629,981.3947,10.5000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,1928.6801,-1774.2100,13.5400,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,1875.9100,-1917.1801,15.0300,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,2019.6000,-1214.1500,21.4700,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,2209.7700,-1001.6900,63.7100,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,1000.3400,-1858.5800,12.3000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,911.1100,-1120.3101,24.0300,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,929.0000,-750.0000,105.8200,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,1129.0900,-2052.8201,69.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-92.7400,-1425.4600,12.7500,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-77.6500,-1167.1801,2.1600,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,34.0000,-2649.0000,40.7300,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-739.0000,-1262.0000,68.1200,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-2177.0000,-2423.0000,30.6300,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-615.0000,-861.0000,105.7200,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-2051.0000,948.0000,55.4000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-2658.0000,-187.0000,4.1800,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-2649.0000,734.9700,27.9600,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-1791.0000,481.0000,25.6800,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-2797.0000,1182.0000,20.2800,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-2589.6233,-16.1650,3.9662,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-2865.0000,690.0000,23.4300,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-2339.0000,-453.0000,80.2400,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-1955.0000,-748.0000,36.2200,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-2420.0300,987.5900,45.3000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-326.5600,2215.3701,43.5700,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-1319.0000,2705.0000,50.2700,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-2474.9399,2443.5200,16.0300,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-1670.6400,2590.4900,81.3700,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,-892.9800,1971.6600,60.6100,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,1576.8600,2837.1399,10.8300,0,0,1,300,'offline_exact_scm',1);

INSERT INTO world_pickup_import_queue (pickup_type, display_name, model_id, pos_x, pos_y, pos_z, interior, virtual_world, amount, cooldown_seconds, source_tag, enabled) VALUES
('weapon','SCM Weapon - Flowers',325,1492.7200,2773.7600,10.8100,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,2642.0300,1125.7400,11.0300,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,2025.2400,661.6000,10.9300,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,2181.8201,1484.9700,11.3600,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,2197.0200,2476.3301,11.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,2212.0000,2526.0000,10.8100,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,2715.7900,1109.4700,6.7000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,2489.2500,918.2800,11.0200,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flowers',325,1472.0800,1890.0900,10.8100,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Nightstick',334,911.6486,-1235.3898,17.6802,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Sniper Rifle',358,733.4333,-1356.4700,23.5229,0,0,20,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Baseball Bat',336,2285.7429,-1647.3091,14.0782,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Parachute',371,1797.6023,-1308.8815,133.8128,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Knife',335,-819.0000,1929.0000,7.0000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Knife',335,-938.3901,1901.6489,4.3000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Grenade',342,2550.9670,2824.3425,10.6000,0,0,3,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Parachute',371,2267.9888,1699.6678,101.4000,0,0,1,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Rocket Launcher',359,-686.0000,934.0000,13.5000,0,0,5,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Heat Seeker',360,-690.0000,934.0000,13.5000,0,0,5,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Minigun',362,-690.0000,939.0000,13.5000,0,0,5,300,'offline_exact_scm',1),
('weapon','SCM Weapon - Flamethrower',361,-686.0000,939.0000,13.5000,0,0,5,300,'offline_exact_scm',1);

-- SAIF / LSIF Dev v0.24E — Public Interior Exact Importer
-- Offline-first / exact-source-first public interior import queue.
-- Data source target: GTA SA IPL/ENEX/map data converted into this queue.

CREATE TABLE IF NOT EXISTS public_interior_import_queue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    interior_type VARCHAR(32) NOT NULL DEFAULT 'public',
    display_name VARCHAR(64) NOT NULL DEFAULT 'Public Interior',

    exterior_x FLOAT NOT NULL DEFAULT 0,
    exterior_y FLOAT NOT NULL DEFAULT 0,
    exterior_z FLOAT NOT NULL DEFAULT 0,
    exterior_a FLOAT NOT NULL DEFAULT 0,
    exterior_interior INT NOT NULL DEFAULT 0,
    exterior_virtual_world INT NOT NULL DEFAULT 0,

    interior_id INT NOT NULL DEFAULT 0,
    interior_x FLOAT NOT NULL DEFAULT 0,
    interior_y FLOAT NOT NULL DEFAULT 0,
    interior_z FLOAT NOT NULL DEFAULT 0,
    interior_a FLOAT NOT NULL DEFAULT 0,

    exit_x FLOAT NOT NULL DEFAULT 0,
    exit_y FLOAT NOT NULL DEFAULT 0,
    exit_z FLOAT NOT NULL DEFAULT 0,

    source_file VARCHAR(128) NOT NULL DEFAULT '',
    source_ref VARCHAR(128) NOT NULL DEFAULT '',
    source_tag VARCHAR(64) NOT NULL DEFAULT 'offline_exact_public',
    enabled TINYINT NOT NULL DEFAULT 1,
    imported TINYINT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    KEY idx_pubint_import_enabled (enabled),
    KEY idx_pubint_import_source_tag (source_tag),
    KEY idx_pubint_import_type (interior_type),
    KEY idx_pubint_import_imported (imported)
);

ALTER TABLE public_interiors
    ADD COLUMN IF NOT EXISTS source_tag VARCHAR(64) NOT NULL DEFAULT 'manual';

CREATE INDEX IF NOT EXISTS idx_public_interiors_source_tag ON public_interiors (source_tag);

-- Optional sample only. Keep commented until you want to test queue import manually.
-- INSERT INTO public_interior_import_queue
-- (interior_type, display_name, exterior_x, exterior_y, exterior_z, exterior_a, exterior_interior, exterior_virtual_world, interior_id, interior_x, interior_y, interior_z, interior_a, exit_x, exit_y, exit_z, source_file, source_ref, source_tag, enabled)
-- VALUES
-- ('ammunation', 'Ammu-Nation Exact Sample', 1368.42, -1279.76, 13.55, 90.0, 0, 0, 1, 286.1489, -40.6443, 1001.5156, 90.0, 286.1489, -40.6443, 1001.5156, 'sample', 'manual_sample', 'offline_exact_public', 1);

-- SAIF v0.24E.1 IPL/ENEX exact public interior queue — Los Santos / County subset
-- Generated from uploaded GTA SA gta.dat + maps IPL ENEX data.
-- Runtime SAIF tetap pakai panah custom, shared virtual world, dan checkpoint merah.

CREATE TABLE IF NOT EXISTS public_interior_import_queue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    interior_type VARCHAR(32) NOT NULL DEFAULT 'public',
    display_name VARCHAR(64) NOT NULL DEFAULT 'Public Interior',
    exterior_x FLOAT NOT NULL DEFAULT 0,
    exterior_y FLOAT NOT NULL DEFAULT 0,
    exterior_z FLOAT NOT NULL DEFAULT 0,
    exterior_a FLOAT NOT NULL DEFAULT 0,
    exterior_interior INT NOT NULL DEFAULT 0,
    exterior_virtual_world INT NOT NULL DEFAULT 0,
    interior_id INT NOT NULL DEFAULT 0,
    interior_x FLOAT NOT NULL DEFAULT 0,
    interior_y FLOAT NOT NULL DEFAULT 0,
    interior_z FLOAT NOT NULL DEFAULT 0,
    interior_a FLOAT NOT NULL DEFAULT 0,
    exit_x FLOAT NOT NULL DEFAULT 0,
    exit_y FLOAT NOT NULL DEFAULT 0,
    exit_z FLOAT NOT NULL DEFAULT 0,
    source_file VARCHAR(128) NOT NULL DEFAULT '',
    source_ref VARCHAR(128) NOT NULL DEFAULT '',
    source_tag VARCHAR(64) NOT NULL DEFAULT 'offline_exact_public',
    enabled TINYINT NOT NULL DEFAULT 1,
    imported TINYINT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    KEY idx_pubint_import_enabled (enabled),
    KEY idx_pubint_import_source_tag (source_tag),
    KEY idx_pubint_import_type (interior_type),
    KEY idx_pubint_import_imported (imported)
);

ALTER TABLE public_interiors
    ADD COLUMN IF NOT EXISTS source_tag VARCHAR(64) NOT NULL DEFAULT 'manual';

CREATE INDEX IF NOT EXISTS idx_public_interiors_source_tag ON public_interiors (source_tag);

-- Replace previous exact public import queue rows with this extracted IPL/ENEX dataset.
DELETE FROM public_interior_import_queue WHERE source_tag = 'offline_exact_public';

INSERT INTO public_interior_import_queue
(interior_type, display_name, exterior_x, exterior_y, exterior_z, exterior_a, exterior_interior, exterior_virtual_world, interior_id, interior_x, interior_y, interior_z, interior_a, exit_x, exit_y, exit_z, source_file, source_ref, source_tag, enabled)
VALUES
('ammunation', 'Ammu-Nation (AMMUN1)', 1368.35, -1279.06, 12.55, 90, 0, 0, 1, 286.149, -40.6444, 1000.57, 354.270078, 286.149, -41.5444, 1000.57, 'maps/LA/LAn2.ipl', 'AMMUN1', 'offline_exact_public', 1),
('ammunation', 'Ammu-Nation (AMMUN2)', 242.668, -178.478, 0.621441, 90.097, 0, 0, 4, 285.801, -84.5476, 1000.54, 354.270078, 285.801, -85.4476, 1000.54, 'maps/country/countrye.ipl', 'AMMUN2', 'offline_exact_public', 1),
('ammunation', 'Ammu-Nation (AMMUN2)', 2333.43, 61.5173, 25.7342, 270, 0, 0, 4, 285.801, -84.5476, 1000.54, 354.270078, 285.801, -85.4476, 1000.54, 'maps/country/countrye.ipl', 'AMMUN2', 'offline_exact_public', 1),
('ammunation', 'Ammu-Nation (AMMUN3)', 2400.5, -1981.48, 12.5604, 0, 0, 0, 6, 296.92, -111.072, 1000.57, 354.270078, 296.92, -111.972, 1000.57, 'maps/LA/LAs2.ipl', 'AMMUN3', 'offline_exact_public', 1),
('247', '24/7 Supermarket (X7_11S)', 1352.31, -1758.3, 12.5149, 359.74, 0, 0, 6, -26.6916, -55.7149, 1002.55, 0, -26.6916, -57.8149, 1002.55, 'maps/LA/LAn.ipl', 'X7_11S', 'offline_exact_public', 1),
('247', '24/7 Supermarket (X7_11B)', 1833.54, -1843.38, 12.5595, 90, 0, 0, 18, -30.9467, -89.6096, 1002.55, 0, -30.9467, -91.7096, 1002.55, 'maps/LA/LAs.ipl', 'X7_11B', 'offline_exact_public', 1),
('247', '24/7 Supermarket (X7_11B)', 1315.49, -897.843, 38.571, 180, 0, 0, 18, -30.9467, -89.6096, 1002.55, 0, -30.9467, -91.7096, 1002.55, 'maps/LA/LaWn.ipl', 'X7_11B', 'offline_exact_public', 1),
('247', '24/7 Supermarket (X711S2)', 1000.33, -919.924, 41.2368, 97, 0, 0, 4, -27.3123, -29.2776, 1002.55, 0, -27.3123, -31.3776, 1002.55, 'maps/LA/LaWn.ipl', 'X711S2', 'offline_exact_public', 1),
('burgershot', 'Burger Shot (FDBURG)', 811.982, -1616.02, 12.618, 270.42, 0, 0, 10, 363.413, -74.5787, 1000.55, 314.7, 363.113, -74.8787, 1000.55, 'maps/LA/LAw.ipl', 'FDBURG', 'offline_exact_public', 1),
('burgershot', 'Burger Shot (FDBURG)', 1199.13, -918.071, 42.3243, 180, 0, 0, 10, 363.413, -74.5787, 1000.55, 314.7, 363.113, -74.8787, 1000.55, 'maps/LA/LaWn.ipl', 'FDBURG', 'offline_exact_public', 1),
('cluckinbell', 'Cluckin'' Bell (FDCHICK)', 2419.95, -1509.8, 23.1568, 270, 0, 0, 9, 365.673, -10.7132, 1000.87, 354.270078, 365.673, -11.6132, 1000.87, 'maps/LA/LAe2.ipl', 'FDCHICK', 'offline_exact_public', 1),
('cluckinbell', 'Cluckin'' Bell (FDCHICK)', 2397.83, -1898.65, 12.7131, 0, 0, 0, 9, 365.673, -10.7132, 1000.87, 354.270078, 365.673, -11.6132, 1000.87, 'maps/LA/LAs2.ipl', 'FDCHICK', 'offline_exact_public', 1),
('cluckinbell', 'Cluckin'' Bell (FDCHICK)', 928.525, -1352.77, 12.4344, 90, 0, 0, 9, 365.673, -10.7132, 1000.87, 354.270078, 365.673, -11.6132, 1000.87, 'maps/LA/LaWn.ipl', 'FDCHICK', 'offline_exact_public', 1),
('pizzastack', 'Pizza Stack (FDPIZA)', 1367.27, 248.388, 18.6229, 69.0975, 0, 0, 5, 372.352, -131.651, 1000.45, 354.270078, 372.352, -133.551, 1000.45, 'maps/country/countrye.ipl', 'FDPIZA', 'offline_exact_public', 1),
('pizzastack', 'Pizza Stack (FDPIZA)', 2333.43, 75.0488, 25.7342, 270, 0, 0, 5, 372.352, -131.651, 1000.45, 354.270078, 372.352, -133.551, 1000.45, 'maps/country/countrye.ipl', 'FDPIZA', 'offline_exact_public', 1),
('pizzastack', 'Pizza Stack (FDPIZA)', 203.334, -202.532, 0.600709, 180, 0, 0, 5, 372.352, -131.651, 1000.45, 354.270078, 372.352, -133.551, 1000.45, 'maps/country/countrye.ipl', 'FDPIZA', 'offline_exact_public', 1),
('pizzastack', 'Pizza Stack (FDPIZA)', 2105.32, -1806.49, 12.6941, 92, 0, 0, 5, 372.352, -131.651, 1000.45, 354.270078, 372.352, -133.551, 1000.45, 'maps/LA/LAe.ipl', 'FDPIZA', 'offline_exact_public', 1),
('gym', 'Gym (GYM1)', 2229.63, -1721.63, 12.6529, 137, 0, 0, 5, 772.112, -3.89865, 999.688, 0, 772.112, -4.99865, 999.688, 'maps/LA/LAe2.ipl', 'GYM1', 'offline_exact_public', 1),
('barber', 'Barber Shop (BARBERS)', 2070.86, -1793.84, 12.661, 270, 0, 0, 2, 411.626, -21.4333, 1000.8, 0, 411.626, -23.3333, 1000.8, 'maps/LA/LAe.ipl', 'BARBERS', 'offline_exact_public', 1),
('barber', 'Barber Shop (BARBER2)', 672.355, -496.834, 15.3751, 271.0975, 0, 0, 3, 418.653, -82.6398, 1000.96, 0, 418.653, -84.1398, 1000.96, 'maps/country/countrye.ipl', 'BARBER2', 'offline_exact_public', 1),
('barber', 'Barber Shop (BARBER2)', 823.629, -1588.9, 12.5764, 142.42, 0, 0, 3, 418.653, -82.6398, 1000.96, 0, 418.653, -84.1398, 1000.96, 'maps/LA/LAw.ipl', 'BARBER2', 'offline_exact_public', 1),
('barber', 'Barber Shop (BARBER3)', 2723.76, -2026.72, 12.5753, 90, 0, 0, 12, 412.022, -52.6499, 1000.96, 0, 412.022, -54.5499, 1000.96, 'maps/LA/LAs2.ipl', 'BARBER3', 'offline_exact_public', 1),
('tattoo', 'Tattoo Shop (TATTOO)', 2068.71, -1779.84, 12.5103, 270, 0, 0, 16, -204.44, -26.454, 1001.3, 0, -204.44, -27.154, 1001.3, 'maps/LA/LAe.ipl', 'TATTOO', 'offline_exact_public', 1),
('tattoo', 'Tattoo Shop (TATTOO)', 1975.79, -2036.65, 12.5753, 90, 0, 0, 16, -204.44, -26.454, 1001.3, 0, -204.44, -27.154, 1001.3, 'maps/LA/LAs2.ipl', 'TATTOO', 'offline_exact_public', 1),
('police', 'Police Department (POLICE1)', 627.642, -571.789, 16.907, 274.0975, 0, 0, 6, 246.784, 63.9002, 1002.64, 0, 246.784, 62.2002, 1002.64, 'maps/country/countrye.ipl', 'POLICE1', 'offline_exact_public', 1),
('police', 'Police Department (POLICE1)', 1554.95, -1674.99, 15.3283, 90, 0, 0, 6, 246.784, 63.9002, 1002.64, 0, 246.784, 62.2002, 1002.64, 'maps/LA/LAn.ipl', 'POLICE1', 'offline_exact_public', 1);

-- In-game after deploy:
-- /pubintexactinfo
-- /pubintimportdb
-- /pubintlist

-- SAIF / LSIF Dev v0.24E.2 — Public Interior Point Editor
-- Adds custom service checkpoint override columns for public interiors.

ALTER TABLE public_interiors
    ADD COLUMN IF NOT EXISTS service_x FLOAT NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS service_y FLOAT NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS service_z FLOAT NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS service_radius FLOAT NOT NULL DEFAULT 0;

-- SAIF / LSIF Dev v0.24E.3 — Public Interior Facing Editor
-- Adds facing/angle storage for public interior exit arrow and service checkpoint.
-- exterior_a and interior_a already exist and are used for exit-to-exterior and enter-to-interior facing.

ALTER TABLE public_interiors
    ADD COLUMN IF NOT EXISTS exit_a FLOAT NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS service_a FLOAT NOT NULL DEFAULT 0;

-- Backfill existing interiors so old rows have sane facing defaults.
UPDATE public_interiors
SET exit_a = interior_a
WHERE exit_a = 0;

UPDATE public_interiors
SET service_a = interior_a
WHERE service_a = 0;

CREATE TABLE IF NOT EXISTS weapon_shop_config (
    weapon_id INT NOT NULL PRIMARY KEY,
    weapon_name VARCHAR(32) NOT NULL,
    price INT NOT NULL DEFAULT 0,
    ammo_per_purchase INT NOT NULL DEFAULT 0,
    enabled TINYINT NOT NULL DEFAULT 1,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO weapon_shop_config (weapon_id, weapon_name, price, ammo_per_purchase, enabled) VALUES
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
(39, 'Satchel Charge', 2000, 5, 1)
ON DUPLICATE KEY UPDATE
    weapon_name = VALUES(weapon_name),
    price = VALUES(price),
    ammo_per_purchase = VALUES(ammo_per_purchase),
    enabled = VALUES(enabled),
    updated_at = CURRENT_TIMESTAMP;


CREATE TABLE IF NOT EXISTS public_service_config (
    id INT AUTO_INCREMENT PRIMARY KEY,
    service_type VARCHAR(32) NOT NULL,
    service_key VARCHAR(32) NOT NULL,
    display_name VARCHAR(48) NOT NULL,
    price INT NOT NULL DEFAULT 0,
    health_add FLOAT NOT NULL DEFAULT 0,
    armor_add FLOAT NOT NULL DEFAULT 0,
    xp_reward INT NOT NULL DEFAULT 0,
    wanted_reduce INT NOT NULL DEFAULT 0,
    enabled TINYINT NOT NULL DEFAULT 1,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_public_service_type_key (service_type, service_key),
    INDEX idx_public_service_type (service_type),
    INDEX idx_public_service_enabled (enabled)
);

INSERT INTO public_service_config
(service_type, service_key, display_name, price, health_add, armor_add, xp_reward, wanted_reduce, enabled, sort_order)
VALUES
('247','sprunk','Sprunk',25,5,0,0,0,1,1),
('247','snack','Snack',35,8,0,0,0,1,2),
('247','first_aid','First Aid',150,25,0,0,0,1,3),
('247','armor_vest','Armor Vest',600,0,25,0,0,1,4),
('burgershot','kids_meal','Moo Kids Meal',45,10,0,0,0,1,1),
('burgershot','beef_tower','Beef Tower',80,20,0,0,0,1,2),
('burgershot','meat_stack','Meat Stack',120,35,0,0,0,1,3),
('burgershot','big_meal','Burger Shot Big Meal',160,50,0,0,0,1,4),
('cluckinbell','little_meal','Cluckin'' Little Meal',45,10,0,0,0,1,1),
('cluckinbell','big_meal','Cluckin'' Big Meal',80,20,0,0,0,1,2),
('cluckinbell','huge_meal','Cluckin'' Huge Meal',120,35,0,0,0,1,3),
('cluckinbell','salad_meal','Salad Meal',90,18,0,0,0,1,4),
('pizzastack','pizza_slice','Pizza Slice',40,10,0,0,0,1,1),
('pizzastack','small_pizza','Small Pizza',75,20,0,0,0,1,2),
('pizzastack','full_rack','Full Rack',120,35,0,0,0,1,3),
('pizzastack','buster_meal','Buster Meal',160,50,0,0,0,1,4),
('gym','light_training','Light Training',100,0,0,10,0,1,1),
('gym','boxing','Boxing Session',150,5,0,15,0,1,2),
('gym','full_workout','Full Workout',250,10,0,25,0,1,3),
('barber','basic','Basic Haircut',150,0,0,0,0,1,1),
('barber','clean_cut','Clean Cut',250,0,0,0,0,1,2),
('barber','premium','Premium Style',500,0,0,0,0,1,3),
('tattoo','small','Small Tattoo',250,0,0,0,0,1,1),
('tattoo','gang','Gang Tattoo',500,0,0,0,0,1,2),
('tattoo','full_body','Full Body Tattoo',1000,0,0,0,0,1,3),
('hospital','checkup','Medical Checkup',150,35,0,0,0,1,1),
('hospital','emergency','Emergency Treatment',350,100,0,0,0,1,2),
('hospital','armor_patch','Armor Patch',500,0,20,0,0,1,3),
('police','wanted_status','Ask Wanted Status',0,0,0,0,0,1,1),
('police','small_fine','Pay Small Fine',500,0,0,0,1,1,2),
('police','safety_info','Public Safety Info',0,0,0,0,0,1,3),
('cityhall','citizen_info','Citizen Service Info',0,0,0,0,0,1,1),
('cityhall','permit_info','Business Permit Info',0,0,0,0,0,1,2),
('cityhall','license_info','License Info',0,0,0,0,0,1,3),
('casino','casino_info','Casino Info',0,0,0,0,0,1,1),
('casino','lucky_snack','Lucky Snack',100,10,0,0,0,1,2),
('casino','vip_service','VIP Service Placeholder',1000,0,0,20,0,1,3)
ON DUPLICATE KEY UPDATE
    display_name = VALUES(display_name),
    sort_order = VALUES(sort_order);


-- SAIF / LSIF Dev v0.24G.1
-- Static World DB Cleanup
-- Move legacy Pawn hardcoded world markers into world_locations so they can be edited through /locmenu.

ALTER TABLE world_locations
ADD COLUMN IF NOT EXISTS source_tag VARCHAR(64) DEFAULT 'manual';

UPDATE world_locations
SET source_tag = 'manual'
WHERE source_tag IS NULL OR source_tag = '';

-- ATM / Bank legacy hardcoded points -> DB world_locations
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_atm_idlewood_247', 'atm', 'Idlewood 24/7 ATM', 1833.8134, -1842.4136, 13.5781, 0.0, 0, 0, 52, 1239, 0, 0, '[ALT] ATM\nIdlewood 24/7 ATM\nBalance / Deposit / Withdraw', 5.0, 1, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_atm_idlewood_247');
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_atm_commerce_247', 'atm', 'Commerce 24/7 ATM', 1352.4896, -1758.2188, 13.5078, 0.0, 0, 0, 52, 1239, 0, 0, '[ALT] ATM\nCommerce 24/7 ATM\nBalance / Deposit / Withdraw', 5.0, 1, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_atm_commerce_247');
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_atm_vinewood_store', 'atm', 'Vinewood Store ATM', 1000.5822, -919.9146, 42.3281, 0.0, 0, 0, 52, 1239, 0, 0, '[ALT] ATM\nVinewood Store ATM\nBalance / Deposit / Withdraw', 5.0, 1, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_atm_vinewood_store');
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_atm_east_ls_market', 'atm', 'East LS Market ATM', 2421.5427, -1224.3597, 25.3828, 0.0, 0, 0, 52, 1239, 0, 0, '[ALT] ATM\nEast LS Market ATM\nBalance / Deposit / Withdraw', 5.0, 1, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_atm_east_ls_market');
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_atm_santa_maria_shop', 'atm', 'Santa Maria Shop ATM', 1154.7312, -1769.6847, 16.5938, 0.0, 0, 0, 52, 1239, 0, 0, '[ALT] ATM\nSanta Maria Shop ATM\nBalance / Deposit / Withdraw', 5.0, 1, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_atm_santa_maria_shop');

-- Dealership legacy hardcoded points -> DB world_locations
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_dealer_ls_grotti', 'dealer', 'LS Grotti Dealership', 2131.9177, -1150.1232, 24.2266, 0.0, 0, 0, 55, 1239, 0, 0, '[ALT] Dealership\nLS Grotti Dealership\nVehicle Shop / Garage Service', 8.0, 1, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_dealer_ls_grotti');
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_dealer_market_budget', 'dealer', 'Market Budget Cars', 562.6155, -1291.7563, 17.2482, 0.0, 0, 0, 55, 1239, 0, 0, '[ALT] Dealership\nMarket Budget Cars\nVehicle Shop / Garage Service', 8.0, 1, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_dealer_market_budget');
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_dealer_sf_import', 'dealer', 'San Fierro Import Dealer', -1954.2469, 300.2021, 35.4688, 0.0, 0, 0, 55, 1239, 0, 0, '[ALT] Dealership\nSan Fierro Import Dealer\nVehicle Shop / Garage Service', 8.0, 1, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_dealer_sf_import');

-- Ammu-Nation legacy static points are migrated as disabled because exact public interiors should be the main route now.
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_ammu_market', 'ammunation', 'Market Ammu-Nation Legacy Fallback', 1368.7429, -1279.8015, 13.5469, 0.0, 0, 0, 6, 1239, 0, 0, '[ALT] Ammu-Nation\nMarket Ammu-Nation\nLegacy fallback', 7.0, 0, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_ammu_market');
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_ammu_willowfield', 'ammunation', 'Willowfield Ammu-Nation Legacy Fallback', 2400.4875, -1981.9600, 13.5469, 0.0, 0, 0, 6, 1239, 0, 0, '[ALT] Ammu-Nation\nWillowfield Ammu-Nation\nLegacy fallback', 7.0, 0, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_ammu_willowfield');
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_ammu_blueberry', 'ammunation', 'Blueberry Ammu-Nation Legacy Fallback', 242.0057, -178.1069, 1.5781, 0.0, 0, 0, 6, 1239, 0, 0, '[ALT] Ammu-Nation\nBlueberry Ammu-Nation\nLegacy fallback', 7.0, 0, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_ammu_blueberry');

-- Job guide legacy hardcoded points -> DB world_locations
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_job_taxi_stand', 'job', 'Taxi Mission Stand', 2112.8467, -1788.3153, 13.5547, 0.0, 0, 0, 51, 1239, 0, 0, '[JOB] Taxi Mission Stand\nNaik Taxi/Cabbie lalu tekan tombol 2 untuk Taxi Mission.', 5.0, 1, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_job_taxi_stand');
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_job_courier_depot', 'job', 'Courier Depot', 2102.8870, -1806.4775, 13.5547, 0.0, 0, 0, 51, 1239, 0, 0, '[JOB] Courier Depot\nNaik Burrito/Boxville/Mule/Pony/Rumpo lalu tekan tombol 2 untuk Courier.', 5.0, 1, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_job_courier_depot');
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_job_trucker_depot', 'job', 'Trucker Cargo Depot', 2460.3918, -2114.8193, 13.5469, 0.0, 0, 0, 51, 1239, 0, 0, '[JOB] Trucker Cargo Depot\nNaik truck valid lalu tekan tombol 2 untuk Trucker Mission.', 5.0, 1, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_job_trucker_depot');
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_job_bus_terminal', 'job', 'Bus Terminal', 1807.9344, -1908.1141, 13.5781, 0.0, 0, 0, 51, 1239, 0, 0, '[JOB] Bus Terminal\nNaik Bus/Coach lalu tekan tombol 2 untuk Bus Route.', 5.0, 1, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_job_bus_terminal');
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_job_police_vigilante', 'job', 'Police Vigilante HQ', 1554.8425, -1675.6542, 16.1953, 0.0, 0, 0, 51, 1239, 0, 0, '[JOB] Police Vigilante HQ\nNaik kendaraan polisi lalu tekan tombol 2 untuk Vigilante Mission.', 5.0, 1, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_job_police_vigilante');

-- Race start legacy marker -> DB location fallback.
INSERT INTO world_locations
(location_key, location_type, display_name, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, map_icon, pickup_model, object_model, linked_object_id, label_text, interaction_radius, enabled, source_tag)
SELECT 'legacy_static_race_ls_intro', 'race', 'LS Intro Race Start', 1528.3741, -1678.0245, 13.3828, 0.0, 0, 0, 53, 1239, 0, 0, '[RACE] LS Intro\nGunakan /joinrace ls\nTombol 2 hanya untuk vehicle mission/job', 5.0, 1, 'legacy_static_migrated'
WHERE NOT EXISTS (SELECT 1 FROM world_locations WHERE location_key='legacy_static_race_ls_intro');

-- SAIF / LSIF Dev v0.24H — Gang Preset DB Config
-- Offline-first / exact-source-first gang HQ preset override.
-- Gang tetap preset GTA SA, bukan player-made gang.

CREATE TABLE IF NOT EXISTS gang_preset_config (
    gang_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    short_name VARCHAR(24) NOT NULL,
    color INT NOT NULL,
    color_name VARCHAR(24) NOT NULL DEFAULT 'DB Custom',
    hq_x FLOAT NOT NULL,
    hq_y FLOAT NOT NULL,
    hq_z FLOAT NOT NULL,
    hq_a FLOAT NOT NULL DEFAULT 0,
    hq_radius FLOAT NOT NULL DEFAULT 8,
    source_tag VARCHAR(32) NOT NULL DEFAULT 'offline_exact_manual',
    enabled TINYINT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO gang_preset_config
(gang_id, name, short_name, color, color_name, hq_x, hq_y, hq_z, hq_a, hq_radius, source_tag, enabled)
VALUES
(1, 'Grove Street Families', 'Grove', 16711935, 'Green', 2495.4094, -1686.1682, 13.5153, 180.0000, 8.0, 'offline_exact_manual', 1),
(2, 'Ballas', 'Ballas', -1436103425, 'Purple', 2229.3215, -1159.7343, 25.7331, 90.0000, 8.0, 'offline_exact_manual', 1),
(3, 'Los Santos Vagos', 'Vagos', -65281, 'Yellow', 2421.5427, -1224.3597, 25.3828, 270.0000, 8.0, 'offline_exact_manual', 1),
(4, 'Varrios Los Aztecas', 'Aztecas', 16777215, 'Turquoise', 1766.6000, -1918.3000, 13.5600, 180.0000, 8.0, 'offline_exact_manual', 1)
ON DUPLICATE KEY UPDATE
    gang_id=gang_id;


CREATE TABLE IF NOT EXISTS business_preset_config (
    business_index INT NOT NULL PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    x FLOAT NOT NULL DEFAULT 0,
    y FLOAT NOT NULL DEFAULT 0,
    z FLOAT NOT NULL DEFAULT 0,
    price INT NOT NULL DEFAULT 10000,
    income_per_minute INT NOT NULL DEFAULT 50,
    source_tag VARCHAR(64) NOT NULL DEFAULT 'legacy_static_migrated',
    enabled TINYINT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL
);

INSERT INTO business_preset_config
(business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
VALUES
(0, 'Idlewood Mini Market', 1833.1124, -1842.9921, 13.5781, 80000, 120, 'legacy_static_migrated', 1),
(1, 'Willowfield Workshop', 2105.4583, -1806.4227, 13.5547, 120000, 180, 'legacy_static_migrated', 1),
(2, 'Market Food Store', 1368.9248, -1279.6914, 13.5469, 175000, 250, 'legacy_static_migrated', 1),
(3, 'East LS Gas Station', 2420.3311, -1508.2178, 24.0000, 250000, 350, 'legacy_static_migrated', 1),
(4, 'Vinewood Electronics', 1000.5822, -919.9146, 42.3281, 350000, 500, 'legacy_static_migrated', 1)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    x = VALUES(x),
    y = VALUES(y),
    z = VALUES(z),
    price = VALUES(price),
    income_per_minute = VALUES(income_per_minute),
    source_tag = VALUES(source_tag),
    enabled = VALUES(enabled);

-- SAIF / LSIF Dev v0.24J.1 — Duplicate-Safe Full SA Seed SQL
-- Purpose: avoid Warning 1062 duplicate primary key when schema.sql is re-run.
-- Existing rows/admin edits are preserved. Missing rows are inserted.
-- SAIF / LSIF Dev v0.24J.2 — Strict-Safe Seed / MySQL 1364 Fix
-- Purpose:
-- - Avoid MySQL/MariaDB 1364 "Field doesn't have a default value" warnings/errors.
-- - Avoid INSERT IGNORE duplicate warnings.
-- - Preserve existing admin edits.
-- - Insert only missing rows.

-- ---------------------------------------------------------------------
-- 1) Make common gang/business seed tables default-safe.
-- ---------------------------------------------------------------------

ALTER TABLE gangs
    MODIFY COLUMN id INT NOT NULL,
    MODIFY COLUMN name VARCHAR(64) NOT NULL DEFAULT '',
    MODIFY COLUMN leader_id INT NOT NULL DEFAULT 0,
    MODIFY COLUMN leader_name VARCHAR(32) NOT NULL DEFAULT 'Server',
    MODIFY COLUMN gang_color INT NOT NULL DEFAULT 0,
    MODIFY COLUMN reputation INT NOT NULL DEFAULT 0,
    MODIFY COLUMN bank_money INT NOT NULL DEFAULT 0;

ALTER TABLE gang_preset_config
    MODIFY COLUMN gang_id INT NOT NULL,
    MODIFY COLUMN name VARCHAR(64) NOT NULL DEFAULT '',
    MODIFY COLUMN short_name VARCHAR(24) NOT NULL DEFAULT '',
    MODIFY COLUMN color INT NOT NULL DEFAULT 0,
    MODIFY COLUMN color_name VARCHAR(24) NOT NULL DEFAULT 'DB Custom',
    MODIFY COLUMN hq_x FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN hq_y FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN hq_z FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN hq_a FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN hq_radius FLOAT NOT NULL DEFAULT 8,
    MODIFY COLUMN source_tag VARCHAR(32) NOT NULL DEFAULT 'offline_reference_manual',
    MODIFY COLUMN enabled TINYINT NOT NULL DEFAULT 1;

ALTER TABLE gang_hq_interiors
    MODIFY COLUMN gang_id INT NOT NULL,
    MODIFY COLUMN interior_id INT NOT NULL DEFAULT 0,
    MODIFY COLUMN virtual_world INT NOT NULL DEFAULT 0,
    MODIFY COLUMN int_x FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN int_y FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN int_z FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN int_a FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN exit_x FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN exit_y FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN exit_z FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN exit_a FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN enabled TINYINT NOT NULL DEFAULT 1;

ALTER TABLE business_preset_config
    ADD COLUMN IF NOT EXISTS enabled TINYINT NOT NULL DEFAULT 1,
    MODIFY COLUMN business_index INT NOT NULL,
    MODIFY COLUMN name VARCHAR(64) NOT NULL DEFAULT '',
    MODIFY COLUMN x FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN y FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN z FLOAT NOT NULL DEFAULT 0,
    MODIFY COLUMN price INT NOT NULL DEFAULT 10000,
    MODIFY COLUMN income_per_minute INT NOT NULL DEFAULT 50,
    MODIFY COLUMN source_tag VARCHAR(64) NOT NULL DEFAULT 'full_sa_business_seed',
    MODIFY COLUMN enabled TINYINT NOT NULL DEFAULT 1;

-- ---------------------------------------------------------------------
-- 2) Insert missing gang preset rows only. Existing edits are preserved.
-- ---------------------------------------------------------------------

INSERT INTO gang_preset_config (gang_id, name, short_name, color, color_name, hq_x, hq_y, hq_z, hq_a, hq_radius, source_tag, enabled)
SELECT 1, 'Grove Street Families', 'Grove', 16711935, 'Green', 2495.4094, -1686.1682, 13.5153, 180.0, 8.0, 'offline_reference_manual', 1
WHERE NOT EXISTS (SELECT 1 FROM gang_preset_config WHERE gang_id=1);
INSERT INTO gang_preset_config (gang_id, name, short_name, color, color_name, hq_x, hq_y, hq_z, hq_a, hq_radius, source_tag, enabled)
SELECT 2, 'Ballas', 'Ballas', -1436103425, 'Purple', 2229.3215, -1159.7343, 25.7331, 90.0, 8.0, 'offline_reference_manual', 1
WHERE NOT EXISTS (SELECT 1 FROM gang_preset_config WHERE gang_id=2);
INSERT INTO gang_preset_config (gang_id, name, short_name, color, color_name, hq_x, hq_y, hq_z, hq_a, hq_radius, source_tag, enabled)
SELECT 3, 'Los Santos Vagos', 'Vagos', -65281, 'Yellow', 2421.5427, -1224.3597, 25.3828, 270.0, 8.0, 'offline_reference_manual', 1
WHERE NOT EXISTS (SELECT 1 FROM gang_preset_config WHERE gang_id=3);
INSERT INTO gang_preset_config (gang_id, name, short_name, color, color_name, hq_x, hq_y, hq_z, hq_a, hq_radius, source_tag, enabled)
SELECT 4, 'Varrios Los Aztecas', 'Aztecas', 16777215, 'Turquoise', 1766.6000, -1918.3000, 13.5600, 180.0, 8.0, 'offline_reference_manual', 1
WHERE NOT EXISTS (SELECT 1 FROM gang_preset_config WHERE gang_id=4);
INSERT INTO gang_preset_config (gang_id, name, short_name, color, color_name, hq_x, hq_y, hq_z, hq_a, hq_radius, source_tag, enabled)
SELECT 5, 'San Fierro Rifa', 'Rifa', 869046783, 'Teal', -2142.7000, -238.4000, 36.5156, 90.0, 8.0, 'offline_reference_manual', 1
WHERE NOT EXISTS (SELECT 1 FROM gang_preset_config WHERE gang_id=5);
INSERT INTO gang_preset_config (gang_id, name, short_name, color, color_name, hq_x, hq_y, hq_z, hq_a, hq_radius, source_tag, enabled)
SELECT 6, 'San Fierro Triads', 'Triads', -3435777, 'Red', -2175.3000, 645.6000, 49.4375, 180.0, 8.0, 'offline_reference_manual', 1
WHERE NOT EXISTS (SELECT 1 FROM gang_preset_config WHERE gang_id=6);
INSERT INTO gang_preset_config (gang_id, name, short_name, color, color_name, hq_x, hq_y, hq_z, hq_a, hq_radius, source_tag, enabled)
SELECT 7, 'Da Nang Boys', 'Da Nang', -862362881, 'Brown', -1720.8000, 1338.3000, 7.1875, 270.0, 8.0, 'offline_reference_manual', 1
WHERE NOT EXISTS (SELECT 1 FROM gang_preset_config WHERE gang_id=7);
INSERT INTO gang_preset_config (gang_id, name, short_name, color, color_name, hq_x, hq_y, hq_z, hq_a, hq_radius, source_tag, enabled)
SELECT 8, 'The Mafia', 'Mafia', 1717987071, 'Gray', 2170.2000, 1677.5000, 10.8203, 180.0, 8.0, 'offline_reference_manual', 1
WHERE NOT EXISTS (SELECT 1 FROM gang_preset_config WHERE gang_id=8);
INSERT INTO gang_preset_config (gang_id, name, short_name, color, color_name, hq_x, hq_y, hq_z, hq_a, hq_radius, source_tag, enabled)
SELECT 9, 'Russian Mafia', 'Russian', -1717960705, 'Pale Blue', 2520.3000, 2311.2000, 10.8203, 90.0, 8.0, 'offline_reference_manual', 1
WHERE NOT EXISTS (SELECT 1 FROM gang_preset_config WHERE gang_id=9);

-- ---------------------------------------------------------------------
-- 3) Insert missing gang runtime rows only. Existing bank/reputation are preserved.
-- ---------------------------------------------------------------------

INSERT INTO gangs (id, name, leader_id, leader_name, gang_color, reputation, bank_money)
SELECT 5, 'San Fierro Rifa', 0, 'Server', 869046783, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM gangs WHERE id=5);
INSERT INTO gangs (id, name, leader_id, leader_name, gang_color, reputation, bank_money)
SELECT 6, 'San Fierro Triads', 0, 'Server', -3435777, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM gangs WHERE id=6);
INSERT INTO gangs (id, name, leader_id, leader_name, gang_color, reputation, bank_money)
SELECT 7, 'Da Nang Boys', 0, 'Server', -862362881, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM gangs WHERE id=7);
INSERT INTO gangs (id, name, leader_id, leader_name, gang_color, reputation, bank_money)
SELECT 8, 'The Mafia', 0, 'Server', 1717987071, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM gangs WHERE id=8);
INSERT INTO gangs (id, name, leader_id, leader_name, gang_color, reputation, bank_money)
SELECT 9, 'Russian Mafia', 0, 'Server', -1717960705, 0, 0 WHERE NOT EXISTS (SELECT 1 FROM gangs WHERE id=9);

-- ---------------------------------------------------------------------
-- 4) Insert missing gang HQ interiors only.
-- ---------------------------------------------------------------------

INSERT INTO gang_hq_interiors (gang_id, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
SELECT 5, 3, 42005, 2496.0498, -1695.2382, 1014.7422, 180.0, -2142.7000, -238.4000, 36.5156, 90.0, 1
WHERE NOT EXISTS (SELECT 1 FROM gang_hq_interiors WHERE gang_id=5);
INSERT INTO gang_hq_interiors (gang_id, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
SELECT 6, 3, 42006, 2496.0498, -1695.2382, 1014.7422, 180.0, -2175.3000, 645.6000, 49.4375, 180.0, 1
WHERE NOT EXISTS (SELECT 1 FROM gang_hq_interiors WHERE gang_id=6);
INSERT INTO gang_hq_interiors (gang_id, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
SELECT 7, 3, 42007, 2496.0498, -1695.2382, 1014.7422, 180.0, -1720.8000, 1338.3000, 7.1875, 270.0, 1
WHERE NOT EXISTS (SELECT 1 FROM gang_hq_interiors WHERE gang_id=7);
INSERT INTO gang_hq_interiors (gang_id, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
SELECT 8, 3, 42008, 2496.0498, -1695.2382, 1014.7422, 180.0, 2170.2000, 1677.5000, 10.8203, 180.0, 1
WHERE NOT EXISTS (SELECT 1 FROM gang_hq_interiors WHERE gang_id=8);
INSERT INTO gang_hq_interiors (gang_id, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
SELECT 9, 3, 42009, 2496.0498, -1695.2382, 1014.7422, 180.0, 2520.3000, 2311.2000, 10.8203, 90.0, 1
WHERE NOT EXISTS (SELECT 1 FROM gang_hq_interiors WHERE gang_id=9);

-- ---------------------------------------------------------------------
-- 5) Insert missing full SA business rows only. Existing admin edits are preserved.
-- ---------------------------------------------------------------------

INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 5, 'Blueberry Gas Station', 219.7430, -233.4430, 1.5781, 110000, 160, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=5);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 6, 'Dillimore General Store', 664.2500, -573.9100, 16.3359, 120000, 170, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=6);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 7, 'Palomino Creek Market', 2303.8500, -16.1600, 26.4844, 130000, 180, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=7);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 8, 'Montgomery Workshop', 1291.7100, 269.3400, 19.5547, 135000, 190, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=8);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 9, 'Angel Pine General Store', -2092.5800, -2464.8400, 30.6250, 125000, 180, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=9);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 10, 'Doherty Garage', -2029.6500, 143.3600, 28.8359, 240000, 320, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=10);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 11, 'Wang Cars Showroom', -1952.9200, 299.1200, 35.4688, 350000, 500, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=11);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 12, 'Zero RC Shop', -2244.2300, 128.0100, 35.3203, 300000, 420, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=12);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 13, 'Chinatown Betting Shop', -2172.2100, 645.8100, 49.4375, 260000, 360, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=13);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 14, 'Hashbury Clothing Store', -2491.2100, -29.7200, 25.7656, 210000, 300, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=14);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 15, 'Easter Basin Depot', -1692.5500, 1326.8500, 7.1875, 230000, 330, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=15);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 16, 'Bayside Marina Store', -2454.2800, 2254.4600, 4.9844, 180000, 260, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=16);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 17, 'Fort Carson Diner', -121.2600, 1116.3800, 19.7422, 145000, 210, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=17);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 18, 'El Quebrados Barbers', -1446.1500, 2592.7700, 55.8359, 145000, 210, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=18);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 19, 'Verdant Meadows Airfield', 414.9400, 2536.0500, 19.1484, 500000, 700, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=19);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 20, 'Redsands West Gas Station', 1596.7700, 2199.1100, 10.8203, 210000, 300, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=20);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 21, 'The Strip Casino Kiosk', 2025.2500, 1007.7300, 10.8203, 350000, 500, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=21);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 22, 'Come-A-Lot Gifts', 2169.7800, 1122.9400, 12.6100, 250000, 340, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=22);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 23, 'Old Venturas Steakhouse', 2384.9000, 1041.5300, 10.8203, 240000, 320, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=23);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 24, 'Pirates Casino Shop', 1997.2100, 1522.0900, 14.6172, 320000, 450, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=24);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 25, 'Rockshore Industrial Depot', 2520.1300, 2311.3500, 10.8203, 260000, 360, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=25);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 26, 'LV Airport Cargo Office', 1685.6200, 1447.5200, 10.7734, 300000, 420, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=26);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 27, 'SF Airport Cargo Office', -1425.4100, -289.6200, 14.1484, 300000, 420, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=27);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 28, 'LS Airport Rentals', 1685.8200, -2241.2300, 13.5469, 280000, 390, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=28);
INSERT INTO business_preset_config (business_index, name, x, y, z, price, income_per_minute, source_tag, enabled)
SELECT 29, 'Flint County Farm Supply', -1060.7200, -1195.4300, 129.2188, 150000, 220, 'full_sa_business_seed', 1 WHERE NOT EXISTS (SELECT 1 FROM business_preset_config WHERE business_index=29);

-- SAIF / LSIF Dev v0.24J.3 — Gang HQ Interiors 1364 Fix
-- Fix for MySQL/MariaDB 1364 caused by gang_hq_interiors.gang_name being NOT NULL
-- while some seed rows did not provide gang_name.
-- This script is duplicate-safe and preserves existing edits.

-- Make gang_name default-safe for future inserts.
ALTER TABLE gang_hq_interiors
    MODIFY COLUMN gang_name VARCHAR(64) NOT NULL DEFAULT '';

-- Ensure existing blank names are filled from known presets.
UPDATE gang_hq_interiors SET gang_name='Grove Street Families' WHERE gang_id=1 AND (gang_name IS NULL OR gang_name='');
UPDATE gang_hq_interiors SET gang_name='Ballas' WHERE gang_id=2 AND (gang_name IS NULL OR gang_name='');
UPDATE gang_hq_interiors SET gang_name='Los Santos Vagos' WHERE gang_id=3 AND (gang_name IS NULL OR gang_name='');
UPDATE gang_hq_interiors SET gang_name='Varrios Los Aztecas' WHERE gang_id=4 AND (gang_name IS NULL OR gang_name='');
UPDATE gang_hq_interiors SET gang_name='San Fierro Rifa' WHERE gang_id=5 AND (gang_name IS NULL OR gang_name='');
UPDATE gang_hq_interiors SET gang_name='San Fierro Triads' WHERE gang_id=6 AND (gang_name IS NULL OR gang_name='');
UPDATE gang_hq_interiors SET gang_name='Da Nang Boys' WHERE gang_id=7 AND (gang_name IS NULL OR gang_name='');
UPDATE gang_hq_interiors SET gang_name='The Mafia' WHERE gang_id=8 AND (gang_name IS NULL OR gang_name='');
UPDATE gang_hq_interiors SET gang_name='Russian Mafia' WHERE gang_id=9 AND (gang_name IS NULL OR gang_name='');

-- Insert missing gang HQ interior rows only. Existing rows/edits are preserved.
INSERT INTO gang_hq_interiors
(gang_id, gang_name, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
SELECT 1, 'Grove Street Families', 3, 42001, 2496.0498, -1695.2382, 1014.7422, 180.0, 2495.4094, -1686.1682, 13.5153, 0.0, 1
WHERE NOT EXISTS (SELECT 1 FROM gang_hq_interiors WHERE gang_id=1);

INSERT INTO gang_hq_interiors
(gang_id, gang_name, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
SELECT 2, 'Ballas', 3, 42002, 2496.0498, -1695.2382, 1014.7422, 180.0, 2229.3215, -1159.7343, 25.7331, 0.0, 1
WHERE NOT EXISTS (SELECT 1 FROM gang_hq_interiors WHERE gang_id=2);

INSERT INTO gang_hq_interiors
(gang_id, gang_name, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
SELECT 3, 'Los Santos Vagos', 3, 42003, 2496.0498, -1695.2382, 1014.7422, 180.0, 2421.5427, -1224.3597, 25.3828, 0.0, 1
WHERE NOT EXISTS (SELECT 1 FROM gang_hq_interiors WHERE gang_id=3);

INSERT INTO gang_hq_interiors
(gang_id, gang_name, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
SELECT 4, 'Varrios Los Aztecas', 3, 42004, 2496.0498, -1695.2382, 1014.7422, 180.0, 1766.6000, -1918.3000, 13.5600, 0.0, 1
WHERE NOT EXISTS (SELECT 1 FROM gang_hq_interiors WHERE gang_id=4);

INSERT INTO gang_hq_interiors
(gang_id, gang_name, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
SELECT 5, 'San Fierro Rifa', 3, 42005, 2496.0498, -1695.2382, 1014.7422, 180.0, -2142.7000, -238.4000, 36.5156, 90.0, 1
WHERE NOT EXISTS (SELECT 1 FROM gang_hq_interiors WHERE gang_id=5);

INSERT INTO gang_hq_interiors
(gang_id, gang_name, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
SELECT 6, 'San Fierro Triads', 3, 42006, 2496.0498, -1695.2382, 1014.7422, 180.0, -2175.3000, 645.6000, 49.4375, 180.0, 1
WHERE NOT EXISTS (SELECT 1 FROM gang_hq_interiors WHERE gang_id=6);

INSERT INTO gang_hq_interiors
(gang_id, gang_name, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
SELECT 7, 'Da Nang Boys', 3, 42007, 2496.0498, -1695.2382, 1014.7422, 180.0, -1720.8000, 1338.3000, 7.1875, 270.0, 1
WHERE NOT EXISTS (SELECT 1 FROM gang_hq_interiors WHERE gang_id=7);

INSERT INTO gang_hq_interiors
(gang_id, gang_name, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
SELECT 8, 'The Mafia', 3, 42008, 2496.0498, -1695.2382, 1014.7422, 180.0, 2170.2000, 1677.5000, 10.8203, 180.0, 1
WHERE NOT EXISTS (SELECT 1 FROM gang_hq_interiors WHERE gang_id=8);

INSERT INTO gang_hq_interiors
(gang_id, gang_name, interior_id, virtual_world, int_x, int_y, int_z, int_a, exit_x, exit_y, exit_z, exit_a, enabled)
SELECT 9, 'Russian Mafia', 3, 42009, 2496.0498, -1695.2382, 1014.7422, 180.0, 2520.3000, 2311.2000, 10.8203, 90.0, 1
WHERE NOT EXISTS (SELECT 1 FROM gang_hq_interiors WHERE gang_id=9);


-- SAIF / LSIF Dev v0.24L - Source Audit Tools
-- Purpose: make source_tag available for audit tools without overwriting exact-source data.
-- Add this to database/schema.sql and run once before testing /sourceaudit.

ALTER TABLE world_locations
    ADD COLUMN IF NOT EXISTS source_tag VARCHAR(64) NOT NULL DEFAULT 'manual' AFTER enabled;

ALTER TABLE world_objects
    ADD COLUMN IF NOT EXISTS source_tag VARCHAR(64) NOT NULL DEFAULT 'manual' AFTER enabled;

UPDATE world_locations
SET source_tag = 'manual'
WHERE source_tag IS NULL OR source_tag = '';

UPDATE world_objects
SET source_tag = 'manual'
WHERE source_tag IS NULL OR source_tag = '';

-- SAIF / LSIF Dev v0.24K.16
-- Gang HQ Split Pickup/Door Editor
-- Wajib dijalankan sebelum server start, karena query runtime membaca kolom baru ini.

ALTER TABLE gang_preset_config
    ADD COLUMN IF NOT EXISTS hq_pickup_model INT NOT NULL DEFAULT 1314,
    ADD COLUMN IF NOT EXISTS hq_map_icon INT NOT NULL DEFAULT 19;

ALTER TABLE gang_hq_interiors
    ADD COLUMN IF NOT EXISTS door_pickup_model INT NOT NULL DEFAULT 1318;

UPDATE gang_preset_config
SET hq_pickup_model = 1314
WHERE hq_pickup_model IS NULL OR hq_pickup_model <= 0;

UPDATE gang_preset_config
SET hq_map_icon = 19
WHERE hq_map_icon IS NULL OR hq_map_icon <= 0;

UPDATE gang_hq_interiors
SET door_pickup_model = 1318
WHERE door_pickup_model IS NULL OR door_pickup_model <= 0;

-- SAIF / LSIF Dev v0.24K.17
-- Public Interior Exterior / Interior Editor DB Parameters
-- Jalankan sebelum start server karena runtime membaca kolom baru ini.

ALTER TABLE public_interiors
    ADD COLUMN IF NOT EXISTS exterior_spawn_x FLOAT NULL AFTER exterior_a,
    ADD COLUMN IF NOT EXISTS exterior_spawn_y FLOAT NULL AFTER exterior_spawn_x,
    ADD COLUMN IF NOT EXISTS exterior_spawn_z FLOAT NULL AFTER exterior_spawn_y,
    ADD COLUMN IF NOT EXISTS exterior_spawn_a FLOAT NULL AFTER exterior_spawn_z,
    ADD COLUMN IF NOT EXISTS exterior_pickup_model INT NOT NULL DEFAULT 1318 AFTER exterior_spawn_a,
    ADD COLUMN IF NOT EXISTS interior_pickup_model INT NOT NULL DEFAULT 1318 AFTER exterior_pickup_model;

UPDATE public_interiors
SET
    exterior_spawn_x = exterior_x,
    exterior_spawn_y = exterior_y,
    exterior_spawn_z = exterior_z,
    exterior_spawn_a = exterior_a
WHERE exterior_spawn_x IS NULL
   OR exterior_spawn_y IS NULL
   OR exterior_spawn_z IS NULL
   OR exterior_spawn_a IS NULL;

UPDATE public_interiors
SET exterior_pickup_model = 1318
WHERE exterior_pickup_model IS NULL OR exterior_pickup_model <= 0;

UPDATE public_interiors
SET interior_pickup_model = 1318
WHERE interior_pickup_model IS NULL OR interior_pickup_model <= 0;

-- Jadikan shared virtual world tersimpan eksplisit di DB, bukan hanya fallback runtime.
UPDATE public_interiors
SET interior_virtual_world = 43000 + id
WHERE interior_virtual_world IS NULL OR interior_virtual_world = 0;

-- SAIF / LSIF Dev v0.24K.18
-- Turf DB Only / No Hardcoded Fallback
--
-- Tidak wajib menghapus data.
-- Patch PWN v0.24K.18 membuat runtime turf hanya membaca gang_territories dari DB.
-- Jika row dihapus atau enabled=0, turf tidak akan muncul lagi setelah restart.

ALTER TABLE gang_territories
    ADD COLUMN IF NOT EXISTS source_tag VARCHAR(64) NOT NULL DEFAULT 'manual';

UPDATE gang_territories
SET source_tag = 'manual'
WHERE source_tag IS NULL OR source_tag = '';

-- Opsional kalau kamu ingin menonaktifkan semua turf lama dari DB:
-- UPDATE gang_territories SET enabled=0, updated_at=NOW();

-- SAIF / LSIF Dev v0.24K.18.1
-- Turf Delete Persist / DB Filter Fix
--
-- Patch PWN:
-- 1) LoadGangTerritories() hanya load WHERE enabled=1.
-- 2) Delete Turf sekarang DELETE row, bukan cuma enabled=0.
-- 3) Runtime skip row invalid/zero coordinate.

ALTER TABLE gang_territories
    ADD COLUMN IF NOT EXISTS source_tag VARCHAR(64) NOT NULL DEFAULT 'manual';

UPDATE gang_territories
SET source_tag = 'manual'
WHERE source_tag IS NULL OR source_tag = '';

-- Cleanup legacy hardcoded default turf yang dulu sering balik setelah restart.
-- Query ini hanya menyasar 6 default awal berdasarkan territory_index + nama legacy.
DELETE FROM gang_territories
WHERE territory_index BETWEEN 1 AND 6
  AND territory_name IN (
    'Ganton Block',
    'Idlewood District',
    'Market Strip',
    'East Los Santos',
    'Vinewood Hills',
    'Pershing Square',
    'Empty Territory'
  );

-- SAIF / LSIF Dev v0.24K.19.2
-- Public Interior Map Icon Native
--
-- Menambahkan icon map native untuk public_interiors.
-- PWN akan membaca public_interiors.exterior_map_icon dan menampilkan lewat SetPlayerMapIcon.

ALTER TABLE public_interiors
    ADD COLUMN IF NOT EXISTS exterior_map_icon INT NOT NULL DEFAULT 52;

-- Default icon untuk data lama.
-- Admin tetap bisa override lewat /pubintmapicon [id] [icon_id] atau menu Public Interior Editor.
UPDATE public_interiors
SET exterior_map_icon = CASE
    WHEN interior_type = 'ammunation' THEN 6
    WHEN interior_type IN ('burgershot', 'cluckinbell', 'pizzastack') THEN 10
    WHEN interior_type = 'barber' THEN 7
    WHEN interior_type = 'tattoo' THEN 39
    WHEN interior_type = 'police' THEN 30
    WHEN interior_type = 'hospital' THEN 22
    ELSE 52
END
WHERE exterior_map_icon IS NULL OR exterior_map_icon <= 0;

-- SAIF / LSIF Dev v0.24K.19.3
-- Public Interior Icon Priority Fix
--
-- Penyebab Ammu-Nation tidak tampil:
-- public interior lebih banyak dari 20 slot map icon yang disediakan (80-99).
-- Patch PWN memprioritaskan Ammu-Nation dulu, lalu interior lain terbaru.
--
-- SQL ini juga memastikan Ammu-Nation yang masih icon default 52 menjadi icon 6.

ALTER TABLE public_interiors
    ADD COLUMN IF NOT EXISTS exterior_map_icon INT NOT NULL DEFAULT 52;

UPDATE public_interiors
SET exterior_map_icon = 6
WHERE interior_type = 'ammunation'
  AND (exterior_map_icon IS NULL OR exterior_map_icon <= 0 OR exterior_map_icon = 52);

UPDATE public_interiors
SET exterior_map_icon = CASE
    WHEN interior_type IN ('burgershot', 'cluckinbell', 'pizzastack') THEN 10
    WHEN interior_type = 'barber' THEN 7
    WHEN interior_type = 'tattoo' THEN 39
    WHEN interior_type = 'police' THEN 30
    WHEN interior_type = 'hospital' THEN 22
    ELSE exterior_map_icon
END
WHERE exterior_map_icon IS NULL OR exterior_map_icon <= 0;


-- SAIF / LSIF Dev v0.24K.19.4
-- Nearby Map Icon Manager
--
-- Tidak ada struktur DB baru.
-- Patch PWN mengubah slot 80-99 menjadi dynamic nearby icon slots:
-- - Public Interior dari public_interiors.exterior_map_icon
-- - Dynamic Location dari world_locations.map_icon
--
-- Icon yang ditampilkan dipilih berdasarkan jarak player, radius 1500m, update otomatis tiap 8 detik.

ALTER TABLE public_interiors
    ADD COLUMN IF NOT EXISTS exterior_map_icon INT NOT NULL DEFAULT 52;

UPDATE public_interiors
SET exterior_map_icon = CASE
    WHEN interior_type = 'ammunation' THEN 6
    WHEN interior_type IN ('burgershot', 'cluckinbell', 'pizzastack') THEN 10
    WHEN interior_type = 'barber' THEN 7
    WHEN interior_type = 'tattoo' THEN 39
    WHEN interior_type = 'police' THEN 30
    WHEN interior_type = 'hospital' THEN 22
    ELSE 52
END
WHERE exterior_map_icon IS NULL OR exterior_map_icon <= 0;

-- SAIF / LSIF Dev v0.24K.21A
-- Cleanup Baseline Pass - DB safety/efficiency SQL
-- Basis: live DB audit v0.24K.20.6
--
-- Aman untuk live DB MariaDB 10.11:
-- 1) Tidak DROP TABLE.
-- 2) Tidak DROP COLUMN.
-- 3) DROP hanya duplicate index yang terdeteksi dari live dump.
-- 4) ADD COLUMN IF NOT EXISTS hanya guard agar schema baseline tidak tertinggal.
--
-- Backup dulu sebelum menjalankan SQL ini:
-- mysqldump -u root -p lsif_db > backup_before_v0.24K.21A.sql

-- ---------------------------------------------------------------------------
-- 1. Guard schema sync: gang_hq_interiors columns used by current lsif.pwn.
--    Pada live DB kamu kolom ini sudah ada, jadi statement ini harus no-op.
-- ---------------------------------------------------------------------------
ALTER TABLE gang_hq_interiors
    ADD COLUMN IF NOT EXISTS door_x FLOAT NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS door_y FLOAT NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS door_z FLOAT NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS door_a FLOAT NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS int_exit_x FLOAT NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS int_exit_y FLOAT NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS int_exit_z FLOAT NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS int_exit_a FLOAT NOT NULL DEFAULT 0;

-- ---------------------------------------------------------------------------
-- 2. Duplicate index cleanup detected in live DB dump.
--    Kedua pasangan index ini mengarah ke kolom yang sama, jadi cukup simpan
--    index lama yang sudah lebih dulu dipakai query/schema.
-- ---------------------------------------------------------------------------
DROP INDEX IF EXISTS idx_parked_vehicles_source_tag ON parked_vehicles;
DROP INDEX IF EXISTS idx_public_interiors_source_tag ON public_interiors;

-- ---------------------------------------------------------------------------
-- 3. Optional helper indexes for audit/source-tag workflow.
--    IF NOT EXISTS menjaga agar aman jika index sudah dibuat di mesin lain.
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_world_locations_source_tag ON world_locations (source_tag);
CREATE INDEX IF NOT EXISTS idx_gang_territories_enabled ON gang_territories (enabled);
CREATE INDEX IF NOT EXISTS idx_gang_territories_source_tag ON gang_territories (source_tag);

-- ---------------------------------------------------------------------------
-- 4. Review-only notes. Jangan drop kolom ini dulu.
-- ---------------------------------------------------------------------------
-- gang_territories.owner_org_id dan owner_org_name masih kandidat deprecated,
-- tetapi belum di-drop karena perlu patch runtime terpisah dan validasi konsep
-- Organization != Gang.
--
-- import_queue tables tetap dipertahankan untuk exact-source-first archive.

-- ==========================================================
-- SAIF / LSIF Dev v0.24K.22B
-- Death Log Audit Schema
-- Run once on live DB before deploying the v0.24K.22B gamemode.
-- ==========================================================

CREATE TABLE IF NOT EXISTS death_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    death_token VARCHAR(40) NOT NULL,
    victim_id INT NOT NULL DEFAULT 0,
    victim_name VARCHAR(24) NOT NULL DEFAULT '',
    killer_id INT NOT NULL DEFAULT 0,
    killer_name VARCHAR(24) NOT NULL DEFAULT '',
    reason_id INT NOT NULL DEFAULT 0,
    reason_name VARCHAR(40) NOT NULL DEFAULT '',
    death_x FLOAT NOT NULL DEFAULT 0,
    death_y FLOAT NOT NULL DEFAULT 0,
    death_z FLOAT NOT NULL DEFAULT 0,
    death_a FLOAT NOT NULL DEFAULT 0,
    death_interior INT NOT NULL DEFAULT 0,
    death_virtual_world INT NOT NULL DEFAULT 0,
    dropped_weapon_count INT NOT NULL DEFAULT 0,
    hospital_fee_charged INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_death_logs_token (death_token),
    KEY idx_death_logs_victim_id (victim_id),
    KEY idx_death_logs_killer_id (killer_id),
    KEY idx_death_logs_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


