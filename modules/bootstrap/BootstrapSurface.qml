import QtQuick
import Quickshell
import "../../config" as AppConfig
import "../../core" as Core
import "../../theme" as Tokens

PanelWindow {
    id: root

    readonly property real scaleFactor: Tokens.Theme.scale
    readonly property string monitorName: screen ? screen.name : "unknown"
    readonly property var palette: Tokens.Theme.colors

    Component.onCompleted: Core.Logger.info(Core.Constants.shellCategory, "Theme preview surface created", {
        screen: monitorName,
        scale: scaleFactor,
        theme: Tokens.Theme.modeName
    })

    Component.onDestruction: Core.Logger.debug(Core.Constants.shellCategory, "Theme preview surface destroyed", {
        screen: monitorName
    })

    anchors {
        top: true
        left: true
    }

    margins {
        top: Tokens.Theme.scaled(Core.Constants.bootstrapMargin)
        left: Tokens.Theme.scaled(Core.Constants.bootstrapMargin)
    }

    implicitWidth: Tokens.Theme.scaled(Core.Constants.bootstrapWidth)
    implicitHeight: Tokens.Theme.scaled(Core.Constants.bootstrapHeight)
    exclusiveZone: 0
    aboveWindows: true
    focusable: false
    visible: AppConfig.Config.showBootstrapSurface
    color: "transparent"
    surfaceFormat.opaque: false

    Rectangle {
        anchors.fill: parent
        radius: Tokens.Theme.scaled(Tokens.Theme.shapes.extraLarge)
        color: root.palette.glassSurfaceStrong
        border.width: 1
        border.color: root.palette.outlineVariant

        Behavior on color {
            ColorAnimation {
                duration: Tokens.Theme.animationDuration(Tokens.Theme.motion.normal)
                easing.type: Tokens.Theme.motion.standardCurve
            }
        }

        ThemePreview {
            anchors.fill: parent
            anchors.margins: Tokens.Theme.scaled(Tokens.Theme.spacing.xLarge)
            monitorName: root.monitorName
        }
    }
}
