#!/usr/bin/env python3

from __future__ import annotations

from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parent.parent

GROUPS = {
    "surfaces": [
        "ApolloSurface",
        "ApolloCard",
        "ApolloPanel",
        "ApolloPopup",
        "ApolloScrim",
    ],
    "buttons": [
        "ApolloButton",
        "ApolloIconButton",
        "ApolloPillButton",
        "ApolloAppButton",
    ],
    "controls": [
        "ApolloToggle",
        "ApolloSlider",
        "ApolloProgress",
        "ApolloSegmentedControl",
    ],
    "layout": [
        "ApolloRow",
        "ApolloColumn",
        "ApolloGrid",
        "ApolloSection",
        "ApolloSpacer",
    ],
    "feedback": [
        "ApolloTooltip",
        "ApolloRipple",
        "ApolloLoadingIndicator",
        "ApolloEmptyState",
    ],
}

THEME_OPTIONAL = {"components/layout/ApolloSpacer.qml"}


def fail(message: str) -> None:
    print(f"[APOLLO][COMPONENT-CHECK][ERROR] {message}", file=sys.stderr)
    raise SystemExit(1)


def read(path: Path) -> str:
    if not path.is_file():
        fail(f"Arquivo obrigatório ausente: {path.relative_to(ROOT)}")
    return path.read_text(encoding="utf-8")


all_types: list[str] = []
for group, type_names in GROUPS.items():
    group_root = ROOT / "components" / group
    qmldir = read(group_root / "qmldir")

    for type_name in type_names:
        all_types.append(type_name)
        filename = f"{type_name}.qml"
        relative_path = f"components/{group}/{filename}"
        content = read(group_root / filename)

        registration = f"{type_name} 1.0 {filename}"
        if registration not in qmldir:
            fail(f"Registro ausente em components/{group}/qmldir: {registration}")

        if re.search(r"#[0-9A-Fa-f]{6,8}", content):
            fail(f"{relative_path} contém cor hexadecimal; use Tokens.Theme.colors")

        if relative_path not in THEME_OPTIONAL:
            if 'import "../../theme" as Tokens' not in content:
                fail(f"{relative_path} não importa o sistema de tokens")

        forbidden_imports = (
            'import "../../modules',
            'import "../../services',
            'import "../../models',
        )
        for forbidden_import in forbidden_imports:
            if forbidden_import in content:
                fail(f"{relative_path} depende de uma camada superior: {forbidden_import}")

        uses_layout_attached = "Layout." in content
        imports_layouts = re.search(
            r"^import\s+QtQuick\.Layouts\b",
            content,
            re.MULTILINE,
        ) is not None
        if uses_layout_attached and not imports_layouts:
            fail(f"{relative_path} usa Layout.* sem importar QtQuick.Layouts")

        uses_mouse_area = re.search(r"\bMouseArea\s*\{", content) is not None
        imports_qtquick = re.search(
            r"^import\s+QtQuick\b",
            content,
            re.MULTILINE,
        ) is not None
        if uses_mouse_area and not imports_qtquick:
            fail(f"{relative_path} usa MouseArea sem importar QtQuick")

preview = read(ROOT / "modules" / "bootstrap" / "ThemePreview.qml")

aliases = {
    "surfaces": "Surfaces",
    "buttons": "Buttons",
    "controls": "Controls",
    "layout": "ApolloLayout",
    "feedback": "Feedback",
}

for group, type_names in GROUPS.items():
    alias = aliases[group]
    expected_import = f'import "../../components/{group}" as {alias}'
    if expected_import not in preview:
        fail(f"ThemePreview.qml não importa o grupo {group}")

    for type_name in type_names:
        if f"{alias}.{type_name}" not in preview:
            fail(f"ThemePreview.qml não instancia {type_name}")

surface = read(ROOT / "components" / "surfaces" / "ApolloSurface.qml")
if "default property alias contentData" not in surface:
    fail("ApolloSurface não expõe conteúdo reutilizável")

button = read(ROOT / "components" / "buttons" / "ApolloButton.qml")
for state_name in ("hovered", "pressed", "active"):
    if state_name not in button:
        fail(f"ApolloButton não declara o estado {state_name}")

print(
    "[APOLLO][COMPONENT-CHECK] "
    f"{len(all_types)} primitivas registradas, desacopladas e exercitadas pela galeria"
)
