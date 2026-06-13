# SAIF / LSIF Dev v0.26A.1.15.1 — Interior Arrow and Spawn Z Fix

## Scope
Patch kecil lanjutan v0.26A.1.15 untuk public interior.

- Runtime lift pickup panah model 1318 dinaikkan dari +0.50 Z menjadi +1.00 Z.
- Runtime spawn player saat masuk public interior diberi +0.50 Z.
- Runtime spawn player saat keluar public interior diberi +0.50 Z.
- Preview admin untuk interior arrival dan exterior return spawn memakai helper lift yang sama.
- Koordinat database tetap exact/original.
- Parked vehicle normalization tetap +0.50 Z dan tidak berubah.

## SQL
Tidak ada SQL baru.

## Replace
`D:\LSIF-DEV\gamemodes\lsif.pwn`

## Compile
F5

## Reload runtime
- `/offlineexactreload` untuk recreate pickup panah public interior.
- Player yang sedang berada di interior sebaiknya keluar/masuk ulang untuk menguji spawn transform baru.

## Expected
- Panah entry/exit lebih tinggi 0.50 dibanding patch sebelumnya.
- Player tidak lagi muncul dengan kaki/badan tertanam setelah enter/exit.
