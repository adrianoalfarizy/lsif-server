-- SAIF / LSIF Dev v0.25B.6
-- Vehicle Mission Point Editor
-- Adds DB-backed spawn/checkpoint/fire-offset config for vehicle mission families.

CREATE TABLE IF NOT EXISTS vehicle_mission_points (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mission_code VARCHAR(32) NOT NULL,
    label VARCHAR(64) NOT NULL,
    enabled TINYINT NOT NULL DEFAULT 0,
    spawn_x FLOAT NOT NULL DEFAULT 0,
    spawn_y FLOAT NOT NULL DEFAULT 0,
    spawn_z FLOAT NOT NULL DEFAULT 0,
    spawn_a FLOAT NOT NULL DEFAULT 0,
    checkpoint_x FLOAT NOT NULL DEFAULT 0,
    checkpoint_y FLOAT NOT NULL DEFAULT 0,
    checkpoint_z FLOAT NOT NULL DEFAULT 0,
    checkpoint_radius FLOAT NOT NULL DEFAULT 5,
    fire_offset_x FLOAT NOT NULL DEFAULT 0,
    fire_offset_y FLOAT NOT NULL DEFAULT 2.1,
    fire_offset_z FLOAT NOT NULL DEFAULT 0.55,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_vehicle_mission_points_code (mission_code),
    KEY idx_vehicle_mission_points_enabled (enabled),
    KEY idx_vehicle_mission_points_label (label)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO vehicle_mission_points
(mission_code, label, enabled, checkpoint_radius, fire_offset_x, fire_offset_y, fire_offset_z)
VALUES
('courier', 'Courier Delivery', 0, 4.0, 0.0, 2.1, 0.55),
('taxi', 'Taxi Ride', 0, 4.0, 0.0, 2.1, 0.55),
('trucker', 'Trucker Freight', 0, 6.0, 0.0, 2.1, 0.55),
('bus', 'Bus Route', 0, 7.0, 0.0, 2.1, 0.55),
('police', 'Police / Vigilante', 0, 5.0, 0.0, 2.1, 0.55),
('paramedic', 'Paramedic / Ambulance', 0, 5.0, 0.0, 2.1, 0.55),
('firefighter', 'Firefighter', 0, 6.0, 0.0, 2.1, 0.55)
ON DUPLICATE KEY UPDATE
    label = VALUES(label),
    checkpoint_radius = CASE
        WHEN checkpoint_radius IS NULL OR checkpoint_radius <= 0 THEN VALUES(checkpoint_radius)
        ELSE checkpoint_radius
    END,
    fire_offset_x = CASE WHEN fire_offset_x IS NULL THEN VALUES(fire_offset_x) ELSE fire_offset_x END,
    fire_offset_y = CASE WHEN fire_offset_y IS NULL THEN VALUES(fire_offset_y) ELSE fire_offset_y END,
    fire_offset_z = CASE WHEN fire_offset_z IS NULL THEN VALUES(fire_offset_z) ELSE fire_offset_z END;
