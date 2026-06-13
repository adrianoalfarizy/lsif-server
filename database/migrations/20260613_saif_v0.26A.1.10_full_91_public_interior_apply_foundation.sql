-- SAIF / LSIF Dev v0.26A.1.10
-- Full 91 Public Interior Apply Transaction Foundation
-- Creates apply-session tracking only. Does not mutate public_interiors.

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_runtime_apply_sessions (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    apply_key VARCHAR(96) COLLATE utf8mb4_unicode_ci NOT NULL,
    apply_scope VARCHAR(64) COLLATE utf8mb4_unicode_ci NOT NULL,
    apply_label VARCHAR(180) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    archive_session_id BIGINT UNSIGNED NOT NULL,
    import_session_id BIGINT UNSIGNED NOT NULL,
    plan_version VARCHAR(64) COLLATE utf8mb4_unicode_ci NOT NULL,
    resolver_version VARCHAR(64) COLLATE utf8mb4_unicode_ci NOT NULL,
    source_tag VARCHAR(96) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    apply_status VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'applying',
    runtime_active_before INT UNSIGNED NOT NULL DEFAULT 0,
    runtime_active_after INT UNSIGNED NOT NULL DEFAULT 0,
    old_rows_disabled INT UNSIGNED NOT NULL DEFAULT 0,
    new_rows_inserted INT UNSIGNED NOT NULL DEFAULT 0,
    exact_rows_inserted INT UNSIGNED NOT NULL DEFAULT 0,
    overlay_rows_inserted INT UNSIGNED NOT NULL DEFAULT 0,
    manual_adjustment_rows INT UNSIGNED NOT NULL DEFAULT 0,
    blocked_rows_skipped INT UNSIGNED NOT NULL DEFAULT 0,
    notes VARCHAR(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL DEFAULT NULL,
    rolled_back_at TIMESTAMP NULL DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_offline_runtime_apply_key (apply_key),
    KEY idx_offline_runtime_apply_scope (apply_scope, apply_status, created_at),
    KEY idx_offline_runtime_apply_archive (archive_session_id),
    KEY idx_offline_runtime_apply_import (import_session_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE offline_runtime_apply_sessions
    ADD COLUMN IF NOT EXISTS exact_rows_inserted INT UNSIGNED NOT NULL DEFAULT 0 AFTER new_rows_inserted,
    ADD COLUMN IF NOT EXISTS overlay_rows_inserted INT UNSIGNED NOT NULL DEFAULT 0 AFTER exact_rows_inserted,
    ADD COLUMN IF NOT EXISTS manual_adjustment_rows INT UNSIGNED NOT NULL DEFAULT 0 AFTER overlay_rows_inserted;

CREATE TABLE IF NOT EXISTS offline_public_interior_apply_rows (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    apply_session_id BIGINT UNSIGNED NOT NULL,
    plan_id BIGINT UNSIGNED NOT NULL,
    service_point_id BIGINT UNSIGNED NOT NULL,
    public_interior_id INT NOT NULL,
    runtime_type VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL,
    display_name VARCHAR(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    resolution_method VARCHAR(48) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    review_status VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    requires_manual_adjustment TINYINT(1) NOT NULL DEFAULT 0,
    source_tag VARCHAR(96) COLLATE utf8mb4_unicode_ci NOT NULL,
    row_checksum CHAR(64) COLLATE ascii_general_ci NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_offline_pubint_apply_plan (apply_session_id, plan_id),
    UNIQUE KEY uq_offline_pubint_apply_runtime (apply_session_id, public_interior_id),
    KEY idx_offline_pubint_apply_source (source_tag),
    KEY idx_offline_pubint_apply_type (apply_session_id, runtime_type),
    KEY idx_offline_pubint_apply_adjust (apply_session_id, requires_manual_adjustment)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE offline_public_interior_apply_rows
    ADD COLUMN IF NOT EXISTS resolution_method VARCHAR(48) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' AFTER display_name,
    ADD COLUMN IF NOT EXISTS review_status VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' AFTER resolution_method,
    ADD COLUMN IF NOT EXISTS requires_manual_adjustment TINYINT(1) NOT NULL DEFAULT 0 AFTER review_status;

CREATE TABLE IF NOT EXISTS offline_public_interior_disabled_rows (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    apply_session_id BIGINT UNSIGNED NOT NULL,
    public_interior_id INT NOT NULL,
    interior_type VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    previous_enabled TINYINT(1) NOT NULL DEFAULT 0,
    previous_source_tag VARCHAR(96) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    row_checksum CHAR(64) COLLATE ascii_general_ci NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_offline_pubint_disabled_row (apply_session_id, public_interior_id),
    KEY idx_offline_pubint_disabled_type (apply_session_id, interior_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
