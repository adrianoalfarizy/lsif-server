-- Verify SAIF v0.26A.1.12 parked vehicle canonical planner
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @offline_session_key := _utf8mb4'ecbbfa867b491c93570b92e0c6d3ff34e1e916da9df914d83edb066c1eac52c3' COLLATE utf8mb4_unicode_ci;
SET @offline_session_id := (SELECT id FROM offline_import_sessions WHERE session_key COLLATE utf8mb4_unicode_ci=@offline_session_key LIMIT 1);
SELECT
 COUNT(*) AS total_expected_211,
 SUM(decision_code='baseline_ready') AS baseline_expected_68,
 SUM(decision_code='progression_optional') AS progression_expected_62,
 SUM(decision_code='stateful_deferred') AS stateful_expected_60,
 SUM(decision_code='duplicate_blocked') AS duplicate_expected_13,
 SUM(decision_code='random_model_review') AS random_expected_3,
 SUM(decision_code='placeholder_blocked') AS placeholder_expected_3,
 SUM(decision_code='switch_unknown_review') AS switch_review_expected_2,
 SUM(recommended_enabled=1) AS recommended_enabled_expected_68,
 SUM(enabled=1) AS enabled_should_be_zero,
 SUM(apply_status<>'draft') AS nondraft_should_be_zero,
 SUM(queue_id IS NULL OR queue_id=0) AS missing_queue_should_be_zero,
 SUM(decision_code='duplicate_blocked' AND duplicate_of_queue_id IS NULL) AS missing_duplicate_link_should_be_zero
FROM offline_vehicle_apply_plan
WHERE session_id=@offline_session_id AND planner_version='saif-vehicle-canonical-planner-v0.26A.1.12';

SELECT batch_key,total_rows,recommended_enabled_rows,optional_rows,blocked_rows,enabled,apply_status
FROM offline_vehicle_apply_batches
WHERE session_id=@offline_session_id AND planner_version='saif-vehicle-canonical-planner-v0.26A.1.12' ORDER BY sort_order;

SELECT
 (SELECT COUNT(*) FROM parked_vehicles WHERE enabled=1) AS runtime_active_unchanged,
 200 AS runtime_capacity,
 68 AS baseline_first_apply,
 132 AS canonical_if_baseline_plus_progression_plus_switch_review,
 200-132 AS spare_slots_before_existing_runtime;
