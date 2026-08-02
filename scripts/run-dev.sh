#!/usr/bin/env bash

set -Eeuo pipefail

readonly SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
readonly ENTRYPOINT="${PROJECT_ROOT}/shell.qml"

log() {
    printf '[APOLLO][DEV] %s\n' "$*"
}

fail() {
    printf '[APOLLO][DEV][ERROR] %s\n' "$*" >&2
    exit 1
}

command -v qs >/dev/null 2>&1 || fail "Quickshell não foi encontrado. Instale o pacote 'quickshell' 0.3 ou superior."
[[ -f "${ENTRYPOINT}" ]] || fail "Entrypoint não encontrado: ${ENTRYPOINT}"

log "Iniciando Apollo Shell a partir de ${ENTRYPOINT}"
exec qs -p "${ENTRYPOINT}" "$@"
