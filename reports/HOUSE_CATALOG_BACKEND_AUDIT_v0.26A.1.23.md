# HOUSE CATALOG BACKEND AUDIT — SAIF v0.26A.1.23

## Baseline before patch

- House world definitions: five Pawn arrays compiled into `lsif.pwn`.
- Runtime capacity: 5.
- Ownership table: `player_houses` using `house_index`.
- Interior behavior: one shared hardcoded interior template.
- GTA SA canonical source-ready savehouses: 29, not apply-ready because no dynamic catalog existed.

## Architecture after patch

- `house_catalog` becomes the DB-backed source of world definitions.
- `player_houses` remains the ownership table.
- `player_houses.house_catalog_id` bridges ownership to definitions.
- Runtime capacity is raised to 64, but only five legacy definitions are seeded and enabled.
- The five legacy houses retain the same names, prices, exterior positions, pickup model/type, interior and private-VW behavior.
- A five-row code fallback exists only if the DB catalog returns zero rows.

## Runtime fields loaded per catalog row

- catalog ID, legacy index, canonical slot
- display name and price
- exterior pickup position and facing
- exterior return/spawn transform
- interior ID
- interior exit pickup position
- interior arrival transform
- map icon type
- pickup model/type
- private-VW recommendation
- enabled/source tag

## Ownership safety

- Existing `player_houses` rows are snapshotted before bridge update.
- Existing `house_index` 0..4 maps to the corresponding seeded catalog row.
- No ownership record is deleted.
- House purchase writes both `house_catalog_id` and compatibility `house_index`.
- Sell behavior remains ownership-only and does not remove catalog definitions.

## Deferred scope

This patch does not insert the 29 GTA SA canonical savehouses. The expected post-migration catalog state is exactly five enabled legacy rows and zero canonical-slot rows.

## Next gate

The next milestone must archive `house_catalog`, checksum the five legacy definitions and dry-run replacement with the 29 `baseline_ready` canonical plans before any world replacement occurs.
