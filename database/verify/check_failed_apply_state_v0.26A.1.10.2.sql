-- SAIF / LSIF Dev v0.26A.1.10.2
-- Verify that the collation failure happened before runtime mutation.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SELECT
    COUNT(*) AS live_completed_apply_should_be_zero
FROM offline_runtime_apply_sessions
WHERE apply_scope='public_interiors_offline_91'
  AND apply_status='complete'
  AND rolled_back_at IS NULL;

SELECT
    COUNT(*) AS applying_session_should_be_zero
FROM offline_runtime_apply_sessions
WHERE apply_scope='public_interiors_offline_91'
  AND apply_status='applying';

SELECT
    COUNT(*) AS imported_runtime_rows_should_be_zero,
    COALESCE(SUM(enabled=1),0) AS imported_enabled_rows_should_be_zero
FROM public_interiors
WHERE source_tag LIKE 'offline_gtasa_pubint91_a%';

SELECT
    COUNT(*) AS apply_mapping_rows_should_be_zero
FROM offline_public_interior_apply_rows;

SELECT
    id,archive_status,runtime_rows_total,archived_rows,created_at,completed_at
FROM offline_runtime_archive_sessions
WHERE archive_scope='public_interiors'
ORDER BY id DESC
LIMIT 3;
