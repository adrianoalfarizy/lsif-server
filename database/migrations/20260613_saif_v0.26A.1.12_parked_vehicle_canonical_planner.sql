-- SAIF / LSIF Dev v0.26A.1.12
-- Parked Vehicle Canonical Resolver & Apply Planner
-- SAFETY: staging/planner only. No parked_vehicles runtime mutation.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_vehicle_apply_batches (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    session_id BIGINT UNSIGNED NOT NULL,
    planner_version VARCHAR(64) NOT NULL,
    batch_key VARCHAR(48) NOT NULL,
    display_name VARCHAR(96) NOT NULL,
    description VARCHAR(255) NOT NULL DEFAULT '',
    total_rows INT UNSIGNED NOT NULL DEFAULT 0,
    recommended_enabled_rows INT UNSIGNED NOT NULL DEFAULT 0,
    optional_rows INT UNSIGNED NOT NULL DEFAULT 0,
    blocked_rows INT UNSIGNED NOT NULL DEFAULT 0,
    sort_order SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    apply_status VARCHAR(24) NOT NULL DEFAULT 'draft',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_offveh_batch_session_key (session_id, planner_version, batch_key),
    KEY idx_offveh_batch_status (enabled, apply_status, sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_vehicle_apply_plan (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    session_id BIGINT UNSIGNED NOT NULL,
    batch_id BIGINT UNSIGNED NOT NULL,
    queue_id BIGINT UNSIGNED NOT NULL,
    duplicate_of_queue_id BIGINT UNSIGNED NULL,
    planner_version VARCHAR(64) NOT NULL,
    plan_source_tag VARCHAR(64) NOT NULL DEFAULT 'offline_scm_cargen_plan',
    decision_code VARCHAR(48) NOT NULL,
    canonical_status VARCHAR(48) NOT NULL,
    apply_readiness VARCHAR(48) NOT NULL,
    initial_state VARCHAR(16) NOT NULL,
    recommended_enabled TINYINT(1) NOT NULL DEFAULT 0,
    requires_progression TINYINT(1) NOT NULL DEFAULT 0,
    requires_model_resolution TINYINT(1) NOT NULL DEFAULT 0,
    requires_state_bridge TINYINT(1) NOT NULL DEFAULT 0,
    runtime_modelid INT NOT NULL DEFAULT -1,
    runtime_color1 INT NOT NULL DEFAULT -1,
    runtime_color2 INT NOT NULL DEFAULT -1,
    runtime_respawn_delay INT UNSIGNED NOT NULL DEFAULT 300,
    runtime_locked TINYINT(1) NOT NULL DEFAULT 0,
    runtime_source_tag VARCHAR(64) NOT NULL DEFAULT 'offline_exact_scm_cargen',
    planner_reason VARCHAR(512) NOT NULL DEFAULT '',
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    apply_status VARCHAR(24) NOT NULL DEFAULT 'draft',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_offveh_plan_queue_version (queue_id, planner_version),
    KEY idx_offveh_plan_session (session_id, planner_version),
    KEY idx_offveh_plan_batch (batch_id, decision_code),
    KEY idx_offveh_plan_readiness (apply_readiness, recommended_enabled),
    KEY idx_offveh_plan_apply (enabled, apply_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
