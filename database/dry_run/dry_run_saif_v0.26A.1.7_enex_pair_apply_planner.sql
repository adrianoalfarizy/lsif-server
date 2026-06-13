-- SAIF v0.26A.1.7 DRY RUN ONLY
-- This file contains SELECT statements only and cannot mutate runtime.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @plan_version := _utf8mb4'saif_enex_pair_planner_v0.26A.1.7' COLLATE utf8mb4_unicode_ci;
SET @session_id := (SELECT id FROM offline_import_sessions ORDER BY id DESC LIMIT 1);
SELECT b.batch_label,b.candidate_count,b.dry_run_ready_count,b.service_pending_count,b.blocked_count,b.status,b.dry_run_only FROM offline_interior_apply_batches b WHERE b.session_id=@session_id AND b.plan_version=@plan_version ORDER BY b.sort_order;
SELECT p.id,p.display_name,p.pair_group_key,p.region_key,p.area_code,p.runtime_type,p.interior_id,p.apply_readiness,p.service_point_status,p.confidence FROM offline_interior_apply_plan p WHERE p.session_id=@session_id AND p.plan_version=@plan_version ORDER BY FIELD(p.apply_readiness,'blocked_duplicate','service_point_pending','dry_run_ready'),p.context_type,p.area_code,p.id;
SELECT COUNT(*) current_active_runtime,80 current_compiled_capacity,91 unique_plans_if_all_old_rows_replaced,11 required_extra_slots FROM public_interiors WHERE enabled=1;
SELECT 'BLOCKER' item,'Raise MAX_PUBLIC_INTERIORS from 80 to at least 128 before full 91-row world apply.' detail
UNION ALL SELECT 'BLOCKER','Resolve exact service/cashier points for 47 non-canonical interior variants.'
UNION ALL SELECT 'BLOCKER','Keep 2 duplicate FDPIZA exterior rows blocked.'
UNION ALL SELECT 'SAFETY','No INSERT/UPDATE/DELETE against public_interiors exists in v0.26A.1.7.';
