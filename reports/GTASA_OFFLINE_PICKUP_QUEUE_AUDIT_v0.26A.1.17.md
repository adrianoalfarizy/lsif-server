# GTA SA Offline Pickup Queue Audit — SAIF v0.26A.1.17

Generated: `2026-06-13T09:32:04.330486+00:00`

## Safety

This phase is staging/read-only. It does not create pickups and does not mutate `world_pickups`.

## Source coverage

- SCM/decompiled creation statements: **777**
- IPL `PICK` entries: **5**
- Total staging rows: **782**
- IPL files containing a `PICK` section: **48**
- Non-empty IPL `PICK` sections: **2**

### Non-empty IPL PICK entries

| Source | Line | Entries |
|---|---:|---:|
| `00_RAW/data/maps/country/countryw.ipl` | 401 | 2 |
| `00_RAW/data/maps/interior/gen_int5.ipl` | 37 | 3 |

## Resolution

- Position resolved: **758**
- Position unresolved: **24**
- Zero-coordinate placeholders: **5**
- Duplicate transform groups: **34**
- Rows in duplicate groups: **69**

## Commands

| Command | Rows |
|---|---:|
| `create_pickup` | 335 |
| `create_pickup_with_ammo` | 215 |
| `create_horseshoe_pickup` | 50 |
| `create_oyster_pickup` | 50 |
| `create_snapshot_pickup` | 50 |
| `create_forsale_property_pickup` | 32 |
| `create_locked_property_pickup` | 29 |
| `create_protection_pickup` | 12 |
| `IPL_PICK` | 5 |
| `create_money_pickup` | 4 |

## Initial categories

These are parser labels for audit only, not apply decisions.

| Category | Rows |
|---|---:|
| `weapon` | 350 |
| `armor` | 74 |
| `collectible_horseshoe` | 50 |
| `collectible_oyster` | 50 |
| `collectible_snapshot` | 50 |
| `bribe` | 49 |
| `savegame` | 37 |
| `property_for_sale` | 32 |
| `property_locked` | 29 |
| `health` | 21 |
| `revenue` | 12 |
| `story_item` | 12 |
| `ipl_pick` | 5 |
| `info` | 4 |
| `money` | 4 |
| `clothing` | 2 |
| `model_reference` | 1 |

## Next stage

v0.26A.1.18 must resolve canonical multiplayer behavior, cooldown, amount, interior context, duplicates, property links, mission-only rows, and runtime target before any archive/apply phase.
