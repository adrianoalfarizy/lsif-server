# SAIF / LSIF Dev v0.26A.1.29 — Controlled 12 Savehouse Garage Catalog Apply

This release applies 12 exact-source, baseline-ready GTA SA savehouse garages into `garage_catalog` and creates 12 `house_garage_links` rows.

The runtime loader may load 12 enabled catalog definitions, but all interaction policy remains disabled:

- master policy: 0
- store: 0
- retrieve: 0
- door animation: 0

## SQL order

1. `database/migrations/20260614_saif_v0.26A.1.29_controlled_12_savehouse_garage_apply_foundation.sql`
2. `database/archive/archive_saif_v0.26A.1.29_preapply_world_garage_catalog.sql`
3. `database/dry_run/dry_run_saif_v0.26A.1.29_controlled_12_savehouse_garage_apply_gate.sql`
4. Run apply with confirmation:

```sql
SET @saif_confirm='APPLY_12_GTASA_SAVEHOUSE_GARAGES';
```

5. `database/verify/verify_saif_v0.26A.1.29_controlled_12_savehouse_garage_apply.sql`

## Runtime expectation

- `garage_catalog`: 12 controlled rows.
- `house_garage_links`: 12 controlled rows.
- `/garagecatalog`: loaded enabled rows 12/64 after reload/restart.
- Existing `/garage` three-player-vehicle-slot system remains unchanged.
- No checkpoint, door, storage, retrieval, or ownership behavior is enabled.
