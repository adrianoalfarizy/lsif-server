SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
SET @patch_key := 'saif_v0.26A.1.16_offline_map_icon_canonical';

CREATE TABLE IF NOT EXISTS offline_public_interior_map_icon_backup (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    patch_key VARCHAR(96) NOT NULL,
    public_interior_id INT NOT NULL,
    interior_type VARCHAR(32) NOT NULL DEFAULT '',
    display_name VARCHAR(96) NOT NULL DEFAULT '',
    old_map_icon INT NOT NULL DEFAULT 0,
    new_map_icon INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_patch_public_interior (patch_key, public_interior_id),
    KEY idx_patch_key (patch_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO offline_public_interior_map_icon_backup
(
    patch_key,
    public_interior_id,
    interior_type,
    display_name,
    old_map_icon,
    new_map_icon
)
SELECT
    @patch_key,
    p.id,
    COALESCE(p.interior_type, ''),
    COALESCE(p.display_name, ''),
    COALESCE(p.exterior_map_icon, 0),
    CASE
        WHEN LOWER(COALESCE(p.interior_type,'')) = 'ammunation' THEN 6
        WHEN LOWER(COALESCE(p.interior_type,'')) = '247' THEN 52
        WHEN LOWER(COALESCE(p.interior_type,'')) = 'burgershot' THEN 10
        WHEN LOWER(COALESCE(p.interior_type,'')) = 'cluckinbell' THEN 14
        WHEN LOWER(COALESCE(p.interior_type,'')) = 'pizzastack' THEN 29
        WHEN LOWER(COALESCE(p.interior_type,'')) = 'barber' THEN 7
        WHEN LOWER(COALESCE(p.interior_type,'')) = 'tattoo' THEN 39
        WHEN LOWER(COALESCE(p.interior_type,'')) IN ('clothing','clothes','binco','zip','suburban','prolaps','victim') THEN 45
        WHEN LOWER(COALESCE(p.interior_type,'')) = 'gym' THEN 54
        WHEN LOWER(COALESCE(p.interior_type,'')) = 'police' THEN 30
        WHEN LOWER(COALESCE(p.interior_type,'')) = 'hospital' THEN 22
        WHEN LOWER(COALESCE(p.interior_type,'')) = 'restaurant' THEN 50
        WHEN LOWER(COALESCE(p.interior_type,'')) IN ('modgarage','carmod') THEN 27
        WHEN LOWER(COALESCE(p.interior_type,'')) IN ('paynspray','pay_n_spray') THEN 63
        WHEN LOWER(COALESCE(p.interior_type,'')) = 'property' THEN 31
        WHEN LOWER(COALESCE(p.interior_type,'')) IN ('savehouse','house') THEN 35
        WHEN LOWER(COALESCE(p.interior_type,'')) = 'casino'
             AND LOWER(COALESCE(p.display_name,'')) LIKE '%caligula%' THEN 25
        WHEN LOWER(COALESCE(p.interior_type,'')) = 'casino' THEN 44
        WHEN LOWER(COALESCE(p.interior_type,'')) = 'cityhall' THEN 0
        ELSE COALESCE(p.exterior_map_icon, 0)
    END
FROM public_interiors p;

SELECT
    'BEFORE' AS section,
    interior_type,
    old_map_icon,
    new_map_icon,
    COUNT(*) AS rows_count
FROM offline_public_interior_map_icon_backup
WHERE patch_key = @patch_key
GROUP BY interior_type, old_map_icon, new_map_icon
ORDER BY interior_type, old_map_icon, new_map_icon;

START TRANSACTION;

UPDATE public_interiors p
JOIN offline_public_interior_map_icon_backup b
  ON b.public_interior_id = p.id
 AND b.patch_key = @patch_key
SET p.exterior_map_icon = b.new_map_icon;

COMMIT;

SELECT
    'AFTER' AS section,
    p.interior_type,
    p.exterior_map_icon,
    COUNT(*) AS rows_count
FROM public_interiors p
GROUP BY p.interior_type, p.exterior_map_icon
ORDER BY p.interior_type, p.exterior_map_icon;
