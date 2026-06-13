-- SAIF / LSIF Dev v0.26A.1.8
-- Exact Interior Service Point Resolver
-- SAFETY: staging metadata only. No public_interiors/runtime mutation.

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_interior_service_points (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    session_id BIGINT UNSIGNED NOT NULL,
    plan_id BIGINT UNSIGNED NOT NULL,
    resolver_version VARCHAR(64) NOT NULL,
    service_key CHAR(64) NOT NULL,
    context_type VARCHAR(64) NOT NULL,
    runtime_type VARCHAR(32) NOT NULL,
    pair_group_key VARCHAR(96) NOT NULL,
    display_name VARCHAR(160) NOT NULL,
    interior_id INT NOT NULL DEFAULT 0,
    service_x DOUBLE NOT NULL DEFAULT 0,
    service_y DOUBLE NOT NULL DEFAULT 0,
    service_z DOUBLE NOT NULL DEFAULT 0,
    service_a DOUBLE NOT NULL DEFAULT 0,
    service_radius DOUBLE NOT NULL DEFAULT 1.5,
    source_radius_xy DOUBLE NOT NULL DEFAULT 0,
    source_radius_z DOUBLE NOT NULL DEFAULT 0,
    interaction_semantics VARCHAR(64) NOT NULL,
    resolution_method VARCHAR(48) NOT NULL,
    confidence TINYINT UNSIGNED NOT NULL DEFAULT 0,
    review_status VARCHAR(32) NOT NULL DEFAULT 'pending',
    source_script VARCHAR(180) NOT NULL DEFAULT '',
    source_line_start INT UNSIGNED NOT NULL DEFAULT 0,
    source_line_end INT UNSIGNED NOT NULL DEFAULT 0,
    evidence_summary TEXT NULL,
    resolver_reason TEXT NULL,
    source_tag VARCHAR(64) NOT NULL DEFAULT 'offline_service_point_queue',
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    apply_status VARCHAR(24) NOT NULL DEFAULT 'draft',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_offline_service_key (session_id, service_key),
    UNIQUE KEY uq_offline_service_plan_version (plan_id, resolver_version),
    KEY idx_offline_service_session (session_id),
    KEY idx_offline_service_method (resolution_method),
    KEY idx_offline_service_review (review_status),
    KEY idx_offline_service_context (context_type, pair_group_key),
    KEY idx_offline_service_apply (enabled, apply_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE offline_interior_apply_plan
    ADD COLUMN IF NOT EXISTS service_point_id BIGINT UNSIGNED NULL AFTER service_point_status,
    ADD COLUMN IF NOT EXISTS service_resolver_version VARCHAR(64) NOT NULL DEFAULT '' AFTER service_point_id,
    ADD COLUMN IF NOT EXISTS service_resolution_method VARCHAR(48) NOT NULL DEFAULT '' AFTER service_resolver_version,
    ADD COLUMN IF NOT EXISTS service_confidence TINYINT UNSIGNED NOT NULL DEFAULT 0 AFTER service_resolution_method;

ALTER TABLE offline_interior_apply_batches
    ADD COLUMN IF NOT EXISTS exact_service_count INT UNSIGNED NOT NULL DEFAULT 0 AFTER service_pending_count,
    ADD COLUMN IF NOT EXISTS overlay_review_count INT UNSIGNED NOT NULL DEFAULT 0 AFTER exact_service_count;
