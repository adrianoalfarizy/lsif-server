-- SAIF / LSIF Dev v0.24K.21C rollback helper
-- Restores rows archived by db_cleanup_apply_v0.24K.21C.sql if their original IDs are still free.
-- This does NOT delete archive rows. It uses INSERT IGNORE to avoid overwriting any newer row that reused the same ID.

START TRANSACTION;

INSERT IGNORE INTO parked_vehicles
(id, modelid, color1, color2, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, respawn_delay, locked, enabled, source_tag, created_at, updated_at)
SELECT id, modelid, color1, color2, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, respawn_delay, locked, enabled, source_tag, created_at, updated_at
FROM saif_archive_parked_vehicles
WHERE source_tag = 'offline_template_ls'
  AND archive_reason LIKE 'v0.24K.21C%';

INSERT IGNORE INTO world_pickups
(id, pickup_type, display_name, model_id, pos_x, pos_y, pos_z, interior, virtual_world, amount, cooldown_seconds, source_tag, enabled, created_at, updated_at)
SELECT id, pickup_type, display_name, model_id, pos_x, pos_y, pos_z, interior, virtual_world, amount, cooldown_seconds, source_tag, enabled, created_at, updated_at
FROM saif_archive_world_pickups
WHERE source_tag = 'offline_template_ls'
  AND archive_reason LIKE 'v0.24K.21C%';

COMMIT;

SELECT 'restored parked_vehicles disabled deprecated curated template' AS item,
       COUNT(*) AS total
FROM parked_vehicles
WHERE enabled = 0 AND source_tag = 'offline_template_ls';

SELECT 'restored world_pickups disabled deprecated curated template' AS item,
       COUNT(*) AS total
FROM world_pickups
WHERE enabled = 0 AND source_tag = 'offline_template_ls';
