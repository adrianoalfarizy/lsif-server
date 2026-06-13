-- SAIF / LSIF Dev v0.26A.1.9
-- Runtime Capacity & Archive/Replace Dry-Run Foundation
-- SAFETY: creates archive metadata/tables only. Does not mutate public_interiors rows.

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

CREATE TABLE IF NOT EXISTS offline_public_interiors_archive (
    archive_row_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    archive_session_id BIGINT UNSIGNED NOT NULL,
    original_id INT NOT NULL,
    interior_type VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    display_name VARCHAR(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    exterior_x DOUBLE NOT NULL DEFAULT 0,
    exterior_y DOUBLE NOT NULL DEFAULT 0,
    exterior_z DOUBLE NOT NULL DEFAULT 0,
    exterior_a DOUBLE NOT NULL DEFAULT 0,
    exterior_spawn_x DOUBLE NOT NULL DEFAULT 0,
    exterior_spawn_y DOUBLE NOT NULL DEFAULT 0,
    exterior_spawn_z DOUBLE NOT NULL DEFAULT 0,
    exterior_spawn_a DOUBLE NOT NULL DEFAULT 0,
    exterior_pickup_model INT NOT NULL DEFAULT 0,
    interior_pickup_model INT NOT NULL DEFAULT 0,
    exterior_map_icon INT NOT NULL DEFAULT 0,
    exterior_interior INT NOT NULL DEFAULT 0,
    exterior_virtual_world INT NOT NULL DEFAULT 0,
    interior_id INT NOT NULL DEFAULT 0,
    interior_virtual_world INT NOT NULL DEFAULT 0,
    interior_x DOUBLE NOT NULL DEFAULT 0,
    interior_y DOUBLE NOT NULL DEFAULT 0,
    interior_z DOUBLE NOT NULL DEFAULT 0,
    interior_a DOUBLE NOT NULL DEFAULT 0,
    exit_x DOUBLE NOT NULL DEFAULT 0,
    exit_y DOUBLE NOT NULL DEFAULT 0,
    exit_z DOUBLE NOT NULL DEFAULT 0,
    exit_a DOUBLE NOT NULL DEFAULT 0,
    service_x DOUBLE NOT NULL DEFAULT 0,
    service_y DOUBLE NOT NULL DEFAULT 0,
    service_z DOUBLE NOT NULL DEFAULT 0,
    service_a DOUBLE NOT NULL DEFAULT 0,
    service_radius DOUBLE NOT NULL DEFAULT 0,
    source_tag VARCHAR(96) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    row_checksum CHAR(64) COLLATE ascii_general_ci NOT NULL,
    captured_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (archive_row_id),
    UNIQUE KEY uq_offline_pubint_archive_row (archive_session_id, original_id),
    KEY idx_offline_pubint_archive_source (archive_session_id, source_tag, enabled),
    KEY idx_offline_pubint_archive_type (archive_session_id, interior_type),
    KEY idx_offline_pubint_archive_checksum (row_checksum)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
