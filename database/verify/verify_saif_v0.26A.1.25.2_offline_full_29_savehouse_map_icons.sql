-- SAIF / LSIF Dev v0.26A.1.25.2
-- Read-only verification for offline-like full 29-savehouse map icon allocation.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET @public_db := (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND exterior_map_icon>0);
SET @hospital_db := (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND interior_type='hospital' AND exterior_map_icon>0);
SET @hospital_fallback := GREATEST(0,7-LEAST(7,@hospital_db));
SET @public_candidates := @public_db+@hospital_fallback;

SELECT 'POLICY_GATE' section,policy_key,enabled,
       public_service_slots,canonical_house_slots,dynamic_context_slots,
       (public_service_slots+canonical_house_slots+dynamic_context_slots) total_slots_should_be_100,
       owned_house_slots legacy_owned_slots_should_be_zero,
       nearby_for_sale_slots legacy_nearby_slots_should_be_zero,
       nearby_radius legacy_radius_should_be_zero,
       (enabled=1 AND policy_key='offline_full_29_savehouse_v2'
        AND public_service_slots=66 AND canonical_house_slots=29 AND dynamic_context_slots=5
        AND owned_house_slots=0 AND nearby_for_sale_slots=0 AND nearby_radius=0
        AND owned_icon_type=35 AND for_sale_icon_type=31) ready_should_be_1
FROM house_map_icon_policy WHERE id=1;

SELECT 'CANONICAL_HOUSE_GATE' section,
       COUNT(*) canonical_active_expected_29,
       COUNT(DISTINCT canonical_slot) unique_slots_expected_29,
       MIN(canonical_slot) min_slot_expected_3,
       MAX(canonical_slot) max_slot_expected_31,
       SUM(canonical_slot<3 OR canonical_slot>31) invalid_slot_should_be_zero,
       SUM(ABS(exterior_pickup_x)<0.001 AND ABS(exterior_pickup_y)<0.001 AND ABS(exterior_pickup_z)<0.001) zero_position_should_be_zero,
       SUM(map_icon_type<>31) non_property_icon_payload_in_db_informational,
       (COUNT(*)=29 AND COUNT(DISTINCT canonical_slot)=29 AND MIN(canonical_slot)=3 AND MAX(canonical_slot)=31
        AND SUM(canonical_slot<3 OR canonical_slot>31)=0) ready_should_be_1
FROM house_catalog
WHERE enabled=1 AND source_tag LIKE 'offline_gtasa_house29_a%';

SELECT 'CANONICAL_SLOT_DETAIL' section,canonical_slot,id house_catalog_id,display_name,
       IF((SELECT COUNT(*) FROM player_houses ph WHERE ph.house_catalog_id=house_catalog.id)>0,35,31) runtime_icon_type,
       66+(canonical_slot-3) native_map_slot,
       exterior_pickup_x,exterior_pickup_y,exterior_pickup_z
FROM house_catalog
WHERE enabled=1 AND source_tag LIKE 'offline_gtasa_house29_a%'
ORDER BY canonical_slot;

SELECT 'PUBLIC_PRIORITY_BUDGET' section,
       @public_db public_db_candidates,
       @hospital_fallback hospital_fallback_candidates,
       @public_candidates total_public_candidates,
       LEAST(66,@public_candidates) rendered_max_66,
       GREATEST(0,@public_candidates-66) omitted_by_priority_allocator_informational,
       66 public_slots,29 canonical_house_slots,5 context_slots,100 total_native_slots;

SELECT 'OWNERSHIP_GATE' section,
       (SELECT COUNT(*) FROM player_houses) ownership_rows,
       (SELECT COUNT(*) FROM player_houses ph LEFT JOIN house_catalog hc ON hc.id=ph.house_catalog_id WHERE hc.id IS NULL OR hc.enabled<>1) orphan_or_disabled_should_be_zero,
       (SELECT COUNT(*) FROM (SELECT house_catalog_id FROM player_houses WHERE house_catalog_id IS NOT NULL GROUP BY house_catalog_id HAVING COUNT(*)>1) d) duplicate_owner_should_be_zero;
