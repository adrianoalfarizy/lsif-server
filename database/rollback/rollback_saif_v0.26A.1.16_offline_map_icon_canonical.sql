SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @patch_key := 'saif_v0.26A.1.16_offline_map_icon_canonical';

START TRANSACTION;

UPDATE public_interiors p
JOIN offline_public_interior_map_icon_backup b
  ON b.public_interior_id = p.id
 AND b.patch_key = @patch_key
SET p.exterior_map_icon = b.old_map_icon;

SELECT
    COUNT(*) AS rows_that_would_restore
FROM offline_public_interior_map_icon_backup
WHERE patch_key = @patch_key;

SELECT
    p.id,
    p.interior_type,
    p.display_name,
    p.exterior_map_icon AS restored_icon
FROM public_interiors p
JOIN offline_public_interior_map_icon_backup b
  ON b.public_interior_id = p.id
 AND b.patch_key = @patch_key
ORDER BY p.id;

-- Safety preview: replace ROLLBACK with COMMIT only after reviewing the result.
ROLLBACK;
