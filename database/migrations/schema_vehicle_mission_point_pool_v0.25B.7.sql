-- SAIF / LSIF Dev v0.25B.7
-- Vehicle Mission Point Pool: banyak spawn/checkpoint random per mission.
-- Aman dijalankan berulang.

CREATE TABLE IF NOT EXISTS vehicle_mission_point_pool (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mission_code VARCHAR(32) NOT NULL,
    point_name VARCHAR(64) NOT NULL DEFAULT 'Random Point',
    enabled TINYINT(1) NOT NULL DEFAULT 1,
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
    source_tag VARCHAR(32) NOT NULL DEFAULT 'manual_pool',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_vmpool_mission_enabled (mission_code, enabled),
    INDEX idx_vmpool_enabled (enabled)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed pool awal dari single fallback v0.25B.6 jika sudah ada titik yang valid.
-- Ini tidak duplicate per mission+source_tag agar migration aman diulang.
INSERT INTO vehicle_mission_point_pool
(
    mission_code,
    point_name,
    enabled,
    spawn_x,
    spawn_y,
    spawn_z,
    spawn_a,
    checkpoint_x,
    checkpoint_y,
    checkpoint_z,
    checkpoint_radius,
    fire_offset_x,
    fire_offset_y,
    fire_offset_z,
    source_tag
)
SELECT
    vmp.mission_code,
    CONCAT(vmp.label, ' Default Pool Point'),
    1,
    vmp.spawn_x,
    vmp.spawn_y,
    vmp.spawn_z,
    vmp.spawn_a,
    vmp.checkpoint_x,
    vmp.checkpoint_y,
    vmp.checkpoint_z,
    CASE WHEN vmp.checkpoint_radius > 0 THEN vmp.checkpoint_radius ELSE 5 END,
    vmp.fire_offset_x,
    CASE WHEN vmp.fire_offset_y = 0 AND vmp.fire_offset_z = 0 THEN 2.1 ELSE vmp.fire_offset_y END,
    CASE WHEN vmp.fire_offset_y = 0 AND vmp.fire_offset_z = 0 THEN 0.55 ELSE vmp.fire_offset_z END,
    'seed_from_single_fallback'
FROM vehicle_mission_points vmp
WHERE vmp.enabled = 1
  AND (
        vmp.spawn_x <> 0 OR vmp.spawn_y <> 0 OR vmp.spawn_z <> 0
        OR vmp.checkpoint_x <> 0 OR vmp.checkpoint_y <> 0 OR vmp.checkpoint_z <> 0
      )
  AND NOT EXISTS (
        SELECT 1
        FROM vehicle_mission_point_pool pool
        WHERE pool.mission_code = vmp.mission_code
          AND pool.source_tag = 'seed_from_single_fallback'
      );
