# STATIC VALIDATION — SAIF v0.26A.1.23

- Curly braces: 5976 / 5976
- Parentheses: 26098 / 26098
- Square brackets: 10040 / 10040
- Duplicate stock/public definitions: 0 []
- Duplicate numeric dialog IDs: 0 []
- Dynamic catalog capacity: 64
- Legacy fallback rows: 5
- New dialog ID: 1338
- `OnHouseCatalogLoaded` forward/public: 1 / 1
- `OnHouseCatalogAuditLoaded` forward/public: 1 / 1
- Ownership bridge column used: yes
- Direct player spawn calls using marker-only `HouseX/Y/Z`: 0
- GTA SA 29-house apply mutation: none
- Remaining `MAX_HOUSES` loops: 4 (array reset/destroy capacity loops only)

## Remaining MAX_HOUSES loops

- line 7865: `for (new i = 0; i < MAX_HOUSES; i++)`
- line 7949: `for (new i = 0; i < MAX_HOUSES; i++)`
- line 35190: `for (new i = 0; i < MAX_HOUSES; i++)`
- line 35389: `for (new i = 0; i < MAX_HOUSES; i++)`

## Important

Pawn was not compiled in this environment. Final validation remains the user's Qawno/Pawn compiler with project includes.
