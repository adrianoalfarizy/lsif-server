-- SAIF / LSIF Dev v0.24K.21D — Orphan Integrity Archive Pass
-- DRY RUN ONLY: shows candidate orphan rows. Does not modify data.

SELECT 'player_vehicles_without_player' AS check_name, COUNT(*) AS candidate_rows
FROM player_vehicles pv
LEFT JOIN players p ON p.id = pv.owner_id
WHERE p.id IS NULL;

SELECT 'player_houses_without_player' AS check_name, COUNT(*) AS candidate_rows
FROM player_houses ph
LEFT JOIN players p ON p.id = ph.owner_id
WHERE p.id IS NULL;

SELECT 'player_businesses_without_player' AS check_name, COUNT(*) AS candidate_rows
FROM player_businesses pb
LEFT JOIN players p ON p.id = pb.owner_id
WHERE p.id IS NULL;

SELECT 'player_weapons_without_player' AS check_name, COUNT(*) AS candidate_rows
FROM player_weapons pw
LEFT JOIN players p ON p.id = pw.player_id
WHERE p.id IS NULL;

SELECT 'organization_members_without_player_or_org' AS check_name, COUNT(*) AS candidate_rows
FROM organization_members om
LEFT JOIN players p ON p.id = om.player_id
LEFT JOIN organizations o ON o.id = om.org_id
WHERE p.id IS NULL OR o.id IS NULL;

SELECT 'gang_members_without_player_or_gang' AS check_name, COUNT(*) AS candidate_rows
FROM gang_members gm
LEFT JOIN players p ON p.id = gm.player_id
LEFT JOIN gang_preset_config g ON g.gang_id = gm.gang_id
WHERE p.id IS NULL OR g.gang_id IS NULL;

SELECT 'gang_weapon_stash_without_gang' AS check_name, COUNT(*) AS candidate_rows
FROM gang_weapon_stash gws
LEFT JOIN gang_preset_config g ON g.gang_id = gws.gang_id
WHERE g.gang_id IS NULL;

SELECT 'race_records_without_player' AS check_name, COUNT(*) AS candidate_rows
FROM race_records rr
LEFT JOIN players p ON p.id = rr.player_id
WHERE p.id IS NULL;

SELECT 'job_stats_without_player' AS check_name, COUNT(*) AS candidate_rows
FROM job_stats js
LEFT JOIN players p ON p.id = js.player_id
WHERE p.id IS NULL;

-- Review-only legacy/deprecated candidates. These are NOT touched by apply script.
SELECT 'review_only_organizations_without_owner_player' AS check_name, COUNT(*) AS candidate_rows
FROM organizations o
LEFT JOIN players p ON p.id = o.owner_id
WHERE o.owner_id IS NOT NULL AND p.id IS NULL;

SELECT 'review_only_gang_territories_with_legacy_owner_org' AS check_name, COUNT(*) AS candidate_rows
FROM gang_territories
WHERE owner_org_id IS NOT NULL AND owner_org_id <> 0;
