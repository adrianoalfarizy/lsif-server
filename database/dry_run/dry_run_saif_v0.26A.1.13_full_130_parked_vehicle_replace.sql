-- SAIF / LSIF Dev v0.26A.1.13
-- FULL CANONICAL PARKED VEHICLE REPLACEMENT DRY-RUN ONLY.
-- Every statement below is SELECT/SET. parked_vehicles is not mutated.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @archive_session_id := (
    SELECT id FROM offline_runtime_archive_sessions
    WHERE archive_scope='parked_vehicles'
    ORDER BY id DESC LIMIT 1
);

SELECT 'CURRENT_RUNTIME' AS section,
       COUNT(*) AS total_rows,
       SUM(enabled=1) AS active_rows,
       SUM(enabled=0) AS disabled_rows
FROM parked_vehicles;

SELECT 'CURRENT_RUNTIME_BY_SOURCE' AS section,
       COALESCE(NULLIF(source_tag,''),'unknown') AS source_tag,
       COUNT(*) AS total_rows,
       SUM(enabled=1) AS active_rows
FROM parked_vehicles
GROUP BY COALESCE(NULLIF(source_tag,''),'unknown')
ORDER BY active_rows DESC,total_rows DESC,source_tag;

SELECT 'LATEST_ARCHIVE_GATE' AS section,
       id,session_key,archive_status,runtime_rows_total,active_rows_total,archived_rows,
       (archive_status='complete' AND runtime_rows_total=archived_rows) AS archive_ready_should_be_1
FROM offline_runtime_archive_sessions
WHERE id=@archive_session_id;

SELECT 'FULL_CANONICAL_SELECTION' AS section,
       decision_code,
       COUNT(*) AS rows_count,
       CASE
           WHEN decision_code='baseline_ready' THEN 'APPLY: original GTA SA startup-ON world vehicle'
           WHEN decision_code='progression_optional' THEN 'APPLY: exact location originally gated by progression'
           ELSE 'DEFER'
       END AS future_action
FROM offline_vehicle_apply_plan
WHERE planner_version='saif-vehicle-canonical-planner-v0.26A.1.12'
GROUP BY decision_code
ORDER BY decision_code;

SELECT 'PROJECTED_REPLACEMENT' AS section,
       256 AS runtime_capacity,
       (SELECT COUNT(*) FROM parked_vehicles WHERE enabled=1) AS active_rows_that_would_be_disabled,
       68 AS baseline_rows_to_insert,
       62 AS progression_rows_to_insert,
       130 AS total_rows_to_insert,
       126 AS capacity_remaining,
       1 AS replacement_fits_capacity;

SELECT 'SELECTED_130_DETAIL' AS section,
       p.id AS plan_id,
       p.decision_code,
       q.id AS queue_id,
       q.generator_name,
       p.runtime_modelid AS modelid,
       q.vehicle_model_name,
       q.vehicle_type,
       q.pos_x,q.pos_y,q.pos_z,q.pos_a,
       p.runtime_color1 AS color1,
       p.runtime_color2 AS color2,
       p.runtime_respawn_delay AS respawn_delay,
       p.runtime_locked AS locked,
       q.city_region,q.area_code,
       q.initial_switch_amount,
       q.context_category,
       p.runtime_source_tag,
       p.planner_reason
FROM offline_vehicle_apply_plan p
JOIN offline_vehicle_queue q ON q.id=p.queue_id
WHERE p.planner_version='saif-vehicle-canonical-planner-v0.26A.1.12'
  AND p.decision_code IN ('baseline_ready','progression_optional')
ORDER BY p.decision_code,q.city_region,q.area_code,p.id;

SELECT 'DEFERRED_81_SUMMARY' AS section,
       decision_code,
       COUNT(*) AS rows_count
FROM offline_vehicle_apply_plan
WHERE planner_version='saif-vehicle-canonical-planner-v0.26A.1.12'
  AND decision_code NOT IN ('baseline_ready','progression_optional')
GROUP BY decision_code
ORDER BY decision_code;

SELECT 'SAFETY_CONTRACT' AS section,
       'Archive all existing rows; future apply disables active runtime rows, inserts exactly 130 canonical rows, never DELETEs existing rows.' AS rule;
