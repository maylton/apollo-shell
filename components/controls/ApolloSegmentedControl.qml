import QtQuick
import "../../theme" as Tokens

Item {
    id: root

    signal activated(int index, string label)

    property var model: []
    property int currentIndex: 0

    readonly property int segmentCount: model ? model.length : 0

    implicitWidth: Tokens.Theme.scaled(260)
    implicitHeight: Tokens.Theme.scaled(48)

    Rectangle {
        anchors.fill: parent
        radius: Tokens.Theme.scaled(Tokens.Theme.shapes.pill)
        color: Tokens.Theme.colors.surfaceContainerHighest
        border.width: 1
        border.color: Tokens.Theme.colors.outlineVariant
    }

    Row {
        anchors.fill: parent
        anchors.margins: Tokens.Theme.scaled(4)
        spacing: Tokens.Theme.scaled(4)

        Repeater {
            model: root.model

            delegate: Rectangle {
                id: segment

                required property int index
                required property var modelData

                width: root.segmentCount > 0
                    ? (parent.width - parent.spacing * (root.segmentCount - 1)) / root.segmentCount
                    : 0
                height: parent.height
                radius: Tokens.Theme.scaled(Tokens.Theme.shapes.pill)
                color: root.currentIndex === index
                    ? Tokens.Theme.colors.secondaryContainer
                    : pointer.containsMouse
                        ? Tokens.Theme.colors.stateHover
                        : "transparent"

                Behavior on color {
                    ColorAnimation {
                        duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
                    }
                }

                Text {
                    anchors.centerIn: parent
                    width: parent.width - Tokens.Theme.scaled(Tokens.Theme.spacing.medium * 2)
                    text: String(segment.modelData)
                    horizontalAlignment: Text.AlignHCenter
                    color: root.currentIndex === segment.index
                        ? Tokens.Theme.colors.onSecondaryContainer
                        : Tokens.Theme.colors.onSurfaceVariant
                    font.family: Tokens.Theme.typography.labelMedium.family
                    font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.labelMedium.pixelSize)
                    font.weight: Tokens.Theme.typography.labelMedium.weight
                    elide: Text.ElideRight
                }

                MouseArea {
                    id: pointer

                    anchors.fill: parent
                    enabled: root.enabled
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        root.currentIndex = segment.index
                        root.activated(segment.index, String(segment.modelData))
                    }
                }
            }
        }
    }
}
