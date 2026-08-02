import QtQuick
import "../../theme" as Tokens

Rectangle {
    id: root

    signal dismissed()

    property bool active: false
    property bool closeOnClick: true

    visible: opacity > 0.01
    opacity: active ? 1 : 0
    color: Tokens.Theme.colors.scrim

    Behavior on opacity {
        NumberAnimation {
            duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
            easing.type: Tokens.Theme.motion.standardCurve
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: root.active

        onClicked: {
            if (root.closeOnClick)
                root.dismissed()
        }
    }
}
