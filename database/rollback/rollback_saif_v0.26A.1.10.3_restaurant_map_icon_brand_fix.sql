-- Preview rollback SAIF v0.26A.1.10.3.
-- Imported Full-91 rows originally stored exterior_map_icon=0 and relied on gamemode fallback.
-- This file deliberately ends in ROLLBACK. Change to COMMIT only when intentionally reverting DB values.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

UPDATE public_interiors
SET exterior_map_icon=0
WHERE source_tag LIKE 'offline_gtasa_pubint91_a%'
  AND (
      (interior_type='burgershot'  AND exterior_map_icon=10) OR
      (interior_type='cluckinbell' AND exterior_map_icon=14) OR
      (interior_type='pizzastack'  AND exterior_map_icon=29)
  );

SELECT ROW_COUNT() AS rows_that_would_revert_to_fallback;
ROLLBACK;
