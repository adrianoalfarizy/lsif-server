-- SAIF / LSIF v0.26A.1.31.5
-- Global Nearest Parking Spawn Rework
-- Tracking/archive foundation for direct global parking catalog apply.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS vehicle_spawn_point_seed_sessions (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    seed_version VARCHAR(64) NOT NULL,
    status VARCHAR(24) NOT NULL DEFAULT 'running',
    archive_rows INT UNSIGNED NOT NULL DEFAULT 0,
    generated_rows INT UNSIGNED NOT NULL DEFAULT 0,
    enabled_rows INT UNSIGNED NOT NULL DEFAULT 0,
    parked_origin_rows INT UNSIGNED NOT NULL DEFAULT 0,
    parked_left_rows INT UNSIGNED NOT NULL DEFAULT 0,
    parked_right_rows INT UNSIGNED NOT NULL DEFAULT 0,
    garage_rows INT UNSIGNED NOT NULL DEFAULT 0,
    mission_default_rows INT UNSIGNED NOT NULL DEFAULT 0,
    mission_pool_rows INT UNSIGNED NOT NULL DEFAULT 0,
    admin_rows_preserved INT UNSIGNED NOT NULL DEFAULT 0,
    source_tag VARCHAR(96) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL DEFAULT NULL,
    rolled_back_at TIMESTAMP NULL DEFAULT NULL,
    PRIMARY KEY (id),
    KEY idx_vehicle_spawn_seed_version_status (seed_version,status,created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS vehicle_spawn_point_seed_archive_rows (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    seed_session_id BIGINT UNSIGNED NOT NULL,
    original_id BIGINT UNSIGNED NOT NULL,
    point_key VARCHAR(96) NOT NULL,
    point_name VARCHAR(64) NOT NULL,
    source_type VARCHAR(32) NOT NULL,
    source_reference_id BIGINT UNSIGNED NULL,
    pos_x FLOAT NOT NULL,
    pos_y FLOAT NOT NULL,
    pos_z FLOAT NOT NULL,
    pos_a FLOAT NOT NULL,
    interior_id INT NOT NULL,
    virtual_world INT NOT NULL,
    clear_radius FLOAT NOT NULL,
    priority SMALLINT NOT NULL,
    enabled TINYINT(1) NOT NULL,
    source_tag VARCHAR(96) NOT NULL,
    archived_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_vehicle_spawn_archive_session_original (seed_session_id,original_id),
    KEY idx_vehicle_spawn_archive_session (seed_session_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SELECT 'SCHEMA_GATE' section,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_spawn_points') spawn_points_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_spawn_point_seed_sessions') sessions_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_spawn_point_seed_archive_rows') archive_table_should_be_1;
