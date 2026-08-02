import QtQuick
import QtQuick.Layouts
import "../../core" as Core
import "../../theme" as Tokens

Item {
    id: root

    readonly property var palette: Tokens.Theme.colors
    readonly property var type: Tokens.Theme.typography
    readonly property var shapes: Tokens.Theme.shapes
    readonly property var spacing: Tokens.Theme.spacing
    readonly property real scaleFactor: Tokens.Theme.scale
    readonly property string monitorName: "unknown"

    ColumnLayout {
        anchors.fill: parent
        spacing: Tokens.Theme.scaled(root.spacing.medium)

        RowLayout {
            Layout.fillWidth: true
            spacing: Tokens.Theme.scaled(root.spacing.medium)

            ColumnLayout {
                Layout.fillWidth: true
                spacing: Tokens.Theme.scaled(root.spacing.xxxSmall)

                Text {
                    Layout.fillWidth: true
                    text: Core.Apollo.displayName
                    color: root.palette.onSurface
                    font.family: root.type.titleLarge.family
                    font.pixelSize: Tokens.Theme.scaled(root.type.titleLarge.pixelSize)
                    font.weight: root.type.titleLarge.weight
                    font.letterSpacing: root.type.titleLarge.letterSpacing
                    elide: Text.ElideRight
                }

                Text {
                    Layout.fillWidth: true
                    text: "Material 3 Expressive • " + root.monitorName
                    color: root.palette.onSurfaceVariant
                    font.family: root.type.bodySmall.family
                    font.pixelSize: Tokens.Theme.scaled(root.type.bodySmall.pixelSize)
                    font.weight: root.type.bodySmall.weight
                    font.letterSpacing: root.type.bodySmall.letterSpacing
                    elide: Text.ElideRight
                }
            }

            Rectangle {
                Layout.preferredHeight: Tokens.Theme.scaled(32)
                Layout.preferredWidth: modeLabel.implicitWidth + Tokens.Theme.scaled(root.spacing.large * 2)
                radius: root.shapes.pill
                color: root.palette.primaryContainer

                Text {
                    id: modeLabel

                    anchors.centerIn: parent
                    text: Tokens.Theme.modeName.toUpperCase()
                    color: root.palette.onPrimaryContainer
                    font.family: root.type.labelSmall.family
                    font.pixelSize: Tokens.Theme.scaled(root.type.labelSmall.pixelSize)
                    font.weight: Font.DemiBold
                    font.letterSpacing: 0.8
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: Tokens.Theme.scaled(root.spacing.small)

            Repeater {
                model: [
                    { label: "Primary", value: root.palette.primary },
                    { label: "Pink", value: root.palette.pink },
                    { label: "Peach", value: root.palette.peach },
                    { label: "Mint", value: root.palette.mint }
                ]

                delegate: ColumnLayout {
                    required property var modelData

                    Layout.fillWidth: true
                    spacing: Tokens.Theme.scaled(root.spacing.xxSmall)

                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: Tokens.Theme.scaled(52)
                        Layout.preferredHeight: Tokens.Theme.scaled(52)
                        radius: root.shapes.circle
                        color: modelData.value
                        border.width: 1
                        border.color: root.palette.outlineVariant
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: modelData.label
                        color: root.palette.onSurfaceVariant
                        font.family: root.type.labelSmall.family
                        font.pixelSize: Tokens.Theme.scaled(root.type.labelSmall.pixelSize)
                        font.weight: root.type.labelSmall.weight
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: Tokens.Theme.scaled(70)
            radius: root.shapes.large
            color: root.palette.surfaceContainerHigh

            RowLayout {
                anchors.fill: parent
                anchors.margins: Tokens.Theme.scaled(root.spacing.large)
                spacing: Tokens.Theme.scaled(root.spacing.large)

                Rectangle {
                    Layout.preferredWidth: Tokens.Theme.scaled(42)
                    Layout.preferredHeight: Tokens.Theme.scaled(42)
                    radius: root.shapes.medium
                    color: root.palette.secondaryContainer

                    Text {
                        anchors.centerIn: parent
                        text: "A"
                        color: root.palette.onSecondaryContainer
                        font.family: root.type.headlineMedium.family
                        font.pixelSize: Tokens.Theme.scaled(24)
                        font.weight: Font.Medium
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: Tokens.Theme.scaled(root.spacing.xxxSmall)

                    Text {
                        Layout.fillWidth: true
                        text: "Shared visual foundation"
                        color: root.palette.onSurface
                        font.family: root.type.titleMedium.family
                        font.pixelSize: Tokens.Theme.scaled(root.type.titleMedium.pixelSize)
                        font.weight: root.type.titleMedium.weight
                        elide: Text.ElideRight
                    }

                    Text {
                        Layout.fillWidth: true
                        text: "Colors, typography, shape, spacing, elevation and motion"
                        color: root.palette.onSurfaceVariant
                        font.family: root.type.bodySmall.family
                        font.pixelSize: Tokens.Theme.scaled(root.type.bodySmall.pixelSize)
                        font.weight: root.type.bodySmall.weight
                        elide: Text.ElideRight
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: Tokens.Theme.scaled(root.spacing.small)

            Repeater {
                model: [
                    root.spacing.minimumTouchTarget + " px touch",
                    root.shapes.extraLarge + " px radius",
                    Tokens.Theme.motion.normal + " ms motion"
                ]

                delegate: Rectangle {
                    required property string modelData

                    Layout.fillWidth: true
                    Layout.preferredHeight: Tokens.Theme.scaled(30)
                    radius: root.shapes.pill
                    color: root.palette.surfaceContainerHighest

                    Text {
                        anchors.centerIn: parent
                        text: modelData
                        color: root.palette.onSurfaceVariant
                        font.family: root.type.labelSmall.family
                        font.pixelSize: Tokens.Theme.scaled(root.type.labelSmall.pixelSize)
                        font.weight: root.type.labelSmall.weight
                    }
                }
            }
        }
    }
}
