# SAIF / LSIF Dev v0.26A.1.22 — House / Property Canonical Resolver & Pair Planner

This package resolves the 255 evidence rows from v0.26A.1.21 into 32 deterministic GTA SA property plans.

## Result

- 32 canonical property slots.
- 29 purchasable savehouses marked `baseline_ready` at source level.
- 2 business assets deferred: Wang Cars and Zero RC Shop.
- 1 story asset deferred: Verdant Meadows.
- 30 exact ENEX pairs, 30 savepoint template links.
- 13 nearby garage candidates, of which 12 belong to baseline savehouses.
- No runtime mutation.

## Critical backend finding

The current gamemode uses `MAX_HOUSES = 5` and hardcoded `HouseX`, `HouseY`, `HouseZ`, `HousePrice`, and `HouseName` arrays. Therefore v0.26A.1.22 is source-ready but not apply-ready. The next safe phase is a dynamic `house_catalog` backend bridge that preserves `player_houses` ownership rows.

## SQL order

1. `database/migrations/20260613_saif_v0.26A.1.22_house_property_canonical_resolver.sql`
2. `database/imports/20260613_gtasa_house_property_canonical_plan_v0.26A.1.22.sql`
3. `database/verify/verify_saif_v0.26A.1.22_house_property_canonical_resolver.sql`

## Owner commands

- `/offlinehouseplans`
- `/offlinepropertyresolver`
- `/offlinehousecanonical`
- `/offlinehouseplanlist`
- `/offlinehouseplan [plan_id]`

All commands are read-only except preview teleport.
