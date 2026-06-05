-- SAIF / LSIF Dev v0.24K.21D — Orphan Integrity Archive Pass
-- ROLLBACK: restores rows archived by this pass back into runtime tables.
-- This only works after db_orphan_apply_v0.24K.21D.sql created the archive tables.

INSERT IGNORE INTO player_vehicles SELECT * FROM saif_archive_v024K21D_player_vehicles;
INSERT IGNORE INTO player_houses SELECT * FROM saif_archive_v024K21D_player_houses;
INSERT IGNORE INTO player_businesses SELECT * FROM saif_archive_v024K21D_player_businesses;
INSERT IGNORE INTO player_weapons SELECT * FROM saif_archive_v024K21D_player_weapons;
INSERT IGNORE INTO organization_members SELECT * FROM saif_archive_v024K21D_organization_members;
INSERT IGNORE INTO gang_members SELECT * FROM saif_archive_v024K21D_gang_members;
INSERT IGNORE INTO gang_weapon_stash SELECT * FROM saif_archive_v024K21D_gang_weapon_stash;
INSERT IGNORE INTO race_records SELECT * FROM saif_archive_v024K21D_race_records;
INSERT IGNORE INTO job_stats SELECT * FROM saif_archive_v024K21D_job_stats;

SELECT 'rollback_player_vehicles' AS restored_table, COUNT(*) AS archive_rows FROM saif_archive_v024K21D_player_vehicles;
SELECT 'rollback_player_houses' AS restored_table, COUNT(*) AS archive_rows FROM saif_archive_v024K21D_player_houses;
SELECT 'rollback_player_businesses' AS restored_table, COUNT(*) AS archive_rows FROM saif_archive_v024K21D_player_businesses;
SELECT 'rollback_player_weapons' AS restored_table, COUNT(*) AS archive_rows FROM saif_archive_v024K21D_player_weapons;
SELECT 'rollback_organization_members' AS restored_table, COUNT(*) AS archive_rows FROM saif_archive_v024K21D_organization_members;
SELECT 'rollback_gang_members' AS restored_table, COUNT(*) AS archive_rows FROM saif_archive_v024K21D_gang_members;
SELECT 'rollback_gang_weapon_stash' AS restored_table, COUNT(*) AS archive_rows FROM saif_archive_v024K21D_gang_weapon_stash;
SELECT 'rollback_race_records' AS restored_table, COUNT(*) AS archive_rows FROM saif_archive_v024K21D_race_records;
SELECT 'rollback_job_stats' AS restored_table, COUNT(*) AS archive_rows FROM saif_archive_v024K21D_job_stats;
