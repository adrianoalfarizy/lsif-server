# SAIF / LSIF Dev v0.26A.1.12 — Parked Vehicle Canonical Resolver & Apply Planner

Tahap ini tidak spawn kendaraan dan tidak mengubah `parked_vehicles`.

## Hasil planner
- Total queue: 211
- Baseline startup ready: 68
- Progression optional: 62
- Stateful deferred: 60
- Duplicate blocked: 13
- Random model review: 3
- Placeholder blocked: 3
- Switch unknown review: 2

## SQL order
1. `database/migrations/20260613_saif_v0.26A.1.12_parked_vehicle_canonical_planner.sql`
2. `database/imports/20260613_gtasa_parked_vehicle_canonical_plan_v0.26A.1.12.sql`
3. `database/verify/verify_saif_v0.26A.1.12_parked_vehicle_canonical_planner.sql`
4. Optional read-only dry-run.

## Commands
- `/offlinevehicleplans`
- `/offlinevehiclebatches`
- `/offlinevehicleplan [plan_id]`

All planner rows remain `enabled=0`, `apply_status=draft`.
