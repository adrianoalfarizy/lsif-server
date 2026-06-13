-- SAIF / LSIF Dev v0.26A.1.19
-- Capture every current world_pickups row before Baseline-89 replacement.
-- SAFETY: archive INSERT/metadata UPDATE only; world_pickups remains untouched.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @archive_session_key := CONCAT('worldpickup_pre_baseline89_', DATE_FORMAT(NOW(6), '%Y%m%d%H%i%s%f'));

INSERT INTO offline_runtime_archive_sessions
(session_key,archive_scope,archive_label,archive_status,runtime_rows_total,active_rows_total,target_rows_total,archived_rows,notes)
SELECT @archive_session_key,'world_pickups','Before GTA SA Baseline-89 world pickup replacement','capturing',
       COUNT(*),COALESCE(SUM(enabled=1),0),89,0,
       'Full world_pickups snapshot. Runtime table is not mutated by capture.'
FROM world_pickups;
SET @archive_session_id := LAST_INSERT_ID();

INSERT INTO offline_world_pickups_archive
(archive_session_id,original_id,pickup_type,display_name,model_id,pos_x,pos_y,pos_z,interior,virtual_world,amount,cooldown_seconds,source_tag,enabled,row_checksum)
SELECT @archive_session_id,id,COALESCE(pickup_type,''),COALESCE(display_name,''),COALESCE(model_id,0),
       COALESCE(pos_x,0),COALESCE(pos_y,0),COALESCE(pos_z,0),COALESCE(interior,0),COALESCE(virtual_world,0),
       COALESCE(amount,0),COALESCE(cooldown_seconds,60),COALESCE(source_tag,''),COALESCE(enabled,0),
       SHA2(CONCAT_WS('|',id,COALESCE(pickup_type,''),COALESCE(display_name,''),COALESCE(model_id,0),
             COALESCE(pos_x,0),COALESCE(pos_y,0),COALESCE(pos_z,0),COALESCE(interior,0),COALESCE(virtual_world,0),
             COALESCE(amount,0),COALESCE(cooldown_seconds,60),COALESCE(source_tag,''),COALESCE(enabled,0)),256)
FROM world_pickups;

UPDATE offline_runtime_archive_sessions
SET archived_rows=(SELECT COUNT(*) FROM offline_world_pickups_archive WHERE archive_session_id=@archive_session_id),
    archive_status=CASE WHEN runtime_rows_total=(SELECT COUNT(*) FROM offline_world_pickups_archive WHERE archive_session_id=@archive_session_id)
                        THEN 'complete' ELSE 'count_mismatch' END,
    completed_at=CURRENT_TIMESTAMP,
    notes=CASE WHEN runtime_rows_total=(SELECT COUNT(*) FROM offline_world_pickups_archive WHERE archive_session_id=@archive_session_id)
               THEN 'Complete snapshot. world_pickups was not mutated.'
               ELSE 'Archive count mismatch. Do not proceed to apply.' END
WHERE id=@archive_session_id;
COMMIT;

SELECT id,session_key,archive_status,runtime_rows_total,active_rows_total,target_rows_total,archived_rows,created_at,completed_at
FROM offline_runtime_archive_sessions WHERE id=@archive_session_id;
