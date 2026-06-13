-- SAIF / LSIF Dev v0.26A.1.6
-- ENEX Context Resolver staging metadata + evidence foundation
-- SAFETY: staging/audit tables only. No runtime table is updated, deleted, archived, reloaded, or spawned.

SET NAMES utf8mb4;

ALTER TABLE offline_interior_queue
    ADD COLUMN IF NOT EXISTS resolved_display_name VARCHAR(128) NOT NULL DEFAULT '' AFTER raw_record,
    ADD COLUMN IF NOT EXISTS resolved_category VARCHAR(64) NOT NULL DEFAULT '' AFTER resolved_display_name,
    ADD COLUMN IF NOT EXISTS resolved_context_type VARCHAR(64) NOT NULL DEFAULT '' AFTER resolved_category,
    ADD COLUMN IF NOT EXISTS access_scope VARCHAR(32) NOT NULL DEFAULT 'review_required' AFTER resolved_context_type,
    ADD COLUMN IF NOT EXISTS service_type VARCHAR(64) NOT NULL DEFAULT '' AFTER access_scope,
    ADD COLUMN IF NOT EXISTS recommended_runtime_target VARCHAR(128) NOT NULL DEFAULT 'review_required' AFTER service_type,
    ADD COLUMN IF NOT EXISTS resolver_status VARCHAR(24) NOT NULL DEFAULT 'pending' AFTER recommended_runtime_target,
    ADD COLUMN IF NOT EXISTS resolver_confidence TINYINT UNSIGNED NOT NULL DEFAULT 0 AFTER resolver_status,
    ADD COLUMN IF NOT EXISTS resolver_version VARCHAR(64) NOT NULL DEFAULT '' AFTER resolver_confidence,
    ADD COLUMN IF NOT EXISTS resolver_reason VARCHAR(512) NOT NULL DEFAULT '' AFTER resolver_version,
    ADD COLUMN IF NOT EXISTS scm_reference_count INT UNSIGNED NOT NULL DEFAULT 0 AFTER resolver_reason,
    ADD COLUMN IF NOT EXISTS scm_shop_binding_count INT UNSIGNED NOT NULL DEFAULT 0 AFTER scm_reference_count,
    ADD COLUMN IF NOT EXISTS pair_group_key VARCHAR(96) NOT NULL DEFAULT '' AFTER scm_shop_binding_count,
    ADD COLUMN IF NOT EXISTS pair_group_size INT UNSIGNED NOT NULL DEFAULT 0 AFTER pair_group_key,
    ADD COLUMN IF NOT EXISTS pair_status VARCHAR(32) NOT NULL DEFAULT 'unresolved' AFTER pair_group_size,
    ADD COLUMN IF NOT EXISTS duplicate_group_size INT UNSIGNED NOT NULL DEFAULT 1 AFTER pair_status,
    ADD COLUMN IF NOT EXISTS point_a_space VARCHAR(32) NOT NULL DEFAULT '' AFTER duplicate_group_size,
    ADD COLUMN IF NOT EXISTS point_b_space VARCHAR(32) NOT NULL DEFAULT '' AFTER point_a_space,
    ADD COLUMN IF NOT EXISTS resolved_at TIMESTAMP NULL DEFAULT NULL AFTER point_b_space;

CREATE INDEX IF NOT EXISTS idx_offline_interior_resolver_status
    ON offline_interior_queue (session_id, resolver_status, resolver_confidence);
CREATE INDEX IF NOT EXISTS idx_offline_interior_runtime_target
    ON offline_interior_queue (session_id, recommended_runtime_target);
CREATE INDEX IF NOT EXISTS idx_offline_interior_access_scope
    ON offline_interior_queue (session_id, access_scope);
CREATE INDEX IF NOT EXISTS idx_offline_interior_pair_group
    ON offline_interior_queue (session_id, pair_group_key);

CREATE TABLE IF NOT EXISTS offline_interior_context_evidence (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    session_id BIGINT UNSIGNED NOT NULL,
    queue_id BIGINT UNSIGNED NOT NULL,
    resolver_version VARCHAR(64) NOT NULL,
    evidence_type VARCHAR(48) NOT NULL,
    evidence_source VARCHAR(255) NOT NULL DEFAULT '',
    evidence_key VARCHAR(128) NOT NULL DEFAULT '',
    evidence_value VARCHAR(512) NOT NULL DEFAULT '',
    confidence_delta SMALLINT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_offline_context_evidence
        (queue_id, resolver_version, evidence_type, evidence_source, evidence_key),
    KEY idx_offline_context_session (session_id, resolver_version),
    KEY idx_offline_context_queue (queue_id),
    KEY idx_offline_context_type (evidence_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
