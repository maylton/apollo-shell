import QtQuick
import QtQuick.Layouts
import "../../theme" as Tokens

ColumnLayout {
    id: root

    default property alias contentData: sectionContent.data
    readonly property alias contentItem: sectionContent

    property string title: ""
    property string subtitle: ""
    property bool headerVisible: title.length > 0 || subtitle.length > 0

    spacing: Tokens.Theme.scaled(Tokens.Theme.spacing.medium)

    ColumnLayout {
        Layout.fillWidth: true
        visible: root.headerVisible
        spacing: Tokens.Theme.scaled(Tokens.Theme.spacing.xxxSmall)

        Text {
            Layout.fillWidth: true
            visible: root.title.length > 0
            text: root.title
            color: Tokens.Theme.colors.onSurface
            font.family: Tokens.Theme.typography.titleMedium.family
            font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.titleMedium.pixelSize)
            font.weight: Tokens.Theme.typography.titleMedium.weight
            elide: Text.ElideRight
        }

        Text {
            Layout.fillWidth: true
            visible: root.subtitle.length > 0
            text: root.subtitle
            color: Tokens.Theme.colors.onSurfaceVariant
            font.family: Tokens.Theme.typography.bodySmall.family
            font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.bodySmall.pixelSize)
            font.weight: Tokens.Theme.typography.bodySmall.weight
            wrapMode: Text.WordWrap
        }
    }

    ColumnLayout {
        id: sectionContent

        Layout.fillWidth: true
        spacing: Tokens.Theme.scaled(Tokens.Theme.spacing.itemGap)
    }
}
