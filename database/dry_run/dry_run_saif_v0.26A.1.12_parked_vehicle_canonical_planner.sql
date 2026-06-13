-- Read-only dry-run SAIF v0.26A.1.12
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @offline_session_key := _utf8mb4'ecbbfa867b491c93570b92e0c6d3ff34e1e916da9df914d83edb066c1eac52c3' COLLATE utf8mb4_unicode_ci;
SET @offline_session_id := (SELECT id FROM offline_import_sessions WHERE session_key COLLATE utf8mb4_unicode_ci=@offline_session_key LIMIT 1);
SELECT p.decision_code,p.apply_readiness,COUNT(*) rows_count,SUM(p.recommended_enabled=1) recommended_enabled
FROM offline_vehicle_apply_plan p WHERE p.session_id=@offline_session_id AND p.planner_version='saif-vehicle-canonical-planner-v0.26A.1.12'
GROUP BY p.decision_code,p.apply_readiness ORDER BY p.decision_code;

SELECT p.id AS plan_id,q.id AS queue_id,q.generator_name,q.modelid,q.vehicle_model_name,q.city_region,q.area_code,q.initial_switch_amount,p.decision_code,p.apply_readiness,p.runtime_locked,p.planner_reason
FROM offline_vehicle_apply_plan p JOIN offline_vehicle_queue q ON q.id=p.queue_id
WHERE p.session_id=@offline_session_id AND p.planner_version='saif-vehicle-canonical-planner-v0.26A.1.12' AND p.decision_code='baseline_ready'
ORDER BY q.city_region,q.area_code,q.id;

SELECT p.id AS plan_id,q.id AS queue_id,q.generator_name,q.modelid,q.vehicle_model_name,q.initial_switch_amount,p.decision_code,p.apply_readiness,p.planner_reason
FROM offline_vehicle_apply_plan p JOIN offline_vehicle_queue q ON q.id=p.queue_id
WHERE p.session_id=@offline_session_id AND p.planner_version='saif-vehicle-canonical-planner-v0.26A.1.12' AND p.decision_code<>'baseline_ready'
ORDER BY p.decision_code,q.id;
