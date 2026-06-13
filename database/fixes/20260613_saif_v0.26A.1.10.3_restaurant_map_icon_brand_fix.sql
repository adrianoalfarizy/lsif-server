-- SAIF / LSIF Dev v0.26A.1.10.3
-- Restaurant Map Icon Brand Fix
-- Runtime target: only GTA SA Full-91 imported public interior rows.

SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

SELECT
    interior_type,
    exterior_map_icon AS icon_before,
    COUNT(*) AS rows_before
FROM public_interiors
WHERE source_tag LIKE 'offline_gtasa_pubint91_a%'
  AND interior_type IN ('burgershot','cluckinbell','pizzastack')
GROUP BY interior_type, exterior_map_icon
ORDER BY interior_type, exterior_map_icon;

UPDATE public_interiors
SET exterior_map_icon = CASE interior_type
    WHEN 'burgershot'  THEN 10
    WHEN 'cluckinbell' THEN 14
    WHEN 'pizzastack'  THEN 29
    ELSE exterior_map_icon
END
WHERE source_tag LIKE 'offline_gtasa_pubint91_a%'
  AND interior_type IN ('burgershot','cluckinbell','pizzastack');

SELECT ROW_COUNT() AS restaurant_rows_updated;

SELECT
    interior_type,
    exterior_map_icon AS icon_after,
    COUNT(*) AS rows_after
FROM public_interiors
WHERE source_tag LIKE 'offline_gtasa_pubint91_a%'
  AND interior_type IN ('burgershot','cluckinbell','pizzastack')
GROUP BY interior_type, exterior_map_icon
ORDER BY interior_type, exterior_map_icon;

COMMIT;
