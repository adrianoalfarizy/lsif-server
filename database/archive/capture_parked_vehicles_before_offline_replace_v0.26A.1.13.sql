-- SAIF / LSIF Dev v0.26A.1.13
-- Capture every current parked_vehicles row before GTA SA canonical replacement.
-- SAFETY: INSERT into archive tables only; parked_vehicles remains untouched.

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @archive_session_key := CONCAT('parkveh_pre_offline_replace_', DATE_FORMAT(NOW(6), '%Y%m%d%H%i%s%f'));

INSERT INTO offline_runtime_archive_sessions
(
    session_key, archive_scope, archive_label, archive_status,
    runtime_rows_total, active_rows_total, target_rows_total,
    archived_rows, notes
)
SELECT
    @archive_session_key,
    'parked_vehicles',
    'Before GTA SA SCM canonical parked vehicle replacement',
    'capturing',
    COUNT(*),
    COALESCE(SUM(enabled=1),0),
    130,
    0,
    'Full snapshot only. Future replacement scope is all existing parked vehicles; runtime is untouched by this capture.'
FROM parked_vehicles;

SET @archive_session_id := LAST_INSERT_ID();

INSERT INTO offline_parked_vehicles_archive
(
    archive_session_id, original_id, modelid, color1, color2,
    pos_x, pos_y, pos_z, pos_a, interior, virtual_world,
    respawn_delay, locked, source_tag, enabled, row_checksum
)
SELECT
    @archive_session_id,
    id,
    COALESCE(modelid,400),
    COALESCE(color1,-1),
    COALESCE(color2,-1),
    COALESCE(pos_x,0),
    COALESCE(pos_y,0),
    COALESCE(pos_z,0),
    COALESCE(pos_a,0),
    COALESCE(interior,0),
    COALESCE(virtual_world,0),
    COALESCE(respawn_delay,300),
    COALESCE(locked,0),
    COALESCE(source_tag,''),
    COALESCE(enabled,0),
    SHA2(CONCAT_WS('|',
        id, COALESCE(modelid,400), COALESCE(color1,-1), COALESCE(color2,-1),
        COALESCE(pos_x,0), COALESCE(pos_y,0), COALESCE(pos_z,0), COALESCE(pos_a,0),
        COALESCE(interior,0), COALESCE(virtual_world,0), COALESCE(respawn_delay,300),
        COALESCE(locked,0), COALESCE(source_tag,''), COALESCE(enabled,0)
    ),256)
FROM parked_vehicles;

UPDATE offline_runtime_archive_sessions
SET archived_rows=(
        SELECT COUNT(*) FROM offline_parked_vehicles_archive
        WHERE archive_session_id=@archive_session_id
    ),
    archive_status=CASE
        WHEN runtime_rows_total=(
            SELECT COUNT(*) FROM offline_parked_vehicles_archive
            WHERE archive_session_id=@archive_session_id
        ) THEN 'complete'
        ELSE 'count_mismatch'
    END,
    completed_at=CURRENT_TIMESTAMP,
    notes=CASE
        WHEN runtime_rows_total=(
            SELECT COUNT(*) FROM offline_parked_vehicles_archive
            WHERE archive_session_id=@archive_session_id
        ) THEN 'Complete snapshot. Runtime parked_vehicles was not mutated.'
        ELSE 'Archive count mismatch. Do not proceed to any apply.'
    END
WHERE id=@archive_session_id;

COMMIT;

SELECT id,session_key,archive_status,runtime_rows_total,active_rows_total,target_rows_total,archived_rows,created_at,completed_at
FROM offline_runtime_archive_sessions
WHERE id=@archive_session_id;
