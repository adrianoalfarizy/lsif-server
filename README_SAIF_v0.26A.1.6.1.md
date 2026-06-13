# SAIF / LSIF Dev v0.26A.1.6.1 — ENEX Resolver SQL Collation Hotfix

## Scope

Small SQL-only hotfix for MariaDB error 1267 when resolving `offline_import_sessions.session_key`.

## Root cause

- `offline_import_sessions.session_key`: `utf8mb4_unicode_ci`
- connection/session literal: `utf8mb4_general_ci`
- comparison at import line 7 caused `Illegal mix of collations`

## Fix

- Set the connection collation explicitly with:
  `SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;`
- Apply explicit `utf8mb4_unicode_ci` to both operands in the session-key lookup.
- Update the reusable Python generator so regenerated SQL keeps the fix.

## Safety

The failed import stopped before the first DELETE/UPDATE/INSERT statement. Re-running the corrected import is safe. The resolver import is transactional and staging-only.

## Run

```bash
cd /opt/lsif-repo
sudo mariadb lsif_db < database/imports/20260613_gtasa_enex_context_resolver_v0.26A.1.6.1.sql
sudo mariadb lsif_db < database/verify/verify_saif_v0.26A.1.6_enex_context_resolver.sql
```
