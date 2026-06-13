-- SAIF v0.26A.1.18 Pickup Canonical Resolver verification
-- Read-only. No runtime mutation.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @resolver_version := _utf8mb4'saif-pickup-resolver-v0.26A.1.18' COLLATE utf8mb4_unicode_ci;
SET @resolver_session_id := (
 SELECT id FROM offline_pickup_resolver_sessions
 WHERE BINARY resolver_version=BINARY @resolver_version
 ORDER BY id DESC LIMIT 1
);

SELECT 'SESSION_GATE' AS section,
 id,resolver_status,total_rows,baseline_ready_rows,deferred_rows,blocked_rows,
 (resolver_status='complete') AS complete_should_be_1,
 (total_rows=782) AS total_should_be_1,
 (baseline_ready_rows=89) AS baseline_should_be_1
FROM offline_pickup_resolver_sessions WHERE id=@resolver_session_id;

SELECT 'PLAN_GATE' AS section,
 COUNT(*) AS total_expected_782,
 SUM(p.decision_code='baseline_ready') AS baseline_expected_89,
 SUM(p.decision_code='baseline_ready' AND p.canonical_category='bribe') AS bribe_expected_49,
 SUM(p.decision_code='baseline_ready' AND p.canonical_category='armor') AS armour_expected_40,
 SUM(p.decision_code='duplicate_shadow_blocked') AS duplicate_shadow_expected_35,
 SUM(p.enabled<>0) AS enabled_should_be_zero,
 SUM(p.apply_status<>'draft') AS nondraft_should_be_zero,
 SUM(p.queue_id IS NULL) AS missing_queue_should_be_zero
FROM offline_pickup_canonical_plan p WHERE p.resolver_session_id=@resolver_session_id;

SELECT 'BASELINE_SAFETY_GATE' AS section,
 SUM(p.decision_code='baseline_ready' AND q.script_name<>'INITIAL') AS noninitial_should_be_zero,
 SUM(p.decision_code='baseline_ready' AND (q.position_resolved<>1 OR q.zero_coordinate<>0)) AS bad_transform_should_be_zero,
 SUM(p.decision_code='baseline_ready' AND q.pos_z>=800.0) AS interior_should_be_zero,
 SUM(p.decision_code='baseline_ready' AND p.canonical_category NOT IN ('armor','bribe')) AS unsupported_type_should_be_zero,
 SUM(p.decision_code='baseline_ready' AND p.runtime_target<>'world_pickups') AS wrong_target_should_be_zero,
 SUM(p.decision_code='baseline_ready' AND p.runtime_z_lift<>0.25) AS wrong_z_lift_should_be_zero
FROM offline_pickup_canonical_plan p
JOIN offline_pickup_queue q ON q.id=p.queue_id
WHERE p.resolver_session_id=@resolver_session_id;

SELECT 'LINKAGE_GATE' AS section,
 (SELECT COUNT(*) FROM offline_pickup_queue WHERE parser_version='saif-pickup-parser-v0.26A.1.17') AS queue_expected_782,
 (SELECT COUNT(*) FROM offline_pickup_canonical_plan WHERE resolver_session_id=@resolver_session_id) AS plans_expected_782,
 (SELECT COUNT(*) FROM offline_pickup_queue q LEFT JOIN offline_pickup_canonical_plan p
    ON p.queue_id=q.id AND p.resolver_session_id=@resolver_session_id
  WHERE q.parser_version='saif-pickup-parser-v0.26A.1.17' AND p.id IS NULL) AS missing_plan_should_be_zero,
 (SELECT COUNT(*) FROM offline_pickup_canonical_plan p LEFT JOIN offline_pickup_queue q ON q.id=p.queue_id
  WHERE p.resolver_session_id=@resolver_session_id AND q.id IS NULL) AS orphan_plan_should_be_zero;

SELECT 'DECISION_DISTRIBUTION' AS section,decision_code,safety_class,COUNT(*) AS rows_total
FROM offline_pickup_canonical_plan
WHERE resolver_session_id=@resolver_session_id
GROUP BY decision_code,safety_class
ORDER BY rows_total DESC,decision_code;

SELECT 'BASELINE_BY_REGION' AS section,q.city_region,q.area_code,p.canonical_category,COUNT(*) AS rows_total
FROM offline_pickup_canonical_plan p
JOIN offline_pickup_queue q ON q.id=p.queue_id
WHERE p.resolver_session_id=@resolver_session_id AND p.decision_code='baseline_ready'
GROUP BY q.city_region,q.area_code,p.canonical_category
ORDER BY q.city_region,q.area_code,p.canonical_category;

SELECT 'RUNTIME_UNTOUCHED_REFERENCE' AS section,
 COUNT(*) AS world_pickups_total,
 SUM(enabled=1) AS world_pickups_active
FROM world_pickups;
