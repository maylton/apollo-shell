import QtQuick
import Quickshell
import "../../config" as AppConfig
import "../../core" as Core
import "../../theme" as Tokens
import "../../components/surfaces" as Surfaces

PanelWindow {
    id: root

    readonly property real scaleFactor: Tokens.Theme.scale
    readonly property string monitorName: screen ? screen.name : "unknown"

    Component.onCompleted: Core.Logger.info(Core.Constants.componentsCategory, "Component gallery surface created", {
        screen: monitorName,
        scale: scaleFactor,
        theme: Tokens.Theme.modeName
    })

    Component.onDestruction: Core.Logger.debug(Core.Constants.componentsCategory, "Component gallery surface destroyed", {
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

    Surfaces.ApolloPanel {
        anchors.fill: parent
        contentPadding: Tokens.Theme.scaled(Tokens.Theme.spacing.xLarge)

        ThemePreview {
            anchors.fill: parent
            monitorName: root.monitorName
        }
    }
}
