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