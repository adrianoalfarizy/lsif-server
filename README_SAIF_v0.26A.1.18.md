# SAIF / LSIF Dev v0.26A.1.18 — GTA SA Pickup Canonical Resolver

## Scope

This patch resolves all 782 v0.26A.1.17 pickup queue rows into a read-only canonical apply plan. It does not spawn or mutate `world_pickups`.

## Exact outcome

- Total linked plans: 782
- Baseline-ready: 89
  - Police bribe: 49
  - Body armour: 40
- Duplicate shadows blocked: 35
- Plan rows enabled: 0
- Non-draft plan rows: 0

Health is deliberately absent from the permanent baseline because all 21 health statements are mission/activity context, not `INITIAL` world pickups.

## Install order

1. Replace and compile `gamemodes/lsif.pwn`.
2. Run migration.
3. Run canonical plan import.
4. Run verify.
5. Test `/offlinepickupplan` and `/offlinepickupplanlist`.

## SQL

- `database/migrations/20260613_saif_v0.26A.1.18_pickup_canonical_resolver.sql`
- `database/imports/20260613_gtasa_pickup_canonical_plan_v0.26A.1.18.sql`
- `database/verify/verify_saif_v0.26A.1.18_pickup_canonical_resolver.sql`
- `database/rollback/rollback_saif_v0.26A.1.18_pickup_canonical_resolver.sql`

## Safety

No SQL file in this patch contains mutation statements targeting `world_pickups`.
