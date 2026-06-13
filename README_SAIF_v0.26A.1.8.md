# SAIF / LSIF Dev v0.26A.1.8 — Exact Interior Service Point Resolver

## Scope
Audit/staging only. No runtime `public_interiors` mutation.

## Result
- 91 unique service-point rows.
- 71 native SCM exact (`scm_exact`).
- 20 SAIF overlay translated anchors (`saif_overlay_translated`) requiring Owner preview.
- 2 duplicate pair plans remain blocked.

## SQL order
1. `database/migrations/20260613_saif_v0.26A.1.8_exact_service_point_resolver.sql`
2. `database/imports/20260613_gtasa_exact_service_points_v0.26A.1.8.sql`
3. `database/verify/verify_saif_v0.26A.1.8_exact_service_point_resolver.sql`
4. Optional read-only report: `database/dry_run/dry_run_saif_v0.26A.1.8_exact_service_points.sql`

## Commands
- `/offlineservicepoints`
- `/offlineservicelist`
- `/offlinepoint [id]`
- `/offlineintreturn`

## Expected verify
- total_service_rows = 91
- exact_expected_71 = 71
- overlay_expected_20 = 20
- dry_run_ready_expected_71 = 71
- overlay_review_expected_20 = 20
- blocked_expected_2 = 2
- enabled_should_be_zero = 0
- nondraft_should_be_zero = 0

## Important
24/7, gym, and police are explicitly marked as overlays because GTA SA does not expose one native purchase/service menu equivalent to SAIF's backend service menu. Their points must be previewed before any future apply.

## Validation artifacts
- `reports/STATIC_VALIDATION_v0.26A.1.8.md`
- `reports/SCM_MARKER_VALIDATION_v0.26A.1.8.json`

The generated Pawn file was statically checked for balanced delimiters, unique dialog IDs, callback uniqueness, and correct service-dialog newline/tab escaping. Qawno/F5 compile remains required.
