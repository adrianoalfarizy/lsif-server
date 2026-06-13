-- SAIF / LSIF Dev v0.26A.1.20
-- Verify latest live Baseline-89 world pickup apply.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @apply_session_id := (
    SELECT id FROM offline_runtime_apply_sessions
    WHERE apply_scope='world_pickups_offline_baseline89'
      AND apply_status='complete' AND rolled_back_at IS NULL
    ORDER BY id DESC LIMIT 1
);

SELECT 'APPLY_SESSION' AS section,id,apply_key,apply_status,source_tag,archive_session_id,import_session_id,
       runtime_active_before,runtime_active_after,old_rows_disabled,new_rows_inserted,
       bribe_rows_inserted,armor_rows_inserted,deferred_rows_skipped,blocked_rows_skipped,created_at,completed_at
FROM offline_runtime_apply_sessions WHERE id=@apply_session_id;

SELECT 'CORE_COUNTS' AS section,
       (SELECT COUNT(*) FROM offline_world_pickup_apply_rows WHERE apply_session_id=@apply_session_id) AS mapped_insert_rows_expected_89,
       (SELECT COUNT(*) FROM offline_world_pickup_apply_rows r JOIN world_pickups w ON w.id=r.world_pickup_id WHERE r.apply_session_id=@apply_session_id) AS runtime_rows_present_expected_89,
       (SELECT COUNT(*) FROM offline_world_pickup_apply_rows r JOIN world_pickups w ON w.id=r.world_pickup_id WHERE r.apply_session_id=@apply_session_id AND w.enabled=1) AS runtime_rows_active_expected_89,
       (SELECT COUNT(*) FROM offline_world_pickup_apply_rows WHERE apply_session_id=@apply_session_id AND canonical_category='bribe') AS bribe_expected_49,
       (SELECT COUNT(*) FROM offline_world_pickup_apply_rows WHERE apply_session_id=@apply_session_id AND canonical_category='armor') AS armor_expected_40,
       (SELECT COUNT(*) FROM offline_world_pickup_disabled_rows WHERE apply_session_id=@apply_session_id) AS old_disabled_mappings,
       (SELECT COUNT(*) FROM world_pickups WHERE enabled=1) AS total_active_expected_89;

SELECT 'STAGING_STATE' AS section,
       (SELECT COUNT(*) FROM offline_pickup_canonical_plan p JOIN offline_world_pickup_apply_rows r ON r.plan_id=p.id WHERE r.apply_session_id=@apply_session_id AND p.apply_status='applied') AS plans_marked_applied_expected_89,
       (SELECT COUNT(*) FROM offline_pickup_queue q JOIN offline_world_pickup_apply_rows r ON r.queue_id=q.id WHERE r.apply_session_id=@apply_session_id AND q.apply_status='applied') AS queue_rows_marked_applied_expected_89,
       (SELECT COUNT(*) FROM offline_pickup_canonical_plan p WHERE p.resolver_version='saif-pickup-resolver-v0.26A.1.18' AND p.decision_code<>'baseline_ready' AND p.apply_status='draft') AS deferred_blocked_plans_still_draft_expected_693;

SELECT 'INTEGRITY' AS section,
       (SELECT COUNT(*) FROM offline_world_pickup_apply_rows r LEFT JOIN world_pickups w ON w.id=r.world_pickup_id WHERE r.apply_session_id=@apply_session_id AND w.id IS NULL) AS missing_runtime_should_be_zero,
       (SELECT COUNT(*) FROM offline_world_pickup_apply_rows r JOIN world_pickups w ON w.id=r.world_pickup_id WHERE r.apply_session_id=@apply_session_id AND BINARY w.source_tag<>BINARY (SELECT source_tag FROM offline_runtime_apply_sessions WHERE id=@apply_session_id)) AS wrong_source_tag_should_be_zero,
       (SELECT COUNT(*) FROM world_pickups WHERE enabled=1 AND source_tag NOT LIKE 'offline_gtasa_pickup89_a%') AS old_or_other_active_should_be_zero,
       (SELECT COUNT(*) FROM world_pickups WHERE enabled=1 AND pickup_type NOT IN ('bribe','armor')) AS unsupported_active_type_should_be_zero,
       (SELECT COUNT(*) FROM world_pickups WHERE enabled=1 AND ((pickup_type='bribe' AND (model_id<>1247 OR amount<>1 OR cooldown_seconds<>180)) OR (pickup_type='armor' AND (model_id<>1242 OR amount<>100 OR cooldown_seconds<>240)))) AS wrong_active_payload_should_be_zero,
       (SELECT COUNT(*) FROM world_pickups WHERE enabled=1 AND (interior<>0 OR virtual_world<>0)) AS wrong_active_world_should_be_zero;

SELECT 'INSERTED_CHECKSUM' AS section,COUNT(*) AS checksum_mismatch_should_be_zero
FROM offline_world_pickup_apply_rows r
JOIN world_pickups w ON w.id=r.world_pickup_id
WHERE r.apply_session_id=@apply_session_id
  AND BINARY r.row_checksum<>BINARY SHA2(CONCAT_WS('|',w.id,COALESCE(w.pickup_type,''),COALESCE(w.display_name,''),COALESCE(w.model_id,0),COALESCE(w.pos_x,0),COALESCE(w.pos_y,0),COALESCE(w.pos_z,0),COALESCE(w.interior,0),COALESCE(w.virtual_world,0),COALESCE(w.amount,0),COALESCE(w.cooldown_seconds,60),COALESCE(w.source_tag,''),COALESCE(w.enabled,0)),256);

SELECT 'ACTIVE_BY_CATEGORY' AS section,r.canonical_category,COUNT(*) AS active_rows
FROM offline_world_pickup_apply_rows r
JOIN world_pickups w ON w.id=r.world_pickup_id
WHERE r.apply_session_id=@apply_session_id AND w.enabled=1
GROUP BY r.canonical_category ORDER BY r.canonical_category;

SELECT 'ACTIVE_BY_REGION' AS section,q.city_region,COUNT(*) AS active_rows
FROM offline_world_pickup_apply_rows r
JOIN offline_pickup_queue q ON q.id=r.queue_id
JOIN world_pickups w ON w.id=r.world_pickup_id
WHERE r.apply_session_id=@apply_session_id AND w.enabled=1
GROUP BY q.city_region ORDER BY active_rows DESC,q.city_region;

SELECT 'CAPACITY' AS section,
       (SELECT COUNT(*) FROM world_pickups WHERE enabled=1) AS active_rows,
       300 AS loader_limit,700 AS memory_capacity,
       (SELECT COUNT(*) FROM world_pickups WHERE enabled=1)<=300 AS loader_fits_should_be_1,
       (SELECT COUNT(*) FROM world_pickups WHERE enabled=1)<=700 AS memory_fits_should_be_1;
