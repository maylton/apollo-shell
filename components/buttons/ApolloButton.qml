import QtQuick
import QtQuick.Layouts
import "../../theme" as Tokens

Item {
    id: root

    signal clicked

    property string text: ""
    property string iconText: ""
    property bool checkable: false
    property bool checked: false
    property bool selected: false
    property color containerColor: Tokens.Theme.colors.surfaceContainerHighest
    property color activeContainerColor: Tokens.Theme.colors.primaryContainer
    property color contentColor: Tokens.Theme.colors.onSurface
    property color activeContentColor: Tokens.Theme.colors.onPrimaryContainer
    property real cornerRadius: Tokens.Theme.scaled(Tokens.Theme.shapes.large)
    property real horizontalPadding: Tokens.Theme.scaled(Tokens.Theme.spacing.large)
    property real verticalPadding: Tokens.Theme.scaled(Tokens.Theme.spacing.medium)
    property real contentSpacing: Tokens.Theme.scaled(Tokens.Theme.spacing.small)

    readonly property bool hovered: pointer.containsMouse
    readonly property bool pressed: pointer.pressed
    readonly property bool active: checked || selected

    implicitWidth: Math.max(
        Tokens.Theme.scaled(Tokens.Theme.spacing.minimumTouchTarget),
        contentRow.implicitWidth + horizontalPadding * 2
    )
    implicitHeight: Math.max(
        Tokens.Theme.scaled(Tokens.Theme.spacing.minimumTouchTarget),
        contentRow.implicitHeight + verticalPadding * 2
    )
    opacity: enabled ? 1 : 0.38

    Rectangle {
        anchors.fill: parent
        radius: root.cornerRadius
        color: root.active ? root.activeContainerColor : root.containerColor

        Behavior on color {
            ColorAnimation {
                duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
                easing.type: Tokens.Theme.motion.standardCurve
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: root.cornerRadius
        color: root.pressed
            ? Tokens.Theme.colors.statePressed
            : root.hovered
                ? Tokens.Theme.colors.stateHover
                : "transparent"

        Behavior on color {
            ColorAnimation {
                duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.fast)
            }
        }
    }

    RowLayout {
        id: contentRow

        anchors.centerIn: parent
        spacing: root.contentSpacing

        Text {
            visible: root.iconText.length > 0
            text: root.iconText
            color: root.active ? root.activeContentColor : root.contentColor
            font.family: Tokens.Theme.typography.titleMedium.family
            font.pixelSize: Tokens.Theme.scaled(18)
            font.weight: Font.Medium
        }

        Text {
            visible: root.text.length > 0
            text: root.text
            color: root.active ? root.activeContentColor : root.contentColor
            font.family: Tokens.Theme.typography.labelLarge.family
            font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.labelLarge.pixelSize)
            font.weight: Tokens.Theme.typography.labelLarge.weight
            font.letterSpacing: Tokens.Theme.typography.labelLarge.letterSpacing
            elide: Text.ElideRight
        }
    }

    MouseArea {
        id: pointer

        anchors.fill: parent
        enabled: root.enabled
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            if (root.checkable)
                root.checked = !root.checked
            root.clicked()
        }
    }
}
