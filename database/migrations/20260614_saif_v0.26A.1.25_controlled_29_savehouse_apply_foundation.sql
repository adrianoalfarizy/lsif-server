-- SAIF / LSIF Dev v0.26A.1.25
-- Controlled GTA SA 29-Savehouse Apply Transaction Foundation
-- Creates tracked apply/rollback metadata only. Does not mutate house_catalog/player_houses.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_house_catalog_apply_sessions (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    apply_key VARCHAR(96) NOT NULL,
    archive_session_id BIGINT UNSIGNED NOT NULL,
    resolver_session_id BIGINT UNSIGNED NOT NULL,
    apply_status VARCHAR(32) NOT NULL DEFAULT 'applying',
    source_tag VARCHAR(64) NOT NULL DEFAULT '',
    catalog_rows_before INT UNSIGNED NOT NULL DEFAULT 0,
    catalog_active_before INT UNSIGNED NOT NULL DEFAULT 0,
    ownership_rows_before INT UNSIGNED NOT NULL DEFAULT 0,
    preserve_legacy_rows INT UNSIGNED NOT NULL DEFAULT 0,
    mapped_ownership_rows INT UNSIGNED NOT NULL DEFAULT 0,
    legacy_rows_disabled INT UNSIGNED NOT NULL DEFAULT 0,
    canonical_rows_inserted INT UNSIGNED NOT NULL DEFAULT 0,
    catalog_active_after INT UNSIGNED NOT NULL DEFAULT 0,
    ownership_rows_after INT UNSIGNED NOT NULL DEFAULT 0,
    notes VARCHAR(1024) NOT NULL DEFAULT '',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL DEFAULT NULL,
    rolled_back_at TIMESTAMP NULL DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_house_catalog_apply_key (apply_key),
    KEY idx_house_catalog_apply_status (apply_status,created_at),
    KEY idx_house_catalog_apply_archive (archive_session_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_house_catalog_apply_rows (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    apply_session_id BIGINT UNSIGNED NOT NULL,
    plan_id BIGINT UNSIGNED NOT NULL,
    canonical_slot INT NOT NULL,
    house_catalog_id INT UNSIGNED NOT NULL,
    source_tag VARCHAR(64) NOT NULL,
    row_checksum CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_house_apply_plan (apply_session_id,plan_id),
    UNIQUE KEY uq_house_apply_slot (apply_session_id,canonical_slot),
    UNIQUE KEY uq_house_apply_catalog (apply_session_id,house_catalog_id),
    KEY idx_house_apply_source (source_tag)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_house_catalog_disabled_rows (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    apply_session_id BIGINT UNSIGNED NOT NULL,
    house_catalog_id INT UNSIGNED NOT NULL,
    previous_enabled TINYINT(1) NOT NULL,
    previous_source_tag VARCHAR(64) NOT NULL DEFAULT '',
    row_checksum CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_house_disabled_catalog (apply_session_id,house_catalog_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_house_ownership_apply_rows (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    apply_session_id BIGINT UNSIGNED NOT NULL,
    transition_id BIGINT UNSIGNED NOT NULL,
    player_house_id INT UNSIGNED NOT NULL,
    policy_status VARCHAR(32) NOT NULL,
    old_house_catalog_id INT UNSIGNED NULL,
    old_house_index INT NOT NULL,
    old_house_name VARCHAR(128) NOT NULL DEFAULT '',
    old_price INT NOT NULL DEFAULT 0,
    old_locked TINYINT(1) NOT NULL DEFAULT 1,
    old_pos_x DECIMAL(11,4) NOT NULL DEFAULT 0,
    old_pos_y DECIMAL(11,4) NOT NULL DEFAULT 0,
    old_pos_z DECIMAL(11,4) NOT NULL DEFAULT 0,
    new_house_catalog_id INT UNSIGNED NULL,
    new_house_index INT NOT NULL,
    new_house_name VARCHAR(128) NOT NULL DEFAULT '',
    new_price INT NOT NULL DEFAULT 0,
    new_locked TINYINT(1) NOT NULL DEFAULT 1,
    new_pos_x DECIMAL(11,4) NOT NULL DEFAULT 0,
    new_pos_y DECIMAL(11,4) NOT NULL DEFAULT 0,
    new_pos_z DECIMAL(11,4) NOT NULL DEFAULT 0,
    before_checksum CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
    after_checksum CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_house_ownership_apply_transition (apply_session_id,transition_id),
    UNIQUE KEY uq_house_ownership_apply_playerhouse (apply_session_id,player_house_id),
    KEY idx_house_ownership_apply_policy (apply_session_id,policy_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SELECT 'HOUSE_APPLY_FOUNDATION' AS section,
       (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='offline_house_catalog_apply_sessions') sessions_table_should_be_1,
       (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='offline_house_catalog_apply_rows') apply_rows_table_should_be_1,
       (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='offline_house_catalog_disabled_rows') disabled_rows_table_should_be_1,
       (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='offline_house_ownership_apply_rows') ownership_rows_table_should_be_1;
