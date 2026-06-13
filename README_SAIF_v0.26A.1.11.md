# SAIF / LSIF Dev v0.26A.1.11 — Offline Parked Vehicle Queue Foundation

## Scope
Parses GTA SA `main_decompiled.txt` car generators into `offline_vehicle_queue` for Owner audit. No vehicle is spawned and `parked_vehicles` is not modified.

## Expected counts
- Total: 211
- Resolved model: 205
- Random model references: 3
- Placeholder zero: 3
- Variable transforms resolved: 10
- Initially ON/OFF/unknown: 72 / 136 / 3

## SQL order
1. `database/migrations/20260613_saif_v0.26A.1.11_offline_vehicle_queue_foundation.sql`
2. `database/imports/20260613_gtasa_scm_car_generators_v0.26A.1.11.sql`
3. `database/verify/verify_saif_v0.26A.1.11_offline_vehicle_queue.sql`

## Commands
- `/offlinevehicles`, `/offlinecars`, `/offlinecargens`
- `/offlinevehiclelist`, `/offlinecarlist`
- `/offlinevehicle [queue_id]`, `/offlinecar [queue_id]`
- `/offlineintreturn` returns from coordinate preview.

## Safety
All queue rows remain disabled and pending. Preview teleports the Owner only and never calls `CreateVehicle`.
