# SAIF / LSIF Dev v0.26A.1.6 — ENEX Context Resolver

## Scope

Patch ini memperkaya 376 row `offline_interior_queue` dengan konteks GTA San Andreas asli berdasarkan:

- nama ENEX dan record IPL;
- referensi exact di `main_decompiled.txt`;
- subsystem/external script terkait;
- binding shop/service;
- zone `map.zon` / `info.zon`;
- pasangan/group ENEX;
- posisi Point A/Point B dan interior ID.

Patch ini **audit-only**. Tidak ada apply, spawn, reload, archive, delete, atau perubahan pada tabel runtime.

## Hasil resolver yang diharapkan

- Total ENEX: `376`
- Resolved: `329`
- Partial: `39`
- Review required: `8`
- Evidence rows: `2081`
- Queue `enabled=1`: `0`
- Queue `apply_status <> 'pending'`: `0`

## File SQL dan urutan eksekusi

Jalankan setelah v0.26A.1.5 dan v0.26A.1.5.1 sudah terpasang serta 376 ENEX tersedia.

1. Backup database.
2. Jalankan migration:

```bash
sudo mariadb lsif_db < database/migrations/20260613_saif_v0.26A.1.6_enex_context_resolver.sql
```

3. Jalankan resolver import:

```bash
sudo mariadb lsif_db < database/imports/20260613_gtasa_enex_context_resolver_v0.26A.1.6.sql
```

4. Jalankan verify:

```bash
sudo mariadb lsif_db < database/verify/verify_saif_v0.26A.1.6_enex_context_resolver.sql
```

## Backup database

```bash
sudo mkdir -p /opt/backups
sudo mysqldump lsif_db \
| sudo tee "/opt/backups/lsif_before_v0.26A.1.6_$(date +%Y%m%d_%H%M%S).sql" \
> /dev/null
sudo ls -lh /opt/backups/lsif_before_v0.26A.1.6_*.sql
```

## Pawn

Replace:

```text
D:\LSIF-DEV\gamemodes\lsif.pwn
```

Compile dengan `F5`.

Menu baru tetap berada di:

```text
/amenus
→ GTA Offline Import Audit
→ ENEX Context Resolver Summary
```

Command:

```text
/offlinecontext
/enexcontext
/offlinecontextaudit
```

Detail `/offlineinteriors` sekarang menampilkan:

- resolved display/category/context;
- access scope;
- service type;
- recommended runtime target;
- resolver status/confidence/version;
- SCM reference dan shop binding count;
- pair group dan duplicate group;
- Point A/Point B coordinate space;
- reason dan source evidence.

## Safety

SQL resolver hanya menyentuh:

```text
offline_interior_queue
offline_interior_context_evidence
offline_import_sessions
offline_import_logs
```

SQL resolver tidak menyentuh:

```text
public_interiors
world_pickups
parked_vehicles
player_houses
public_service_config
skin_catalog
gang_preset_config
```

Nama tabel runtime yang muncul dalam `recommended_runtime_target` hanya rekomendasi teks, bukan operasi SQL.

## Rollback

File rollback:

```text
database/rollback/rollback_saif_v0.26A.1.6_enex_context_resolver.sql
```

Rollback sengaja berakhir dengan `ROLLBACK;`. Periksa session ID dan row count lebih dahulu. Ubah ke `COMMIT;` hanya ketika benar-benar ingin membersihkan metadata resolver v0.26A.1.6.

## Git dan deploy

```bat
cd D:\LSIF-DEV
git add gamemodes/lsif.pwn gamemodes/lsif.amx
git add database/migrations/20260613_saif_v0.26A.1.6_enex_context_resolver.sql
git add database/imports/20260613_gtasa_enex_context_resolver_v0.26A.1.6.sql
git add database/verify/verify_saif_v0.26A.1.6_enex_context_resolver.sql
git add database/rollback/rollback_saif_v0.26A.1.6_enex_context_resolver.sql
git add tools/offline_import/saif_enex_context_resolver.py
git add reports/GTASA_ENEX_CONTEXT_RESOLVER_v0.26A.1.6.*
git add README_SAIF_v0.26A.1.6.md CHECKSUMS_SHA256.txt
git commit -m "Add GTA offline ENEX context resolver"
git push
```

Deploy:

```bash
/opt/lsif-repo/deploy/deploy-to-server.sh
```

## Status yang belum dilakukan

- Belum memilih row untuk apply.
- Belum membuat `public_interiors` baru.
- Belum menonaktifkan/menghapus lokasi lama.
- Belum membuat pickup/panah/checkpoint runtime.
- Belum mengubah `player_houses`.
- Belum memindahkan service config.

Tahap berikutnya setelah checklist CLEAR adalah audit pairing dan penyusunan apply-plan per keluarga konteks, dimulai dari kategori yang paling jelas seperti Ammu-Nation, restaurant, barber, tattoo, clothing, dan 24/7.
