# SAIF / LSIF Dev v0.26A.1.24 — House Catalog Runtime Archive & 29-Savehouse Dry-Run

This patch adds a full snapshot of `house_catalog`, a snapshot of `player_houses` ownership linkage, an explicit ownership-transition staging plan, and a dry-run of the future five-to-29 catalog replacement.

## Safety

- No `INSERT`, `UPDATE`, or `DELETE` against `house_catalog`.
- No `INSERT`, `UPDATE`, or `DELETE` against `player_houses`.
- No GTA SA house is created at runtime.
- Capture is SQL-only.
- Rollback file is preview-only and ends with `ROLLBACK`.

## Expected canonical selection

- 29 baseline-ready savehouses.
- 2 business assets deferred.
- 1 story asset deferred.
- 12 baseline garage candidates.
- Runtime catalog capacity: 64.

## Installation order

1. Backup database.
2. Run the v0.26A.1.24 migration.
3. Compile and deploy the PWN.
4. Capture a fresh house catalog archive.
5. Run verify.
6. Run the 29-savehouse dry-run.
7. Review ownership-policy and map-icon projections before any future apply.

## Owner commands

- `/offlinehousedryrun`
- `/offlinehousearchive`
- `/offlinehousecapacity`
- `/offlinehousecatalogdryrun`

All commands are read-only status views.
