import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../config" as AppConfig
import "../../core" as Core

PanelWindow {
    id: root

    readonly property real scaleFactor: AppConfig.Config.effectiveScale
    readonly property string monitorName: screen ? screen.name : "unknown"
    readonly property color surfaceColor: AppConfig.Config.darkMode ? "#2A152E" : "#F4EFFA"
    readonly property color outlineColor: AppConfig.Config.darkMode ? "#5A3C60" : "#DDD3E8"
    readonly property color primaryTextColor: AppConfig.Config.darkMode ? "#F8EFFF" : "#2A1730"
    readonly property color secondaryTextColor: AppConfig.Config.darkMode ? "#D6C2DB" : "#6B5A70"

    anchors {
        top: true
        left: true
    }

    margins {
        top: Math.round(Core.Constants.bootstrapMargin * root.scaleFactor)
        left: Math.round(Core.Constants.bootstrapMargin * root.scaleFactor)
    }

    implicitWidth: Math.round(Core.Constants.bootstrapWidth * root.scaleFactor)
    implicitHeight: Math.round(Core.Constants.bootstrapHeight * root.scaleFactor)
    exclusiveZone: 0
    aboveWindows: true
    focusable: false
    visible: AppConfig.Config.showBootstrapSurface
    color: "transparent"
    surfaceFormat.opaque: false

    Rectangle {
        anchors.fill: parent
        radius: Math.round(Core.Constants.bootstrapRadius * root.scaleFactor)
        color: root.surfaceColor
        border.width: 1
        border.color: root.outlineColor

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Math.round(18 * root.scaleFactor)
            spacing: Math.round(4 * root.scaleFactor)

            Text {
                Layout.fillWidth: true
                text: Core.Apollo.displayName
                color: root.primaryTextColor
                font.pixelSize: Math.round(20 * root.scaleFactor)
                font.weight: Font.DemiBold
                elide: Text.ElideRight
            }

            Text {
                Layout.fillWidth: true
                text: "Foundation preview • " + root.monitorName
                color: root.secondaryTextColor
                font.pixelSize: Math.round(13 * root.scaleFactor)
                elide: Text.ElideRight
            }
        }
    }
}
