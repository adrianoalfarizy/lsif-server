# SAIF / LSIF Dev v0.26A.1.24.1 — House Map Icon Schema Fix

## Scope

Hotfix ini memperbaiki nama kolom map icon pada seluruh jalur House Catalog 29-Savehouse Dry-Run.

Schema aktual `public_interiors` memakai:

```sql
exterior_map_icon
```

Bukan:

```sql
map_icon_type
```

## File yang diperbaiki

- `gamemodes/lsif.pwn`
- `database/verify/verify_saif_v0.26A.1.24.1_house_catalog_runtime_archive.sql`
- `database/dry_run/dry_run_saif_v0.26A.1.24.1_house_catalog_29_savehouse_replace.sql`

## Tidak ada perubahan

- Tidak ada migration baru.
- Tidak ada perubahan `house_catalog`.
- Tidak ada perubahan `player_houses`.
- Tidak ada perubahan `public_interiors`.
- Tidak ada perubahan ownership transition plan.
- Tidak perlu capture archive ulang selama catalog dan ownership tidak berubah setelah session terakhir.

## Status hasil user sebelum hotfix

Archive session 8 sudah valid:

- catalog rows: 5 / 5
- catalog checksum mismatch: 0
- catalog linkage mismatch: 0 / 0
- ownership rows: 2 / 2
- ownership checksum mismatch: 0
- ownership transition pending: 2
- canonical plans: 32
- baseline savehouses: 29
- duplicate exterior: 0
- capacity: 29 / 64

Apply tetap belum boleh dilakukan karena dua ownership masih `pending_mapping`.

## Setelah deploy

Jalankan corrected verify:

```bash
sudo mariadb lsif_db \
< database/verify/verify_saif_v0.26A.1.24.1_house_catalog_runtime_archive.sql
```

Lalu corrected full dry-run:

```bash
sudo mariadb lsif_db \
< database/dry_run/dry_run_saif_v0.26A.1.24.1_house_catalog_29_savehouse_replace.sql
```
