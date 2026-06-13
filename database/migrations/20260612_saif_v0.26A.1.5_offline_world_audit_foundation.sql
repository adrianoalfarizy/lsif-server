-- SAIF / LSIF Dev v0.26A.1.5
-- Offline World Source Registry & ENEX Audit Queue Foundation
-- SAFETY: creates staging/audit tables only. No runtime table is updated or deleted.

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS offline_import_sessions (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    session_key CHAR(64) NOT NULL,
    session_label VARCHAR(128) NOT NULL,
    source_root VARCHAR(512) NOT NULL,
    source_version VARCHAR(64) NOT NULL DEFAULT '',
    parser_version VARCHAR(64) NOT NULL DEFAULT '',
    status VARCHAR(32) NOT NULL DEFAULT 'created',
    total_files INT UNSIGNED NOT NULL DEFAULT 0,
    parsed_files INT UNSIGNED NOT NULL DEFAULT 0,
    total_records INT UNSIGNED NOT NULL DEFAULT 0,
    warning_count INT UNSIGNED NOT NULL DEFAULT 0,
    error_count INT UNSIGNED NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_offline_import_sessions_key (session_key),
    KEY idx_offline_import_sessions_status (status),
    KEY idx_offline_import_sessions_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_source_files (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    session_id BIGINT UNSIGNED NOT NULL,
    relative_path VARCHAR(512) NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    extension VARCHAR(32) NOT NULL DEFAULT '',
    source_type VARCHAR(64) NOT NULL DEFAULT 'OTHER',
    size_bytes BIGINT UNSIGNED NOT NULL DEFAULT 0,
    sha256 CHAR(64) NOT NULL,
    parse_status VARCHAR(32) NOT NULL DEFAULT 'registered',
    record_count INT UNSIGNED NOT NULL DEFAULT 0,
    warning_text TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_offline_source_file_path (session_id, relative_path),
    KEY idx_offline_source_files_session_type (session_id, source_type),
    KEY idx_offline_source_files_sha256 (sha256),
    KEY idx_offline_source_files_parse_status (parse_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_import_logs (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    session_id BIGINT UNSIGNED NOT NULL,
    log_level VARCHAR(16) NOT NULL DEFAULT 'info',
    component VARCHAR(64) NOT NULL DEFAULT '',
    message TEXT NOT NULL,
    source_file VARCHAR(512) NOT NULL DEFAULT '',
    source_line INT UNSIGNED NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_offline_import_logs_session_level (session_id, log_level),
    KEY idx_offline_import_logs_component (component),
    KEY idx_offline_import_logs_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS offline_interior_queue (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    session_id BIGINT UNSIGNED NOT NULL,
    source_file_id BIGINT UNSIGNED NULL,
    source_file VARCHAR(512) NOT NULL,
    source_line INT UNSIGNED NOT NULL DEFAULT 0,
    record_hash CHAR(64) NOT NULL,
    source_type VARCHAR(64) NOT NULL DEFAULT 'IPL_ENEX',
    raw_name VARCHAR(64) NOT NULL DEFAULT '',
    display_name VARCHAR(128) NOT NULL DEFAULT '',
    category VARCHAR(64) NOT NULL DEFAULT 'unknown',
    context_type VARCHAR(64) NOT NULL DEFAULT 'unknown',
    confidence TINYINT UNSIGNED NOT NULL DEFAULT 0,

    entry_x FLOAT NOT NULL DEFAULT 0,
    entry_y FLOAT NOT NULL DEFAULT 0,
    entry_z FLOAT NOT NULL DEFAULT 0,
    entry_a FLOAT NOT NULL DEFAULT 0,
    entry_size_x FLOAT NOT NULL DEFAULT 0,
    entry_size_y FLOAT NOT NULL DEFAULT 0,
    entry_size_z FLOAT NOT NULL DEFAULT 0,

    exit_x FLOAT NOT NULL DEFAULT 0,
    exit_y FLOAT NOT NULL DEFAULT 0,
    exit_z FLOAT NOT NULL DEFAULT 0,
    exit_a FLOAT NOT NULL DEFAULT 0,
    interior_id INT NOT NULL DEFAULT 0,
    flags INT NOT NULL DEFAULT 0,
    sky_color INT NOT NULL DEFAULT 0,
    num_peds INT NOT NULL DEFAULT 0,
    time_on INT NOT NULL DEFAULT 0,
    time_off INT NOT NULL DEFAULT 24,

    city_code VARCHAR(32) NOT NULL DEFAULT '',
    area_code VARCHAR(32) NOT NULL DEFAULT '',
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    review_status VARCHAR(24) NOT NULL DEFAULT 'pending',
    apply_status VARCHAR(24) NOT NULL DEFAULT 'pending',
    source_tag VARCHAR(64) NOT NULL DEFAULT 'offline_enex_queue',
    notes VARCHAR(255) NOT NULL DEFAULT '',
    raw_record TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE KEY uq_offline_interior_session_hash (session_id, record_hash),
    KEY idx_offline_interior_session (session_id),
    KEY idx_offline_interior_session_category (session_id, category),
    KEY idx_offline_interior_context (context_type),
    KEY idx_offline_interior_review (review_status, apply_status),
    KEY idx_offline_interior_source (source_file_id, source_line),
    KEY idx_offline_interior_area (city_code, area_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
