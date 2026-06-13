# SAIF / LSIF Dev v0.26A.1.16.1 — Hospital Map Icon Coverage Fix

## Akar masalah
Patch v0.26A.1.16 hanya membangun icon dari row aktif `public_interiors`.
Sementara tujuh lokasi hospital yang dipakai death/respawn berada pada array
`HospitalRespawnX/Y/Z`, dan tidak otomatis mempunyai row `public_interiors`.
Akibatnya database dapat mempunyai mapping icon hospital=22 yang benar, tetapi
hospital tetap tidak tampil karena tidak ada kandidat runtime yang dipasang.

Selain itu, icon public interior sebelumnya dipasang sesuai urutan row dan lima
slot selalu dicadangkan untuk house. Hospital yang terlambat dalam urutan dapat
tertinggal saat slot penuh.

## Perbaikan
1. Hospital public interior aktif dipasang paling dahulu.
2. Tujuh hospital respawn dipakai sebagai fallback icon 22.
3. Fallback tidak dibuat bila sudah ada public interior hospital dalam radius 120 m.
4. Hospital dialokasikan sebelum icon layanan lain.
5. House/property hanya memakai slot yang tersisa, bukan reserve tetap.
6. `/mapiconaudit` menampilkan jumlah hospital dari DB dan fallback secara terpisah.

## SQL
Tidak ada SQL baru. Koordinat dan map icon DB tidak diubah.

## Instalasi
Replace `gamemodes/lsif.pwn`, compile F5, push/deploy, kemudian jalankan:

```
/offlineexactreload
/mapiconaudit
```

Pada audit, baris berikut harus menunjukkan hospital lebih dari nol:

```
Hospital DB/Fallback [22]: <db> / <fallback>
```

Jumlah fallback maksimum adalah 7. Jika ada hospital DB dekat salah satu titik,
fallback untuk titik tersebut otomatis tidak dibuat agar tidak duplikat.
