#!/usr/bin/env bash
set -euo pipefail

TIMEOUT_SECONDS="${SAIF_DB_WAIT_TIMEOUT:-120}"

if command -v mariadb-admin >/dev/null 2>&1; then
    DB_ADMIN="$(command -v mariadb-admin)"
elif command -v mysqladmin >/dev/null 2>&1; then
    DB_ADMIN="$(command -v mysqladmin)"
else
    echo "[SAIF] mariadb-admin/mysqladmin tidak ditemukan." >&2
    exit 1
fi

echo "[SAIF] Menunggu MariaDB siap sebelum open.mp dijalankan..."

for ((second = 1; second <= TIMEOUT_SECONDS; second++)); do
    if "$DB_ADMIN" ping --protocol=tcp --host=127.0.0.1 --silent >/dev/null 2>&1; then
        echo "[SAIF] MariaDB siap setelah ${second} detik."
        exit 0
    fi
    sleep 1
done

echo "[SAIF] MariaDB belum siap setelah ${TIMEOUT_SECONDS} detik; startup open.mp dibatalkan." >&2
exit 1
