#!/usr/bin/env python3

from __future__ import annotations

from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parent.parent

SINGLETONS = {
    "Colors.qml": [
        "background",
        "surfaceContainer",
        "onSurface",
        "primary",
        "primaryContainer",
        "secondary",
        "tertiary",
        "outlineVariant",
        "glassSurfaceStrong",
        "statePressed",
    ],
    "Typography.qml": [
        "clock",
        "displayLarge",
        "headlineLarge",
        "titleLarge",
        "bodyMedium",
        "labelSmall",
    ],
    "Shapes.qml": [
        "extraSmall",
        "medium",
        "extraLarge",
        "expressive",
        "pill",
    ],
    "Spacing.qml": [
        "small",
        "medium",
        "large",
        "xxLarge",
        "minimumTouchTarget",
    ],
    "Elevation.qml": [
        "level0",
        "level1",
        "level3",
        "level5",
        "floating",
    ],
    "Motion.qml": [
        "fast",
        "normal",
        "extraLong",
        "standardCurve",
        "duration",
    ],
    "Theme.qml": [
        "colors",
        "typography",
        "shapes",
        "spacing",
        "elevation",
        "motion",
        "toggleDarkMode",
        "scaled",
    ],
}


def fail(message: str) -> None:
    print(f"[APOLLO][THEME-CHECK][ERROR] {message}", file=sys.stderr)
    raise SystemExit(1)


def read(relative_path: str) -> str:
    path = ROOT / relative_path
    if not path.is_file():
        fail(f"Arquivo obrigatório ausente: {relative_path}")
    return path.read_text(encoding="utf-8")


for filename, required_tokens in SINGLETONS.items():
    relative_path = f"theme/{filename}"
    content = read(relative_path)

    if "pragma Singleton" not in content:
        fail(f"{relative_path} não declara pragma Singleton")
    if not re.search(r"\bSingleton\s*\{", content):
        fail(f"{relative_path} não usa Singleton como raiz")

    for token in required_tokens:
        if not re.search(rf"\b{re.escape(token)}\b", content):
            fail(f"Token {token!r} ausente em {relative_path}")

qmldir = read("theme/qmldir")
for filename in SINGLETONS:
    type_name = filename.removesuffix(".qml")
    expected = f"singleton {type_name} 1.0 {filename}"
    if expected not in qmldir:
        fail(f"Registro ausente em theme/qmldir: {expected}")

bootstrap = read("modules/bootstrap/BootstrapSurface.qml")
preview = read("modules/bootstrap/ThemePreview.qml")

for relative_path, content in (
    ("modules/bootstrap/BootstrapSurface.qml", bootstrap),
    ("modules/bootstrap/ThemePreview.qml", preview),
):
    if 'import "../../theme" as Tokens' not in content:
        fail(f"{relative_path} não importa o sistema de tokens")
    if re.search(r"#[0-9A-Fa-f]{6,8}", content):
        fail(f"{relative_path} contém cor hexadecimal fora de theme/Colors.qml")

if "Tokens.Theme.colors" not in bootstrap:
    fail("BootstrapSurface.qml não consome a paleta compartilhada")
if "Tokens.Theme.typography" not in preview:
    fail("ThemePreview.qml não consome tipografia compartilhada")
if "Tokens.Theme.shapes" not in preview:
    fail("ThemePreview.qml não consome formas compartilhadas")
if "Tokens.Theme.spacing" not in preview:
    fail("ThemePreview.qml não consome espaçamento compartilhado")

metadata = read("data/applications/io.github.maylton.apollo-shell.desktop")
if "Name=Apollo Shell" not in metadata:
    fail("Arquivo .desktop não possui o nome do aplicativo")
if "Exec=qs -c apollo-shell" not in metadata:
    fail("Arquivo .desktop não aponta para o identificador do shell")

print(
    "[APOLLO][THEME-CHECK] Sistema visual validado: "
    f"{len(SINGLETONS)} singletons e galeria sem estilos duplicados"
)
