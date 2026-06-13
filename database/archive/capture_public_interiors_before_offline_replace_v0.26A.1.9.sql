-- SAIF / LSIF Dev v0.26A.1.9
-- Capture a read-only snapshot of current public_interiors into dedicated archive tables.
-- This script DOES NOT update/delete/disable public_interiors.

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SET @archive_session_key := CONCAT('pubint_pre_offline_replace_', DATE_FORMAT(NOW(6), '%Y%m%d%H%i%s%f'));

INSERT INTO offline_runtime_archive_sessions
(
    session_key,
    archive_scope,
    archive_label,
    archive_status,
    runtime_rows_total,
    active_rows_total,
    target_rows_total,
    archived_rows,
    notes
)
SELECT
    @archive_session_key,
    'public_interiors',
    'Before GTA SA offline public interior replacement',
    'capturing',
    COUNT(*),
    COALESCE(SUM(enabled=1),0),
    COALESCE(SUM(enabled=1 AND interior_type IN ('ammunation','247','burgershot','cluckinbell','pizzastack','barber','tattoo','clothing','gym','police')),0),
    0,
    'Snapshot only. Runtime rows remain untouched.'
FROM public_interiors;

SET @archive_session_id := LAST_INSERT_ID();

INSERT INTO offline_public_interiors_archive
(
    archive_session_id,
    original_id,
    interior_type,
    display_name,
    exterior_x,
    exterior_y,
    exterior_z,
    exterior_a,
    exterior_spawn_x,
    exterior_spawn_y,
    exterior_spawn_z,
    exterior_spawn_a,
    exterior_pickup_model,
    interior_pickup_model,
    exterior_map_icon,
    exterior_interior,
    exterior_virtual_world,
    interior_id,
    interior_virtual_world,
    interior_x,
    interior_y,
    interior_z,
    interior_a,
    exit_x,
    exit_y,
    exit_z,
    exit_a,
    service_x,
    service_y,
    service_z,
    service_a,
    service_radius,
    source_tag,
    enabled,
    row_checksum
)
SELECT
    @archive_session_id,
    id,
    COALESCE(interior_type,''),
    COALESCE(display_name,''),
    COALESCE(exterior_x,0),
    COALESCE(exterior_y,0),
    COALESCE(exterior_z,0),
    COALESCE(exterior_a,0),
    COALESCE(exterior_spawn_x,0),
    COALESCE(exterior_spawn_y,0),
    COALESCE(exterior_spawn_z,0),
    COALESCE(exterior_spawn_a,0),
    COALESCE(exterior_pickup_model,0),
    COALESCE(interior_pickup_model,0),
    COALESCE(exterior_map_icon,0),
    COALESCE(exterior_interior,0),
    COALESCE(exterior_virtual_world,0),
    COALESCE(interior_id,0),
    COALESCE(interior_virtual_world,0),
    COALESCE(interior_x,0),
    COALESCE(interior_y,0),
    COALESCE(interior_z,0),
    COALESCE(interior_a,0),
    COALESCE(exit_x,0),
    COALESCE(exit_y,0),
    COALESCE(exit_z,0),
    COALESCE(exit_a,0),
    COALESCE(service_x,0),
    COALESCE(service_y,0),
    COALESCE(service_z,0),
    COALESCE(service_a,0),
    COALESCE(service_radius,0),
    COALESCE(source_tag,''),
    COALESCE(enabled,0),
    SHA2(CONCAT_WS('|',
        id, COALESCE(interior_type,''), COALESCE(display_name,''),
        COALESCE(exterior_x,0), COALESCE(exterior_y,0), COALESCE(exterior_z,0), COALESCE(exterior_a,0),
        COALESCE(exterior_spawn_x,0), COALESCE(exterior_spawn_y,0), COALESCE(exterior_spawn_z,0), COALESCE(exterior_spawn_a,0),
        COALESCE(exterior_pickup_model,0), COALESCE(interior_pickup_model,0), COALESCE(exterior_map_icon,0),
        COALESCE(exterior_interior,0), COALESCE(exterior_virtual_world,0), COALESCE(interior_id,0), COALESCE(interior_virtual_world,0),
        COALESCE(interior_x,0), COALESCE(interior_y,0), COALESCE(interior_z,0), COALESCE(interior_a,0),
        COALESCE(exit_x,0), COALESCE(exit_y,0), COALESCE(exit_z,0), COALESCE(exit_a,0),
        COALESCE(service_x,0), COALESCE(service_y,0), COALESCE(service_z,0), COALESCE(service_a,0), COALESCE(service_radius,0),
        COALESCE(source_tag,''), COALESCE(enabled,0)
    ),256)
FROM public_interiors;

UPDATE offline_runtime_archive_sessions
SET archived_rows = (
        SELECT COUNT(*)
        FROM offline_public_interiors_archive
        WHERE archive_session_id=@archive_session_id
    ),
    archive_status = 'complete',
    completed_at = CURRENT_TIMESTAMP,
    notes = 'Complete snapshot. Runtime public_interiors was not mutated.'
WHERE id=@archive_session_id;

COMMIT;

SELECT
    id,
    session_key,
    archive_status,
    runtime_rows_total,
    active_rows_total,
    target_rows_total,
    archived_rows,
    created_at,
    completed_at
FROM offline_runtime_archive_sessions
WHERE id=@archive_session_id;
