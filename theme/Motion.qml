pragma Singleton

import QtQuick
import Quickshell
import "../config" as AppConfig

Singleton {
    readonly property int instant: 0
    readonly property int fast: 100
    readonly property int short: 160
    readonly property int normal: 240
    readonly property int long: 360
    readonly property int extraLong: 500

    readonly property int standardCurve: Easing.OutCubic
    readonly property int emphasizedCurve: Easing.OutBack
    readonly property int decelerateCurve: Easing.OutQuart
    readonly property int accelerateCurve: Easing.InCubic
    readonly property int linearCurve: Easing.Linear

    readonly property var standardBezier: [0.2, 0.0, 0.0, 1.0]
    readonly property var emphasizedBezier: [0.2, 0.0, 0.0, 1.0]
    readonly property var emphasizedAccelerateBezier: [0.3, 0.0, 0.8, 0.15]
    readonly property var emphasizedDecelerateBezier: [0.05, 0.7, 0.1, 1.0]

    function duration(baseDuration) {
        return AppConfig.Config.animationsEnabled ? Math.max(0, baseDuration) : instant
    }
}
