import QtQuick
import "../../theme" as Tokens

Item {
    id: root

    signal moved(real value)

    property real from: 0
    property real to: 1
    property real value: 0
    property real stepSize: 0

    readonly property real range: Math.max(0.000001, to - from)
    readonly property real normalizedValue: Math.max(0, Math.min(1, (value - from) / range))
    readonly property bool hovered: pointer.containsMouse
    readonly property bool pressed: pointer.pressed

    implicitWidth: Tokens.Theme.scaled(220)
    implicitHeight: Tokens.Theme.scaled(40)
    opacity: enabled ? 1 : 0.38

    function valueForPosition(position) {
        const usableWidth = Math.max(1, root.width - thumb.width)
        const normalized = Math.max(0, Math.min(1, (position - thumb.width / 2) / usableWidth))
        let nextValue = root.from + normalized * root.range

        if (root.stepSize > 0)
            nextValue = Math.round((nextValue - root.from) / root.stepSize) * root.stepSize + root.from

        return Math.max(root.from, Math.min(root.to, nextValue))
    }

    function updateFromPosition(position) {
        root.value = valueForPosition(position)
        root.moved(root.value)
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: thumb.width / 2
        anchors.rightMargin: thumb.width / 2
        height: Tokens.Theme.scaled(6)
        radius: Tokens.Theme.scaled(Tokens.Theme.shapes.pill)
        color: Tokens.Theme.colors.surfaceContainerHighest

        Rectangle {
            width: parent.width * root.normalizedValue
            height: parent.height
            radius: parent.radius
            color: Tokens.Theme.colors.primary

            Behavior on width {
                enabled: !root.pressed

                NumberAnimation {
                    duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
                    easing.type: Tokens.Theme.motion.standardCurve
                }
            }
        }
    }

    Rectangle {
        id: thumb

        width: Tokens.Theme.scaled(root.pressed ? 28 : 22)
        height: width
        radius: Tokens.Theme.scaled(Tokens.Theme.shapes.circle)
        x: root.normalizedValue * (root.width - width)
        anchors.verticalCenter: parent.verticalCenter
        color: Tokens.Theme.colors.primary
        border.width: Tokens.Theme.scaled(2)
        border.color: Tokens.Theme.colors.onPrimary

        Behavior on x {
            enabled: !root.pressed

            NumberAnimation {
                duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
                easing.type: Tokens.Theme.motion.standardCurve
            }
        }

        Behavior on width {
            NumberAnimation {
                duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.fast)
            }
        }
    }

    MouseArea {
        id: pointer

        anchors.fill: parent
        enabled: root.enabled
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onPressed: mouse => root.updateFromPosition(mouse.x)
        onPositionChanged: mouse => {
            if (pressed)
                root.updateFromPosition(mouse.x)
        }
    }
}
