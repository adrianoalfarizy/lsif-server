-- SAIF / LSIF Dev v0.26A.1.10
-- Read-only gate report before full 91-row apply.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @archive_id := (
    SELECT COALESCE(MAX(id),0)
    FROM offline_runtime_archive_sessions
    WHERE archive_scope='public_interiors' AND archive_status='complete'
);
SET @import_session_id := (
    SELECT COALESCE(MAX(session_id),0)
    FROM offline_interior_apply_plan
    WHERE plan_version='saif_enex_pair_planner_v0.26A.1.7'
);

SELECT
    @archive_id AS latest_complete_archive_id,
    (SELECT archive_status FROM offline_runtime_archive_sessions WHERE id=@archive_id) AS archive_status,
    (SELECT runtime_rows_total FROM offline_runtime_archive_sessions WHERE id=@archive_id) AS archive_runtime_rows,
    (SELECT archived_rows FROM offline_runtime_archive_sessions WHERE id=@archive_id) AS archive_rows,
    (SELECT COUNT(*) FROM public_interiors) AS current_runtime_rows,
    (SELECT COUNT(*) FROM offline_runtime_apply_sessions WHERE apply_scope IN ('public_interiors_offline_91','public_interiors_exact_71') AND apply_status='complete' AND rolled_back_at IS NULL) AS existing_live_apply_should_be_zero;

SELECT
    SUM(p.apply_readiness='dry_run_ready' AND sp.resolution_method='scm_exact' AND sp.review_status='approved_exact') AS exact_ready_expected_71,
    SUM(p.apply_readiness='service_overlay_review' AND sp.resolution_method='saif_overlay_translated' AND sp.review_status='preview_required') AS overlay_ready_expected_20,
    (SELECT COUNT(*) FROM offline_interior_apply_plan b WHERE b.session_id=@import_session_id AND b.plan_version='saif_enex_pair_planner_v0.26A.1.7' AND b.apply_readiness='blocked_duplicate') AS blocked_expected_2,
    COUNT(*) AS unique_rows_to_insert_expected_91
FROM offline_interior_apply_plan p
INNER JOIN offline_interior_service_points sp ON sp.id=p.service_point_id
WHERE p.session_id=@import_session_id
  AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7'
  AND p.plan_status='pair_ready'
  AND p.apply_status='draft'
  AND sp.resolver_version='saif_service_point_resolver_v0.26A.1.8'
  AND sp.apply_status='draft'
  AND p.apply_readiness IN ('dry_run_ready','service_overlay_review');

SELECT
    SUM(enabled=1) AS current_active,
    SUM(enabled=1 AND interior_type IN ('ammunation','247','burgershot','cluckinbell','pizzastack','barber','tattoo','clothing','gym','police')) AS target_family_rows_to_disable,
    SUM(enabled=1)
      - SUM(enabled=1 AND interior_type IN ('ammunation','247','burgershot','cluckinbell','pizzastack','barber','tattoo','clothing','gym','police'))
      + 91 AS projected_active_after_apply,
    128 AS compiled_capacity,
    128 - (
      SUM(enabled=1)
      - SUM(enabled=1 AND interior_type IN ('ammunation','247','burgershot','cluckinbell','pizzastack','barber','tattoo','clothing','gym','police'))
      + 91
    ) AS projected_headroom
FROM public_interiors;

SELECT interior_type,COUNT(*) AS active_rows_to_disable
FROM public_interiors
WHERE enabled=1
  AND interior_type IN ('ammunation','247','burgershot','cluckinbell','pizzastack','barber','tattoo','clothing','gym','police')
GROUP BY interior_type
ORDER BY interior_type;

SELECT
    p.runtime_type,
    sp.resolution_method,
    COUNT(*) AS rows_to_insert,
    SUM(sp.resolution_method='saif_overlay_translated') AS requires_manual_adjustment
FROM offline_interior_apply_plan p
INNER JOIN offline_interior_service_points sp ON sp.id=p.service_point_id
WHERE p.session_id=@import_session_id
  AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7'
  AND p.plan_status='pair_ready'
  AND p.apply_status='draft'
  AND sp.apply_status='draft'
  AND p.apply_readiness IN ('dry_run_ready','service_overlay_review')
GROUP BY p.runtime_type,sp.resolution_method
ORDER BY p.runtime_type,sp.resolution_method;

SELECT
    p.id AS plan_id,p.runtime_type,p.display_name,p.area_code,p.interior_id,
    sp.service_x,sp.service_y,sp.service_z,sp.service_a,sp.service_radius,
    sp.resolution_method,sp.review_status,
    'Will be active; adjust after apply if needed' AS action
FROM offline_interior_apply_plan p
INNER JOIN offline_interior_service_points sp ON sp.id=p.service_point_id
WHERE p.session_id=@import_session_id
  AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7'
  AND p.apply_readiness='service_overlay_review'
  AND p.apply_status='draft'
ORDER BY p.runtime_type,p.area_code,p.id;
