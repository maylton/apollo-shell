pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    readonly property QtObject level0: QtObject {
        readonly property int z: 0
        readonly property int verticalOffset: 0
        readonly property int blurRadius: 0
        readonly property real opacity: 0.0
    }

    readonly property QtObject level1: QtObject {
        readonly property int z: 1
        readonly property int verticalOffset: 1
        readonly property int blurRadius: 3
        readonly property real opacity: 0.18
    }

    readonly property QtObject level2: QtObject {
        readonly property int z: 2
        readonly property int verticalOffset: 2
        readonly property int blurRadius: 6
        readonly property real opacity: 0.20
    }

    readonly property QtObject level3: QtObject {
        readonly property int z: 3
        readonly property int verticalOffset: 4
        readonly property int blurRadius: 10
        readonly property real opacity: 0.22
    }

    readonly property QtObject level4: QtObject {
        readonly property int z: 4
        readonly property int verticalOffset: 6
        readonly property int blurRadius: 14
        readonly property real opacity: 0.24
    }

    readonly property QtObject level5: QtObject {
        readonly property int z: 5
        readonly property int verticalOffset: 8
        readonly property int blurRadius: 20
        readonly property real opacity: 0.28
    }

    readonly property QtObject floating: level3
    readonly property QtObject modal: level5
}
