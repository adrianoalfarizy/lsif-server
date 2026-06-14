-- SAIF / LSIF Dev v0.26A.1.25.1
-- Read-only audit of public icon candidates versus the fixed 91+1+8 allocator.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @public_db := (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND exterior_map_icon>0);
SET @hospital_db := (SELECT COUNT(*) FROM public_interiors WHERE enabled=1 AND interior_type='hospital' AND exterior_map_icon>0);
SET @hospital_fallback := GREATEST(0,7-LEAST(7,@hospital_db));
SET @candidates := @public_db+@hospital_fallback;
SELECT 'ALLOCATOR_SUMMARY' section,
       @public_db public_db_icon_candidates,
       @hospital_db hospital_db_icons,
       @hospital_fallback hospital_fallback_candidates,
       @candidates total_public_candidates,
       LEAST(91,@candidates) public_icons_rendered_max_91,
       GREATEST(0,@candidates-91) public_icons_omitted_by_allocator,
       91 public_service_slots,1 owned_house_slot,8 nearby_for_sale_slots,100 total_native_slots,
       (SELECT COUNT(*) FROM house_map_icon_policy WHERE id=1 AND enabled=1 AND public_service_slots=91 AND owned_house_slots=1 AND nearby_for_sale_slots=8) policy_ready_should_be_1;
SELECT 'PUBLIC_ICON_CATEGORY_COUNTS' section,interior_type,exterior_map_icon,COUNT(*) rows_count
FROM public_interiors
WHERE enabled=1 AND exterior_map_icon>0
GROUP BY interior_type,exterior_map_icon
ORDER BY FIELD(interior_type,'hospital','police','ammunation','247','burgershot','cluckinbell','pizzastack','gym','barber','tattoo','clothing','casino'),interior_type,exterior_map_icon;
SELECT 'RUNTIME_PRIORITY_PREVIEW' section,id,interior_type,display_name,exterior_map_icon,
       CASE WHEN interior_type='hospital' THEN 1 ELSE 3 END priority_group
FROM public_interiors
WHERE enabled=1 AND exterior_map_icon>0
ORDER BY CASE WHEN interior_type='hospital' THEN 1 ELSE 3 END,id
LIMIT 120;
