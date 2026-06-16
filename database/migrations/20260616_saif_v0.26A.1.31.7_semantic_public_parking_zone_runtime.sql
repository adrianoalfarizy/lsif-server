-- SAIF / LSIF v0.26A.1.31.7
-- Semantic Public Parking Zone Runtime
-- Schema only. Runtime apply is intentionally separated and confirmation-gated.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS public_parking_policy (
    id TINYINT UNSIGNED NOT NULL,
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    require_colandreas TINYINT(1) NOT NULL DEFAULT 1,
    reject_when_unavailable TINYINT(1) NOT NULL DEFAULT 1,
    search_near_radius FLOAT NOT NULL DEFAULT 250.0,
    search_mid_radius FLOAT NOT NULL DEFAULT 500.0,
    search_far_radius FLOAT NOT NULL DEFAULT 1000.0,
    max_runtime_slots SMALLINT UNSIGNED NOT NULL DEFAULT 1024,
    source_tag VARCHAR(96) NOT NULL DEFAULT 'saif_semantic_public_parking_v0.26A.1.31.7',
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO public_parking_policy
(id,enabled,require_colandreas,reject_when_unavailable,search_near_radius,search_mid_radius,search_far_radius,max_runtime_slots,source_tag)
VALUES
(1,0,1,1,250.0,500.0,1000.0,1024,'saif_semantic_public_parking_v0.26A.1.31.7')
ON DUPLICATE KEY UPDATE id=VALUES(id);

CREATE TABLE IF NOT EXISTS public_parking_zones (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    zone_key VARCHAR(96) NOT NULL,
    zone_name VARCHAR(64) NOT NULL,
    zone_type VARCHAR(32) NOT NULL,
    facility_type VARCHAR(32) NOT NULL DEFAULT 'public',
    facility_reference_id BIGINT UNSIGNED NULL,
    center_x FLOAT NOT NULL,
    center_y FLOAT NOT NULL,
    center_z FLOAT NOT NULL,
    center_a FLOAT NOT NULL DEFAULT 0,
    interior_id INT NOT NULL DEFAULT 0,
    virtual_world INT NOT NULL DEFAULT 0,
    search_radius FLOAT NOT NULL DEFAULT 180.0,
    priority SMALLINT NOT NULL DEFAULT 50,
    review_status VARCHAR(24) NOT NULL DEFAULT 'candidate',
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    source_tag VARCHAR(96) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_public_parking_zone_key (zone_key),
    KEY idx_public_parking_zone_runtime (enabled,review_status,interior_id,virtual_world,priority),
    KEY idx_public_parking_zone_facility (facility_type,facility_reference_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS public_parking_slots (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    zone_id BIGINT UNSIGNED NOT NULL,
    slot_number SMALLINT UNSIGNED NOT NULL,
    slot_name VARCHAR(64) NOT NULL,
    pos_x FLOAT NOT NULL,
    pos_y FLOAT NOT NULL,
    pos_z FLOAT NOT NULL,
    pos_a FLOAT NOT NULL,
    clear_radius FLOAT NOT NULL DEFAULT 4.5,
    review_status VARCHAR(24) NOT NULL DEFAULT 'candidate',
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    source_tag VARCHAR(96) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_public_parking_zone_slot (zone_id,slot_number),
    KEY idx_public_parking_slot_runtime (enabled,review_status,zone_id),
    CONSTRAINT fk_public_parking_slot_zone
      FOREIGN KEY (zone_id) REFERENCES public_parking_zones(id)
      ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS semantic_parking_apply_sessions (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    apply_version VARCHAR(64) NOT NULL,
    apply_status VARCHAR(24) NOT NULL DEFAULT 'running',
    previous_policy_enabled TINYINT(1) NOT NULL DEFAULT 0,
    previous_nearest_spawn_enabled TINYINT(1) NOT NULL DEFAULT 0,
    archived_legacy_points INT UNSIGNED NOT NULL DEFAULT 0,
    disabled_legacy_points INT UNSIGNED NOT NULL DEFAULT 0,
    facility_candidate_zones INT UNSIGNED NOT NULL DEFAULT 0,
    approved_admin_zones INT UNSIGNED NOT NULL DEFAULT 0,
    approved_admin_slots INT UNSIGNED NOT NULL DEFAULT 0,
    source_tag VARCHAR(96) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL DEFAULT NULL,
    rolled_back_at TIMESTAMP NULL DEFAULT NULL,
    PRIMARY KEY (id),
    KEY idx_semantic_parking_apply_version (apply_version,apply_status,created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS semantic_parking_legacy_point_archive (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    apply_session_id BIGINT UNSIGNED NOT NULL,
    vehicle_spawn_point_id BIGINT UNSIGNED NOT NULL,
    previous_enabled TINYINT(1) NOT NULL,
    source_type VARCHAR(32) NOT NULL,
    source_tag VARCHAR(96) NOT NULL,
    archived_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_semantic_parking_archive_session_point (apply_session_id,vehicle_spawn_point_id),
    KEY idx_semantic_parking_archive_session (apply_session_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SELECT 'SCHEMA_GATE' section,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='public_parking_policy') policy_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='public_parking_zones') zones_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='public_parking_slots') slots_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='semantic_parking_apply_sessions') sessions_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='semantic_parking_legacy_point_archive') archive_table_should_be_1;
