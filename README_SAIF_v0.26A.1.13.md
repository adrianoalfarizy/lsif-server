# SAIF / LSIF Dev v0.26A.1.13 — Parked Vehicle Runtime Archive & Full Canonical Dry-Run

## Scope

Tahap ini belum melakukan apply kendaraan. Patch:

- menaikkan `MAX_PARKED_VEHICLES` dari 200 menjadi 256;
- mengubah loader DB dari `LIMIT 200` menjadi `LIMIT 256`;
- membuat snapshot lengkap seluruh row `parked_vehicles`;
- memverifikasi checksum snapshot terhadap runtime;
- membuat dry-run replacement penuh untuk 68 baseline + 62 progression = 130 kendaraan;
- mempertahankan 81 row lain sebagai staging/deferred;
- menambahkan status audit Owner di `/amenus`.

## SQL order

```bash
cd /opt/lsif-repo

sudo mariadb lsif_db < database/migrations/20260613_saif_v0.26A.1.13_parked_vehicle_runtime_archive_dry_run.sql
sudo mariadb lsif_db < database/archive/capture_parked_vehicles_before_offline_replace_v0.26A.1.13.sql
sudo mariadb lsif_db < database/verify/verify_saif_v0.26A.1.13_parked_vehicle_runtime_archive_dry_run.sql
sudo mariadb lsif_db < database/dry_run/dry_run_saif_v0.26A.1.13_full_130_parked_vehicle_replace.sql
```

## Expected gates

- archive status `complete`;
- archive `runtime_rows_total = archived_rows`;
- checksum mismatch `0`;
- baseline `68`;
- progression `62`;
- selected `130`;
- stateful `60`;
- duplicate `13`;
- random `3`;
- placeholder `3`;
- unknown `2`;
- capacity `256`, remaining `126`.

## Owner commands

```text
/offlinevehicledryrun
/offlinecardryrun
/offlinevehiclearchive
/offlinecararchive
/offlinevehiclecapacity
```

All aliases open the same read-only status page. The actual archive capture is intentionally SQL-only so it cannot be triggered accidentally from in-game UI.

## Replacement contract

The later apply transaction will:

1. require a complete fresh archive;
2. verify runtime checksums have not changed since archive;
3. disable all currently active `parked_vehicles` rows without deleting them;
4. insert exactly 130 selected GTA SA SCM car generators;
5. tag baseline and progression rows distinctly;
6. reload parked vehicle runtime;
7. provide one-command tracked rollback.

v0.26A.1.13 itself performs none of those runtime mutations.
