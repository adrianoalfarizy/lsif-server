-- SAIF / LSIF Dev v0.26A.1.19
-- BASELINE-89 WORLD PICKUP REPLACEMENT DRY-RUN ONLY.
-- SET/SELECT/temporary-table statements only. world_pickups is not mutated.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @resolver_version := _utf8mb4'saif-pickup-resolver-v0.26A.1.18' COLLATE utf8mb4_unicode_ci;
SET @resolver_session_id := (SELECT id FROM offline_pickup_resolver_sessions WHERE BINARY resolver_version=BINARY @resolver_version ORDER BY id DESC LIMIT 1);
SET @archive_session_id := (SELECT id FROM offline_runtime_archive_sessions WHERE archive_scope='world_pickups' ORDER BY id DESC LIMIT 1);

SELECT 'CURRENT_RUNTIME' section,COUNT(*) total_rows,COALESCE(SUM(enabled=1),0) active_rows,COALESCE(SUM(enabled=0),0) disabled_rows
FROM world_pickups;
SELECT 'CURRENT_RUNTIME_BY_SOURCE' section,COALESCE(NULLIF(source_tag,''),'unknown') source_tag,COUNT(*) total_rows,COALESCE(SUM(enabled=1),0) active_rows
FROM world_pickups GROUP BY COALESCE(NULLIF(source_tag,''),'unknown') ORDER BY active_rows DESC,total_rows DESC,source_tag;

SELECT 'ARCHIVE_GATE' section,id archive_session_id,archive_status,runtime_rows_total,active_rows_total,archived_rows,
       (archive_status='complete' AND runtime_rows_total=archived_rows) ready_should_be_1
FROM offline_runtime_archive_sessions WHERE id=@archive_session_id;

SELECT 'ARCHIVE_CHECKSUM_GATE' section,
       COUNT(*) checksum_mismatch_should_be_zero
FROM offline_world_pickups_archive a JOIN world_pickups w ON w.id=a.original_id
WHERE a.archive_session_id=@archive_session_id
  AND BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',w.id,COALESCE(w.pickup_type,''),COALESCE(w.display_name,''),COALESCE(w.model_id,0),
      COALESCE(w.pos_x,0),COALESCE(w.pos_y,0),COALESCE(w.pos_z,0),COALESCE(w.interior,0),COALESCE(w.virtual_world,0),
      COALESCE(w.amount,0),COALESCE(w.cooldown_seconds,60),COALESCE(w.source_tag,''),COALESCE(w.enabled,0)),256);

DROP TEMPORARY TABLE IF EXISTS tmp_saif_baseline89;
CREATE TEMPORARY TABLE tmp_saif_baseline89 AS
SELECT p.id plan_id,p.queue_id,p.canonical_category,p.canonical_model_id model_id,p.canonical_pickup_type pickup_type,
       p.canonical_amount amount,p.canonical_cooldown_seconds cooldown_seconds,p.recommended_interior interior,
       p.recommended_virtual_world virtual_world,p.runtime_z_lift,q.pos_x,q.pos_y,q.pos_z,
       (q.pos_z+p.runtime_z_lift) runtime_z,q.city_region,q.area_code,q.source_file,q.source_line,q.script_name
FROM offline_pickup_canonical_plan p JOIN offline_pickup_queue q ON q.id=p.queue_id
WHERE p.resolver_session_id=@resolver_session_id AND p.decision_code='baseline_ready';

SELECT 'PLAN_GATE' section,COUNT(*) selected_expected_89,
       SUM(canonical_category='bribe') bribe_expected_49,
       SUM(canonical_category='armor') armour_expected_40,
       SUM(script_name<>'INITIAL') noninitial_should_be_zero,
       SUM(model_id NOT IN (1242,1247)) invalid_model_should_be_zero,
       SUM(ABS(pos_x)<0.001 AND ABS(pos_y)<0.001 AND ABS(pos_z)<0.001) zero_coordinate_should_be_zero,
       SUM(interior<>0 OR virtual_world<>0) wrong_world_should_be_zero
FROM tmp_saif_baseline89;

SELECT 'PROJECTED_REPLACEMENT' section,
       700 memory_capacity,300 loader_limit,
       (SELECT COUNT(*) FROM world_pickups WHERE enabled=1) active_rows_that_would_be_disabled,
       49 bribe_rows_to_insert,40 armour_rows_to_insert,89 total_rows_to_insert,
       89 projected_active_after_replace,211 loader_headroom,
       (89<=300) loader_fits_should_be_1,(89<=700) memory_fits_should_be_1;

SELECT 'INTERNAL_DUPLICATE_GATE' section,COUNT(*) duplicate_pairs_within_050m_should_be_zero
FROM offline_pickup_canonical_plan p1
JOIN offline_pickup_queue q1 ON q1.id=p1.queue_id
JOIN offline_pickup_canonical_plan p2
  ON p2.id>p1.id
 AND p2.resolver_session_id=p1.resolver_session_id
 AND p2.decision_code='baseline_ready'
JOIN offline_pickup_queue q2 ON q2.id=p2.queue_id
WHERE p1.resolver_session_id=@resolver_session_id
  AND p1.decision_code='baseline_ready'
  AND POW(q1.pos_x-q2.pos_x,2)+POW(q1.pos_y-q2.pos_y,2)
      +POW((q1.pos_z+p1.runtime_z_lift)-(q2.pos_z+p2.runtime_z_lift),2)<=0.25;

SELECT 'ACTIVE_RUNTIME_EXACT_OVERLAP' section,COUNT(*) overlap_pairs,
       COUNT(DISTINCT s.plan_id) selected_rows_with_overlap
FROM tmp_saif_baseline89 s JOIN world_pickups w
  ON w.enabled=1 AND w.interior=s.interior AND w.virtual_world=s.virtual_world
 AND ABS(w.pos_x-s.pos_x)<=0.10 AND ABS(w.pos_y-s.pos_y)<=0.10 AND ABS(w.pos_z-s.runtime_z)<=0.35;

SELECT 'ACTIVE_RUNTIME_PROXIMITY_AUDIT' section,COUNT(*) pairs_within_150m
FROM tmp_saif_baseline89 s JOIN world_pickups w
  ON w.enabled=1 AND w.interior=s.interior AND w.virtual_world=s.virtual_world
 AND POW(w.pos_x-s.pos_x,2)+POW(w.pos_y-s.pos_y,2)+POW(w.pos_z-s.runtime_z,2)<=2.25;

SELECT 'PUBLIC_INTERIOR_PROXIMITY_AUDIT' section,COUNT(*) pairs_within_150m
FROM tmp_saif_baseline89 s JOIN public_interiors i
  ON i.enabled=1 AND i.exterior_interior=s.interior AND i.exterior_virtual_world=s.virtual_world
 AND POW(i.exterior_x-s.pos_x,2)+POW(i.exterior_y-s.pos_y,2)+POW(i.exterior_z-s.runtime_z,2)<=2.25;

SELECT 'SELECTED_89_DETAIL' section,plan_id,queue_id,canonical_category,model_id,pickup_type,amount,cooldown_seconds,
       pos_x,pos_y,pos_z,runtime_z,interior,virtual_world,city_region,area_code,source_file,source_line
FROM tmp_saif_baseline89 ORDER BY canonical_category,city_region,area_code,plan_id;

SELECT 'DEFERRED_BLOCKED_SUMMARY' section,decision_code,safety_class,COUNT(*) rows_total
FROM offline_pickup_canonical_plan WHERE resolver_session_id=@resolver_session_id AND decision_code<>'baseline_ready'
GROUP BY decision_code,safety_class ORDER BY rows_total DESC,decision_code;

SELECT 'SAFETY_CONTRACT' section,
       'Future apply may disable active old rows and insert exactly 89 canonical rows; this v0.26A.1.19 script performs no world_pickups mutation.' rule_text;
DROP TEMPORARY TABLE IF EXISTS tmp_saif_baseline89;
