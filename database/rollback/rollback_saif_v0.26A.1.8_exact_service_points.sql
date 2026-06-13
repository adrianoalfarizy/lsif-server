-- SAFE rollback preview. Review first; final statement defaults to ROLLBACK.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;
SET @offline_session_key := _utf8mb4'ecbbfa867b491c93570b92e0c6d3ff34e1e916da9df914d83edb066c1eac52c3' COLLATE utf8mb4_unicode_ci;
SET @session_id := (SELECT id FROM offline_import_sessions WHERE session_key COLLATE utf8mb4_unicode_ci = @offline_session_key COLLATE utf8mb4_unicode_ci LIMIT 1);
UPDATE offline_interior_apply_plan SET service_point_id=NULL,service_resolver_version='',service_resolution_method='',service_confidence=0,
 service_point_status=CASE WHEN apply_readiness='blocked_duplicate' THEN 'not_evaluated' WHEN pair_group_key IN ('AMMUN1','FDBURG','FDCHICK','FDPIZA','BARBERS','TATTOO','CSCHP','GYM1','POLICE1') THEN 'default_compatible' ELSE 'exact_required' END,
 apply_readiness=CASE WHEN apply_readiness='blocked_duplicate' THEN 'blocked_duplicate' WHEN pair_group_key IN ('AMMUN1','FDBURG','FDCHICK','FDPIZA','BARBERS','TATTOO','CSCHP','GYM1','POLICE1') THEN 'dry_run_ready' ELSE 'service_point_pending' END
WHERE session_id=@session_id AND plan_version='saif_enex_pair_planner_v0.26A.1.7';
UPDATE offline_interior_apply_batches b
SET b.dry_run_ready_count=(SELECT COUNT(*) FROM offline_interior_apply_plan p WHERE p.batch_id=b.id AND p.apply_readiness='dry_run_ready'),
    b.service_pending_count=(SELECT COUNT(*) FROM offline_interior_apply_plan p WHERE p.batch_id=b.id AND p.apply_readiness='service_point_pending'),
    b.exact_service_count=0,
    b.overlay_review_count=0,
    b.blocked_count=(SELECT COUNT(*) FROM offline_interior_apply_plan p WHERE p.batch_id=b.id AND p.apply_readiness='blocked_duplicate')
WHERE b.session_id=@session_id AND b.plan_version='saif_enex_pair_planner_v0.26A.1.7';
DELETE FROM offline_interior_service_points WHERE session_id=@session_id AND resolver_version='saif_service_point_resolver_v0.26A.1.8';
SELECT ROW_COUNT() AS staged_rows_that_would_be_deleted;
ROLLBACK;
-- Change ROLLBACK to COMMIT only after reviewing the selected session.
