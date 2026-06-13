# SAIF / LSIF Dev v0.26A.1.15 — World Spawn Height Normalization

## Scope

Patch kecil gabungan untuk dua gejala setelah import GTA SA offline:

1. Kendaraan hasil Full-130 sebagian tenggelam/nyungsep karena koordinat car generator digunakan mentah oleh `CreateVehicle`.
2. Pickup panah model 1318 pada entry/exit public interior tampak tenggelam karena koordinat ENEX adalah titik lantai, sedangkan origin visual model panah lebih rendah.

## Perubahan

- Kendaraan dengan `source_tag` prefix `offline_gtasa_parkveh130_a` dibuat pada `pos_z + 0.50`.
- Kendaraan manual/curated/source lain tidak diberi lift.
- Pickup panah public interior model 1318 dibuat pada `base_z + 0.50`.
- Koordinat DB tidak diubah.
- Posisi spawn player ketika masuk/keluar interior tidak diubah.
- Label parked vehicle mengikuti runtime Z yang sudah dinormalisasi.
- `/parkvehinfo` menampilkan DB Z, runtime Z, dan source tag.

## SQL

Tidak ada SQL baru.

## Instalasi

Replace `gamemodes/lsif.pwn`, compile F5, commit/push, deploy, lalu jalankan:

- `/offlinevehiclereload` untuk parked vehicle
- `/offlineexactreload` untuk public interior/pickup panah

## Safety

Patch adalah runtime visual/physics normalization. Nilai `pos_z`, `exterior_z`, dan `exit_z` di database tetap exact-source dan tidak ditimpa.
