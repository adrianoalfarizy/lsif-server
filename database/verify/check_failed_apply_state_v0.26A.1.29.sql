-- SAIF / LSIF Dev v0.26A.1.29
-- Read-only diagnostic after a failed/retried controlled apply.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @apply_version := _utf8mb4'saif-controlled-12-savehouse-garage-apply-v0.26A.1.29' COLLATE utf8mb4_unicode_ci;
SET @catalog_source_tag := _utf8mb4'offline_gtasa_savehouse_garage12_a1' COLLATE utf8mb4_unicode_ci;
SET @link_source_tag := _utf8mb4'offline_gtasa_savehouse_garage12_link_a1' COLLATE utf8mb4_unicode_ci;

SELECT 'LATEST_APPLY_SESSION' section,id,status,archive_session_id,geometry_session_id,garage_resolver_session_id,
       expected_catalog_rows,applied_catalog_rows,expected_link_rows,applied_link_rows,created_at,completed_at,rolled_back_at,notes
FROM garage_catalog_apply_sessions
WHERE BINARY apply_version=BINARY @apply_version
ORDER BY id DESC LIMIT 1;

SELECT 'CURRENT_RUNTIME_STATE' section,
       (SELECT COUNT(*) FROM garage_catalog) catalog_total,
       (SELECT COUNT(*) FROM garage_catalog WHERE BINARY source_tag=BINARY @catalog_source_tag) target_catalog_rows,
       (SELECT COUNT(*) FROM garage_catalog WHERE BINARY source_tag=BINARY @catalog_source_tag AND enabled=1) target_enabled_rows,
       (SELECT COUNT(*) FROM house_garage_links) link_total,
       (SELECT COUNT(*) FROM house_garage_links WHERE BINARY source_tag=BINARY @link_source_tag) target_link_rows,
       (SELECT COUNT(*) FROM house_garage_links WHERE BINARY source_tag=BINARY @link_source_tag AND enabled=1) target_enabled_links;

SELECT 'POLICY_STATE' section,policy_key,enabled,store_enabled,retrieve_enabled,door_animation_enabled,max_catalog_rows
FROM garage_runtime_policy WHERE id=1;
