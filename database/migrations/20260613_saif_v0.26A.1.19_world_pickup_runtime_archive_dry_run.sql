-- SAIF / LSIF Dev v0.26A.1.19
-- World Pickup Runtime Archive & Baseline-89 Dry-Run Foundation
-- SAFETY: creates archive metadata/table only. No world_pickups mutation.
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

CREATE TABLE IF NOT EXISTS offline_world_pickups_archive (
    archive_row_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    archive_session_id BIGINT UNSIGNED NOT NULL,
    original_id INT NOT NULL,
    pickup_type VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    display_name VARCHAR(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    model_id INT NOT NULL DEFAULT 0,
    pos_x DOUBLE NOT NULL DEFAULT 0,
    pos_y DOUBLE NOT NULL DEFAULT 0,
    pos_z DOUBLE NOT NULL DEFAULT 0,
    interior INT NOT NULL DEFAULT 0,
    virtual_world INT NOT NULL DEFAULT 0,
    amount INT NOT NULL DEFAULT 0,
    cooldown_seconds INT NOT NULL DEFAULT 60,
    source_tag VARCHAR(96) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    row_checksum CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
    captured_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (archive_row_id),
    UNIQUE KEY uq_offline_worldpickup_archive_row (archive_session_id, original_id),
    KEY idx_offline_worldpickup_archive_source (archive_session_id, source_tag, enabled),
    KEY idx_offline_worldpickup_archive_type (archive_session_id, pickup_type),
    KEY idx_offline_worldpickup_archive_checksum (row_checksum)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
