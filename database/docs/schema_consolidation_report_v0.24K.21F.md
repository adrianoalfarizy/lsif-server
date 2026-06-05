# SAIF / LSIF Dev v0.24K.21F — Schema Consolidation Prep

## Tujuan

Pass ini tidak mengubah runtime gameplay. Fokusnya menyiapkan baseline schema yang bersih, karena `database/schema.sql` lama sudah berisi campuran struktur, seed, patch historis, duplicate ALTER, dan catatan migration.

## File yang dibuat

- `schema_clean_baseline_v0.24K.21F.sql` — struktur bersih dari live DB audit, structure-only, untuk referensi/replacement schema repo nanti.
- `schema_verify_v0.24K.21F.sql` — query read-only untuk cek live DB setelah cleanup A-E.
- `lsif_v0.24K.21F_schema_consolidation_prep.pwn` — hanya update version text.

## Hal yang sengaja tidak dilakukan

- Tidak menghapus table live DB.
- Tidak menghapus kolom live DB.
- Tidak mengubah data player/world/gang/business.
- Tidak menjalankan SQL mutation.
- Tidak mengubah death/hospital/class selection/weapon drop/money anti-cheat.

## Catatan penting

`schema_clean_baseline_v0.24K.21F.sql` tidak perlu dijalankan ke live DB. File ini adalah baseline struktur bersih untuk repo/fresh install.

Untuk live DB, jalankan hanya `schema_verify_v0.24K.21F.sql` karena isinya SELECT read-only.

## Ringkasan struktur

- Runtime table baseline: 35 table.
- Duplicate source_tag index lama pada parked/public interior tidak dimasukkan.
- Index audit dari v0.24K.21A sudah dicerminkan.
- Kolom door/facing Gang HQ yang dipakai runtime sudah ada.

## Rekomendasi setelah clear

Setelah v0.24K.21F clear, langkah berikutnya bisa salah satu:

1. `v0.24K.21G — Seed/Data Split Pass`: pisahkan seed config exact/manual dari schema structure.
2. `v0.24K.21H — Legacy Command/Function Inventory`: audit command/helper yang sudah tidak dipakai.
3. `v0.24K.22 — Death/Hospital Polish`: kembali ke roadmap gameplay setelah cleanup DB cukup aman.
