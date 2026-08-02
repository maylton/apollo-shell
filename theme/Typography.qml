pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    readonly property string displayFamily: "Roboto Flex"
    readonly property string bodyFamily: "Roboto"

    readonly property QtObject clock: QtObject {
        readonly property string family: root.displayFamily
        readonly property int pixelSize: 48
        readonly property int weight: Font.Normal
        readonly property real letterSpacing: -1.0
        readonly property real lineHeight: 1.05
    }

    readonly property QtObject displayLarge: QtObject {
        readonly property string family: root.displayFamily
        readonly property int pixelSize: 57
        readonly property int weight: Font.Normal
        readonly property real letterSpacing: -0.25
        readonly property real lineHeight: 1.12
    }

    readonly property QtObject displayMedium: QtObject {
        readonly property string family: root.displayFamily
        readonly property int pixelSize: 45
        readonly property int weight: Font.Normal
        readonly property real letterSpacing: 0.0
        readonly property real lineHeight: 1.16
    }

    readonly property QtObject headlineLarge: QtObject {
        readonly property string family: root.displayFamily
        readonly property int pixelSize: 32
        readonly property int weight: Font.Medium
        readonly property real letterSpacing: 0.0
        readonly property real lineHeight: 1.25
    }

    readonly property QtObject headlineMedium: QtObject {
        readonly property string family: root.displayFamily
        readonly property int pixelSize: 28
        readonly property int weight: Font.Medium
        readonly property real letterSpacing: 0.0
        readonly property real lineHeight: 1.29
    }

    readonly property QtObject titleLarge: QtObject {
        readonly property string family: root.displayFamily
        readonly property int pixelSize: 22
        readonly property int weight: Font.DemiBold
        readonly property real letterSpacing: 0.0
        readonly property real lineHeight: 1.27
    }

    readonly property QtObject titleMedium: QtObject {
        readonly property string family: root.bodyFamily
        readonly property int pixelSize: 16
        readonly property int weight: Font.DemiBold
        readonly property real letterSpacing: 0.15
        readonly property real lineHeight: 1.5
    }

    readonly property QtObject titleSmall: QtObject {
        readonly property string family: root.bodyFamily
        readonly property int pixelSize: 14
        readonly property int weight: Font.DemiBold
        readonly property real letterSpacing: 0.1
        readonly property real lineHeight: 1.43
    }

    readonly property QtObject bodyLarge: QtObject {
        readonly property string family: root.bodyFamily
        readonly property int pixelSize: 16
        readonly property int weight: Font.Normal
        readonly property real letterSpacing: 0.5
        readonly property real lineHeight: 1.5
    }

    readonly property QtObject bodyMedium: QtObject {
        readonly property string family: root.bodyFamily
        readonly property int pixelSize: 14
        readonly property int weight: Font.Normal
        readonly property real letterSpacing: 0.25
        readonly property real lineHeight: 1.43
    }

    readonly property QtObject bodySmall: QtObject {
        readonly property string family: root.bodyFamily
        readonly property int pixelSize: 12
        readonly property int weight: Font.Normal
        readonly property real letterSpacing: 0.4
        readonly property real lineHeight: 1.33
    }

    readonly property QtObject labelLarge: QtObject {
        readonly property string family: root.bodyFamily
        readonly property int pixelSize: 14
        readonly property int weight: Font.DemiBold
        readonly property real letterSpacing: 0.1
        readonly property real lineHeight: 1.43
    }

    readonly property QtObject labelMedium: QtObject {
        readonly property string family: root.bodyFamily
        readonly property int pixelSize: 12
        readonly property int weight: Font.DemiBold
        readonly property real letterSpacing: 0.5
        readonly property real lineHeight: 1.33
    }

    readonly property QtObject labelSmall: QtObject {
        readonly property string family: root.bodyFamily
        readonly property int pixelSize: 11
        readonly property int weight: Font.Medium
        readonly property real letterSpacing: 0.5
        readonly property real lineHeight: 1.45
    }
}
