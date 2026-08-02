import QtQuick
import "../../theme" as Tokens

Rectangle {
    id: root

    default property alias contentData: contentItem.data
    readonly property alias contentItem: contentItem

    property color surfaceColor: Tokens.Theme.colors.surfaceContainer
    property color outlineColor: Tokens.Theme.colors.outlineVariant
    property real cornerRadius: Tokens.Theme.scaled(Tokens.Theme.shapes.large)
    property real contentPadding: Tokens.Theme.scaled(Tokens.Theme.spacing.large)
    property bool outlined: true
    property bool animateColors: true

    implicitWidth: Math.max(
        Tokens.Theme.scaled(48),
        contentItem.implicitWidth + contentPadding * 2
    )
    implicitHeight: Math.max(
        Tokens.Theme.scaled(48),
        contentItem.implicitHeight + contentPadding * 2
    )

    radius: cornerRadius
    color: surfaceColor
    border.width: outlined ? 1 : 0
    border.color: outlineColor
    clip: true

    Behavior on color {
        enabled: root.animateColors

        ColorAnimation {
            duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.normal)
            easing.type: Tokens.Theme.motion.standardCurve
        }
    }

    Item {
        id: contentItem

        anchors.fill: parent
        anchors.margins: root.contentPadding
    }
}
