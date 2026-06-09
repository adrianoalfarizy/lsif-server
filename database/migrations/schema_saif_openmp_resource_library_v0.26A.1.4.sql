-- SAIF / LSIF Dev v0.26A.1.4
-- Open.mp Offline-like Resource Library
-- Purpose: copy official open.mp resource references into DB as a staging/library table.
-- IMPORTANT: This does NOT spawn anything in game. It only stores IDs/names/raw rows for later review.

CREATE TABLE IF NOT EXISTS saif_resource_sources (
    id INT AUTO_INCREMENT PRIMARY KEY,
    source_key VARCHAR(64) NOT NULL UNIQUE,
    title VARCHAR(128) NOT NULL,
    source_url VARCHAR(255) NOT NULL,
    offline_like TINYINT NOT NULL DEFAULT 1,
    enabled TINYINT NOT NULL DEFAULT 1,
    last_imported_at DATETIME NULL,
    imported_rows INT NOT NULL DEFAULT 0,
    notes VARCHAR(255) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS saif_resource_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    source_key VARCHAR(64) NOT NULL,
    resource_group VARCHAR(64) NOT NULL,
    external_id INT NULL,
    name VARCHAR(128) NULL,
    category VARCHAR(128) NULL,
    model_name VARCHAR(128) NULL,
    raw_label VARCHAR(255) NULL,
    raw_json JSON NULL,
    offline_like TINYINT NOT NULL DEFAULT 1,
    enabled TINYINT NOT NULL DEFAULT 0,
    imported_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_saif_resource_item (source_key, resource_group, external_id, raw_label),
    KEY idx_resource_group (resource_group),
    KEY idx_external_id (external_id),
    KEY idx_name (name),
    KEY idx_category (category),
    CONSTRAINT fk_saif_resource_items_source
        FOREIGN KEY (source_key) REFERENCES saif_resource_sources(source_key)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS saif_resource_import_logs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    source_key VARCHAR(64) NOT NULL,
    source_url VARCHAR(255) NOT NULL,
    status VARCHAR(32) NOT NULL,
    rows_found INT NOT NULL DEFAULT 0,
    message TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    KEY idx_source_key (source_key),
    KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Source registry. The importer will update imported_rows and last_imported_at.
INSERT INTO saif_resource_sources (source_key, title, source_url, offline_like, notes) VALUES
('vehicleid', 'Vehicle IDs', 'https://open.mp/docs/scripting/resources/vehicleid', 1, 'Vehicle model IDs/categories/seats/mod shops for parked vehicles, jobs, traffic, missions.'),
('skins', 'Skins', 'https://open.mp/docs/scripting/resources/skins', 1, 'Skin IDs for clothing shop, gangs, jobs, NPC-like actors.'),
('weaponids', 'Weapon IDs', 'https://open.mp/docs/scripting/resources/weaponids', 1, 'Weapon IDs for Ammu-Nation, death reason, loadout, gang stash.'),
('pickupids', 'Pickup IDs', 'https://open.mp/docs/scripting/resources/pickupids', 1, 'Common pickup model IDs for bribes, armor, health, icons.'),
('animations', 'Animations', 'https://open.mp/docs/scripting/resources/animations', 1, 'Animation library/name list for service actions and offline-like interactions.'),
('sound_ids', 'Sound IDs', 'https://open.mp/docs/scripting/resources/sound-ids', 1, 'PlayerPlaySound IDs for offline-like ambience and feedback.'),
('shopnames', 'Shop Names', 'https://open.mp/docs/scripting/resources/shopnames', 1, 'SetPlayerShopName names for GTA SA shop script behavior.'),
('samp_objects', 'SA-MP Objects', 'https://open.mp/docs/scripting/resources/samp_objects', 1, 'SA-MP custom object IDs, useful for maps/editor/interiors.'),
('textdrawsprites', 'TextDraw Sprites', 'https://open.mp/docs/scripting/resources/textdrawsprites', 1, 'Sprite names for unique UI/UX and themed menus.'),
('vehiclecolorid', 'Vehicle Color IDs', 'https://open.mp/docs/scripting/resources/vehiclecolorid', 1, 'Vehicle color palette references.'),
('paintjobs', 'Paintjobs', 'https://open.mp/docs/scripting/resources/paintjobs', 1, 'ChangeVehiclePaintjob references.'),
('vehicleinformationtypes', 'Vehicle Information Types', 'https://open.mp/docs/scripting/resources/vehicleinformationtypes', 1, 'GetVehicleModelInfo types for fire offset/checkpoint helpers.'),
('keys', 'Keys', 'https://open.mp/docs/scripting/resources/keys', 1, 'Key constants for ALT / FIRE / vehicle mission interactions.'),
('playerstates', 'Player States', 'https://open.mp/docs/scripting/resources/playerstates', 1, 'GetPlayerState values for interaction validation.'),
('bullethittypes', 'Bullet Hit Types', 'https://open.mp/docs/scripting/resources/bullethittypes', 1, 'OnPlayerWeaponShot hit type references for future crime/weapon hooks.')
ON DUPLICATE KEY UPDATE
    title = VALUES(title),
    source_url = VALUES(source_url),
    offline_like = VALUES(offline_like),
    notes = VALUES(notes),
    updated_at = CURRENT_TIMESTAMP;

-- Verification helpers
SELECT 'saif_resource_sources_count' AS check_name, COUNT(*) AS value FROM saif_resource_sources;
SELECT 'saif_resource_items_count_before_import' AS check_name, COUNT(*) AS value FROM saif_resource_items;
