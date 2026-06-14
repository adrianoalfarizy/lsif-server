# SAIF v0.26A.1.24 — House Catalog Runtime Archive & 29-Savehouse Dry-Run Audit

## Scope

Read-only/staging phase before replacing the five legacy `house_catalog` rows with 29 canonical GTA SA savehouses.

No SQL in this patch mutates `house_catalog` or `player_houses`.

## Current baseline

- Dynamic catalog capacity: 64.
- Expected active legacy definitions: 5.
- Expected canonical definitions before apply: 0.
- Canonical resolver plans: 32.
- Source-ready savehouses: 29 (slots 3–31).
- Deferred assets: Wang Cars, Zero RC Shop, Verdant Meadows.

## Archive coverage

The capture stores every `house_catalog` field and a SHA-256 checksum in `offline_house_catalog_archive`.

It also captures every ownership row from `player_houses` in `offline_house_ownership_archive` and creates one explicit transition-policy row per ownership in `offline_house_ownership_transition_plan`.

## Ownership contract

Ownership is never reassigned automatically. Future apply is blocked when existing ownership rows remain `pending_mapping` or `invalid_source`.

Allowed future policy states:

- `mapped`: explicitly assigned to a canonical GTA SA slot;
- `preserve_legacy`: keep the old definition available for that owner;
- `refund_then_release`: controlled refund and ownership release.

## Map-icon capacity finding

SA-MP/open.mp exposes only 100 per-player native map-icon slots. The current allocator gives service/public icons priority and houses use leftovers. The dry-run reports how many of the future 29 house icons would actually render.

If `all_29_fit_should_be_1 = 0`, map-icon allocation/streaming must be solved before apply. This does not invalidate the source coordinates or catalog plan.

## Apply readiness gates

- archive complete;
- catalog and ownership checksums unchanged;
- archive linkage complete in both directions;
- 29 unique canonical slots selected;
- no invalid transforms or prices;
- no duplicate exterior pair within 1.0 m;
- catalog capacity fits 29;
- ownership transition policy ready;
- map-icon strategy ready.
