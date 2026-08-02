import QtQuick
import "../../theme" as Tokens

Rectangle {
    id: root

    property string text: ""
    property bool shown: false

    implicitWidth: label.implicitWidth + Tokens.Theme.scaled(Tokens.Theme.spacing.medium * 2)
    implicitHeight: label.implicitHeight + Tokens.Theme.scaled(Tokens.Theme.spacing.small * 2)
    visible: opacity > 0.01
    opacity: shown && text.length > 0 ? 1 : 0
    scale: shown ? 1 : 0.96
    radius: Tokens.Theme.scaled(Tokens.Theme.shapes.small)
    color: Tokens.Theme.colors.inverseSurface

    Behavior on opacity {
        NumberAnimation {
            duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
            easing.type: Tokens.Theme.motion.standardCurve
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
            easing.type: Tokens.Theme.motion.emphasizedCurve
        }
    }

    Text {
        id: label

        anchors.centerIn: parent
        text: root.text
        color: Tokens.Theme.colors.inverseOnSurface
        font.family: Tokens.Theme.typography.labelSmall.family
        font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.labelSmall.pixelSize)
        font.weight: Tokens.Theme.typography.labelSmall.weight
    }
}
