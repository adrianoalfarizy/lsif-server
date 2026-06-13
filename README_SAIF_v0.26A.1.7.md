# SAIF / LSIF Dev v0.26A.1.7 — ENEX Pair Audit & Apply Planner

## Scope
Audit-only planner. No runtime table mutation, no spawn, no reload, no delete, and no apply.

## Results
- 10 family batches
- 93 exterior candidates
- 91 unique pair-ready
- 44 dry-run ready with current canonical service defaults
- 47 exact service/cashier point pending
- 2 exact duplicate FDPIZA rows blocked
- Runtime capacity currently 80; full unique core plan requires at least 91. Recommended future limit: 128.

## Install order
1. Backup DB.
2. Run migration.
3. Run generated planner import.
4. Run verify and dry-run SELECT file.
5. Replace/compile `gamemodes/lsif.pwn`.
6. Deploy and test `/offlinepairs`.

## SQL
```bash
sudo mariadb lsif_db < database/migrations/20260613_saif_v0.26A.1.7_enex_pair_apply_planner.sql
sudo mariadb lsif_db < database/imports/20260613_gtasa_enex_pair_apply_plan_v0.26A.1.7.sql
sudo mariadb lsif_db < database/verify/verify_saif_v0.26A.1.7_enex_pair_apply_planner.sql
sudo mariadb lsif_db < database/dry_run/dry_run_saif_v0.26A.1.7_enex_pair_apply_planner.sql
```

## Commands
- `/offlinepairs`
- `/offlinepairbatches`
- `/offlineplan [plan_id]`
- `/offlineinteriors`

## Explicit non-goals
- Does not change `public_interiors`.
- Does not increase `MAX_PUBLIC_INTERIORS` yet.
- Does not resolve the 47 exact service points yet.
- Does not create archive/apply/rollback runtime transaction yet.
