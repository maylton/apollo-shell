import QtQuick
import "../../theme" as Tokens

Item {
    id: root

    property color rippleColor: Tokens.Theme.colors.statePressed
    property real originX: width / 2
    property real originY: height / 2

    clip: true

    function trigger(x, y) {
        originX = x === undefined ? width / 2 : x
        originY = y === undefined ? height / 2 : y
        rippleAnimation.restart()
    }

    Rectangle {
        id: circle

        width: Math.max(root.width, root.height) * 2
        height: width
        radius: width / 2
        x: root.originX - width / 2
        y: root.originY - height / 2
        color: root.rippleColor
        opacity: 0
        scale: 0
    }

    ParallelAnimation {
        id: rippleAnimation

        NumberAnimation {
            target: circle
            property: "scale"
            from: 0
            to: 1
            duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.normal)
            easing.type: Tokens.Theme.motion.decelerateCurve
        }

        SequentialAnimation {
            NumberAnimation {
                target: circle
                property: "opacity"
                from: 0.28
                to: 0.18
                duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
            }

            NumberAnimation {
                target: circle
                property: "opacity"
                from: 0.18
                to: 0
                duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
            }
        }
    }
}
