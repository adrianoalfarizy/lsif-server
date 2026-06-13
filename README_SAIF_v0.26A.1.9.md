# SAIF / LSIF Dev v0.26A.1.9 — Runtime Capacity & Archive/Replace Dry-Run Foundation

## Tujuan

Tahap ini menyiapkan public interior offline untuk apply di tahap berikutnya tanpa melakukan replace sekarang.

Yang dilakukan:

- menaikkan kapasitas runtime `MAX_PUBLIC_INTERIORS` dari 80 menjadi 128;
- mengubah loader DB dari `LIMIT 80` menjadi `LIMIT 128`;
- menyediakan archive snapshot lengkap untuk tabel `public_interiors`;
- menyediakan dry-run replacement yang hanya memakai `SELECT`;
- menampilkan kapasitas, proyeksi, dan status archive melalui menu Owner.

Yang tidak dilakukan:

- tidak men-disable row `public_interiors`;
- tidak menghapus runtime lama;
- tidak memasukkan 91 plan ke runtime;
- tidak reload public interior akibat SQL archive;
- tidak apply 20 overlay yang belum final.

## Konfirmasi editor service point backend

Backend SAIF memang sudah mempunyai editor untuk memindahkan service point setelah row runtime dibuat:

```text
/pubintpoints [id]
/pubintsetpoint [id] service
/pubintsetfacing [id] service
/pubintserviceradius [id] [radius]
/pubintgoto [id]
```

Pada GUI `Public Interior Editor`, action yang tersedia juga mencakup:

```text
Set Service Checkpoint + Facing = My Position
Set Service Radius
Goto Service Point
```

Jadi 20 overlay 24/7, gym, dan police tetap aman untuk dikoreksi manual tanpa compile ulang.

## Urutan SQL

1. Jalankan migration.
2. Jalankan archive snapshot.
3. Jalankan verify.
4. Jalankan dry-run report.
5. Jangan menjalankan SQL apply karena versi ini memang belum menyertakannya.

## File utama

```text
database/migrations/20260613_saif_v0.26A.1.9_runtime_archive_dry_run_foundation.sql
database/archive/capture_public_interiors_before_offline_replace_v0.26A.1.9.sql
database/verify/verify_saif_v0.26A.1.9_runtime_archive_dry_run.sql
database/dry_run/dry_run_saif_v0.26A.1.9_public_interior_replace.sql
database/rollback/rollback_latest_public_interior_archive_v0.26A.1.9.sql
```

## Command Owner

```text
/offlineruntimedryrun
/offlinearchivestatus
/offlinecapacity
```

Menu:

```text
/amenus
→ GTA Offline Import Audit
→ Runtime Capacity / Archive Dry-Run
```
