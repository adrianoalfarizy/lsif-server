-- SAIF / LSIF Dev v0.26A.1.10
-- Post-apply / post-rollback verification for full 91-row apply.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @latest_apply_id := (
    SELECT COALESCE(MAX(id),0)
    FROM offline_runtime_apply_sessions
    WHERE apply_scope='public_interiors_offline_91'
);

SELECT
    id AS apply_session_id,apply_status,archive_session_id,import_session_id,source_tag,
    runtime_active_before,old_rows_disabled,new_rows_inserted,
    exact_rows_inserted,overlay_rows_inserted,manual_adjustment_rows,
    blocked_rows_skipped,runtime_active_after,created_at,completed_at,rolled_back_at
FROM offline_runtime_apply_sessions
WHERE id=@latest_apply_id;

SELECT
    COUNT(*) AS mapped_insert_rows_expected_91,
    SUM(p.id IS NOT NULL) AS runtime_rows_present_expected_91,
    SUM(p.enabled=1) AS imported_rows_active,
    SUM(p.enabled=0) AS imported_rows_disabled,
    SUM(r.resolution_method='scm_exact') AS exact_mapped_expected_71,
    SUM(r.resolution_method='saif_overlay_translated') AS overlay_mapped_expected_20,
    SUM(r.requires_manual_adjustment=1) AS adjustment_rows_expected_20,
    COUNT(DISTINCT r.plan_id) AS mapped_plans_expected_91,
    COUNT(DISTINCT r.service_point_id) AS mapped_service_points_expected_91
FROM offline_public_interior_apply_rows r
LEFT JOIN public_interiors p ON p.id=r.public_interior_id
WHERE r.apply_session_id=@latest_apply_id;

SELECT
    COUNT(*) AS previous_rows_recorded,
    SUM(p.id IS NOT NULL) AS previous_rows_present,
    SUM(p.enabled=1) AS previous_rows_currently_active,
    SUM(p.enabled=0) AS previous_rows_currently_disabled
FROM offline_public_interior_disabled_rows d
LEFT JOIN public_interiors p ON p.id=d.public_interior_id
WHERE d.apply_session_id=@latest_apply_id;

SELECT
    COUNT(*) AS runtime_total,
    SUM(enabled=1) AS runtime_active,
    SUM(enabled=1 AND interior_type IN ('ammunation','247','burgershot','cluckinbell','pizzastack','barber','tattoo','clothing','gym','police')) AS target_family_active,
    SUM(enabled=1 AND source_tag=(SELECT source_tag FROM offline_runtime_apply_sessions WHERE id=@latest_apply_id)) AS latest_import_active_expected_91
FROM public_interiors;

SELECT
    r.runtime_type,r.resolution_method,
    COUNT(*) AS imported_rows,
    SUM(pi.enabled=1) AS active_rows,
    SUM(r.requires_manual_adjustment=1) AS adjustment_rows
FROM offline_public_interior_apply_rows r
LEFT JOIN public_interiors pi ON pi.id=r.public_interior_id
WHERE r.apply_session_id=@latest_apply_id
GROUP BY r.runtime_type,r.resolution_method
ORDER BY r.runtime_type,r.resolution_method;

SELECT
    SUM(apply_status='applied') AS plans_marked_applied_expected_91,
    SUM(apply_status='draft') AS plans_marked_draft_expected_zero
FROM offline_interior_apply_plan
WHERE id IN (SELECT plan_id FROM offline_public_interior_apply_rows WHERE apply_session_id=@latest_apply_id);

SELECT
    SUM(apply_status='applied') AS service_points_marked_applied_expected_91,
    SUM(apply_status='draft') AS service_points_marked_draft_expected_zero
FROM offline_interior_service_points
WHERE id IN (SELECT service_point_id FROM offline_public_interior_apply_rows WHERE apply_session_id=@latest_apply_id);

-- The 20 rows to review/adjust with the existing backend editor.
SELECT
    r.public_interior_id,r.runtime_type,r.display_name,p.interior_id,
    sp.service_x,sp.service_y,sp.service_z,sp.service_a,sp.service_radius,
    CONCAT('/pubintpoints ',r.public_interior_id) AS open_editor,
    CONCAT('/pubintsetpoint ',r.public_interior_id,' service') AS save_current_position,
    CONCAT('/pubintsetfacing ',r.public_interior_id,' service') AS save_current_facing
FROM offline_public_interior_apply_rows r
INNER JOIN offline_interior_apply_plan p ON p.id=r.plan_id
INNER JOIN offline_interior_service_points sp ON sp.id=r.service_point_id
WHERE r.apply_session_id=@latest_apply_id
  AND r.requires_manual_adjustment=1
ORDER BY r.runtime_type,r.display_name,r.public_interior_id;
