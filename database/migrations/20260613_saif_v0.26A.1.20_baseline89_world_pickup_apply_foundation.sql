-- SAIF / LSIF Dev v0.26A.1.20
-- Full Baseline-89 World Pickup Apply Transaction Foundation
-- Creates tracked apply/rollback metadata only. Does not mutate world_pickups.
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
    ADD COLUMN IF NOT EXISTS baseline_rows_inserted INT UNSIGNED NOT NULL DEFAULT 0 AFTER manual_adjustment_rows,
    ADD COLUMN IF NOT EXISTS progression_rows_inserted INT UNSIGNED NOT NULL DEFAULT 0 AFTER baseline_rows_inserted,
    ADD COLUMN IF NOT EXISTS deferred_rows_skipped INT UNSIGNED NOT NULL DEFAULT 0 AFTER progression_rows_inserted,
    ADD COLUMN IF NOT EXISTS bribe_rows_inserted INT UNSIGNED NOT NULL DEFAULT 0 AFTER deferred_rows_skipped,
    ADD COLUMN IF NOT EXISTS armor_rows_inserted INT UNSIGNED NOT NULL DEFAULT 0 AFTER bribe_rows_inserted;

CREATE TABLE IF NOT EXISTS offline_world_pickup_apply_rows (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    apply_session_id BIGINT UNSIGNED NOT NULL,
    plan_id BIGINT UNSIGNED NOT NULL,
    queue_id BIGINT UNSIGNED NOT NULL,
    world_pickup_id INT NOT NULL,
    canonical_category VARCHAR(48) COLLATE utf8mb4_unicode_ci NOT NULL,
    pickup_type VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL,
    model_id INT NOT NULL,
    source_tag VARCHAR(96) COLLATE utf8mb4_unicode_ci NOT NULL,
    row_checksum CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_offline_worldpickup_apply_plan (apply_session_id, plan_id),
    UNIQUE KEY uq_offline_worldpickup_apply_runtime (apply_session_id, world_pickup_id),
    KEY idx_offline_worldpickup_apply_queue (apply_session_id, queue_id),
    KEY idx_offline_worldpickup_apply_category (apply_session_id, canonical_category),
    KEY idx_offline_worldpickup_apply_source (source_tag)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_world_pickup_disabled_rows (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    apply_session_id BIGINT UNSIGNED NOT NULL,
    world_pickup_id INT NOT NULL,
    previous_enabled TINYINT(1) NOT NULL DEFAULT 0,
    previous_source_tag VARCHAR(96) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    row_checksum CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_offline_worldpickup_disabled_row (apply_session_id, world_pickup_id),
    KEY idx_offline_worldpickup_disabled_source (apply_session_id, previous_source_tag)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
