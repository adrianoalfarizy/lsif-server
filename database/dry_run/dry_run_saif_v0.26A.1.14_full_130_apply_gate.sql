-- SAIF / LSIF Dev v0.26A.1.14
-- Full 130 parked vehicle apply preflight. SELECT/SET only.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @archive_session_id := (
    SELECT id FROM offline_runtime_archive_sessions
    WHERE archive_scope='parked_vehicles' AND archive_status='complete'
    ORDER BY id DESC LIMIT 1
);
SET @planner_session_id := (
    SELECT MAX(session_id) FROM offline_vehicle_apply_plan
    WHERE planner_version='saif-vehicle-canonical-planner-v0.26A.1.12'
);

SELECT 'ARCHIVE_GATE' AS section,
       @archive_session_id AS archive_session_id,
       s.archive_status,s.runtime_rows_total,s.active_rows_total,s.archived_rows,
       (s.archive_status='complete' AND s.runtime_rows_total=s.archived_rows) AS ready_should_be_1
FROM offline_runtime_archive_sessions s
WHERE s.id=@archive_session_id;

SELECT 'ARCHIVE_CHECKSUM_GATE' AS section,
       COUNT(*) AS checksum_mismatch_should_be_zero
FROM offline_parked_vehicles_archive a
LEFT JOIN parked_vehicles p ON p.id=a.original_id
WHERE a.archive_session_id=@archive_session_id
  AND (p.id IS NULL OR BINARY a.row_checksum<>BINARY SHA2(CONCAT_WS('|',
      p.id,COALESCE(p.modelid,400),COALESCE(p.color1,-1),COALESCE(p.color2,-1),
      COALESCE(p.pos_x,0),COALESCE(p.pos_y,0),COALESCE(p.pos_z,0),COALESCE(p.pos_a,0),
      COALESCE(p.interior,0),COALESCE(p.virtual_world,0),COALESCE(p.respawn_delay,300),
      COALESCE(p.locked,0),COALESCE(p.source_tag,''),COALESCE(p.enabled,0)
  ),256));

SELECT 'PLANNER_GATE' AS section,
       COUNT(*) AS total_expected_211,
       SUM(decision_code='baseline_ready' AND apply_status='draft') AS baseline_expected_68,
       SUM(decision_code='progression_optional' AND apply_status='draft') AS progression_expected_62,
       SUM(decision_code NOT IN ('baseline_ready','progression_optional')) AS deferred_expected_81,
       SUM(decision_code IN ('baseline_ready','progression_optional')) AS selected_expected_130,
       SUM(decision_code IN ('baseline_ready','progression_optional') AND (runtime_modelid<400 OR runtime_modelid>611)) AS invalid_model_should_be_zero,
       SUM(decision_code IN ('baseline_ready','progression_optional') AND ABS(q.pos_x)<0.001 AND ABS(q.pos_y)<0.001 AND ABS(q.pos_z)<0.001) AS zero_coordinate_should_be_zero,
       SUM(decision_code IN ('baseline_ready','progression_optional') AND (requires_model_resolution<>0 OR requires_state_bridge<>0)) AS unresolved_dependency_should_be_zero
FROM offline_vehicle_apply_plan p
JOIN offline_vehicle_queue q ON q.id=p.queue_id
WHERE p.session_id=@planner_session_id
  AND p.planner_version='saif-vehicle-canonical-planner-v0.26A.1.12';

SELECT 'RUNTIME_GATE' AS section,
       COUNT(*) AS runtime_total,
       SUM(enabled=1) AS runtime_active_before,
       130 AS projected_active_after,
       256 AS compiled_capacity,
       (130<=256) AS fits_capacity_should_be_1,
       (SELECT COUNT(*) FROM offline_runtime_apply_sessions
        WHERE apply_scope='parked_vehicles_offline_130'
          AND apply_status='complete' AND rolled_back_at IS NULL) AS existing_live_apply_should_be_zero,
       (SELECT COUNT(*) FROM parked_vehicles
        WHERE enabled=1 AND source_tag LIKE 'offline_gtasa_parkveh130_a%') AS orphan_import_active_should_be_zero
FROM parked_vehicles;

SELECT 'SELECTED_130_BY_DECISION' AS section, p.decision_code,COUNT(*) AS rows_count
FROM offline_vehicle_apply_plan p
WHERE p.session_id=@planner_session_id
  AND p.planner_version='saif-vehicle-canonical-planner-v0.26A.1.12'
  AND p.decision_code IN ('baseline_ready','progression_optional')
GROUP BY p.decision_code;
