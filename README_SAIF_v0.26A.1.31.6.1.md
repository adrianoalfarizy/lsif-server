# SAIF v0.26A.1.31.6.1 — Dynamic Parking Stat Tag Compile Hotfix

Hotfix compile-only untuk dynamic near-player parking solver.

Perubahan:

- Mengubah named enum `E_DYNAMIC_PARKING_STAT` menjadi anonymous enum agar konstanta indeks tidak membawa tag enum ke array integer biasa.
- Menandai parameter `stats[]` pada `SaveDynamicParkingStatsForPlayer` sebagai `const` karena fungsi hanya membaca data.
- Menghapus assignment `maxZ` yang tidak dipakai dan memakai `maxZ <= minZ` sebagai validasi bounding-box ColAndreas.
- Tidak mengubah SQL, database, collision solver, candidate ring, fallback catalog, marker kuning, atau lifecycle kendaraan.

Target compile:

```text
0 Errors.
0 Warnings.
```
