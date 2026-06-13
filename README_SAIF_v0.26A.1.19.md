# SAIF / LSIF Dev v0.26A.1.19
## World Pickup Runtime Archive & Baseline-89 Dry-Run

Status: archive/dry-run foundation only. No `world_pickups` apply or spawn mutation.

### Scope
- Snapshot every current `world_pickups` row, including disabled rows and enabled state.
- Store a SHA-256 checksum per row.
- Verify archive count, linkage, and unchanged runtime state.
- Dry-run exact replacement with 89 canonical pickups: 49 police bribes + 40 body armour.
- Audit internal duplicates, active-runtime overlap, proximity, capacity, and loader limit.
- Provide archive-discard rollback preview ending in `ROLLBACK`.

### Runtime limits
- Pawn array capacity: 700.
- Loader SQL limit: 300.
- Future projected active rows after replacement: 89.
- Loader headroom: 211.

### SQL order
1. `database/migrations/20260613_saif_v0.26A.1.19_world_pickup_runtime_archive_dry_run.sql`
2. `database/archive/capture_world_pickups_before_baseline89_replace_v0.26A.1.19.sql`
3. `database/verify/verify_saif_v0.26A.1.19_world_pickup_runtime_archive.sql`
4. `database/dry_run/dry_run_saif_v0.26A.1.19_baseline89_world_pickup_replace.sql`

### Owner tools
- `/offlinepickupdryrun`
- `/offlinepickuparchive`
- `/offlinepickupcapacity`
- `/offlinepickupruntimestatus`
- `/amenus -> GTA Offline Import Audit -> World Pickup Runtime Archive / Baseline-89 Dry-Run`

These commands display DB status only. Archive capture remains SQL-only.

### Expected gates
- Archive status `complete`.
- Runtime rows = archived rows.
- Checksum mismatch = 0.
- Missing rows in either direction = 0.
- Baseline = 89; bribe = 49; armour = 40.
- Internal duplicate pairs <=0.5m = 0.
- Projected active 89 <= loader 300 <= memory 700.
