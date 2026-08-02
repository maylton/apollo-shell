import QtQuick
import "../../theme" as Tokens

Item {
    id: root

    property bool running: true
    property color indicatorColor: Tokens.Theme.colors.primary

    implicitWidth: Tokens.Theme.scaled(44)
    implicitHeight: Tokens.Theme.scaled(16)

    Row {
        anchors.centerIn: parent
        spacing: Tokens.Theme.scaled(Tokens.Theme.spacing.xxSmall)

        Repeater {
            model: 3

            delegate: Rectangle {
                id: dot

                required property int index

                width: Tokens.Theme.scaled(8)
                height: width
                radius: Tokens.Theme.scaled(Tokens.Theme.shapes.circle)
                color: root.indicatorColor
                opacity: root.running ? 0.4 : 1
                scale: 1

                SequentialAnimation {
                    running: root.running && root.visible && Tokens.Theme.animationsEnabled
                    loops: Animation.Infinite

                    PauseAnimation {
                        duration: dot.index * 100
                    }

                    ParallelAnimation {
                        NumberAnimation {
                            target: dot
                            property: "opacity"
                            from: 0.4
                            to: 1
                            duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
                        }

                        NumberAnimation {
                            target: dot
                            property: "scale"
                            from: 0.85
                            to: 1.2
                            duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
                        }
                    }

                    ParallelAnimation {
                        NumberAnimation {
                            target: dot
                            property: "opacity"
                            from: 1
                            to: 0.4
                            duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
                        }

                        NumberAnimation {
                            target: dot
                            property: "scale"
                            from: 1.2
                            to: 0.85
                            duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.short)
                        }
                    }

                    PauseAnimation {
                        duration: (2 - dot.index) * 100
                    }
                }
            }
        }
    }
}
