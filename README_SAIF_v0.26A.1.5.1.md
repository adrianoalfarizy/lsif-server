# SAIF / LSIF Dev v0.26A.1.5.1 — ENEX Side-Aware Preview

## Tujuan

Memperbaiki fitur audit ENEX yang sebelumnya selalu memaksa `entry_x/y/z` ke Interior 0 sehingga koordinat interior high-Z dapat membuat Owner free fall.

Patch ini tetap read-only terhadap staging dan runtime world.

## SQL

Tidak ada SQL baru.

## Perubahan

- Detail ENEX sekarang membuka menu preview Point A / Point B.
- Point A memilih World 0 atau interior secara otomatis dari source IPL, Z, dan `interior_id`.
- Point B memakai `interior_id` ENEX bila tersedia.
- Preview interior memakai virtual world audit terisolasi `60000 + playerid`.
- Posisi, facing, interior, dan virtual world Owner disimpan sebelum preview pertama.
- Menu dan command `/offlineintreturn` mengembalikan Owner ke posisi awal.
- High-Z tanpa interior valid diblokir agar tidak free fall.
- Preview ditolak saat Owner masih berada di kendaraan.
- `/offlineintgoto [queue_id] [a/b]` tersedia sebagai fallback command.
- Tidak ada perubahan pada `offline_interior_queue`, `public_interiors`, `world_pickups`, atau runtime world.

## Replace

```text
D:\LSIF-DEV\gamemodes\lsif.pwn
```

## Compile

```text
F5
```

## Git

```bat
cd D:\LSIF-DEV
git add gamemodes/lsif.pwn gamemodes/lsif.amx
git commit -m "Fix ENEX side-aware audit preview"
git push
```

## Deploy

```bash
/opt/lsif-repo/deploy/deploy-to-server.sh
```

## Test utama

1. Login sebagai Owner.
2. Buka `/amenus` → `GTA Offline Import Audit`.
3. Buka `Interior / ENEX Queue`.
4. Pilih record interior high-Z seperti `JETINT`, `MADDOGS`, `BIKESCH`, atau `AMMUN1`.
5. Tekan `Preview`.
6. Uji `Preview Point A` dan `Preview Point B`.
7. Pastikan chat menampilkan Interior/VW yang digunakan.
8. Pilih `Return to Previous Position` atau gunakan `/offlineintreturn`.
9. Pastikan posisi, interior, VW, dan facing kembali.

## Safety

- Tidak ada SQL migration.
- Tidak ada apply queue.
- Tidak ada spawn pickup/object/vehicle.
- Tidak ada delete/archive/reload runtime.
- Semua 376 queue row tetap `enabled=0` dan `apply_status=pending`.
