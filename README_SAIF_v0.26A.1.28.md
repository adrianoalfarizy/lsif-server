# SAIF / LSIF Dev v0.26A.1.28 — Garage Vehicle Spawn & Interaction Geometry Planner

This version derives deterministic preview-only geometry from the 52 exact IPL GRGE definitions already resolved in v0.26A.1.26.

## Result

- 52 staging geometry rows.
- 12 baseline savehouse garage candidates must resolve as `baseline_ready`.
- Point1→Point2 is treated as the front/door edge.
- Point1→Point3 is treated as the garage depth direction.
- Derived interaction point outside the front edge.
- Derived vehicle entry point and inward heading.
- Derived vehicle spawn point inside the garage and outward heading.
- No runtime garage, vehicle, door, object, checkpoint, or ownership mutation.

## SQL order

```bash
sudo mariadb lsif_db < database/migrations/20260614_saif_v0.26A.1.28_garage_vehicle_spawn_geometry_planner.sql
sudo mariadb lsif_db < database/imports/20260614_gtasa_garage_vehicle_spawn_geometry_plan_v0.26A.1.28.sql
sudo mariadb lsif_db < database/verify/verify_saif_v0.26A.1.28_garage_vehicle_spawn_geometry_planner.sql
```

## Owner commands

```text
/garagegeometry
/garagegeometrylist
/garagegeometrydetail [geometry_id]
```

All previews are teleport-only. No vehicle or runtime world element is created.
