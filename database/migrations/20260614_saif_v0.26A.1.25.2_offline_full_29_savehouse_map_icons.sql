-- SAIF / LSIF Dev v0.26A.1.25.2
-- Offline-like full 29-savehouse map icon allocator policy.
-- Metadata/config only: no house_catalog or player_houses mutation.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

CREATE TABLE IF NOT EXISTS house_map_icon_policy (
    id TINYINT UNSIGNED NOT NULL,
    policy_key VARCHAR(64) NOT NULL,
    enabled TINYINT(1) NOT NULL DEFAULT 1,
    public_service_slots SMALLINT UNSIGNED NOT NULL DEFAULT 66,
    owned_house_slots SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    nearby_for_sale_slots SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    canonical_house_slots SMALLINT UNSIGNED NOT NULL DEFAULT 29,
    dynamic_context_slots SMALLINT UNSIGNED NOT NULL DEFAULT 5,
    nearby_radius DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    refresh_interval_ms INT UNSIGNED NOT NULL DEFAULT 30000,
    owned_icon_type SMALLINT NOT NULL DEFAULT 35,
    for_sale_icon_type SMALLINT NOT NULL DEFAULT 31,
    notes VARCHAR(512) NOT NULL DEFAULT '',
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_house_map_icon_policy_key (policy_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE house_map_icon_policy
    ADD COLUMN IF NOT EXISTS canonical_house_slots SMALLINT UNSIGNED NOT NULL DEFAULT 29 AFTER nearby_for_sale_slots,
    ADD COLUMN IF NOT EXISTS dynamic_context_slots SMALLINT UNSIGNED NOT NULL DEFAULT 5 AFTER canonical_house_slots;

INSERT INTO house_map_icon_policy
(id,policy_key,enabled,public_service_slots,owned_house_slots,nearby_for_sale_slots,
 canonical_house_slots,dynamic_context_slots,nearby_radius,refresh_interval_ms,
 owned_icon_type,for_sale_icon_type,notes)
VALUES
(1,'offline_full_29_savehouse_v2',1,66,0,0,29,5,0.00,30000,35,31,
 'Native 100-slot split: 0-65 prioritized public/service; 66-94 deterministic canonical_slot 3-31 savehouses; 95-99 context/fallback. No nearest/radius filtering for canonical savehouses. MAPICON_LOCAL.')
ON DUPLICATE KEY UPDATE
 policy_key=VALUES(policy_key),
 enabled=VALUES(enabled),
 public_service_slots=VALUES(public_service_slots),
 owned_house_slots=VALUES(owned_house_slots),
 nearby_for_sale_slots=VALUES(nearby_for_sale_slots),
 canonical_house_slots=VALUES(canonical_house_slots),
 dynamic_context_slots=VALUES(dynamic_context_slots),
 nearby_radius=VALUES(nearby_radius),
 refresh_interval_ms=VALUES(refresh_interval_ms),
 owned_icon_type=VALUES(owned_icon_type),
 for_sale_icon_type=VALUES(for_sale_icon_type),
 notes=VALUES(notes);

COMMIT;

SELECT 'HOUSE_MAP_ICON_POLICY_V2' section,policy_key,enabled,
       public_service_slots,canonical_house_slots,dynamic_context_slots,
       (public_service_slots+canonical_house_slots+dynamic_context_slots) total_slots_should_be_100,
       owned_house_slots legacy_owned_slots_should_be_zero,
       nearby_for_sale_slots legacy_nearby_slots_should_be_zero,
       nearby_radius legacy_radius_should_be_zero,
       refresh_interval_ms,owned_icon_type,for_sale_icon_type
FROM house_map_icon_policy WHERE id=1;
