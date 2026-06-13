-- Verify SAIF v0.26A.1.10.3 restaurant map icon brands.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SELECT
    SUM(interior_type='burgershot'  AND exterior_map_icon=10) AS burgershot_icon_10,
    SUM(interior_type='cluckinbell' AND exterior_map_icon=14) AS cluckinbell_icon_14,
    SUM(interior_type='pizzastack'  AND exterior_map_icon=29) AS pizzastack_icon_29,
    SUM(interior_type='burgershot'  AND exterior_map_icon<>10) AS burgershot_wrong_should_be_zero,
    SUM(interior_type='cluckinbell' AND exterior_map_icon<>14) AS cluckinbell_wrong_should_be_zero,
    SUM(interior_type='pizzastack'  AND exterior_map_icon<>29) AS pizzastack_wrong_should_be_zero
FROM public_interiors
WHERE source_tag LIKE 'offline_gtasa_pubint91_a%'
  AND interior_type IN ('burgershot','cluckinbell','pizzastack');

SELECT id,interior_type,display_name,exterior_map_icon,source_tag,enabled
FROM public_interiors
WHERE source_tag LIKE 'offline_gtasa_pubint91_a%'
  AND interior_type IN ('burgershot','cluckinbell','pizzastack')
ORDER BY interior_type,id;
