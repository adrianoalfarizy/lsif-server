-- SAIF / LSIF Dev v0.26A.1.25.2
-- Roll back policy metadata only. Pair with the previous lsif.pwn when reverting runtime behavior.
-- No house_catalog/player_houses mutation.
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;
UPDATE house_map_icon_policy
SET policy_key='offline_owned_plus_nearest_v1',
    enabled=1,
    public_service_slots=91,
    owned_house_slots=1,
    nearby_for_sale_slots=8,
    canonical_house_slots=0,
    dynamic_context_slots=0,
    nearby_radius=1500.00,
    refresh_interval_ms=8000,
    owned_icon_type=35,
    for_sale_icon_type=31,
    notes='Rolled back to legacy 91 public + 1 owned + 8 nearby allocator metadata.'
WHERE id=1;
COMMIT;
SELECT * FROM house_map_icon_policy WHERE id=1;
