pragma Singleton

import Quickshell
import "../config" as AppConfig
import "../core" as Core

Singleton {
    id: root

    readonly property var colors: Colors
    readonly property var typography: Typography
    readonly property var shapes: Shapes
    readonly property var spacing: Spacing
    readonly property var elevation: Elevation
    readonly property var motion: Motion

    readonly property bool dark: AppConfig.Config.darkMode
    readonly property string modeName: dark ? "dark" : "light"
    readonly property real scale: AppConfig.Config.effectiveScale
    readonly property bool animationsEnabled: AppConfig.Config.animationsEnabled

    signal paletteChanged(bool dark)

    function setDarkMode(enabled) {
        const normalizedValue = Boolean(enabled)
        if (AppConfig.Config.darkMode === normalizedValue)
            return

        AppConfig.Config.darkMode = normalizedValue
    }

    function toggleDarkMode() {
        setDarkMode(!dark)
    }

    function scaled(value) {
        return Math.round(Number(value) * scale)
    }

    function animationDuration(baseDuration) {
        return motion.duration(baseDuration)
    }

    Connections {
        target: AppConfig.Config

        function onDarkModeChanged() {
            Core.Logger.info(Core.Constants.themeCategory, "Color scheme changed", {
                mode: root.modeName
            })
            root.paletteChanged(root.dark)
        }
    }
}
