#!/usr/bin/env bash

set -Eeuo pipefail

readonly SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

log() {
    printf '[APOLLO][CHECK] %s\n' "$*"
}

fail() {
    printf '[APOLLO][CHECK][ERROR] %s\n' "$*" >&2
    exit 1
}

readonly REQUIRED_FILES=(
    "shell.qml"
    "qmldir"
    "core/Apollo.qml"
    "core/Constants.qml"
    "core/Logger.qml"
    "core/Paths.qml"
    "config/Config.qml"
    "config/defaults.json"
    "theme/Colors.qml"
    "theme/Typography.qml"
    "theme/Shapes.qml"
    "theme/Spacing.qml"
    "theme/Elevation.qml"
    "theme/Motion.qml"
    "theme/Theme.qml"
    "theme/qmldir"
    "modules/bootstrap/BootstrapSurface.qml"
    "modules/bootstrap/ThemePreview.qml"
    "data/applications/io.github.maylton.apollo-shell.desktop"
    "scripts/check-theme.py"
    "scripts/run-dev.sh"
)

for relative_path in "${REQUIRED_FILES[@]}"; do
    [[ -f "${PROJECT_ROOT}/${relative_path}" ]] \
        || fail "Arquivo obrigatório ausente: ${relative_path}"
done

command -v python3 >/dev/null 2>&1 || fail "python3 é necessário para validar a configuração."

log "Validando JSON"
python3 -m json.tool "${PROJECT_ROOT}/config/defaults.json" >/dev/null

log "Validando scripts"
bash -n "${PROJECT_ROOT}/scripts/run-dev.sh"
bash -n "${PROJECT_ROOT}/scripts/check-foundation.sh"
python3 -m py_compile "${PROJECT_ROOT}/scripts/check-theme.py"

log "Verificando delimitadores básicos dos arquivos QML"
python3 - "${PROJECT_ROOT}" <<'PY'
from __future__ import annotations

from pathlib import Path
import sys

root = Path(sys.argv[1])
qml_files = sorted(root.rglob("*.qml"))
pairs = {"{": "}", "[": "]", "(": ")"}
closing = {value: key for key, value in pairs.items()}


def validate(path: Path) -> None:
    text = path.read_text(encoding="utf-8")
    stack: list[tuple[str, int]] = []
    in_string: str | None = None
    escaped = False
    in_line_comment = False
    in_block_comment = False
    index = 0

    while index < len(text):
        char = text[index]
        next_char = text[index + 1] if index + 1 < len(text) else ""

        if in_line_comment:
            if char == "\n":
                in_line_comment = False
            index += 1
            continue

        if in_block_comment:
            if char == "*" and next_char == "/":
                in_block_comment = False
                index += 2
            else:
                index += 1
            continue

        if in_string is not None:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == in_string:
                in_string = None
            index += 1
            continue

        if char == "/" and next_char == "/":
            in_line_comment = True
            index += 2
            continue

        if char == "/" and next_char == "*":
            in_block_comment = True
            index += 2
            continue

        if char in {"'", '"', "`"}:
            in_string = char
            index += 1
            continue

        if char in pairs:
            stack.append((char, index))
        elif char in closing:
            if not stack or stack[-1][0] != closing[char]:
                raise ValueError(f"delimitador inesperado {char!r} na posição {index}")
            stack.pop()

        index += 1

    if in_string is not None:
        raise ValueError("string não finalizada")
    if in_block_comment:
        raise ValueError("comentário de bloco não finalizado")
    if stack:
        opener, position = stack[-1]
        raise ValueError(f"delimitador {opener!r} aberto na posição {position} não foi fechado")


failures: list[str] = []
for qml_file in qml_files:
    try:
        validate(qml_file)
    except ValueError as error:
        failures.append(f"{qml_file.relative_to(root)}: {error}")

if failures:
    print("\n".join(failures), file=sys.stderr)
    raise SystemExit(1)

print(f"Validated {len(qml_files)} QML files")
PY

log "Validando sistema de tokens"
python3 "${PROJECT_ROOT}/scripts/check-theme.py"

if [[ "${APOLLO_RUNTIME_CHECK:-0}" == "1" ]]; then
    command -v qs >/dev/null 2>&1 || fail "Quickshell não foi encontrado para o teste de execução."
    command -v timeout >/dev/null 2>&1 || fail "O comando 'timeout' é necessário para o teste de execução."
    [[ -n "${WAYLAND_DISPLAY:-}" ]] || fail "WAYLAND_DISPLAY não está definido. Execute o teste dentro de uma sessão Wayland."

    readonly RUNTIME_TIMEOUT="${APOLLO_RUNTIME_TIMEOUT:-5}"
    log "Executando teste do Quickshell por ${RUNTIME_TIMEOUT}s"

    set +e
    timeout "${RUNTIME_TIMEOUT}s" "${PROJECT_ROOT}/scripts/run-dev.sh"
    runtime_status=$?
    set -e

    if [[ ${runtime_status} -ne 0 && ${runtime_status} -ne 124 ]]; then
        fail "Quickshell encerrou com status ${runtime_status}."
    fi
fi

log "Marcos 1 e 2 validados com sucesso"
