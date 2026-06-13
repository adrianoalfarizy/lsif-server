# SAIF v0.26A.1.5 Static Validation

## Gamemode provenance

- Baseline PWN SHA-256: `352c38e9b4401fd5ffff57ec227def4b949cc86db32b5e0b2264912f41890714`
- Patched PWN SHA-256: `be0fb5a4f74102088ce965f2eb0ae98d07ef71b5370cf95d368b0e216d17f4c8`
- Line endings: CRLF
- Baseline: v0.26A.1.3.1 Cold Boot Database Readiness
- Patch: v0.26A.1.5 Offline World Audit Foundation

## Pawn static checks

- Total lines: 47748
- Braces: 5687 open / 5687 close
- Parentheses: 22805 open / 22805 close
- `OnGameModeInit`: 1 definition
- `OnPlayerCommandText`: 1 definition
- `OnDialogResponse`: 1 definition
- Duplicate dialog IDs: 0
- Owner guard present: yes
- `/amenus` mapping appended at index 25: yes
- ENEX pagination: yes
- Goto coordinate guard: yes

## Parser and dataset checks

- Python syntax compile: PASS
- Source paths unique: 275 / 275
- ENEX record hashes unique: 376 / 376
- Queue sources missing from registry: 0
- Invalid exterior coordinates: 0
- Registered source files: 275
- Parsed IPL files: 53
- ENEX rows: 376
- Warnings: 4

## SQL static checks

- Migration staging tables: 4
- Import transaction: 1 start / 1 commit
- Source-file inserts: 275
- ENEX inserts: 376
- Warning-log inserts: 4
- Generated enabled=1 queue rows: 0
- Generated enabled=0 queue rows: 376
- Runtime table mutations detected: none

## Important limitation

The PWN was not compiled here because the exact project `pawncc` and include tree were not present. Compile with the user's Qawno/F5 environment remains mandatory before Git/deploy.
