# STATIC VALIDATION — SAIF v0.26A.1.20

## Pawn structure

- Curly braces: 5897 / 5897
- Parentheses: 25406 / 25406
- Square brackets: 9700 / 9700
- Duplicate stock/public definitions: 0
- Duplicate numeric dialog IDs: 0
- New apply callback forward: yes
- New apply dialog ID: 1329

## SQL safety

- Apply token uses VARBINARY/BINARY comparison.
- Rollback token uses VARBINARY/BINARY comparison.
- Archive/runtime checksum comparison uses BINARY SHA-256.
- `DELETE FROM world_pickups`: 0 occurrence(s).
- Replacement uses disable + insert, never delete.
- Rollback uses disable import + restore prior enabled-state.

## Capacity

- Planned active rows: 89
- Loader limit: 300
- Pawn capacity: 700
- Headroom after apply: 211 loader slots / 611 array slots.

## Important

`pawncc` with the project include directory was not available in this environment. Qawno F5 remains the final Pawn compile validation.
