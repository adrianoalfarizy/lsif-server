# Baseline-89 World Pickup Apply Audit — v0.26A.1.20

## Selection

| Category | Rows | Model | Type | Amount | Cooldown |
|---|---:|---:|---|---:|---:|
| Police bribe | 49 | 1247 | bribe | 1 wanted level | 180 s |
| Body armour | 40 | 1242 | armor | 100 | 240 s |
| **Total** | **89** |  |  |  |  |

## Pre-apply gates

- latest `world_pickups` archive must be the latest archive scope row and status `complete`;
- archive metadata target must equal 89;
- current count and active count must match archive metadata;
- no missing IDs in either direction;
- no row checksum mismatch;
- canonical session must be complete with 782 total / 89 ready / 649 deferred / 44 blocked;
- selected plan must be 49 bribe + 40 armour;
- no internal duplicate within 0.50 metre;
- no existing live apply and no active orphan source tags;
- 89 rows fit loader 300 and array 700.

## Apply mutation

1. record every currently active old pickup;
2. set those old rows `enabled=0`;
3. insert exactly 89 canonical rows;
4. create plan/queue/runtime mapping;
5. mark only selected plan and queue rows applied;
6. assert exactly 89 active runtime DB rows;
7. commit.

## Rollback mutation

1. verify mappings and row checksums;
2. set imported rows `enabled=0`;
3. restore previous old-row enabled-state;
4. return selected plan to `draft` and queue to `pending`;
5. assert active count equals pre-apply count;
6. mark session `rolled_back`;
7. commit.
