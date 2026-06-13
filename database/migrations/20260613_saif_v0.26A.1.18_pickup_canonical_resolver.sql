-- SAIF / LSIF Dev v0.26A.1.18
-- GTA SA Pickup Canonical Resolver foundation
-- SAFETY: resolver/plan tables only; no world_pickups mutation.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_pickup_resolver_sessions (
 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 resolver_key CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
 queue_session_id BIGINT UNSIGNED NULL,
 parser_version VARCHAR(64) NOT NULL,
 resolver_version VARCHAR(64) NOT NULL,
 resolver_status VARCHAR(24) NOT NULL DEFAULT 'building',
 total_rows INT UNSIGNED NOT NULL DEFAULT 0,
 baseline_ready_rows INT UNSIGNED NOT NULL DEFAULT 0,
 deferred_rows INT UNSIGNED NOT NULL DEFAULT 0,
 blocked_rows INT UNSIGNED NOT NULL DEFAULT 0,
 source_checksum CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
 notes VARCHAR(255) NOT NULL DEFAULT '',
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 completed_at TIMESTAMP NULL DEFAULT NULL,
 PRIMARY KEY(id),
 UNIQUE KEY uq_pickup_resolver_key(resolver_key),
 KEY idx_pickup_resolver_version(resolver_version,resolver_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_pickup_canonical_plan (
 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 resolver_session_id BIGINT UNSIGNED NOT NULL,
 queue_id BIGINT UNSIGNED NOT NULL,
 record_hash CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
 resolver_version VARCHAR(64) NOT NULL,
 base_decision_code VARCHAR(48) NOT NULL,
 decision_code VARCHAR(48) NOT NULL,
 canonical_category VARCHAR(48) NOT NULL,
 runtime_target VARCHAR(64) NOT NULL,
 canonical_model_id INT NULL,
 canonical_pickup_type VARCHAR(32) NOT NULL DEFAULT '',
 canonical_amount INT NULL,
 canonical_cooldown_seconds INT UNSIGNED NOT NULL DEFAULT 0,
 canonical_weapon_id INT NOT NULL DEFAULT 0,
 canonical_ammo INT NULL,
 recommended_interior INT NOT NULL DEFAULT -1,
 recommended_virtual_world INT NOT NULL DEFAULT -1,
 runtime_z_lift FLOAT NOT NULL DEFAULT 0,
 duplicate_resolution VARCHAR(32) NOT NULL DEFAULT 'unique',
 duplicate_primary_record_hash CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
 requires_interior_context TINYINT(1) NOT NULL DEFAULT 0,
 requires_backend_bridge TINYINT(1) NOT NULL DEFAULT 0,
 requires_account_persistence TINYINT(1) NOT NULL DEFAULT 0,
 safety_class VARCHAR(24) NOT NULL DEFAULT 'deferred',
 resolution_reason VARCHAR(255) NOT NULL DEFAULT '',
 review_status VARCHAR(24) NOT NULL DEFAULT 'deferred',
 enabled TINYINT(1) NOT NULL DEFAULT 0,
 apply_status VARCHAR(24) NOT NULL DEFAULT 'draft',
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY(id),
 UNIQUE KEY uq_pickup_plan_session_queue(resolver_session_id,queue_id),
 UNIQUE KEY uq_pickup_plan_version_hash(resolver_version,record_hash),
 KEY idx_pickup_plan_decision(decision_code,safety_class),
 KEY idx_pickup_plan_target(runtime_target,review_status),
 KEY idx_pickup_plan_apply(enabled,apply_status),
 CONSTRAINT fk_pickup_plan_resolver_session FOREIGN KEY(resolver_session_id)
   REFERENCES offline_pickup_resolver_sessions(id) ON DELETE CASCADE,
 CONSTRAINT fk_pickup_plan_queue FOREIGN KEY(queue_id)
   REFERENCES offline_pickup_queue(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
