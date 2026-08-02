import QtQuick
import "../../theme" as Tokens

ApolloSurface {
    id: root

    property bool open: false
    property real closedScale: 0.94

    visible: opacity > 0.01
    opacity: open ? 1 : 0
    scale: open ? 1 : closedScale
    surfaceColor: Tokens.Theme.colors.surfaceContainerHighest
    outlineColor: Tokens.Theme.colors.outline
    cornerRadius: Tokens.Theme.scaled(Tokens.Theme.shapes.extraLarge)

    Behavior on opacity {
        NumberAnimation {
            duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
            easing.type: Tokens.Theme.motion.standardCurve
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.normal)
            easing.type: Tokens.Theme.motion.emphasizedCurve
        }
    }
}
