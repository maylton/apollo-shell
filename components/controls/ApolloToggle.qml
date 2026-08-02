import QtQuick
import "../../theme" as Tokens

Item {
    id: root

    signal toggled(bool checked)

    property bool checked: false

    readonly property bool hovered: pointer.containsMouse
    readonly property bool pressed: pointer.pressed

    implicitWidth: Tokens.Theme.scaled(52)
    implicitHeight: Tokens.Theme.scaled(32)
    opacity: enabled ? 1 : 0.38

    Rectangle {
        anchors.fill: parent
        radius: Tokens.Theme.scaled(Tokens.Theme.shapes.pill)
        color: root.checked
            ? Tokens.Theme.colors.primary
            : Tokens.Theme.colors.surfaceContainerHighest
        border.width: root.checked ? 0 : 1
        border.color: Tokens.Theme.colors.outline

        Behavior on color {
            ColorAnimation {
                duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: Tokens.Theme.scaled(Tokens.Theme.shapes.pill)
        color: root.pressed
            ? Tokens.Theme.colors.statePressed
            : root.hovered
                ? Tokens.Theme.colors.stateHover
                : "transparent"
    }

    Rectangle {
        id: thumb

        width: Tokens.Theme.scaled(root.checked ? 24 : 16)
        height: width
        radius: Tokens.Theme.scaled(Tokens.Theme.shapes.circle)
        x: root.checked
            ? root.width - width - Tokens.Theme.scaled(4)
            : Tokens.Theme.scaled(8)
        anchors.verticalCenter: parent.verticalCenter
        color: root.checked
            ? Tokens.Theme.colors.onPrimary
            : Tokens.Theme.colors.outline

        Behavior on x {
            NumberAnimation {
                duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.normal)
                easing.type: Tokens.Theme.motion.emphasizedCurve
            }
        }

        Behavior on width {
            NumberAnimation {
                duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
            }
        }

        Behavior on color {
            ColorAnimation {
                duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
            }
        }
    }

    MouseArea {
        id: pointer

        anchors.fill: parent
        enabled: root.enabled
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            root.checked = !root.checked
            root.toggled(root.checked)
        }
    }
}
