-- SAIF / LSIF v0.26A.1.30.1
-- House Vehicle Storage Complete Runtime
-- Creates unified storage tables when absent. Runtime activation is performed by the controlled apply script.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS vehicle_storage_policy (
    id TINYINT UNSIGNED NOT NULL,
    policy_key VARCHAR(64) NOT NULL,
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    house_storage_enabled TINYINT(1) NOT NULL DEFAULT 0,
    public_garage_storage_enabled TINYINT(1) NOT NULL DEFAULT 0,
    impound_storage_enabled TINYINT(1) NOT NULL DEFAULT 0,
    business_storage_enabled TINYINT(1) NOT NULL DEFAULT 0,
    store_enabled TINYINT(1) NOT NULL DEFAULT 0,
    retrieve_enabled TINYINT(1) NOT NULL DEFAULT 0,
    alt_confirmation_required TINYINT(1) NOT NULL DEFAULT 1,
    driver_required TINYINT(1) NOT NULL DEFAULT 1,
    vehicle_owner_required TINYINT(1) NOT NULL DEFAULT 1,
    one_active_storage_per_vehicle TINYINT(1) NOT NULL DEFAULT 1,
    max_locations INT UNSIGNED NOT NULL DEFAULT 512,
    max_slots_per_location SMALLINT UNSIGNED NOT NULL DEFAULT 10,
    source_tag VARCHAR(96) NOT NULL DEFAULT 'saif_v0.26A.1.30.1',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id), UNIQUE KEY uq_vehicle_storage_policy_key (policy_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO vehicle_storage_policy
(id,policy_key,enabled,house_storage_enabled,public_garage_storage_enabled,impound_storage_enabled,business_storage_enabled,store_enabled,retrieve_enabled,alt_confirmation_required,driver_required,vehicle_owner_required,one_active_storage_per_vehicle,max_locations,max_slots_per_location,source_tag)
VALUES (1,'unified_vehicle_storage_v1',0,0,0,0,0,0,0,1,1,1,1,512,10,'saif_v0.26A.1.30.1')
ON DUPLICATE KEY UPDATE policy_key=VALUES(policy_key),alt_confirmation_required=1,driver_required=1,vehicle_owner_required=1,one_active_storage_per_vehicle=1,max_locations=512,max_slots_per_location=10;

CREATE TABLE IF NOT EXISTS vehicle_storage_locations (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    storage_key VARCHAR(96) NOT NULL, storage_type VARCHAR(24) NOT NULL,
    reference_id BIGINT UNSIGNED NULL, location_name VARCHAR(96) NOT NULL,
    ownership_mode VARCHAR(32) NOT NULL DEFAULT 'none', access_mode VARCHAR(32) NOT NULL DEFAULT 'disabled',
    capacity SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    interaction_x FLOAT NOT NULL DEFAULT 0, interaction_y FLOAT NOT NULL DEFAULT 0, interaction_z FLOAT NOT NULL DEFAULT 0,
    interaction_radius FLOAT NOT NULL DEFAULT 2.5,
    spawn_x FLOAT NOT NULL DEFAULT 0, spawn_y FLOAT NOT NULL DEFAULT 0, spawn_z FLOAT NOT NULL DEFAULT 0, spawn_a FLOAT NOT NULL DEFAULT 0,
    interior_id INT NOT NULL DEFAULT 0, virtual_world INT NOT NULL DEFAULT 0,
    geometry_status VARCHAR(24) NOT NULL DEFAULT 'pending', enabled TINYINT(1) NOT NULL DEFAULT 0,
    apply_status VARCHAR(24) NOT NULL DEFAULT 'draft', source_tag VARCHAR(96) NOT NULL, row_checksum CHAR(64) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id), UNIQUE KEY uq_vehicle_storage_location_key (storage_key),
    KEY idx_vehicle_storage_location_type_ref (storage_type,reference_id), KEY idx_vehicle_storage_location_enabled (enabled,storage_type), KEY idx_vehicle_storage_location_source (source_tag)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS player_vehicle_storage (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    player_vehicle_id INT UNSIGNED NOT NULL, owner_player_id INT UNSIGNED NOT NULL,
    storage_location_id BIGINT UNSIGNED NOT NULL, storage_slot SMALLINT UNSIGNED NOT NULL,
    storage_status VARCHAR(24) NOT NULL DEFAULT 'stored', stored_health FLOAT NULL, stored_fuel INT NULL, stored_locked TINYINT(1) NULL,
    transaction_token CHAR(40) NOT NULL, stored_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, released_at TIMESTAMP NULL DEFAULT NULL,
    source_tag VARCHAR(96) NOT NULL DEFAULT 'saif_house_storage_runtime_v0.26A.1.30.1',
    PRIMARY KEY (id), UNIQUE KEY uq_player_vehicle_active_storage (player_vehicle_id),
    UNIQUE KEY uq_vehicle_storage_location_slot (storage_location_id,storage_slot), UNIQUE KEY uq_vehicle_storage_state_token (transaction_token),
    KEY idx_vehicle_storage_owner (owner_player_id), KEY idx_vehicle_storage_status (storage_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS vehicle_storage_transactions (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, transaction_token CHAR(40) NOT NULL,
    action_type VARCHAR(24) NOT NULL, status VARCHAR(24) NOT NULL DEFAULT 'pending',
    player_vehicle_id INT UNSIGNED NOT NULL, owner_player_id INT UNSIGNED NOT NULL,
    from_storage_location_id BIGINT UNSIGNED NULL, to_storage_location_id BIGINT UNSIGNED NULL, storage_slot SMALLINT UNSIGNED NULL,
    vehicle_health FLOAT NULL, vehicle_fuel INT NULL, vehicle_locked TINYINT(1) NULL, failure_reason VARCHAR(255) NULL,
    source_tag VARCHAR(96) NOT NULL DEFAULT 'saif_house_storage_runtime_v0.26A.1.30.1',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, completed_at TIMESTAMP NULL DEFAULT NULL,
    PRIMARY KEY (id), UNIQUE KEY uq_vehicle_storage_transaction_token (transaction_token),
    KEY idx_vehicle_storage_transaction_vehicle (player_vehicle_id,created_at), KEY idx_vehicle_storage_transaction_owner (owner_player_id,created_at),
    KEY idx_vehicle_storage_transaction_status (status,created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SELECT 'SCHEMA_GATE' section,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_storage_policy') policy_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_storage_locations') locations_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='player_vehicle_storage') state_table_should_be_1,
 (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='vehicle_storage_transactions') transactions_table_should_be_1;
