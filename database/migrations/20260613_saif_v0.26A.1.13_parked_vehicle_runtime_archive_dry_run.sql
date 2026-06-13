-- SAIF / LSIF Dev v0.26A.1.13
-- Parked Vehicle Runtime Archive & Full Canonical Apply Dry-Run Foundation
-- SAFETY: creates archive metadata/tables only. Does not mutate parked_vehicles.

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_runtime_archive_sessions (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    session_key VARCHAR(96) COLLATE utf8mb4_unicode_ci NOT NULL,
    archive_scope VARCHAR(64) COLLATE utf8mb4_unicode_ci NOT NULL,
    archive_label VARCHAR(160) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    archive_status VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'capturing',
    runtime_rows_total INT UNSIGNED NOT NULL DEFAULT 0,
    active_rows_total INT UNSIGNED NOT NULL DEFAULT 0,
    target_rows_total INT UNSIGNED NOT NULL DEFAULT 0,
    archived_rows INT UNSIGNED NOT NULL DEFAULT 0,
    notes VARCHAR(768) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_offline_runtime_archive_session_key (session_key),
    KEY idx_offline_runtime_archive_scope (archive_scope, created_at),
    KEY idx_offline_runtime_archive_status (archive_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_parked_vehicles_archive (
    archive_row_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    archive_session_id BIGINT UNSIGNED NOT NULL,
    original_id INT NOT NULL,
    modelid INT NOT NULL DEFAULT 400,
    color1 INT NOT NULL DEFAULT -1,
    color2 INT NOT NULL DEFAULT -1,
    pos_x DOUBLE NOT NULL DEFAULT 0,
    pos_y DOUBLE NOT NULL DEFAULT 0,
    pos_z DOUBLE NOT NULL DEFAULT 0,
    pos_a DOUBLE NOT NULL DEFAULT 0,
    interior INT NOT NULL DEFAULT 0,
    virtual_world INT NOT NULL DEFAULT 0,
    respawn_delay INT NOT NULL DEFAULT 300,
    locked TINYINT(1) NOT NULL DEFAULT 0,
    source_tag VARCHAR(96) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    row_checksum CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
    captured_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (archive_row_id),
    UNIQUE KEY uq_offline_parkveh_archive_row (archive_session_id, original_id),
    KEY idx_offline_parkveh_archive_source (archive_session_id, source_tag, enabled),
    KEY idx_offline_parkveh_archive_model (archive_session_id, modelid),
    KEY idx_offline_parkveh_archive_checksum (row_checksum)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
