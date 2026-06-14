# SAIF / LSIF Dev v0.26A.1.25 — Controlled GTA SA 29-Savehouse Apply Transaction

This patch performs the first controlled live application of the 29 canonical GTA SA purchasable savehouses.

## Contract

- Requires a complete fresh `house_catalog` + ownership archive.
- Requires all ownership policies to be `preserve_legacy` or explicit `mapped`.
- Rejects `refund_then_release` in this version.
- Keeps explicitly preserved legacy definitions enabled.
- Disables other active legacy definitions; never deletes them.
- Inserts exactly canonical slots 3–31.
- Does not delete `player_houses`.
- Tracks every inserted, disabled, and ownership row.
- Rollback disables imported definitions and restores archived enabled/ownership state.

## Runtime visual normalization

For source tag `offline_gtasa_house29_a*` only:

- entry/exit arrow visual Z: `+1.00`
- player interior/exterior arrival Z: `+0.50`

Database exact-source coordinates are not changed.

## SQL order

1. migration v0.26A.1.25
2. fresh archive v0.26A.1.24 if runtime changed
3. ownership policy staging v0.26A.1.24.2
4. dry-run v0.26A.1.25
5. apply with token `APPLY_29_GTASA_SAVEHOUSES`
6. verify
7. `/offlinehousereload`

Rollback token: `ROLLBACK_LATEST_29_GTASA_SAVEHOUSES`.
