# SAIF / LSIF Dev v0.26A.1.10.2 — Apply Checksum Collation Hotfix

## Root cause
`offline_public_interiors_archive.row_checksum` uses `ascii_general_ci`, while `SHA2(...)` inherited `utf8mb4_unicode_ci`. MariaDB rejected the `<>` checksum comparison.

## Fix
- Compare archive checksum and generated SHA-256 as binary strings.
- Store confirmation tokens in `VARBINARY` and compare against binary literals.
- Apply the same binary-safe token logic to rollback.

## Safety
The failure occurred during the checksum gate before `START TRANSACTION`; no runtime rows were disabled or inserted.

## Run
```bash
sudo mariadb lsif_db < database/verify/check_failed_apply_state_v0.26A.1.10.2.sql

(
  echo "SET @saif_confirm='APPLY_91_OFFLINE_PUBLIC_INTERIORS';"
  cat database/apply/apply_saif_v0.26A.1.10.2_full_91_public_interiors.sql
) | sudo mariadb lsif_db

sudo mariadb lsif_db < database/verify/verify_saif_v0.26A.1.10_full_91_public_interior_apply.sql
```

No Pawn compile, migration, archive capture, or server restart is required for this SQL-only hotfix.
