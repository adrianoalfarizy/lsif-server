-- SAIF / LSIF Dev v0.26A.1.9 verification
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SELECT
    COUNT(*) AS archive_sessions,
    COALESCE(SUM(archive_status='complete'),0) AS complete_sessions,
    COALESCE(SUM(archive_status<>'complete'),0) AS incomplete_sessions
FROM offline_runtime_archive_sessions
WHERE archive_scope='public_interiors';

SET @latest_archive_session_id := (
    SELECT id
    FROM offline_runtime_archive_sessions
    WHERE archive_scope='public_interiors'
    ORDER BY id DESC
    LIMIT 1
);

SELECT
    s.id AS archive_session_id,
    s.session_key,
    s.archive_status,
    s.runtime_rows_total,
    s.active_rows_total,
    s.target_rows_total,
    s.archived_rows,
    COUNT(a.archive_row_id) AS actual_archive_rows,
    SUM(a.original_id IS NULL) AS invalid_original_id_should_be_zero,
    COUNT(*) - COUNT(DISTINCT a.original_id) AS duplicate_original_id_should_be_zero
FROM offline_runtime_archive_sessions s
LEFT JOIN offline_public_interiors_archive a ON a.archive_session_id=s.id
WHERE s.id=@latest_archive_session_id
GROUP BY s.id;

SELECT
    128 AS pawn_runtime_capacity,
    (SELECT COUNT(*) FROM public_interiors WHERE enabled=1) AS active_runtime_now,
    (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND interior_type IN ('ammunation','247','burgershot','cluckinbell','pizzastack','barber','tattoo','clothing','gym','police')) AS active_target_rows,
    (SELECT COUNT(*) FROM offline_interior_apply_plan p WHERE p.session_id=(SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1) AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7' AND p.apply_readiness='dry_run_ready') AS exact_ready_expected_71,
    (SELECT COUNT(*) FROM offline_interior_apply_plan p WHERE p.session_id=(SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1) AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7' AND p.apply_readiness='service_overlay_review') AS overlay_review_expected_20,
    (SELECT COUNT(*) FROM offline_interior_apply_plan p WHERE p.session_id=(SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1) AND p.plan_version='saif_enex_pair_planner_v0.26A.1.7' AND p.apply_readiness='blocked_duplicate') AS blocked_expected_2;
