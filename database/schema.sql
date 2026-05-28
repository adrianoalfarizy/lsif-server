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

-- LSIF v0.20A.1 — Separate Organization and Gang Foundation
-- Organization tetap untuk ekonomi/bisnis/job.
-- Gang menjadi entitas terpisah untuk turf/territory.

CREATE TABLE IF NOT EXISTS gangs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL UNIQUE,
    leader_id INT NOT NULL,
    leader_name VARCHAR(24) NOT NULL,
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

-- Jika table territory sudah dibuat dari v0.20A lama, tambahkan kolom gang baru tanpa menghapus kolom lama.
ALTER TABLE gang_territories
ADD COLUMN IF NOT EXISTS owner_gang_id INT NOT NULL DEFAULT 0 AFTER territory_name;

ALTER TABLE gang_territories
ADD COLUMN IF NOT EXISTS owner_gang_name VARCHAR(64) NOT NULL DEFAULT 'Neutral' AFTER owner_gang_id;

-- Pastikan owner_color tetap ada.
ALTER TABLE gang_territories
ADD COLUMN IF NOT EXISTS owner_color INT NOT NULL DEFAULT -1431655681 AFTER owner_gang_name;

-- Index gang owner, jika belum ada.
CREATE INDEX IF NOT EXISTS idx_owner_gang_id ON gang_territories (owner_gang_id);

-- Seed / refresh territory dasar dengan owner gang neutral.
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

-- Optional: organisasi lama boleh tetap punya kolom gang_color dari v0.20A, tapi mulai v0.20A.1 tidak dipakai lagi.
-- Jangan drop kolom dulu agar migrasi aman.
