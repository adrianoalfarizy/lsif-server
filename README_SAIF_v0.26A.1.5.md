# SAIF / LSIF Dev v0.26A.1.5 — Offline World Audit Foundation

Paket ini memulai pipeline import dunia GTA San Andreas offline secara aman. Tahap pertama hanya membuat **source registry**, **log import**, dan **ENEX/interior staging queue**.

## Isi paket

- `gamemodes/lsif.pwn` — gamemode terbaru dengan menu audit Owner-only.
- `database/migrations/...sql` — membuat empat tabel staging/audit.
- `database/imports/...sql` — mendaftarkan 275 file sumber dan memasukkan 376 ENEX ke queue.
- `database/verify/...sql` — verifikasi read-only.
- `database/rollback/...sql` — template rollback satu staging session; default tetap `ROLLBACK`.
- `tools/offline_import/saif_offline_world_parser.py` — parser reusable, hanya memakai Python standard library.
- `reports/...` — source acceptance audit, manifest hash, JSON, dan laporan ENEX.

## Yang sengaja belum dilakukan

- Belum ada command apply.
- Belum mengganti `public_interiors`.
- Belum spawn pickup, kendaraan, object, atau checkpoint.
- Belum menghapus atau mengarsipkan dunia SAIF yang aktif.
- Belum menganggap hasil klasifikasi parser sebagai data yang otomatis disetujui.

## Urutan instalasi

### 1. Backup database

Contoh di Ubuntu:

```bash
mkdir -p /opt/backups
mysqldump -u root -p lsif_db > /opt/backups/lsif_before_v0.26A.1.5_$(date +%Y%m%d_%H%M%S).sql
```

Sesuaikan user dan nama database apabila berbeda.

### 2. Jalankan migration

```bash
mariadb -u root -p lsif_db < database/migrations/20260612_saif_v0.26A.1.5_offline_world_audit_foundation.sql
```

### 3. Import source registry dan ENEX queue

```bash
mariadb -u root -p lsif_db < database/imports/20260612_gtasa_offline_source_enex_queue.sql
```

### 4. Jalankan verifikasi

```bash
mariadb -u root -p lsif_db < database/verify/verify_saif_v0.26A.1.5_offline_world_audit.sql
```

Nilai inti yang diharapkan:

```text
registered_files = 275
total_enex = 376
enabled_rows_should_be_zero = 0
unlinked_source_file_rows_should_be_zero = 0
warning logs = 4
```

### 5. Replace dan compile gamemode

Copy:

```text
gamemodes/lsif.pwn
```

ke:

```text
D:\LSIF-DEV\gamemodes\lsif.pwn
```

Compile menggunakan Qawno/F5. File sudah melewati pemeriksaan statis, tetapi belum dapat saya compile di lingkungan pembuatan karena compiler Pawn dan include project yang sama persis tidak tersedia.

### 6. Git, push, deploy

```bat
cd D:\LSIF-DEV
git add gamemodes/lsif.pwn gamemodes/lsif.amx
git add database/migrations/20260612_saif_v0.26A.1.5_offline_world_audit_foundation.sql
git add database/imports/20260612_gtasa_offline_source_enex_queue.sql
git add database/verify/verify_saif_v0.26A.1.5_offline_world_audit.sql
git add database/rollback/rollback_saif_v0.26A.1.5_latest_import_session.sql
git add tools/offline_import/saif_offline_world_parser.py
git add reports
git commit -m "Add GTA offline source registry and ENEX audit queue"
git push
```

Deploy di Ubuntu:

```bash
/opt/lsif-repo/deploy/deploy-to-server.sh
```

## Command audit di dalam game

```text
/offlineaudit
/offlineworld
/offlineimport
/offlinesources
/offlineinteriors
/offlineenex
/offlineintgoto [queue_id]
```

Menu **GTA Offline Import Audit** juga ditambahkan di bagian paling bawah `/amenus`, sehingga index menu lama tidak bergeser.

Semua fungsi Owner-only. Semua fungsi read-only terhadap dunia runtime, kecuali `goto` yang hanya memindahkan Owner ke koordinat exterior ENEX untuk melihat lokasi. `goto` tidak membuat pickup, interior, maupun row runtime.

## Menjalankan parser ulang di Windows

Tidak membutuhkan `pip` atau module tambahan.

```bat
py tools\offline_import\saif_offline_world_parser.py ^
  --source-root "D:\SAIF-OFFLINE-SOURCE" ^
  --source-root-label "SAIF-OFFLINE-SOURCE" ^
  --session-label "GTA SA Offline Full Source - ENEX Audit" ^
  --source-version "GTA SA PC 1.0 US" ^
  --output-sql "database\imports\20260612_gtasa_offline_source_enex_queue.sql" ^
  --output-json "reports\GTASA_OFFLINE_ENEX_AUDIT_v0.26A.1.5.json"
```

Import SQL bersifat idempotent untuk source dan versi parser yang sama. Rerun memperbarui metadata parser tanpa mengubah `enabled`, `review_status`, atau `apply_status` yang sudah ada pada queue.

## Rollback staging session

Script rollback memilih import session terbaru dan sengaja berakhir dengan:

```sql
ROLLBACK;
```

Periksa dahulu `session_to_remove`. Ganti menjadi `COMMIT;` hanya jika session tersebut benar-benar staging session yang ingin dibuang. Script tidak menyentuh tabel runtime.
