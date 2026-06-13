-- SAIF / LSIF Dev v0.26A.1.9
-- REPLACE DRY-RUN ONLY. All statements below are SELECT.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SELECT 'CURRENT_RUNTIME' AS section,
       COUNT(*) AS total_rows,
       SUM(enabled=1) AS active_rows,
       SUM(enabled=0) AS disabled_rows
FROM public_interiors;

SELECT 'ROWS_THAT_WOULD_BE_ARCHIVED_AND_REPLACED' AS section,
       interior_type,
       COUNT(*) AS active_rows
FROM public_interiors
WHERE enabled=1
  AND interior_type IN ('ammunation','247','burgershot','cluckinbell','pizzastack','barber','tattoo','clothing','gym','police')
GROUP BY interior_type
ORDER BY interior_type;

SELECT 'ROWS_PRESERVED_IN_FIRST_REPLACEMENT' AS section,
       interior_type,
       COUNT(*) AS active_rows
FROM public_interiors
WHERE enabled=1
  AND interior_type NOT IN ('ammunation','247','burgershot','cluckinbell','pizzastack','barber','tattoo','clothing','gym','police')
GROUP BY interior_type
ORDER BY interior_type;

SELECT 'OFFLINE_PLAN_COUNTS' AS section,
       apply_readiness,
       COUNT(*) AS rows_count
FROM offline_interior_apply_plan
WHERE session_id=(SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1)
  AND plan_version='saif_enex_pair_planner_v0.26A.1.7'
GROUP BY apply_readiness
ORDER BY apply_readiness;

SELECT 'PROJECTED_CAPACITY' AS section,
       128 AS runtime_capacity,
       (SELECT COUNT(*) FROM public_interiors WHERE enabled=1) AS current_active,
       (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND interior_type IN ('ammunation','247','burgershot','cluckinbell','pizzastack','barber','tattoo','clothing','gym','police')) AS current_target_active,
       (SELECT COUNT(*) FROM offline_interior_apply_plan p WHERE p.session_id=(SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1) AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7' AND p.apply_readiness='dry_run_ready') AS exact_ready,
       (SELECT COUNT(*) FROM offline_interior_apply_plan p WHERE p.session_id=(SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1) AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7' AND p.apply_readiness='service_overlay_review') AS overlay_review,
       ((SELECT COUNT(*) FROM public_interiors WHERE enabled=1)
        - (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND interior_type IN ('ammunation','247','burgershot','cluckinbell','pizzastack','barber','tattoo','clothing','gym','police'))
        + (SELECT COUNT(*) FROM offline_interior_apply_plan p WHERE p.session_id=(SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1) AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7' AND p.apply_readiness='dry_run_ready')) AS projected_exact_only,
       ((SELECT COUNT(*) FROM public_interiors WHERE enabled=1)
        - (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND interior_type IN ('ammunation','247','burgershot','cluckinbell','pizzastack','barber','tattoo','clothing','gym','police'))
        + (SELECT COUNT(*) FROM offline_interior_apply_plan p WHERE p.session_id=(SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1) AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7' AND p.apply_readiness IN ('dry_run_ready','service_overlay_review'))) AS projected_full_91;

SELECT 'EXACT_READY_DETAIL' AS section,
       p.id AS plan_id,
       p.runtime_type,
       p.display_name,
       p.area_code,
       p.interior_id,
       p.exterior_x,
       p.exterior_y,
       p.exterior_z,
       sp.service_x,
       sp.service_y,
       sp.service_z,
       sp.service_radius,
       p.apply_readiness
FROM offline_interior_apply_plan p
JOIN offline_interior_service_points sp ON sp.id=p.service_point_id
WHERE p.session_id=(SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1)
  AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7'
  AND p.apply_readiness='dry_run_ready'
ORDER BY p.runtime_type,p.area_code,p.id;

SELECT 'OVERLAY_REVIEW_DETAIL' AS section,
       p.id AS plan_id,
       p.runtime_type,
       p.display_name,
       p.area_code,
       p.interior_id,
       sp.id AS service_point_id,
       sp.service_x,
       sp.service_y,
       sp.service_z,
       sp.service_radius,
       sp.review_status
FROM offline_interior_apply_plan p
JOIN offline_interior_service_points sp ON sp.id=p.service_point_id
WHERE p.session_id=(SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1)
  AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7'
  AND p.apply_readiness='service_overlay_review'
ORDER BY p.runtime_type,p.area_code,p.id;
