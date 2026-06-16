# Static Validation — SAIF v0.26A.1.31.7

## Pawn source

- Lines: `56619`
- Raw braces: `6497 / 6497`
- Raw parentheses: `29357 / 29357`
- Raw square brackets: `11648 / 11648`
- Lexical braces after removing comments/strings: `6495 / 6495`
- Lexical parentheses after removing comments/strings: `27840 / 27840`
- Lexical square brackets after removing comments/strings: `10808 / 10808`
- Duplicate stock/public definitions: `0`
- Forward declarations: `266`
- Missing forward definitions: `2` (pre-existing: `OnGangRespectLoaded`, `OnGangHQPointModelSaved`)

## Owned vehicle spawn contract

- `FindNearestSemanticPublicParkingSlot` calls inside `ProcessOwnedVehicleSpawnRequest`: `1`
- Dynamic arbitrary-ground solver calls inside owned spawn path: `0`
- Legacy global catalog calls inside owned spawn path: `0`
- Parked-vehicle references inside owned spawn path: `0`
- Yellow marker calls inside owned spawn path: `1`
- Semantic runtime capacity: `1024 approved slots`
- Search radii: `250 / 500 / 1000 meter`

## SQL package

- `database/apply/apply_saif_v0.26A.1.31.7_semantic_public_parking_zone_runtime.sql`: 213 lines, parentheses 87 / 87, lexical state `code`
- `database/migrations/20260616_saif_v0.26A.1.31.7_semantic_public_parking_zone_runtime.sql`: 112 lines, parentheses 61 / 61, lexical state `code`
- `database/rollback/rollback_saif_v0.26A.1.31.7_semantic_public_parking_zone_runtime.sql`: 95 lines, parentheses 13 / 13, lexical state `code`
- `database/verify/verify_saif_v0.26A.1.31.7_semantic_public_parking_zone_runtime.sql`: 104 lines, parentheses 95 / 95, lexical state `code`

## Important behavior

- `public_interiors` is used only to create candidate facility zones.
- Candidate zones are not runtime spawn sources until approved and supplied with approved slots.
- `parked_vehicles`, parked-vehicle offsets, garage slots, mission points, and arbitrary ground are excluded from `/myveh`.
- ColAndreas validates approved slot safety; it does not decide whether a location is semantically a parking lot.
- No SQL was executed and Pawn was not compiled in this validation environment. Qawno F5 and live MariaDB gates remain final.
