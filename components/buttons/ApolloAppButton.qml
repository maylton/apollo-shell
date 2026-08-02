import QtQuick
import QtQuick.Layouts
import "../../theme" as Tokens

Item {
    id: root

    signal clicked()

    property string name: "Application"
    property string iconText: "A"
    property bool running: false
    property bool active: false
    property bool selected: false

    readonly property bool hovered: pointer.containsMouse
    readonly property bool pressed: pointer.pressed

    implicitWidth: Tokens.Theme.scaled(84)
    implicitHeight: Tokens.Theme.scaled(92)
    opacity: enabled ? 1 : 0.38

    ColumnLayout {
        anchors.fill: parent
        spacing: Tokens.Theme.scaled(Tokens.Theme.spacing.xSmall)

        Item {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: Tokens.Theme.scaled(58)
            Layout.preferredHeight: Tokens.Theme.scaled(58)

            Rectangle {
                anchors.fill: parent
                radius: Tokens.Theme.scaled(
                    root.selected
                        ? Tokens.Theme.shapes.large
                        : Tokens.Theme.shapes.circle
                )
                color: root.active || root.selected
                    ? Tokens.Theme.colors.primaryContainer
                    : Tokens.Theme.colors.surfaceContainerHighest
                scale: root.pressed ? 0.92 : root.hovered ? 1.04 : 1

                Behavior on radius {
                    NumberAnimation {
                        duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.normal)
                        easing.type: Tokens.Theme.motion.emphasizedCurve
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
                        easing.type: Tokens.Theme.motion.emphasizedCurve
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: root.iconText
                    color: root.active || root.selected
                        ? Tokens.Theme.colors.onPrimaryContainer
                        : Tokens.Theme.colors.onSurface
                    font.family: Tokens.Theme.typography.titleLarge.family
                    font.pixelSize: Tokens.Theme.scaled(22)
                    font.weight: Font.DemiBold
                }
            }

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: Tokens.Theme.scaled(-4)
                width: root.active
                    ? Tokens.Theme.scaled(18)
                    : Tokens.Theme.scaled(6)
                height: Tokens.Theme.scaled(4)
                radius: Tokens.Theme.scaled(Tokens.Theme.shapes.pill)
                color: root.running
                    ? Tokens.Theme.colors.activeIndicator
                    : "transparent"

                Behavior on width {
                    NumberAnimation {
                        duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.normal)
                        easing.type: Tokens.Theme.motion.emphasizedCurve
                    }
                }
            }
        }

        Text {
            Layout.fillWidth: true
            text: root.name
            horizontalAlignment: Text.AlignHCenter
            color: Tokens.Theme.colors.onSurface
            font.family: Tokens.Theme.typography.labelSmall.family
            font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.labelSmall.pixelSize)
            font.weight: Tokens.Theme.typography.labelSmall.weight
            elide: Text.ElideRight
        }
    }

    MouseArea {
        id: pointer

        anchors.fill: parent
        enabled: root.enabled
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
