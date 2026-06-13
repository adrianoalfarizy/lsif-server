-- SAIF / LSIF Dev v0.26A.1.20
-- Read-only diagnostics after an apply error or interrupted operator workflow.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SELECT 'LATEST_APPLY_SESSIONS' AS section,id,apply_scope,apply_status,source_tag,archive_session_id,
       runtime_active_before,runtime_active_after,old_rows_disabled,new_rows_inserted,created_at,completed_at,rolled_back_at
FROM offline_runtime_apply_sessions
WHERE apply_scope='world_pickups_offline_baseline89'
ORDER BY id DESC LIMIT 10;

SELECT 'ACTIVE_IMPORT_ROWS' AS section,source_tag,COUNT(*) AS active_rows
FROM world_pickups
WHERE enabled=1 AND source_tag LIKE 'offline_gtasa_pickup89_a%'
GROUP BY source_tag ORDER BY source_tag;

SELECT 'CURRENT_RUNTIME' AS section,COUNT(*) AS total_rows,COALESCE(SUM(enabled=1),0) AS active_rows
FROM world_pickups;

SELECT 'PLAN_STATE' AS section,apply_status,COUNT(*) AS rows_total
FROM offline_pickup_canonical_plan
WHERE resolver_version='saif-pickup-resolver-v0.26A.1.18'
GROUP BY apply_status ORDER BY apply_status;
