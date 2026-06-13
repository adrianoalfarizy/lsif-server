-- SAIF / LSIF Dev v0.26A.1.14
-- Verify latest live Full-130 parked vehicle apply.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @apply_session_id := (
    SELECT id FROM offline_runtime_apply_sessions
    WHERE apply_scope='parked_vehicles_offline_130'
      AND apply_status='complete' AND rolled_back_at IS NULL
    ORDER BY id DESC LIMIT 1
);

SELECT 'APPLY_SESSION' AS section,id,apply_key,apply_status,source_tag,archive_session_id,import_session_id,
       runtime_active_before,runtime_active_after,old_rows_disabled,new_rows_inserted,
       baseline_rows_inserted,progression_rows_inserted,deferred_rows_skipped,created_at,completed_at
FROM offline_runtime_apply_sessions WHERE id=@apply_session_id;

SELECT 'CORE_COUNTS' AS section,
       (SELECT COUNT(*) FROM offline_parked_vehicle_apply_rows WHERE apply_session_id=@apply_session_id) AS mapped_insert_rows_expected_130,
       (SELECT COUNT(*) FROM offline_parked_vehicle_apply_rows r JOIN parked_vehicles p ON p.id=r.parked_vehicle_id WHERE r.apply_session_id=@apply_session_id) AS runtime_rows_present_expected_130,
       (SELECT COUNT(*) FROM offline_parked_vehicle_apply_rows r JOIN parked_vehicles p ON p.id=r.parked_vehicle_id WHERE r.apply_session_id=@apply_session_id AND p.enabled=1) AS runtime_rows_active_expected_130,
       (SELECT COUNT(*) FROM offline_parked_vehicle_apply_rows WHERE apply_session_id=@apply_session_id AND decision_code='baseline_ready') AS baseline_expected_68,
       (SELECT COUNT(*) FROM offline_parked_vehicle_apply_rows WHERE apply_session_id=@apply_session_id AND decision_code='progression_optional') AS progression_expected_62,
       (SELECT COUNT(*) FROM offline_parked_vehicle_disabled_rows WHERE apply_session_id=@apply_session_id) AS old_disabled_mappings,
       (SELECT COUNT(*) FROM parked_vehicles WHERE enabled=1) AS total_active_expected_130;

SELECT 'STAGING_STATE' AS section,
       (SELECT COUNT(*) FROM offline_vehicle_apply_plan p JOIN offline_parked_vehicle_apply_rows r ON r.plan_id=p.id WHERE r.apply_session_id=@apply_session_id AND p.apply_status='applied') AS plans_marked_applied_expected_130,
       (SELECT COUNT(*) FROM offline_vehicle_queue q JOIN offline_parked_vehicle_apply_rows r ON r.queue_id=q.id WHERE r.apply_session_id=@apply_session_id AND q.apply_status='applied') AS queue_rows_marked_applied_expected_130,
       (SELECT COUNT(*) FROM offline_vehicle_apply_plan WHERE planner_version='saif-vehicle-canonical-planner-v0.26A.1.12' AND decision_code NOT IN ('baseline_ready','progression_optional') AND apply_status='draft') AS deferred_plans_still_draft_expected_81;

SELECT 'INTEGRITY' AS section,
       (SELECT COUNT(*) FROM offline_parked_vehicle_apply_rows r LEFT JOIN parked_vehicles p ON p.id=r.parked_vehicle_id WHERE r.apply_session_id=@apply_session_id AND p.id IS NULL) AS missing_runtime_should_be_zero,
       (SELECT COUNT(*) FROM offline_parked_vehicle_apply_rows r JOIN parked_vehicles p ON p.id=r.parked_vehicle_id WHERE r.apply_session_id=@apply_session_id AND BINARY p.source_tag<>BINARY (SELECT source_tag FROM offline_runtime_apply_sessions WHERE id=@apply_session_id)) AS wrong_source_tag_should_be_zero,
       (SELECT COUNT(*) FROM parked_vehicles WHERE enabled=1 AND source_tag NOT LIKE 'offline_gtasa_parkveh130_a%') AS old_or_other_active_should_be_zero,
       (SELECT COUNT(*) FROM parked_vehicles WHERE enabled=1 AND (modelid<400 OR modelid>611)) AS invalid_active_model_should_be_zero;

SELECT 'ACTIVE_BY_DECISION' AS section,r.decision_code,COUNT(*) AS active_rows
FROM offline_parked_vehicle_apply_rows r
JOIN parked_vehicles p ON p.id=r.parked_vehicle_id
WHERE r.apply_session_id=@apply_session_id AND p.enabled=1
GROUP BY r.decision_code;

SELECT 'ACTIVE_BY_REGION' AS section,q.city_region,COUNT(*) AS active_rows
FROM offline_parked_vehicle_apply_rows r
JOIN offline_vehicle_queue q ON q.id=r.queue_id
JOIN parked_vehicles p ON p.id=r.parked_vehicle_id
WHERE r.apply_session_id=@apply_session_id AND p.enabled=1
GROUP BY q.city_region ORDER BY active_rows DESC,q.city_region;
