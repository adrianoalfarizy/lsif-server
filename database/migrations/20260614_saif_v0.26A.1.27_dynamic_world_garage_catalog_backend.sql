-- SAIF / LSIF Dev v0.26A.1.27
-- Dynamic World Garage Catalog Backend & House Link Bridge
-- SAFETY: schema + disabled policy only. No garage rows, house links, vehicles, doors, checkpoints, or ownership are applied.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS garage_runtime_policy (
    id TINYINT UNSIGNED NOT NULL,
    policy_key VARCHAR(64) NOT NULL,
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    max_catalog_rows SMALLINT UNSIGNED NOT NULL DEFAULT 64,
    interaction_radius DECIMAL(8,2) NOT NULL DEFAULT 5.00,
    vehicle_required TINYINT(1) NOT NULL DEFAULT 1,
    inherit_house_owner TINYINT(1) NOT NULL DEFAULT 1,
    store_enabled TINYINT(1) NOT NULL DEFAULT 0,
    retrieve_enabled TINYINT(1) NOT NULL DEFAULT 0,
    door_animation_enabled TINYINT(1) NOT NULL DEFAULT 0,
    notes VARCHAR(768) NOT NULL DEFAULT '',
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_garage_runtime_policy_key (policy_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO garage_runtime_policy
(id,policy_key,enabled,max_catalog_rows,interaction_radius,vehicle_required,inherit_house_owner,store_enabled,retrieve_enabled,door_animation_enabled,notes)
VALUES
(1,'offline_house_garage_bridge_v1',0,64,5.00,1,1,0,0,0,
 'v0.26A.1.27 backend foundation only. Physical garage runtime, vehicle storage/retrieval and door animation remain disabled until geometry/spawn planning and controlled apply are complete.')
ON DUPLICATE KEY UPDATE
 policy_key=VALUES(policy_key),
 enabled=0,
 max_catalog_rows=VALUES(max_catalog_rows),
 interaction_radius=VALUES(interaction_radius),
 vehicle_required=VALUES(vehicle_required),
 inherit_house_owner=VALUES(inherit_house_owner),
 store_enabled=0,
 retrieve_enabled=0,
 door_animation_enabled=0,
 notes=VALUES(notes);

CREATE TABLE IF NOT EXISTS garage_catalog (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    canonical_garage_plan_id BIGINT UNSIGNED NULL,
    source_queue_id BIGINT UNSIGNED NOT NULL,
    garage_key CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
    garage_name VARCHAR(40) NOT NULL,
    runtime_class VARCHAR(40) NOT NULL DEFAULT 'house_garage',
    safety_class VARCHAR(48) NOT NULL DEFAULT 'baseline_savehouse_candidate',
    garage_type INT NOT NULL DEFAULT -1,
    garage_door_type INT NOT NULL DEFAULT -1,
    center_x FLOAT NOT NULL DEFAULT 0,
    center_y FLOAT NOT NULL DEFAULT 0,
    center_z FLOAT NOT NULL DEFAULT 0,
    bound_x1 FLOAT NOT NULL DEFAULT 0,
    bound_y1 FLOAT NOT NULL DEFAULT 0,
    bound_z1 FLOAT NOT NULL DEFAULT 0,
    bound_x2 FLOAT NOT NULL DEFAULT 0,
    bound_y2 FLOAT NOT NULL DEFAULT 0,
    bound_x3 FLOAT NOT NULL DEFAULT 0,
    bound_y3 FLOAT NOT NULL DEFAULT 0,
    bound_z2 FLOAT NOT NULL DEFAULT 0,
    interaction_x FLOAT NOT NULL DEFAULT 0,
    interaction_y FLOAT NOT NULL DEFAULT 0,
    interaction_z FLOAT NOT NULL DEFAULT 0,
    vehicle_spawn_x FLOAT NULL,
    vehicle_spawn_y FLOAT NULL,
    vehicle_spawn_z FLOAT NULL,
    vehicle_spawn_a FLOAT NULL,
    spawn_status VARCHAR(24) NOT NULL DEFAULT 'unresolved',
    source_file VARCHAR(512) NOT NULL DEFAULT '',
    source_line INT UNSIGNED NOT NULL DEFAULT 0,
    source_record_hash CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
    city_region VARCHAR(32) NOT NULL DEFAULT '',
    area_code VARCHAR(32) NOT NULL DEFAULT '',
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    apply_status VARCHAR(24) NOT NULL DEFAULT 'draft',
    sort_order INT NOT NULL DEFAULT 0,
    source_tag VARCHAR(64) NOT NULL DEFAULT 'offline_gtasa_garage_catalog',
    row_checksum CHAR(64) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL DEFAULT '',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_garage_catalog_plan (canonical_garage_plan_id),
    UNIQUE KEY uq_garage_catalog_source (source_queue_id),
    UNIQUE KEY uq_garage_catalog_key (garage_key),
    KEY idx_garage_catalog_runtime (enabled,apply_status,runtime_class),
    KEY idx_garage_catalog_source_tag (source_tag),
    KEY idx_garage_catalog_sort (sort_order,id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS house_garage_links (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    house_catalog_id BIGINT UNSIGNED NOT NULL,
    garage_catalog_id BIGINT UNSIGNED NOT NULL,
    canonical_house_slot INT NULL,
    link_class VARCHAR(48) NOT NULL DEFAULT 'baseline_savehouse_candidate',
    ownership_mode VARCHAR(32) NOT NULL DEFAULT 'inherit_house_owner',
    access_mode VARCHAR(32) NOT NULL DEFAULT 'house_owner_only',
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    source_tag VARCHAR(64) NOT NULL DEFAULT 'offline_gtasa_house_garage_link',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_house_garage_house (house_catalog_id),
    UNIQUE KEY uq_house_garage_pair (house_catalog_id,garage_catalog_id),
    KEY idx_house_garage_garage (garage_catalog_id),
    KEY idx_house_garage_enabled (enabled,link_class)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SELECT 'WORLD_GARAGE_BACKEND_SCHEMA' section,
       (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='garage_runtime_policy') policy_table_should_be_1,
       (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='garage_catalog') catalog_table_should_be_1,
       (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='house_garage_links') links_table_should_be_1;

SELECT 'WORLD_GARAGE_POLICY' section,policy_key,enabled,max_catalog_rows,interaction_radius,vehicle_required,
       inherit_house_owner,store_enabled,retrieve_enabled,door_animation_enabled,
       (enabled=0 AND store_enabled=0 AND retrieve_enabled=0 AND door_animation_enabled=0) safety_disabled_should_be_1
FROM garage_runtime_policy WHERE id=1;
