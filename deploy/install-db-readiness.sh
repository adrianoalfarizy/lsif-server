#!/usr/bin/env bash
set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
    echo "Jalankan sebagai root: sudo bash install-db-readiness.sh" >&2
    exit 1
fi

SERVICE_NAME="${1:-omp-server.service}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ASSET_DIR="$SCRIPT_DIR"
if [[ -d "$SCRIPT_DIR/systemd" ]]; then
    ASSET_DIR="$SCRIPT_DIR/systemd"
fi

if ! systemctl list-unit-files "$SERVICE_NAME" --no-legend 2>/dev/null | grep -q .; then
    echo "Service $SERVICE_NAME tidak ditemukan." >&2
    echo "Contoh bila nama service berbeda: sudo bash install-db-readiness.sh nama-service.service" >&2
    exit 1
fi

install -m 0755 "$ASSET_DIR/saif-wait-for-mariadb.sh" /usr/local/sbin/saif-wait-for-mariadb.sh
install -d -m 0755 "/etc/systemd/system/${SERVICE_NAME}.d"
install -m 0644 "$ASSET_DIR/omp-server-db-readiness.conf" "/etc/systemd/system/${SERVICE_NAME}.d/db-readiness.conf"

systemctl enable mariadb.service
systemctl daemon-reload
systemctl restart "$SERVICE_NAME"

systemctl --no-pager --full status mariadb.service || true
systemctl --no-pager --full status "$SERVICE_NAME" || true

echo
printf 'Verifikasi boot dependency:\n'
systemctl show "$SERVICE_NAME" -p After -p Requires -p Restart -p RestartUSec
