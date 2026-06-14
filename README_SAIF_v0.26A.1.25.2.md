# SAIF / LSIF Dev v0.26A.1.25.2
## Offline-Like Full 29 Savehouse Map Icons

Patch ini mengganti allocator rumah `1 owned + 8 nearest` menjadi allocator offline-like yang deterministik:

- native slot `0-65`: public/service icon berdasarkan prioritas;
- native slot `66-94`: seluruh 29 canonical GTA SA savehouse;
- native slot `95-99`: context/fallback, terutama owned legacy house;
- canonical house tidak lagi memakai radius 1.500 m atau pemilihan nearest;
- `canonical_slot 3-31` dipetakan langsung ke `map slot 66-94`;
- rumah for-sale memakai icon `31`; rumah occupied/owned memakai icon `35`;
- semua icon tetap `MAPICON_LOCAL`: terdaftar pada pause map, radar hanya muncul pada jarak native.

## File

- `gamemodes/lsif.pwn` — direct full replacement berdasarkan file terbaru yang diberikan user.
- `database/migrations/20260614_saif_v0.26A.1.25.2_offline_full_29_savehouse_map_icons.sql`
- `database/verify/verify_saif_v0.26A.1.25.2_offline_full_29_savehouse_map_icons.sql`
- `database/rollback/rollback_saif_v0.26A.1.25.2_map_icon_policy.sql`
- `reports/STATIC_VALIDATION_v0.26A.1.25.2.md`
- `lsif_v0.26A.1.25.2.patch`

## Instalasi

1. Backup DB dan `gamemodes/lsif.pwn`/`lsif.amx` aktif.
2. Jalankan migration policy metadata.
3. Ganti `gamemodes/lsif.pwn` dengan file patch ini.
4. Compile dengan command Pawn yang biasa dipakai project.
5. Deploy AMX dan restart/reload server.
6. Jalankan verify SQL.
7. Login sebagai Owner lalu jalankan `/refreshicons` dan `/mapiconaudit`.


## Git commit dan push dari PC development

Jalankan hanya setelah compile menghasilkan `0 error` dan file `gamemodes/lsif.amx` terbaru sudah terbentuk.

Buka Command Prompt atau Git Bash pada repository development:

```bat
cd /d D:\LSIF-DEV

git status --short
git diff --check
```

Pastikan tidak ada file lain yang ikut berubah tanpa sengaja. Tambahkan hanya file patch ini dan AMX hasil compile:

```bat
git add gamemodes/lsif.pwn
git add gamemodes/lsif.amx
git add database/migrations/20260614_saif_v0.26A.1.25.2_offline_full_29_savehouse_map_icons.sql
git add database/verify/verify_saif_v0.26A.1.25.2_offline_full_29_savehouse_map_icons.sql
git add database/rollback/rollback_saif_v0.26A.1.25.2_map_icon_policy.sql
git add reports/STATIC_VALIDATION_v0.26A.1.25.2.md
git add README_SAIF_v0.26A.1.25.2.md
git add CHECKSUMS_SHA256.txt
```

Periksa staged diff:

```bat
git status
git diff --cached --stat
git diff --cached --check
```

Commit dan push:

```bat
git commit -m "Add offline-like full 29 savehouse map icons"
git push origin main
```

Expected:

- commit berhasil dibuat;
- push berakhir tanpa rejection;
- branch lokal dan `origin/main` menunjuk commit baru yang sama.

Periksa commit terakhir:

```bat
git log -1 --oneline
```

Jangan melakukan `git push --force`.

## Pull dan deploy di server Ubuntu

Masuk ke server lalu pastikan repository tidak memiliki perubahan lokal yang belum diamankan:

```bash
cd /opt/lsif-repo

git status --short
git log -1 --oneline
```

Jika `git status --short` menampilkan perubahan, jangan langsung pull. Backup atau commit perubahan tersebut terlebih dahulu agar tidak tertimpa.

Ambil commit terbaru secara fast-forward only:

```bash
cd /opt/lsif-repo

git fetch origin
git pull --ff-only origin main
git log -1 --oneline
```

Pastikan commit terakhir memiliki pesan:

```text
Add offline-like full 29 savehouse map icons
```

### Backup sebelum migration dan deploy

```bash
sudo mkdir -p /opt/backups

sudo mysqldump lsif_db \
| sudo tee "/opt/backups/lsif_before_v0.26A.1.25.2_map_icon_$(date +%Y%m%d_%H%M%S).sql" \
> /dev/null

sudo cp -a gamemodes/lsif.amx \
"/opt/backups/lsif_before_v0.26A.1.25.2_$(date +%Y%m%d_%H%M%S).amx"
```

Periksa backup bukan `0 byte`:

```bash
sudo ls -lh /opt/backups/lsif_before_v0.26A.1.25.2_*
```

### Jalankan migration policy

```bash
cd /opt/lsif-repo

sudo mariadb lsif_db \
< database/migrations/20260614_saif_v0.26A.1.25.2_offline_full_29_savehouse_map_icons.sql
```

Migration ini hanya mengubah metadata `house_map_icon_policy`; tidak mengubah `house_catalog` atau `player_houses`.

### Jalankan script deploy project

```bash
cd /opt/lsif-repo

chmod +x deploy/deploy-to-server.sh
sudo ./deploy/deploy-to-server.sh
```

Jika script deploy menampilkan error, jangan restart server. Simpan output lengkap untuk dianalisis.

### Restart dan cek service

```bash
sudo systemctl restart omp-server
sudo systemctl status omp-server --no-pager
```

Status wajib:

```text
Active: active (running)
```

Periksa log startup:

```bash
sudo journalctl -u omp-server -n 150 --no-pager
```

Tidak boleh ada:

- `Run time error`;
- `AMX load error`;
- error MySQL terkait `house_map_icon_policy`;
- crash atau restart loop.

### Verify database setelah deploy

```bash
cd /opt/lsif-repo

sudo mariadb lsif_db \
< database/verify/verify_saif_v0.26A.1.25.2_offline_full_29_savehouse_map_icons.sql
```

Gate utama:

```text
POLICY_GATE ready_should_be_1 = 1
CANONICAL_HOUSE_GATE ready_should_be_1 = 1
canonical_active_expected_29 = 29
unique_slots_expected_29 = 29
invalid_slot_should_be_zero = 0
zero_position_should_be_zero = 0
```

### Test in-game setelah deploy

Login sebagai Owner lalu jalankan:

```text
/refreshicons
/mapiconaudit
```

Expected:

```text
Canonical rows/unique rendered: 29 / 29
Canonical invalid slot: 0
Canonical duplicate slot: 0
Canonical omitted from fixed 29: 0
```

Buka pause map dan pastikan seluruh 29 canonical savehouse terlihat tanpa harus berada di radius dekat rumah.

## Rollback deployment

Rollback policy hanya diperlukan bila allocator baru menyebabkan regression dan belum ada mutation house setelah deployment:

```bash
cd /opt/lsif-repo

sudo mariadb lsif_db \
< database/rollback/rollback_saif_v0.26A.1.25.2_map_icon_policy.sql
```

Kembalikan commit code dengan `git revert`, bukan reset paksa:

```bash
cd /opt/lsif-repo

git log -3 --oneline
git revert <SHA_COMMIT_V0.26A.1.25.2>
git push origin main
```

Kemudian pull dan deploy ulang di server:

```bash
cd /opt/lsif-repo
git pull --ff-only origin main
sudo ./deploy/deploy-to-server.sh
sudo systemctl restart omp-server
sudo systemctl status omp-server --no-pager
```

## Expected runtime audit

- `Canonical rows/unique rendered: 29 / 29`
- `Canonical invalid slot: 0`
- `Canonical duplicate slot: 0`
- `Canonical omitted from fixed 29: 0`
- player actual canonical house rendered: `29 / 29`
- public rendered maksimal `66`; public omitted boleh lebih dari nol dan bersifat informational.

## Regression checklist

- 29 savehouse terlihat pada pause map tanpa harus mendekati lokasi.
- icon 31 berubah menjadi 35 setelah rumah dibeli/occupied.
- buy/sell langsung merefresh icon.
- relog dan respawn tetap menampilkan 29 savehouse.
- `/offlinehousereload` merebuild pickup, label, ownership count, dan icon.
- owned legacy house tetap terlihat melalui context slot.
- public hospital/police/Ammu/24-7/restaurant utama tetap muncul sesuai priority budget.

Migration ini tidak mengubah `house_catalog` atau `player_houses`.
