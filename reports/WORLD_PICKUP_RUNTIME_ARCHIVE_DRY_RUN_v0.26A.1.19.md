# World Pickup Runtime Archive & Baseline-89 Dry-Run Audit

## Version
SAIF / LSIF Dev v0.26A.1.19

## Purpose
This phase freezes the current `world_pickups` state before any replacement and validates the exact 89-row GTA SA baseline selected by the v0.26A.1.18 resolver. It performs no runtime apply.

## Selected canonical baseline
- 49 police bribe pickups.
- 40 body armour pickups.
- 89 total.
- Source script must be `INITIAL`.
- World context must be interior 0 / virtual world 0.
- Runtime Z is source Z + 0.25.

## Runtime capacity
- Pawn array: 700.
- SQL loader limit: 300.
- Projected active after replacement: 89.
- Loader headroom: 211.

## Archive contract
Every row is copied, including disabled rows and the original enabled state. The checksum contains ID, type, display name, model, transform, interior, VW, amount, cooldown, source tag, and enabled state.

## Dry-run checks
1. Latest archive exists and is complete.
2. Runtime count equals archive count.
3. Current rows still match archived SHA-256 checksums.
4. No row is missing in either direction.
5. Baseline counts are exactly 89 / 49 / 40.
6. All selected rows have valid model/type/world/transform/Z lift.
7. Internal selected proximity within 0.50m is zero.
8. Existing active runtime overlap is reported as information because future replacement disables old active rows first.
9. Public interior proximity is reported for manual review.

## Mutation policy
The migration creates archive tables. Capture inserts archive rows and updates archive metadata only. Verify and dry-run are read-only. There is no `INSERT`, `UPDATE`, or `DELETE` against `world_pickups` in this patch.
