SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SELECT
    COUNT(*) AS total_public_interiors,
    SUM(enabled=1) AS active_public_interiors,
    SUM(enabled=1 AND NOT (exterior_x=0 AND exterior_y=0 AND exterior_z=0)) AS active_with_valid_coordinates
FROM public_interiors;

SELECT
    SUM(enabled=1 AND interior_type='ammunation' AND exterior_map_icon<>6) AS ammunation_wrong_should_be_zero,
    SUM(enabled=1 AND interior_type='247' AND exterior_map_icon<>52) AS store_247_wrong_should_be_zero,
    SUM(enabled=1 AND interior_type='burgershot' AND exterior_map_icon<>10) AS burgershot_wrong_should_be_zero,
    SUM(enabled=1 AND interior_type='cluckinbell' AND exterior_map_icon<>14) AS cluckinbell_wrong_should_be_zero,
    SUM(enabled=1 AND interior_type='pizzastack' AND exterior_map_icon<>29) AS pizzastack_wrong_should_be_zero,
    SUM(enabled=1 AND interior_type='barber' AND exterior_map_icon<>7) AS barber_wrong_should_be_zero,
    SUM(enabled=1 AND interior_type='tattoo' AND exterior_map_icon<>39) AS tattoo_wrong_should_be_zero,
    SUM(enabled=1 AND interior_type IN ('clothing','clothes','binco','zip','suburban','prolaps','victim') AND exterior_map_icon<>45) AS clothing_wrong_should_be_zero,
    SUM(enabled=1 AND interior_type='gym' AND exterior_map_icon<>54) AS gym_wrong_should_be_zero,
    SUM(enabled=1 AND interior_type='police' AND exterior_map_icon<>30) AS police_wrong_should_be_zero,
    SUM(enabled=1 AND interior_type='hospital' AND exterior_map_icon<>22) AS hospital_wrong_should_be_zero,
    SUM(enabled=1 AND interior_type='cityhall' AND exterior_map_icon<>0) AS cityhall_should_have_no_icon_zero,
    SUM(enabled=1 AND interior_type='casino' AND LOWER(display_name) LIKE '%caligula%' AND exterior_map_icon<>25) AS caligulas_wrong_should_be_zero,
    SUM(enabled=1 AND interior_type='casino' AND LOWER(display_name) NOT LIKE '%caligula%' AND exterior_map_icon<>44) AS other_casino_wrong_should_be_zero
FROM public_interiors;

SELECT
    interior_type,
    exterior_map_icon,
    COUNT(*) AS rows_count,
    SUM(enabled=1) AS active_rows
FROM public_interiors
GROUP BY interior_type, exterior_map_icon
ORDER BY interior_type, exterior_map_icon;

SELECT
    SUM(enabled=1 AND exterior_map_icon=56) AS crash_risk_icon_56_should_be_zero,
    SUM(enabled=1 AND exterior_map_icon NOT BETWEEN 0 AND 63) AS invalid_icon_should_be_zero,
    SUM(enabled=1 AND exterior_map_icon>0 AND NOT (exterior_x=0 AND exterior_y=0 AND exterior_z=0)) AS active_icon_candidates,
    95 AS compiled_public_icon_budget,
    CASE
        WHEN SUM(enabled=1 AND exterior_map_icon>0 AND NOT (exterior_x=0 AND exterior_y=0 AND exterior_z=0)) <= 95 THEN 1
        ELSE 0
    END AS fits_public_icon_budget_should_be_1
FROM public_interiors;
