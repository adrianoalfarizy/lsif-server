# SAIF v0.26A.1.31.2 — In-Vehicle ALT Key Routing Hotfix

Fixes ALT interactions while the player is inside a vehicle.

Root cause:
- On foot, default LALT is reported as KEY_WALK.
- In a vehicle, default LALT is reported as KEY_FIRE.
- The previous callback only routed KEY_WALK, so house-garage store and vehicle-mission ALT handlers were not reached while driving.

Change:
- Route rising-edge KEY_FIRE while inside a vehicle to TryHandleVehicleMissionAlt and TryHandleHouseVehicleStorageAlt.
- Preserve existing KEY_WALK routing for on-foot interactions and vehicle retrieval.
- No SQL or database changes.
