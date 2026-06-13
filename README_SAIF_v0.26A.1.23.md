# SAIF / LSIF Dev v0.26A.1.23 — Dynamic House Catalog Backend Foundation

## Scope

This patch replaces the five hardcoded world-definition arrays as the primary house source with a database-backed `house_catalog` loader. Ownership stays in `player_houses`.

It does **not** apply the 29 GTA SA canonical savehouses yet.

## Runtime architecture

- `house_catalog`: world definition, price, exterior marker/spawn, interior entry/exit/spawn, icon/pickup, source tag.
- `player_houses`: ownership, owner, lock state and legacy compatibility.
- `player_houses.house_catalog_id`: new bridge to catalog.
- Runtime capacity: 64 definitions.
- Five old houses are seeded with their exact previous coordinates/prices/interior behavior.
- A five-row in-code fallback remains only for cold-boot safety if the catalog query returns zero rows.

## Safety

- Existing ownership is snapshotted to `house_catalog_bridge_backup`.
- Existing `player_houses` rows are mapped using legacy `house_index` 0..4.
- No ownership row is deleted.
- No GTA SA canonical plan is enabled/applied.
- Reload is Owner-only and rebuilds pickups, labels and map icons.

## Files

- `gamemodes/lsif.pwn`
- `database/migrations/20260613_saif_v0.26A.1.23_dynamic_house_catalog_foundation.sql`
- `database/verify/verify_saif_v0.26A.1.23_dynamic_house_catalog_foundation.sql`
- `database/rollback/rollback_saif_v0.26A.1.23_dynamic_house_catalog_foundation.sql`
- `reports/STATIC_VALIDATION_v0.26A.1.23.md`

## Owner commands

- `/housecatalog`
- `/housecatalogstatus`
- `/housecatalogreload`

Also available under `/amenus → GTA Offline Import Audit → Dynamic House Catalog Backend`.

## Expected database state after migration

- catalog total/enabled/legacy/source-tag rows: 5
- canonical GTA SA rows: 0
- every existing `player_houses` row mapped to a valid catalog ID
- 29 offline canonical savehouse plans remain disabled and draft

## Next milestone

`v0.26A.1.24 — House Catalog Runtime Archive & 29-Savehouse Dry-Run`
