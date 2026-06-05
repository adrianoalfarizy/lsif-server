-- SAIF / LSIF Dev v0.24K.21D — Orphan Integrity Archive Pass
-- APPLY: archives safe orphan runtime rows into versioned archive tables, then removes them from runtime tables.
-- Does NOT touch logs, player rows, organizations, active world rows, exact-source rows, or schema structure.
-- Run db_orphan_dryrun_v0.24K.21D.sql first and take a full DB backup before this script.

CREATE TABLE IF NOT EXISTS saif_archive_v024K21D_player_vehicles LIKE player_vehicles;
INSERT IGNORE INTO saif_archive_v024K21D_player_vehicles
SELECT pv.*
FROM player_vehicles pv
LEFT JOIN players p ON p.id = pv.owner_id
WHERE p.id IS NULL;
DELETE pv
FROM player_vehicles pv
LEFT JOIN players p ON p.id = pv.owner_id
WHERE p.id IS NULL;

CREATE TABLE IF NOT EXISTS saif_archive_v024K21D_player_houses LIKE player_houses;
INSERT IGNORE INTO saif_archive_v024K21D_player_houses
SELECT ph.*
FROM player_houses ph
LEFT JOIN players p ON p.id = ph.owner_id
WHERE p.id IS NULL;
DELETE ph
FROM player_houses ph
LEFT JOIN players p ON p.id = ph.owner_id
WHERE p.id IS NULL;

CREATE TABLE IF NOT EXISTS saif_archive_v024K21D_player_businesses LIKE player_businesses;
INSERT IGNORE INTO saif_archive_v024K21D_player_businesses
SELECT pb.*
FROM player_businesses pb
LEFT JOIN players p ON p.id = pb.owner_id
WHERE p.id IS NULL;
DELETE pb
FROM player_businesses pb
LEFT JOIN players p ON p.id = pb.owner_id
WHERE p.id IS NULL;

CREATE TABLE IF NOT EXISTS saif_archive_v024K21D_player_weapons LIKE player_weapons;
INSERT IGNORE INTO saif_archive_v024K21D_player_weapons
SELECT pw.*
FROM player_weapons pw
LEFT JOIN players p ON p.id = pw.player_id
WHERE p.id IS NULL;
DELETE pw
FROM player_weapons pw
LEFT JOIN players p ON p.id = pw.player_id
WHERE p.id IS NULL;

CREATE TABLE IF NOT EXISTS saif_archive_v024K21D_organization_members LIKE organization_members;
INSERT IGNORE INTO saif_archive_v024K21D_organization_members
SELECT om.*
FROM organization_members om
LEFT JOIN players p ON p.id = om.player_id
LEFT JOIN organizations o ON o.id = om.org_id
WHERE p.id IS NULL OR o.id IS NULL;
DELETE om
FROM organization_members om
LEFT JOIN players p ON p.id = om.player_id
LEFT JOIN organizations o ON o.id = om.org_id
WHERE p.id IS NULL OR o.id IS NULL;

CREATE TABLE IF NOT EXISTS saif_archive_v024K21D_gang_members LIKE gang_members;
INSERT IGNORE INTO saif_archive_v024K21D_gang_members
SELECT gm.*
FROM gang_members gm
LEFT JOIN players p ON p.id = gm.player_id
LEFT JOIN gang_preset_config g ON g.gang_id = gm.gang_id
WHERE p.id IS NULL OR g.gang_id IS NULL;
DELETE gm
FROM gang_members gm
LEFT JOIN players p ON p.id = gm.player_id
LEFT JOIN gang_preset_config g ON g.gang_id = gm.gang_id
WHERE p.id IS NULL OR g.gang_id IS NULL;

CREATE TABLE IF NOT EXISTS saif_archive_v024K21D_gang_weapon_stash LIKE gang_weapon_stash;
INSERT IGNORE INTO saif_archive_v024K21D_gang_weapon_stash
SELECT gws.*
FROM gang_weapon_stash gws
LEFT JOIN gang_preset_config g ON g.gang_id = gws.gang_id
WHERE g.gang_id IS NULL;
DELETE gws
FROM gang_weapon_stash gws
LEFT JOIN gang_preset_config g ON g.gang_id = gws.gang_id
WHERE g.gang_id IS NULL;

CREATE TABLE IF NOT EXISTS saif_archive_v024K21D_race_records LIKE race_records;
INSERT IGNORE INTO saif_archive_v024K21D_race_records
SELECT rr.*
FROM race_records rr
LEFT JOIN players p ON p.id = rr.player_id
WHERE p.id IS NULL;
DELETE rr
FROM race_records rr
LEFT JOIN players p ON p.id = rr.player_id
WHERE p.id IS NULL;

CREATE TABLE IF NOT EXISTS saif_archive_v024K21D_job_stats LIKE job_stats;
INSERT IGNORE INTO saif_archive_v024K21D_job_stats
SELECT js.*
FROM job_stats js
LEFT JOIN players p ON p.id = js.player_id
WHERE p.id IS NULL;
DELETE js
FROM job_stats js
LEFT JOIN players p ON p.id = js.player_id
WHERE p.id IS NULL;

-- Post-apply summary.
SELECT 'archive_player_vehicles' AS archive_table, COUNT(*) AS archived_rows FROM saif_archive_v024K21D_player_vehicles;
SELECT 'archive_player_houses' AS archive_table, COUNT(*) AS archived_rows FROM saif_archive_v024K21D_player_houses;
SELECT 'archive_player_businesses' AS archive_table, COUNT(*) AS archived_rows FROM saif_archive_v024K21D_player_businesses;
SELECT 'archive_player_weapons' AS archive_table, COUNT(*) AS archived_rows FROM saif_archive_v024K21D_player_weapons;
SELECT 'archive_organization_members' AS archive_table, COUNT(*) AS archived_rows FROM saif_archive_v024K21D_organization_members;
SELECT 'archive_gang_members' AS archive_table, COUNT(*) AS archived_rows FROM saif_archive_v024K21D_gang_members;
SELECT 'archive_gang_weapon_stash' AS archive_table, COUNT(*) AS archived_rows FROM saif_archive_v024K21D_gang_weapon_stash;
SELECT 'archive_race_records' AS archive_table, COUNT(*) AS archived_rows FROM saif_archive_v024K21D_race_records;
SELECT 'archive_job_stats' AS archive_table, COUNT(*) AS archived_rows FROM saif_archive_v024K21D_job_stats;
