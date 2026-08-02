import QtQuick
import "../../theme" as Tokens

Item {
    id: root

    property real value: 0
    property bool indeterminate: false
    property color trackColor: Tokens.Theme.colors.surfaceContainerHighest
    property color indicatorColor: Tokens.Theme.colors.primary

    readonly property real normalizedValue: Math.max(0, Math.min(1, value))

    implicitWidth: Tokens.Theme.scaled(160)
    implicitHeight: Tokens.Theme.scaled(8)
    clip: true

    Rectangle {
        anchors.fill: parent
        radius: Tokens.Theme.scaled(Tokens.Theme.shapes.pill)
        color: root.trackColor
    }

    Rectangle {
        id: indicator

        width: root.indeterminate
            ? root.width * 0.35
            : root.width * root.normalizedValue
        height: root.height
        x: root.indeterminate ? -width : 0
        radius: Tokens.Theme.scaled(Tokens.Theme.shapes.pill)
        color: root.indicatorColor

        Behavior on width {
            enabled: !root.indeterminate

            NumberAnimation {
                duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.normal)
                easing.type: Tokens.Theme.motion.standardCurve
            }
        }

        SequentialAnimation on x {
            running: root.indeterminate && root.visible && Tokens.Theme.animationsEnabled
            loops: Animation.Infinite

            NumberAnimation {
                from: -indicator.width
                to: root.width
                duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.extraLong * 2)
                easing.type: Tokens.Theme.motion.standardCurve
            }
        }
    }
}
