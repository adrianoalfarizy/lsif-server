-- SAIF v0.26A.1.7 verify: staging planner only
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @plan_version := _utf8mb4'saif_enex_pair_planner_v0.26A.1.7' COLLATE utf8mb4_unicode_ci;
SET @session_id := (SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1);
SELECT COUNT(*) AS batch_rows_expected_10 FROM offline_interior_apply_batches WHERE session_id=@session_id AND plan_version=@plan_version;
SELECT COUNT(*) AS plan_rows_expected_93,
 SUM(apply_readiness='dry_run_ready') AS dry_run_ready_expected_44,
 SUM(apply_readiness='service_point_pending') AS service_pending_expected_47,
 SUM(apply_readiness='blocked_duplicate') AS blocked_expected_2,
 SUM(plan_status='pair_ready') AS pair_ready_expected_91,
 SUM(enabled=1) AS enabled_should_be_zero,
 SUM(apply_status<>'draft') AS nondraft_should_be_zero
FROM offline_interior_apply_plan WHERE session_id=@session_id AND plan_version=@plan_version;
SELECT context_type,COUNT(*) total,SUM(apply_readiness='dry_run_ready') ready,SUM(apply_readiness='service_point_pending') service_pending,SUM(apply_readiness='blocked_duplicate') blocked FROM offline_interior_apply_plan WHERE session_id=@session_id AND plan_version=@plan_version GROUP BY context_type ORDER BY MIN(batch_id);
SELECT COUNT(*) AS missing_queue_link_should_be_zero FROM offline_interior_apply_plan p LEFT JOIN offline_interior_queue e ON e.id=p.exterior_queue_id LEFT JOIN offline_interior_queue i ON i.id=p.interior_queue_id WHERE p.session_id=@session_id AND p.plan_version=@plan_version AND (e.id IS NULL OR i.id IS NULL);
SELECT COUNT(*) AS invalid_coordinate_should_be_zero FROM offline_interior_apply_plan WHERE session_id=@session_id AND plan_version=@plan_version AND (ABS(exterior_x)>4000 OR ABS(exterior_y)>4000 OR exterior_z<-100 OR exterior_z>500 OR interior_id<=0 OR ABS(interior_x)>4000 OR ABS(interior_y)>4000 OR interior_z<-1000 OR interior_z>2000);
SELECT COUNT(*) active_runtime_now, 80 runtime_limit, 91 unique_planned_after_replace, (91-80) minimum_capacity_shortfall FROM public_interiors WHERE enabled=1;
