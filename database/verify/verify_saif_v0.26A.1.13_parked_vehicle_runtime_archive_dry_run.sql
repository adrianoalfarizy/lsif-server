-- SAIF / LSIF Dev v0.26A.1.13
-- Verify parked vehicle archive integrity and canonical 130-row replacement gates.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @archive_session_id := (
    SELECT id FROM offline_runtime_archive_sessions
    WHERE archive_scope='parked_vehicles'
    ORDER BY id DESC LIMIT 1
);

SELECT 'LATEST_ARCHIVE' AS section,
       id,session_key,archive_status,runtime_rows_total,active_rows_total,target_rows_total,archived_rows,
       (runtime_rows_total=archived_rows) AS count_match_should_be_1
FROM offline_runtime_archive_sessions
WHERE id=@archive_session_id;

SELECT 'ARCHIVE_INTEGRITY' AS section,
       (SELECT COUNT(*) FROM offline_parked_vehicles_archive WHERE archive_session_id=@archive_session_id) AS actual_archive_rows,
       (SELECT COUNT(*) FROM offline_parked_vehicles_archive WHERE archive_session_id=@archive_session_id AND original_id<=0) AS invalid_original_id_should_be_zero,
       (SELECT COUNT(*) FROM (
            SELECT original_id FROM offline_parked_vehicles_archive
            WHERE archive_session_id=@archive_session_id
            GROUP BY original_id HAVING COUNT(*)>1
        ) d) AS duplicate_original_id_should_be_zero,
       (SELECT COUNT(*) FROM offline_parked_vehicles_archive a
        JOIN parked_vehicles p ON p.id=a.original_id
        WHERE a.archive_session_id=@archive_session_id
          AND BINARY a.row_checksum <> BINARY SHA2(CONCAT_WS('|',
              p.id, COALESCE(p.modelid,400), COALESCE(p.color1,-1), COALESCE(p.color2,-1),
              COALESCE(p.pos_x,0), COALESCE(p.pos_y,0), COALESCE(p.pos_z,0), COALESCE(p.pos_a,0),
              COALESCE(p.interior,0), COALESCE(p.virtual_world,0), COALESCE(p.respawn_delay,300),
              COALESCE(p.locked,0), COALESCE(p.source_tag,''), COALESCE(p.enabled,0)
          ),256)) AS checksum_mismatch_should_be_zero,
       (SELECT COUNT(*) FROM offline_parked_vehicles_archive a
        LEFT JOIN parked_vehicles p ON p.id=a.original_id
        WHERE a.archive_session_id=@archive_session_id AND p.id IS NULL) AS archived_row_missing_from_runtime_should_be_zero,
       (SELECT COUNT(*) FROM parked_vehicles p
        LEFT JOIN offline_parked_vehicles_archive a
          ON a.archive_session_id=@archive_session_id AND a.original_id=p.id
        WHERE a.archive_row_id IS NULL) AS runtime_row_missing_from_archive_should_be_zero,
       (SELECT COUNT(*) FROM parked_vehicles) AS current_runtime_rows,
       ((SELECT COUNT(*) FROM parked_vehicles)=(SELECT runtime_rows_total FROM offline_runtime_archive_sessions WHERE id=@archive_session_id)) AS runtime_count_match_should_be_1;

SELECT 'PLANNER_GATES' AS section,
       COUNT(*) AS total_expected_211,
       SUM(decision_code='baseline_ready') AS baseline_expected_68,
       SUM(decision_code='progression_optional') AS progression_expected_62,
       SUM(decision_code IN ('baseline_ready','progression_optional')) AS selected_expected_130,
       SUM(decision_code='stateful_deferred') AS stateful_expected_60,
       SUM(decision_code='duplicate_blocked') AS duplicate_expected_13,
       SUM(decision_code='random_model_review') AS random_expected_3,
       SUM(decision_code='placeholder_blocked') AS placeholder_expected_3,
       SUM(decision_code='switch_unknown_review') AS unknown_expected_2,
       SUM(enabled=1) AS enabled_should_be_zero,
       SUM(apply_status<>'draft') AS nondraft_should_be_zero
FROM offline_vehicle_apply_plan
WHERE planner_version='saif-vehicle-canonical-planner-v0.26A.1.12';

SELECT 'CAPACITY_GATE' AS section,
       256 AS runtime_capacity,
       130 AS planned_replacement_rows,
       256-130 AS remaining_slots,
       (130<=256) AS fits_capacity_should_be_1;
