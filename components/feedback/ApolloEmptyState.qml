import QtQuick
import QtQuick.Layouts
import "../../theme" as Tokens
import "../buttons" as Buttons

ColumnLayout {
    id: root

    signal actionTriggered

    property string iconText: "?"
    property string title: "Nothing here yet"
    property string description: "Content will appear here when it becomes available."
    property string actionText: ""

    spacing: Tokens.Theme.scaled(Tokens.Theme.spacing.medium)

    Rectangle {
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: Tokens.Theme.scaled(64)
        Layout.preferredHeight: Tokens.Theme.scaled(64)
        radius: Tokens.Theme.scaled(Tokens.Theme.shapes.extraLarge)
        color: Tokens.Theme.colors.secondaryContainer

        Text {
            anchors.centerIn: parent
            text: root.iconText
            color: Tokens.Theme.colors.onSecondaryContainer
            font.family: Tokens.Theme.typography.headlineMedium.family
            font.pixelSize: Tokens.Theme.scaled(28)
            font.weight: Font.Medium
        }
    }

    Text {
        Layout.fillWidth: true
        text: root.title
        horizontalAlignment: Text.AlignHCenter
        color: Tokens.Theme.colors.onSurface
        font.family: Tokens.Theme.typography.titleMedium.family
        font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.titleMedium.pixelSize)
        font.weight: Tokens.Theme.typography.titleMedium.weight
        wrapMode: Text.WordWrap
    }

    Text {
        Layout.fillWidth: true
        text: root.description
        horizontalAlignment: Text.AlignHCenter
        color: Tokens.Theme.colors.onSurfaceVariant
        font.family: Tokens.Theme.typography.bodySmall.family
        font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.bodySmall.pixelSize)
        font.weight: Tokens.Theme.typography.bodySmall.weight
        wrapMode: Text.WordWrap
    }

    Buttons.ApolloPillButton {
        Layout.alignment: Qt.AlignHCenter
        visible: root.actionText.length > 0
        text: root.actionText
        iconText: "+"
        onClicked: root.actionTriggered()
    }
}
