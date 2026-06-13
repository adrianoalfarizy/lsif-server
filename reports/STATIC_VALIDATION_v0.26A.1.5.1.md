# Static Validation — SAIF v0.26A.1.5.1

## Source

- Base: SAIF v0.26A.1.5 `lsif.pwn`
- Output: SAIF v0.26A.1.5.1 ENEX Side-Aware Preview

## Structural checks

- Curly braces: 5715 / 5715
- Parentheses: 22262 / 22262
- Square brackets: 8387 / 8387
- Duplicate dialog IDs: 0
- `OnGameModeInit`: 1
- `OnPlayerCommandText`: 1
- `OnDialogResponse`: 1
- `OnOfflineInteriorPreviewLoaded`: 1
- Old `OnOfflineInteriorGotoLoaded`: 0
- Old `QueryOfflineInteriorGoto`: 0

## Offline-source simulation over 376 ENEX rows

### Point A

- Auto World 0: 224
- Auto declared interior: 151
- Blocked high-Z without valid interior: 1 (`STUDRAN`)

### Point B

- Declared interior: 154
- World 0 because `interior_id=0`: 222
- Blocked high-Z without valid interior: 0

## Runtime safety

The new preview flow performs only:

- read-only `SELECT` from `offline_interior_queue`;
- player position/interior/VW/facing changes;
- local per-player return-state storage.

It does not update staging rows or mutate `public_interiors`, `world_pickups`, `parked_vehicles`, or other world runtime tables.

## Compiler note

`pawncc` and the project's include tree are not present in this environment. Final compile must be run with Qawno/F5 in `D:\LSIF-DEV`.
