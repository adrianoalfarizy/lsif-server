SAIF / LSIF Dev v0.26A.1.3.1 — Cold Boot Database Readiness Fix

ROOT CAUSE
==========
Pada cold boot, open.mp dapat start sebelum MariaDB siap. lsif.pwn lama tetap
menjalankan query ban/whitelist/account walaupun mysql_connect gagal. Callback
auth tidak pernah kembali. Timer EnsureAuthDialog hanya mengirim query kedua ke
handle DB yang sama-sama belum siap sehingga muncul pesan auth fallback tetapi
tidak ada dialog login/register.

ISI PATCH
=========
1. lsif_v0.26A.1.3.1.pwn
   - menggunakan AUTO_RECONNECT untuk koneksi yang sudah berhasil;
   - validasi MYSQL_INVALID_HANDLE dan mysql_errno;
   - fail-fast: open.mp exit jika DB belum siap, bukan berjalan setengah aktif;
   - guard OnPlayerConnect dan EnsureAuthDialog terhadap handle DB tidak siap;
   - tidak mengubah query login/register, password, vitals, atau schema DB.

2. saif-wait-for-mariadb.sh
   - menunggu MariaDB menjawab ping TCP sebelum open.mp start.

3. omp-server-db-readiness.conf
   - systemd dependency After/Requires mariadb.service;
   - ExecStartPre readiness check;
   - Restart=always dan RestartSec=5.

4. install-db-readiness.sh
   - memasang helper + systemd drop-in.

INSTALL SERVER
==============
Upload tiga file shell/config ke server, masuk ke foldernya, lalu:

  sudo bash install-db-readiness.sh

Jika nama service open.mp bukan omp-server.service:

  sudo bash install-db-readiness.sh NAMA-SERVICE.service

VERIFIKASI
==========
  systemctl cat omp-server.service
  systemctl show omp-server.service -p After -p Requires -p Restart
  journalctl -u mariadb.service -u omp-server.service -b --no-pager

COLD BOOT TEST
==============
  sudo reboot

Setelah server hidup:
  systemctl status mariadb.service --no-pager
  systemctl status omp-server.service --no-pager
  journalctl -u omp-server.service -b --no-pager | tail -n 100

Expected:
- MariaDB aktif lebih dulu.
- Log [MYSQL] Berhasil connect muncul.
- Tidak ada kondisi server online dengan DB gagal.
- Login/register dialog tampil pada koneksi pertama tanpa deploy ulang.
