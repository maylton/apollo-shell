import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
    id: root

    readonly property string monitorName: screen ? screen.name : "unknown"

    anchors {
        top: true
        left: true
    }

    margins {
        top: 24
        left: 24
    }

    implicitWidth: 328
    implicitHeight: 96
    exclusiveZone: 0
    aboveWindows: true
    focusable: false
    color: "transparent"
    surfaceFormat.opaque: false

    Rectangle {
        anchors.fill: parent
        radius: 28
        color: "#F4EFFA"
        border.width: 1
        border.color: "#DDD3E8"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 18
            spacing: 4

            Text {
                Layout.fillWidth: true
                text: "Apollo Shell"
                color: "#2A1730"
                font.pixelSize: 20
                font.weight: Font.DemiBold
            }

            Text {
                Layout.fillWidth: true
                text: "Foundation preview • " + root.monitorName
                color: "#6B5A70"
                font.pixelSize: 13
                elide: Text.ElideRight
            }
        }
    }
}
