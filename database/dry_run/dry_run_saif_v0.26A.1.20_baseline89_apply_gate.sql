-- SAIF / LSIF Dev v0.26A.1.20
-- Final apply gate for exactly 89 GTA SA baseline world pickups.
-- READ-ONLY: SET/SELECT/temporary-table only. No world_pickups mutation.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @resolver_version := _utf8mb4'saif-pickup-resolver-v0.26A.1.18' COLLATE utf8mb4_unicode_ci;
SET @resolver_session_id := (
    SELECT id FROM offline_pickup_resolver_sessions
    WHERE BINARY resolver_version=BINARY @resolver_version
    ORDER BY id DESC LIMIT 1
);
SET @archive_session_id := (
    SELECT id FROM offline_runtime_archive_sessions
    WHERE archive_scope='world_pickups'
    ORDER BY id DESC LIMIT 1
);

SELECT 'ARCHIVE_GATE' AS section,id AS archive_session_id,archive_status,runtime_rows_total,active_rows_total,
       target_rows_total,archived_rows,
       (archive_status='complete' AND runtime_rows_total=archived_rows AND target_rows_total=89) AS ready_should_be_1
FROM offline_runtime_archive_sessions WHERE id=@archive_session_id;

SELECT 'ARCHIVE_INTEGRITY' AS section,
       (SELECT COUNT(*) FROM offline_world_pickups_archive a
        LEFT JOIN world_pickups w ON w.id=a.original_id
        WHERE a.archive_session_id=@archive_session_id AND w.id IS NULL) AS archived_missing_from_runtime_should_be_zero,
       (SELECT COUNT(*) FROM world_pickups w
        LEFT JOIN offline_world_pickups_archive a
          ON a.archive_session_id=@archive_session_id AND a.original_id=w.id
        WHERE a.original_id IS NULL) AS current_missing_from_archive_should_be_zero,
       (SELECT COUNT(*) FROM offline_world_pickups_archive a
        JOIN world_pickups w ON w.id=a.original_id
        WHERE a.archive_session_id=@archive_session_id
          AND BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',w.id,COALESCE(w.pickup_type,''),COALESCE(w.display_name,''),COALESCE(w.model_id,0),COALESCE(w.pos_x,0),COALESCE(w.pos_y,0),COALESCE(w.pos_z,0),COALESCE(w.interior,0),COALESCE(w.virtual_world,0),COALESCE(w.amount,0),COALESCE(w.cooldown_seconds,60),COALESCE(w.source_tag,''),COALESCE(w.enabled,0)),256)) AS checksum_mismatch_should_be_zero;

SELECT 'RESOLVER_SESSION' AS section,id,resolver_status,total_rows,baseline_ready_rows,deferred_rows,blocked_rows,
       (resolver_status='complete' AND total_rows=782 AND baseline_ready_rows=89 AND deferred_rows=649 AND blocked_rows=44) AS ready_should_be_1
FROM offline_pickup_resolver_sessions WHERE id=@resolver_session_id;

DROP TEMPORARY TABLE IF EXISTS tmp_saif_apply89;
CREATE TEMPORARY TABLE tmp_saif_apply89 AS
SELECT p.id AS plan_id,p.queue_id,p.canonical_category,p.canonical_model_id AS model_id,
       p.canonical_pickup_type AS pickup_type,p.canonical_amount AS amount,
       p.canonical_cooldown_seconds AS cooldown_seconds,p.recommended_interior AS interior,
       p.recommended_virtual_world AS virtual_world,p.runtime_z_lift,
       p.review_status,p.enabled,p.apply_status,q.pos_x,q.pos_y,q.pos_z,
       q.pos_z+p.runtime_z_lift AS runtime_z,q.script_name,q.city_region,q.area_code
FROM offline_pickup_canonical_plan p
JOIN offline_pickup_queue q ON q.id=p.queue_id
WHERE p.resolver_session_id=@resolver_session_id
  AND p.resolver_version=@resolver_version
  AND p.decision_code='baseline_ready';

SELECT 'PLAN_GATE' AS section,COUNT(*) AS selected_expected_89,
       SUM(canonical_category='bribe') AS bribe_expected_49,
       SUM(canonical_category='armor') AS armor_expected_40,
       SUM(script_name<>'INITIAL') AS noninitial_should_be_zero,
       SUM(enabled<>0 OR apply_status<>'draft' OR review_status<>'ready') AS staging_state_should_be_zero,
       SUM(interior<>0 OR virtual_world<>0) AS wrong_world_should_be_zero,
       SUM(ABS(pos_x)<0.001 AND ABS(pos_y)<0.001 AND ABS(pos_z)<0.001) AS zero_coordinate_should_be_zero,
       SUM((canonical_category='bribe' AND (model_id<>1247 OR pickup_type<>'bribe' OR amount<>1 OR cooldown_seconds<>180))
           OR (canonical_category='armor' AND (model_id<>1242 OR pickup_type<>'armor' OR amount<>100 OR cooldown_seconds<>240))) AS wrong_payload_should_be_zero,
       SUM(ABS(runtime_z_lift-0.25)>0.001) AS wrong_z_lift_should_be_zero
FROM tmp_saif_apply89;

SELECT 'INTERNAL_DUPLICATE_GATE' AS section,COUNT(*) AS duplicate_pairs_within_050m_should_be_zero
FROM tmp_saif_apply89 a
JOIN tmp_saif_apply89 b ON b.plan_id>a.plan_id
 AND POW(a.pos_x-b.pos_x,2)+POW(a.pos_y-b.pos_y,2)+POW(a.runtime_z-b.runtime_z,2)<=0.25;

SELECT 'LIVE_APPLY_GATE' AS section,
       (SELECT COUNT(*) FROM offline_runtime_apply_sessions
        WHERE apply_scope='world_pickups_offline_baseline89'
          AND apply_status='complete' AND rolled_back_at IS NULL) AS existing_live_apply_should_be_zero,
       (SELECT COUNT(*) FROM world_pickups
        WHERE enabled=1 AND source_tag LIKE 'offline_gtasa_pickup89_a%') AS orphan_import_active_should_be_zero;

SELECT 'CAPACITY_GATE' AS section,
       (SELECT COUNT(*) FROM world_pickups) AS runtime_total_before,
       (SELECT COUNT(*) FROM world_pickups WHERE enabled=1) AS runtime_active_before,
       89 AS projected_active_after,
       300 AS loader_limit,700 AS memory_capacity,211 AS loader_headroom,
       (89<=300) AS loader_fits_should_be_1,(89<=700) AS memory_fits_should_be_1;

SELECT 'SELECTED_89_BY_CATEGORY' AS section,canonical_category,COUNT(*) AS rows_total
FROM tmp_saif_apply89 GROUP BY canonical_category ORDER BY canonical_category;

SELECT 'APPLY_CONTRACT' AS section,
       'Future apply disables all currently active old world_pickups, inserts 49 bribe + 40 armour, tracks every row, and never deletes runtime data.' AS rule_text;
DROP TEMPORARY TABLE IF EXISTS tmp_saif_apply89;
