# SAIF / LSIF Dev v0.26A.1.14.1 — Full 130 Dry-Run Alias Hotfix

Fixes MariaDB ERROR 1052 in the Full-130 parked vehicle dry-run by qualifying planner columns with alias `p`.

No schema, Pawn, runtime, archive, or apply changes.

Run:

```bash
sudo mariadb lsif_db < database/dry_run/dry_run_saif_v0.26A.1.14.1_full_130_apply_gate.sql
```
