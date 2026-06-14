-- SAIF / LSIF Dev v0.26A.1.24
-- Capture current house_catalog and player_houses ownership before GTA SA 29-savehouse replacement.
-- SAFETY: writes archive/staging tables only. house_catalog and player_houses remain untouched.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @archive_session_key := CONCAT('housecatalog_pre_gtasa29_', DATE_FORMAT(NOW(6), '%Y%m%d%H%i%s%f'));

INSERT INTO offline_runtime_archive_sessions
(session_key,archive_scope,archive_label,archive_status,runtime_rows_total,active_rows_total,target_rows_total,archived_rows,notes)
SELECT @archive_session_key,'house_catalog','Before GTA SA 29-savehouse catalog replacement','capturing',
       COUNT(*),COALESCE(SUM(enabled=1),0),29,0,
       CONCAT('Full house_catalog snapshot plus player_houses ownership snapshot. Ownership rows at capture: ',(SELECT COUNT(*) FROM player_houses),'. Runtime tables are not mutated.')
FROM house_catalog;
SET @archive_session_id := LAST_INSERT_ID();

INSERT INTO offline_house_catalog_archive
(archive_session_id,original_id,legacy_house_index,canonical_slot,display_name,price,
 exterior_pickup_x,exterior_pickup_y,exterior_pickup_z,exterior_facing,
 exterior_spawn_x,exterior_spawn_y,exterior_spawn_z,exterior_spawn_a,
 interior_id,interior_exit_x,interior_exit_y,interior_exit_z,
 interior_spawn_x,interior_spawn_y,interior_spawn_z,interior_spawn_a,
 savepoint_x,savepoint_y,savepoint_z,garage_source_evidence_id,
 map_icon_type,pickup_model,pickup_type,private_vw_required,enabled,sort_order,source_tag,row_checksum)
SELECT @archive_session_id,id,legacy_house_index,canonical_slot,display_name,price,
       exterior_pickup_x,exterior_pickup_y,exterior_pickup_z,exterior_facing,
       exterior_spawn_x,exterior_spawn_y,exterior_spawn_z,exterior_spawn_a,
       interior_id,interior_exit_x,interior_exit_y,interior_exit_z,
       interior_spawn_x,interior_spawn_y,interior_spawn_z,interior_spawn_a,
       savepoint_x,savepoint_y,savepoint_z,garage_source_evidence_id,
       map_icon_type,pickup_model,pickup_type,private_vw_required,enabled,sort_order,source_tag,
       SHA2(CONCAT_WS('|',id,COALESCE(legacy_house_index,'NULL'),COALESCE(canonical_slot,'NULL'),COALESCE(display_name,''),COALESCE(price,0),
             COALESCE(exterior_pickup_x,0),COALESCE(exterior_pickup_y,0),COALESCE(exterior_pickup_z,0),COALESCE(exterior_facing,0),
             COALESCE(exterior_spawn_x,0),COALESCE(exterior_spawn_y,0),COALESCE(exterior_spawn_z,0),COALESCE(exterior_spawn_a,0),
             COALESCE(interior_id,0),COALESCE(interior_exit_x,0),COALESCE(interior_exit_y,0),COALESCE(interior_exit_z,0),
             COALESCE(interior_spawn_x,0),COALESCE(interior_spawn_y,0),COALESCE(interior_spawn_z,0),COALESCE(interior_spawn_a,0),
             COALESCE(savepoint_x,'NULL'),COALESCE(savepoint_y,'NULL'),COALESCE(savepoint_z,'NULL'),COALESCE(garage_source_evidence_id,'NULL'),
             COALESCE(map_icon_type,0),COALESCE(pickup_model,0),COALESCE(pickup_type,0),COALESCE(private_vw_required,0),
             COALESCE(enabled,0),COALESCE(sort_order,0),COALESCE(source_tag,'')),256)
FROM house_catalog;

INSERT INTO offline_house_ownership_archive
(archive_session_id,player_house_id,owner_id,house_catalog_id,house_index,house_name,price,locked,pos_x,pos_y,pos_z,row_checksum)
SELECT @archive_session_id,id,owner_id,house_catalog_id,house_index,COALESCE(house_name,''),COALESCE(price,0),COALESCE(locked,1),
       COALESCE(pos_x,0),COALESCE(pos_y,0),COALESCE(pos_z,0),
       SHA2(CONCAT_WS('|',id,owner_id,COALESCE(house_catalog_id,'NULL'),house_index,COALESCE(house_name,''),COALESCE(price,0),
             COALESCE(locked,1),COALESCE(pos_x,0),COALESCE(pos_y,0),COALESCE(pos_z,0)),256)
FROM player_houses;

INSERT INTO offline_house_ownership_transition_plan
(archive_session_id,player_house_id,owner_id,old_house_catalog_id,old_house_index,target_canonical_slot,target_plan_id,policy_status,notes)
SELECT @archive_session_id,ph.id,ph.owner_id,ph.house_catalog_id,ph.house_index,NULL,NULL,
       CASE WHEN ph.house_catalog_id IS NULL OR hc.id IS NULL THEN 'invalid_source' ELSE 'pending_mapping' END,
       CASE WHEN ph.house_catalog_id IS NULL THEN 'Ownership has no house_catalog_id; repair source linkage before apply.'
            WHEN hc.id IS NULL THEN 'Ownership references a missing house_catalog row; repair orphan before apply.'
            ELSE 'Explicit policy required: map to canonical slot, preserve legacy, or refund then release.' END
FROM player_houses ph
LEFT JOIN house_catalog hc ON hc.id=ph.house_catalog_id;

SET @catalog_archive_rows := (SELECT COUNT(*) FROM offline_house_catalog_archive WHERE archive_session_id=@archive_session_id);
SET @ownership_source_rows := (SELECT COUNT(*) FROM player_houses);
SET @ownership_archive_rows := (SELECT COUNT(*) FROM offline_house_ownership_archive WHERE archive_session_id=@archive_session_id);

UPDATE offline_runtime_archive_sessions
SET archived_rows=@catalog_archive_rows,
    archive_status=CASE WHEN runtime_rows_total=@catalog_archive_rows AND @ownership_source_rows=@ownership_archive_rows
                        THEN 'complete' ELSE 'count_mismatch' END,
    completed_at=CURRENT_TIMESTAMP,
    notes=CASE WHEN runtime_rows_total=@catalog_archive_rows AND @ownership_source_rows=@ownership_archive_rows
               THEN CONCAT('Complete catalog + ownership snapshot. Catalog rows: ',@catalog_archive_rows,
                           '; ownership rows: ',@ownership_archive_rows,
                           '. No house_catalog/player_houses mutation.')
               ELSE CONCAT('Archive mismatch. Catalog ',@catalog_archive_rows,'/',runtime_rows_total,
                           '; ownership ',@ownership_archive_rows,'/',@ownership_source_rows,'. Do not apply.') END
WHERE id=@archive_session_id;

COMMIT;

SELECT id,session_key,archive_status,runtime_rows_total,active_rows_total,target_rows_total,archived_rows,notes,created_at,completed_at
FROM offline_runtime_archive_sessions WHERE id=@archive_session_id;

SELECT 'OWNERSHIP_ARCHIVE' section,@ownership_source_rows source_rows,@ownership_archive_rows archived_rows,
       (SELECT COUNT(*) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='pending_mapping') pending_mapping_rows,
       (SELECT COUNT(*) FROM offline_house_ownership_transition_plan WHERE archive_session_id=@archive_session_id AND policy_status='invalid_source') invalid_source_rows;
