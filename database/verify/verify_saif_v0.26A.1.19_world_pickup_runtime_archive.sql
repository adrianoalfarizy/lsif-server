-- SAIF v0.26A.1.19 world_pickups archive verification
-- Read-only. No runtime mutation.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @resolver_version := _utf8mb4'saif-pickup-resolver-v0.26A.1.18' COLLATE utf8mb4_unicode_ci;
SET @archive_session_id := (SELECT id FROM offline_runtime_archive_sessions WHERE archive_scope='world_pickups' ORDER BY id DESC LIMIT 1);
SET @resolver_session_id := (SELECT id FROM offline_pickup_resolver_sessions WHERE BINARY resolver_version=BINARY @resolver_version ORDER BY id DESC LIMIT 1);

SELECT 'ARCHIVE_SESSION_GATE' section,id,archive_status,runtime_rows_total,active_rows_total,target_rows_total,archived_rows,
       (archive_status='complete') complete_should_be_1,
       (runtime_rows_total=archived_rows) count_match_should_be_1,
       (target_rows_total=89) target_should_be_1
FROM offline_runtime_archive_sessions WHERE id=@archive_session_id;

SELECT 'ARCHIVE_CHECKSUM_GATE' section,
       COALESCE(SUM(BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',w.id,COALESCE(w.pickup_type,''),COALESCE(w.display_name,''),COALESCE(w.model_id,0),
           COALESCE(w.pos_x,0),COALESCE(w.pos_y,0),COALESCE(w.pos_z,0),COALESCE(w.interior,0),COALESCE(w.virtual_world,0),
           COALESCE(w.amount,0),COALESCE(w.cooldown_seconds,60),COALESCE(w.source_tag,''),COALESCE(w.enabled,0)),256)),0) checksum_mismatch_should_be_zero
FROM offline_world_pickups_archive a JOIN world_pickups w ON w.id=a.original_id
WHERE a.archive_session_id=@archive_session_id;

SELECT 'ARCHIVE_LINKAGE_GATE' section,
       (SELECT COUNT(*) FROM world_pickups w LEFT JOIN offline_world_pickups_archive a ON a.archive_session_id=@archive_session_id AND a.original_id=w.id WHERE a.archive_row_id IS NULL) current_missing_from_archive_should_be_zero,
       (SELECT COUNT(*) FROM offline_world_pickups_archive a LEFT JOIN world_pickups w ON w.id=a.original_id WHERE a.archive_session_id=@archive_session_id AND w.id IS NULL) archived_missing_from_runtime_should_be_zero;

SELECT 'BASELINE_89_GATE' section,
       COUNT(*) total_selected_expected_89,
       SUM(p.canonical_category='bribe') bribe_expected_49,
       SUM(p.canonical_category='armor') armour_expected_40,
       SUM(q.script_name<>'INITIAL') noninitial_should_be_zero,
       SUM(q.position_resolved<>1 OR q.zero_coordinate<>0) bad_transform_should_be_zero,
       SUM(p.runtime_target<>'world_pickups') wrong_target_should_be_zero,
       SUM(p.canonical_model_id NOT IN (1242,1247)) wrong_model_should_be_zero,
       SUM(p.canonical_pickup_type NOT IN ('armor','bribe')) wrong_type_should_be_zero,
       SUM(p.recommended_interior<>0 OR p.recommended_virtual_world<>0) wrong_world_should_be_zero,
       SUM(ABS(p.runtime_z_lift-0.25)>0.0001) wrong_z_lift_should_be_zero,
       SUM(p.enabled<>0 OR p.apply_status<>'draft') staging_state_should_be_zero
FROM offline_pickup_canonical_plan p JOIN offline_pickup_queue q ON q.id=p.queue_id
WHERE p.resolver_session_id=@resolver_session_id AND p.decision_code='baseline_ready';

SELECT 'RUNTIME_CAPACITY_GATE' section,
       700 memory_capacity,300 loader_limit,89 projected_active_after_replace,
       (89<=300) loader_fits_should_be_1,(89<=700) memory_fits_should_be_1,
       (SELECT COUNT(*) FROM world_pickups) current_total,
       (SELECT COUNT(*) FROM world_pickups WHERE enabled=1) active_rows_that_future_apply_would_disable;
