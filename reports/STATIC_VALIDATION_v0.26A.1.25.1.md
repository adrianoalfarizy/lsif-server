# STATIC VALIDATION — SAIF v0.26A.1.25.1

## Pawn structure

- Curly braces: 6015 / 6015
- Parentheses: 26542 / 26542
- Square brackets: 10089 / 10089
- Duplicate stock/public names: 0 []
- Duplicate numeric dialog IDs: 0 []
- v0.26A.1.25.1 version markers: 4

## SQL gate audit

- Old fatal public-overflow message: 0
- Strict 91+1+8 policy gate present: 1
- Apply output exposes omitted metric: 1
- Dry-run exposes informational omitted metric: 1
- Verify allocator section present: 1
- DELETE house_catalog: 0
- DELETE player_houses: 0
- New procedure create/call/drop: 1 / 1 / 2
- Old failed procedure cleanup markers: 2

## Result

Static structure is balanced. Public icon candidate overflow is no longer a fatal apply condition. The allocator contract remains strict: slots 0–90 for prioritized public icons, slot 91 for the owned house, and slots 92–99 for nearby for-sale houses. Pawn compilation must still be performed with the project Qawno includes.
