# SAIF / LSIF Dev v0.26A.1.27
## Dynamic World Garage Catalog Backend & House Link Bridge

## Why this phase exists

The current `/garage` implementation is a three-slot player vehicle inventory and dealership service. It is not a physical GTA SA world-garage system.

v0.26A.1.27 therefore introduces a separate backend:

- `garage_runtime_policy` — safety switches; all disabled;
- `garage_catalog` — future physical garage definitions, capacity 64;
- `house_garage_links` — link physical garages to live `house_catalog` rows;
- Pawn loader and Owner audit/reload commands;
- read-only dry-run mapping 12 baseline savehouses from the v0.26A.1.26 canonical queue.

No garage row or link is applied in this phase.

## Commands

```text
/garagecatalog
/garagecatalogstatus
/garagecatalogreload
/worldgarages
/worldgaragereload
```

Menu:

```text
/amenus
→ GTA Offline Import Audit
→ Dynamic World Garage Catalog Backend
```

## SQL order

```bash
sudo mariadb lsif_db \
< database/migrations/20260614_saif_v0.26A.1.27_dynamic_world_garage_catalog_backend.sql

sudo mariadb lsif_db \
< database/dry_run/dry_run_saif_v0.26A.1.27_dynamic_world_garage_catalog_backend.sql

sudo mariadb lsif_db \
< database/verify/verify_saif_v0.26A.1.27_dynamic_world_garage_catalog_backend.sql
```

## Expected core gates

```text
SCHEMA_GATE tables = 1 / 1 / 1
POLICY_GATE ready = 1
canonical garage source = 52
all house links = 13
baseline savehouse links = 12
story link = 1
missing live house = 0
runtime garage catalog rows = 0
runtime house-garage links = 0
FINAL_GATE ready = 1
```

## Mandatory deployment order

Migration must run before the new AMX starts, because the Pawn loader queries `garage_catalog` and `house_garage_links` on startup.

```text
compile → push → server pull → DB backup → migration → dry-run → verify → deploy → restart → /garagecatalog
```

## Next roadmap

`v0.26A.1.28 — Garage Vehicle Spawn & Interaction Geometry Planner`

That phase must resolve and confirm safe vehicle spawn/facing points for the 12 baseline savehouse garages. It still must not enable storage or door animation until every geometry row passes preview and collision tests.
