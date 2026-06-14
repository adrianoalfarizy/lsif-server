-- Read-only diagnostics for latest house apply session.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @apply_session_id := (SELECT id FROM offline_house_catalog_apply_sessions ORDER BY id DESC LIMIT 1);
SELECT 'LATEST_APPLY' section,* FROM offline_house_catalog_apply_sessions WHERE id=@apply_session_id;
SELECT 'MAPPINGS' section,
       (SELECT COUNT(*) FROM offline_house_catalog_apply_rows WHERE apply_session_id=@apply_session_id) canonical_mappings,
       (SELECT COUNT(*) FROM offline_house_catalog_disabled_rows WHERE apply_session_id=@apply_session_id) disabled_mappings,
       (SELECT COUNT(*) FROM offline_house_ownership_apply_rows WHERE apply_session_id=@apply_session_id) ownership_mappings;
SELECT 'CURRENT_STATE' section,
       (SELECT COUNT(*) FROM house_catalog) catalog_total,
       (SELECT COUNT(*) FROM house_catalog WHERE enabled=1) catalog_active,
       (SELECT COUNT(*) FROM house_catalog WHERE enabled=1 AND source_tag LIKE 'offline_gtasa_house29_a%') imported_active,
       (SELECT COUNT(*) FROM player_houses) ownership_rows,
       (SELECT COUNT(*) FROM player_houses ph LEFT JOIN house_catalog h ON h.id=ph.house_catalog_id WHERE h.id IS NULL OR h.enabled<>1) orphan_or_disabled_ownership;
