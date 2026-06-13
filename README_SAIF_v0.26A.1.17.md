# SAIF / LSIF Dev v0.26A.1.17 — GTA SA Offline Pickup Queue Foundation

## Scope

This patch registers **782** exact-source pickup candidates in a disabled staging queue:

- 777 pickup creation statements from `01_DECOMPILED/main_decompiled.txt`;
- 5 entries from non-empty IPL `PICK` sections;
- 48 IPL `PICK` sections audited, 2 non-empty.

No pickup is spawned. `world_pickups` is not mutated.

## SQL order

1. `database/migrations/20260613_saif_v0.26A.1.17_offline_pickup_queue_foundation.sql`
2. `database/imports/20260613_gtasa_offline_pickup_queue_v0.26A.1.17.sql`
3. `database/verify/verify_saif_v0.26A.1.17_offline_pickup_queue.sql`

## Owner tools

- `/offlinepickups`
- `/offlinepickuplist`
- `/offlinepickup [queue_id]`
- `/amenus -> GTA Offline Import Audit -> GTA SA Offline Pickup Queue`

Preview is teleport-only. It is blocked for unresolved, zero-coordinate, and likely-interior points. No `CreatePickup` occurs.

## Expected verify

- total 782
- SCM 777
- IPL 5
- resolved 758
- unresolved 24
- zero coordinate 5
- enabled 0
- non-pending apply 0

## Next phase

v0.26A.1.18 — Pickup Canonical Resolver. It will decide safe/runtime categories, cooldowns, amounts, duplicates, interior context, property linkage, mission-only rows, and future backend targets.
