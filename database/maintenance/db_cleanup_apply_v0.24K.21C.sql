-- SAIF / LSIF Dev v0.24K.21C
-- Deprecated Template Archive Pass
-- Purpose:
--   Archive and remove disabled curated fallback template rows that are no longer used at runtime.
--   This does NOT touch exact-source rows, manual rows, active rows, players, logs, businesses, gangs, or public interiors.
-- Safety:
--   1. Make a full DB backup first.
--   2. Run db_cleanup_dryrun_v0.24K.21C.sql first.
--   3. This script archives rows into saif_archive_* tables before deletion.

CREATE TABLE IF NOT EXISTS saif_archive_parked_vehicles LIKE parked_vehicles;
ALTER TABLE saif_archive_parked_vehicles ADD COLUMN IF NOT EXISTS archived_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE saif_archive_parked_vehicles ADD COLUMN IF NOT EXISTS archive_reason VARCHAR(255) NOT NULL DEFAULT '';

CREATE TABLE IF NOT EXISTS saif_archive_world_pickups LIKE world_pickups;
ALTER TABLE saif_archive_world_pickups ADD COLUMN IF NOT EXISTS archived_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE saif_archive_world_pickups ADD COLUMN IF NOT EXISTS archive_reason VARCHAR(255) NOT NULL DEFAULT '';

START TRANSACTION;

-- Archive disabled curated parked vehicle templates.
INSERT INTO saif_archive_parked_vehicles
(id, modelid, color1, color2, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, respawn_delay, locked, enabled, source_tag, created_at, updated_at, archived_at, archive_reason)
SELECT id, modelid, color1, color2, pos_x, pos_y, pos_z, pos_a, interior, virtual_world, respawn_delay, locked, enabled, source_tag, created_at, updated_at, NOW(), 'v0.24K.21C disabled deprecated curated template cleanup'
FROM parked_vehicles
WHERE enabled = 0 AND source_tag = 'offline_template_ls'
ON DUPLICATE KEY UPDATE
    archived_at = VALUES(archived_at),
    archive_reason = VALUES(archive_reason);

-- Archive disabled curated world pickup templates.
INSERT INTO saif_archive_world_pickups
(id, pickup_type, display_name, model_id, pos_x, pos_y, pos_z, interior, virtual_world, amount, cooldown_seconds, source_tag, enabled, created_at, updated_at, archived_at, archive_reason)
SELECT id, pickup_type, display_name, model_id, pos_x, pos_y, pos_z, interior, virtual_world, amount, cooldown_seconds, source_tag, enabled, created_at, updated_at, NOW(), 'v0.24K.21C disabled deprecated curated template cleanup'
FROM world_pickups
WHERE enabled = 0 AND source_tag = 'offline_template_ls'
ON DUPLICATE KEY UPDATE
    archived_at = VALUES(archived_at),
    archive_reason = VALUES(archive_reason);

-- Delete only disabled deprecated curated fallback rows.
DELETE FROM parked_vehicles
WHERE enabled = 0 AND source_tag = 'offline_template_ls';

DELETE FROM world_pickups
WHERE enabled = 0 AND source_tag = 'offline_template_ls';

COMMIT;

-- Post-cleanup summary.
SELECT 'remaining parked_vehicles disabled deprecated curated template' AS item,
       COUNT(*) AS total
FROM parked_vehicles
WHERE enabled = 0 AND source_tag = 'offline_template_ls';

SELECT 'archived parked_vehicles disabled deprecated curated template' AS item,
       COUNT(*) AS total
FROM saif_archive_parked_vehicles
WHERE source_tag = 'offline_template_ls' AND archive_reason LIKE 'v0.24K.21C%';

SELECT 'remaining world_pickups disabled deprecated curated template' AS item,
       COUNT(*) AS total
FROM world_pickups
WHERE enabled = 0 AND source_tag = 'offline_template_ls';

SELECT 'archived world_pickups disabled deprecated curated template' AS item,
       COUNT(*) AS total
FROM saif_archive_world_pickups
WHERE source_tag = 'offline_template_ls' AND archive_reason LIKE 'v0.24K.21C%';
