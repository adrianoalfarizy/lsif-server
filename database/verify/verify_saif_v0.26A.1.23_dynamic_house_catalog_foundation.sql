-- Verify SAIF v0.26A.1.23 Dynamic House Catalog Backend Foundation
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SELECT
    'CATALOG_GATE' AS section,
    COUNT(*) AS total_expected_5,
    SUM(enabled=1) AS enabled_expected_5,
    SUM(legacy_house_index BETWEEN 0 AND 4) AS legacy_expected_5,
    SUM(source_tag='legacy_house_catalog_v0.26A.1.23') AS source_tag_expected_5,
    SUM(canonical_slot IS NOT NULL) AS gta_sa_applied_should_be_zero,
    SUM(price<=0) AS invalid_price_should_be_zero,
    SUM(exterior_pickup_x=0 AND exterior_pickup_y=0 AND exterior_pickup_z=0) AS zero_exterior_should_be_zero,
    SUM(interior_id<=0) AS invalid_interior_should_be_zero,
    SUM(pickup_model<=0 OR pickup_type<0) AS invalid_pickup_should_be_zero
FROM house_catalog;

SELECT
    'LEGACY_INDEX_GATE' AS section,
    COUNT(DISTINCT legacy_house_index) AS distinct_expected_5,
    MIN(legacy_house_index) AS min_expected_0,
    MAX(legacy_house_index) AS max_expected_4
FROM house_catalog
WHERE legacy_house_index IS NOT NULL;

SELECT
    'OWNERSHIP_BRIDGE_GATE' AS section,
    COUNT(*) AS ownership_rows,
    COALESCE(SUM(ph.house_catalog_id IS NOT NULL),0) AS mapped_rows,
    COALESCE(SUM(ph.house_catalog_id IS NULL),0) AS unmapped_should_be_zero,
    COALESCE(SUM(ph.house_catalog_id IS NOT NULL AND hc.id IS NULL),0) AS orphan_should_be_zero,
    COALESCE(SUM(hc.id IS NOT NULL AND hc.legacy_house_index<>ph.house_index),0) AS legacy_mismatch_should_be_zero
FROM player_houses ph
LEFT JOIN house_catalog hc ON hc.id=ph.house_catalog_id;

SELECT
    'OWNERSHIP_SNAPSHOT_GATE' AS section,
    (SELECT COUNT(*) FROM player_houses) AS current_player_house_rows,
    COUNT(*) AS captured_rows,
    ((SELECT COUNT(*) FROM player_houses)=COUNT(*)) AS count_match_should_be_1
FROM house_catalog_bridge_backup
WHERE patch_key='saif-v0.26A.1.23-house-catalog-foundation';

SELECT
    'OFFLINE_APPLY_SAFETY' AS section,
    SUM(decision_code='baseline_ready') AS source_ready_expected_29,
    SUM(decision_code='baseline_ready' AND apply_status<>'draft') AS nondraft_should_be_zero,
    SUM(decision_code='baseline_ready' AND enabled<>0) AS enabled_should_be_zero
FROM offline_property_canonical_plan
WHERE resolver_version='saif-house-property-resolver-v0.26A.1.22';

SELECT
    'RUNTIME_CAPACITY_REFERENCE' AS section,
    64 AS compiled_catalog_capacity,
    COUNT(*) AS enabled_catalog_rows,
    64-COUNT(*) AS remaining_capacity_expected_59,
    (COUNT(*)<=64) AS fits_should_be_1
FROM house_catalog
WHERE enabled=1;
