# Static Validation — SAIF v0.26A.1.24.1

## Pawn structure

- Curly braces: 5981 / 5981
- Parentheses: 26279 / 26279
- Square brackets: 10044 / 10044
- New dialog IDs: none
- Runtime mutation added: none

## Schema validation

Correct public interior column:

```text
public_interiors.exterior_map_icon
```

Corrected references:

1. verify SQL public icon count
2. verify SQL hospital icon count
3. dry-run SQL public icon count
4. dry-run SQL hospital icon count
5. Pawn `/offlinehousedryrun` public icon count
6. Pawn `/offlinehousedryrun` hospital icon count

No invalid `public_interiors.map_icon_type` reference remains in the hotfix package.

`house_catalog.map_icon_type` remains unchanged because that column is valid for `house_catalog`.

## Safety

- No `INSERT`, `UPDATE`, or `DELETE` added for `house_catalog`.
- No `INSERT`, `UPDATE`, or `DELETE` added for `player_houses`.
- No `INSERT`, `UPDATE`, or `DELETE` added for `public_interiors`.
- Archive session data is not modified.
