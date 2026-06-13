-- Verify SAIF v0.26A.1.8
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @offline_session_key := _utf8mb4'ecbbfa867b491c93570b92e0c6d3ff34e1e916da9df914d83edb066c1eac52c3' COLLATE utf8mb4_unicode_ci;
SET @session_id := (SELECT id FROM offline_import_sessions WHERE session_key COLLATE utf8mb4_unicode_ci = @offline_session_key COLLATE utf8mb4_unicode_ci LIMIT 1);
SET @resolver_version := 'saif_service_point_resolver_v0.26A.1.8';
SELECT COUNT(*) total_service_rows,
 SUM(resolution_method='scm_exact') exact_expected_71,
 SUM(resolution_method='saif_overlay_translated') overlay_expected_20,
 SUM(review_status='approved_exact') approved_exact_expected_71,
 SUM(review_status='preview_required') preview_required_expected_20,
 SUM(enabled=1) enabled_should_be_zero,
 SUM(apply_status<>'draft') nondraft_should_be_zero,
 SUM(ABS(service_x)>4000 OR ABS(service_y)>4000 OR service_z<-1000 OR service_z>2000) invalid_coords_should_be_zero
FROM offline_interior_service_points WHERE session_id=@session_id AND resolver_version=@resolver_version;
SELECT context_type,COUNT(*) total,SUM(resolution_method='scm_exact') exact_rows,SUM(resolution_method='saif_overlay_translated') overlay_rows,MIN(confidence) min_confidence,MAX(confidence) max_confidence FROM offline_interior_service_points WHERE session_id=@session_id AND resolver_version=@resolver_version GROUP BY context_type ORDER BY context_type;
SELECT COUNT(*) plans_total,
 SUM(apply_readiness='dry_run_ready') dry_run_ready_expected_71,
 SUM(apply_readiness='service_overlay_review') overlay_review_expected_20,
 SUM(apply_readiness='blocked_duplicate') blocked_expected_2,
 SUM(service_point_id IS NULL AND apply_readiness<>'blocked_duplicate') missing_service_link_should_be_zero,
 SUM(enabled=1) enabled_should_be_zero,
 SUM(apply_status<>'draft') nondraft_should_be_zero
FROM offline_interior_apply_plan WHERE session_id=@session_id AND plan_version='saif_enex_pair_planner_v0.26A.1.7';
SELECT COUNT(*) runtime_public_interiors_unchanged_by_verify FROM public_interiors;
