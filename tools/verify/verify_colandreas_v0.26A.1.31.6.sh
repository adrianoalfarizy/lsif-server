#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-$(pwd)}"
cd "$ROOT"

fail=0
check_file() {
    local path="$1"
    if [[ -s "$path" ]]; then
        printf '[OK] %s\n' "$path"
    else
        printf '[MISSING] %s\n' "$path"
        fail=1
    fi
}

check_file "plugins/ColAndreas_static.so"
check_file "scriptfiles/ColAndreas/ColAndreas.cadb"

if [[ -f config.json ]] && grep -q 'ColAndreas_static' config.json; then
    printf '[OK] config.json contains ColAndreas_static\n'
else
    printf '[MISSING] config.json legacy_plugins entry ColAndreas_static\n'
    fail=1
fi

if [[ -f config.json ]]; then
    python3 -m json.tool config.json >/dev/null
    printf '[OK] config.json valid JSON\n'
fi

if (( fail != 0 )); then
    printf 'COLANDREAS_DEPENDENCY_GATE=0\n'
    exit 1
fi

printf 'COLANDREAS_DEPENDENCY_GATE=1\n'
