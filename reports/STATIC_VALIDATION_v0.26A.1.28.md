# SAIF / LSIF Dev v0.26A.1.28 Static Validation

```text
Lines                         : 52794
Curly braces                  : 6088 / 6088
Parentheses                   : 27319 / 27319
Square brackets               : 10316 / 10316
Duplicate dialog ID           : 0
Duplicate stock/public        : 0
Callback forward/public       : valid
New dialog IDs                : 1347-1350
Adjacent Pawn strings (delta) : 0
Geometry plans expected       : 52
Baseline geometry expected    : 12
Runtime mutation SQL          : none
```

## Runtime call delta

```text
CreatePickup            : 0
CreateDynamicObject     : 0
CreateObject            : 0
CreateVehicle           : 0
AddStaticVehicle        : 0
SetPlayerCheckpoint     : 0
SetPlayerRaceCheckpoint : 0
```

No new pickup, object, vehicle, checkpoint, garage runtime, house ownership, or player vehicle mutation call is introduced by this patch. Pawn compilation with the complete Qawno include set remains the final syntax validation.
