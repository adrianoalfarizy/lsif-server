-- SAIF / LSIF Dev v0.24K.21C
-- Dry-run only: review disabled deprecated curated template rows before archive/delete.
-- This script performs SELECT only. Safe to run repeatedly.

SELECT 'parked_vehicles disabled deprecated curated template' AS item,
       COUNT(*) AS total
FROM parked_vehicles
WHERE enabled = 0 AND source_tag = 'offline_template_ls';

SELECT id, modelid, color1, color2, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, respawn_delay, locked, enabled, source_tag, created_at, updated_at
FROM parked_vehicles
WHERE enabled = 0 AND source_tag = 'offline_template_ls'
ORDER BY id
LIMIT 20;

SELECT 'world_pickups disabled deprecated curated template' AS item,
       COUNT(*) AS total
FROM world_pickups
WHERE enabled = 0 AND source_tag = 'offline_template_ls';

SELECT id, pickup_type, display_name, model_id, pos_x, pos_y, pos_z, interior, virtual_world, amount, cooldown_seconds, source_tag, enabled, created_at, updated_at
FROM world_pickups
WHERE enabled = 0 AND source_tag = 'offline_template_ls'
ORDER BY id
LIMIT 20;

-- These are intentionally NOT cleaned by v0.24K.21C. Review only.
SELECT 'world_locations disabled legacy_static_migrated - review only' AS item,
       COUNT(*) AS total
FROM world_locations
WHERE enabled = 0 AND source_tag = 'legacy_static_migrated';

SELECT 'public_interiors disabled manual - review only' AS item,
       COUNT(*) AS total
FROM public_interiors
WHERE enabled = 0 AND source_tag = 'manual';
