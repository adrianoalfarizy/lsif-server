# GTA SA Pickup Canonical Resolver — SAIF v0.26A.1.18

## Safety boundary

- Resolver reads the 782-row `offline_pickup_queue` dataset.
- It writes only `offline_pickup_resolver_sessions` and `offline_pickup_canonical_plan`.
- Every plan row remains `enabled=0` and `apply_status=draft`.
- No `world_pickups` mutation or runtime spawn is performed.

## Canonical outcome

| Decision | Rows |
|---|---:|
| `weapon_economy_deferred` | 327 |
| `collectible_persistence_deferred` | 150 |
| `baseline_ready` | 89 |
| `property_bridge_deferred` | 76 |
| `duplicate_shadow_blocked` | 35 |
| `interior_context_deferred` | 26 |
| `dynamic_position_deferred` | 24 |
| `mission_context_deferred` | 23 |
| `economy_backend_deferred` | 13 |
| `reference_only` | 5 |
| `invalid_placeholder` | 5 |
| `mission_story_excluded` | 4 |
| `interior_ipl_deferred` | 3 |
| `ipl_semantics_deferred` | 2 |

## Baseline-ready world pickups

| Category | Rows | Model | Amount | Recommended cooldown |
|---|---:|---:|---:|---:|
| Police bribe | 49 | 1247 | wanted -1 | 180 s |
| Body armour | 40 | 1242 | 100 armour | 240 s |
| **Total** | **89** |  |  |  |

Health is not included in baseline-ready: all 21 health creation statements belong to mission/activity scripts, not the permanent `INITIAL` world set.

## Duplicate policy

- Duplicate groups from parser: 34.
- Rows in duplicate groups: 69.
- Primary evidence rows retained: 34.
- Duplicate shadows blocked: 35.

## Deferred backends

- weapons → ammo/economy/anti-farm bridge;
- collectibles → per-account collection persistence;
- properties/save points → `player_houses` and private VW bridge;
- interior pickup points → exact interior ID/VW resolver;
- mission/story/dynamic positions → contextual mission runtime only;
- revenue/money → ownership or mission payout backend.

## Next gate

v0.26A.1.19 will archive current `world_pickups`, compare checksums, and dry-run only the 89 baseline-ready rows. No automatic apply is authorized by this resolver.
