pragma Singleton

import QtQuick
import Quickshell
import "../config" as AppConfig

Singleton {
    id: root

    readonly property bool dark: AppConfig.Config.darkMode

    // Core Material color roles
    readonly property color background: dark ? "#160D19" : "#FFF7FF"
    readonly property color onBackground: dark ? "#F3E7F4" : "#241A25"

    readonly property color surface: dark ? "#160D19" : "#FFF7FF"
    readonly property color surfaceDim: dark ? "#160D19" : "#E7DCE7"
    readonly property color surfaceBright: dark ? "#403442" : "#FFF7FF"
    readonly property color surfaceContainerLowest: dark ? "#100812" : "#FFFFFF"
    readonly property color surfaceContainerLow: dark ? "#211724" : "#FAF0FA"
    readonly property color surfaceContainer: dark ? "#251B28" : "#F4EAF4"
    readonly property color surfaceContainerHigh: dark ? "#302532" : "#EEE4EE"
    readonly property color surfaceContainerHighest: dark ? "#3B303D" : "#E8DEE8"
    readonly property color onSurface: dark ? "#F3E7F4" : "#241A25"
    readonly property color onSurfaceVariant: dark ? "#D5C2D5" : "#574B58"

    readonly property color primary: dark ? "#D9B8FF" : "#72518E"
    readonly property color onPrimary: dark ? "#41245A" : "#FFFFFF"
    readonly property color primaryContainer: dark ? "#593A71" : "#EEDBFF"
    readonly property color onPrimaryContainer: dark ? "#F0DCFF" : "#2B0B43"

    readonly property color secondary: dark ? "#E5B7D0" : "#86536D"
    readonly property color onSecondary: dark ? "#4D2038" : "#FFFFFF"
    readonly property color secondaryContainer: dark ? "#67384F" : "#FFD8E8"
    readonly property color onSecondaryContainer: dark ? "#FFD8E8" : "#371125"

    readonly property color tertiary: dark ? "#F4B8A8" : "#9A4F43"
    readonly property color onTertiary: dark ? "#5C1D15" : "#FFFFFF"
    readonly property color tertiaryContainer: dark ? "#7B352B" : "#FFDAD2"
    readonly property color onTertiaryContainer: dark ? "#FFDAD2" : "#3C0803"

    readonly property color error: dark ? "#FFB4AB" : "#BA1A1A"
    readonly property color onError: dark ? "#690005" : "#FFFFFF"
    readonly property color errorContainer: dark ? "#93000A" : "#FFDAD6"
    readonly property color onErrorContainer: dark ? "#FFDAD6" : "#410002"

    readonly property color outline: dark ? "#9E8D9F" : "#897889"
    readonly property color outlineVariant: dark ? "#504350" : "#DCCBDC"
    readonly property color shadow: "#000000"
    readonly property color scrim: dark ? "#99000000" : "#66000000"

    readonly property color inverseSurface: dark ? "#F3E7F4" : "#392E3A"
    readonly property color inverseOnSurface: dark ? "#342A36" : "#FCEFFB"
    readonly property color inversePrimary: dark ? "#72518E" : "#D9B8FF"

    // Apollo-specific expressive roles
    readonly property color lavender: dark ? "#D9B8FF" : "#C9A8F0"
    readonly property color pink: dark ? "#F1AFCB" : "#E7A4C4"
    readonly property color peach: dark ? "#F3B6A6" : "#E7AF9F"
    readonly property color plum: dark ? "#2A152E" : "#6A416F"
    readonly property color mint: dark ? "#9BD9C5" : "#5F9F8B"

    readonly property color glassSurface: dark ? "#D9231727" : "#E8FBF4FC"
    readonly property color glassSurfaceStrong: dark ? "#F02D1C32" : "#F7F8EEF8"
    readonly property color activeIndicator: dark ? "#D9B8FF" : "#72518E"
    readonly property color inactiveIndicator: dark ? "#67576A" : "#C9B9CB"

    readonly property color success: dark ? "#9ED9AF" : "#2F6B43"
    readonly property color warning: dark ? "#F2CB7D" : "#805600"
    readonly property color info: dark ? "#AFCBFF" : "#3C5F91"

    readonly property color stateHover: dark ? "#14FFFFFF" : "#14000000"
    readonly property color stateFocus: dark ? "#1FFFFFFF" : "#1F000000"
    readonly property color statePressed: dark ? "#29FFFFFF" : "#29000000"
    readonly property color stateDragged: dark ? "#33FFFFFF" : "#33000000"
}
