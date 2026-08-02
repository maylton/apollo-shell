pragma Singleton

import Quickshell
import "../config" as AppConfig
import "../core" as Core

Singleton {
    id: root

    // Expose a plain reactive palette object instead of forwarding the
    // Colors singleton directly. Qt bindings reliably track every role,
    // including semantic names that begin with "on".
    readonly property var colors: ({
        background: Colors.background,
        onBackground: Colors["onBackground"],
        surface: Colors.surface,
        surfaceDim: Colors.surfaceDim,
        surfaceBright: Colors.surfaceBright,
        surfaceContainerLowest: Colors.surfaceContainerLowest,
        surfaceContainerLow: Colors.surfaceContainerLow,
        surfaceContainer: Colors.surfaceContainer,
        surfaceContainerHigh: Colors.surfaceContainerHigh,
        surfaceContainerHighest: Colors.surfaceContainerHighest,
        onSurface: Colors["onSurface"],
        onSurfaceVariant: Colors["onSurfaceVariant"],
        primary: Colors.primary,
        onPrimary: Colors["onPrimary"],
        primaryContainer: Colors.primaryContainer,
        onPrimaryContainer: Colors["onPrimaryContainer"],
        secondary: Colors.secondary,
        onSecondary: Colors["onSecondary"],
        secondaryContainer: Colors.secondaryContainer,
        onSecondaryContainer: Colors["onSecondaryContainer"],
        tertiary: Colors.tertiary,
        onTertiary: Colors["onTertiary"],
        tertiaryContainer: Colors.tertiaryContainer,
        onTertiaryContainer: Colors["onTertiaryContainer"],
        error: Colors.error,
        onError: Colors["onError"],
        errorContainer: Colors.errorContainer,
        onErrorContainer: Colors["onErrorContainer"],
        outline: Colors.outline,
        outlineVariant: Colors.outlineVariant,
        shadow: Colors.shadow,
        scrim: Colors.scrim,
        inverseSurface: Colors.inverseSurface,
        inverseOnSurface: Colors.inverseOnSurface,
        inversePrimary: Colors.inversePrimary,
        lavender: Colors.lavender,
        pink: Colors.pink,
        peach: Colors.peach,
        plum: Colors.plum,
        mint: Colors.mint,
        glassSurface: Colors.glassSurface,
        glassSurfaceStrong: Colors.glassSurfaceStrong,
        activeIndicator: Colors.activeIndicator,
        inactiveIndicator: Colors.inactiveIndicator,
        success: Colors.success,
        warning: Colors.warning,
        info: Colors.info,
        stateHover: Colors.stateHover,
        stateFocus: Colors.stateFocus,
        statePressed: Colors.statePressed,
        stateDragged: Colors.stateDragged
    })

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

    onDarkChanged: {
        Core.Logger.info(Core.Constants.themeCategory, "Color scheme changed", {
            mode: root.modeName
        })
        root.paletteChanged(root.dark)
    }

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
}
