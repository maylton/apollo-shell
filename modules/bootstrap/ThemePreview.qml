import QtQuick
import QtQuick.Layouts
import "../../core" as Core
import "../../theme" as Tokens
import "../../components/surfaces" as Surfaces
import "../../components/buttons" as Buttons
import "../../components/controls" as Controls
import "../../components/layout" as ApolloLayout
import "../../components/feedback" as Feedback

Item {
    id: root

    property string monitorName: "unknown"
    property bool popupOpen: true
    property bool tooltipShown: true
    property real sliderValue: 0.62
    property int segmentIndex: 1

    Flickable {
        id: viewport

        anchors.fill: parent
        clip: true
        contentWidth: width
        contentHeight: gallery.implicitHeight
        boundsBehavior: Flickable.StopAtBounds

        ApolloLayout.ApolloColumn {
            id: gallery

            width: viewport.width
            spacing: Tokens.Theme.scaled(Tokens.Theme.spacing.xLarge)

            ApolloLayout.ApolloRow {
                Layout.fillWidth: true

                ApolloLayout.ApolloColumn {
                    Layout.fillWidth: true
                    spacing: Tokens.Theme.scaled(Tokens.Theme.spacing.xxxSmall)

                    Text {
                        Layout.fillWidth: true
                        text: Core.Apollo.displayName
                        color: Tokens.Theme.colors.onSurface
                        font.family: Tokens.Theme.typography.titleLarge.family
                        font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.titleLarge.pixelSize)
                        font.weight: Tokens.Theme.typography.titleLarge.weight
                        elide: Text.ElideRight
                    }

                    Text {
                        Layout.fillWidth: true
                        text: "Primitive components • " + root.monitorName
                        color: Tokens.Theme.colors.onSurfaceVariant
                        font.family: Tokens.Theme.typography.bodySmall.family
                        font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.bodySmall.pixelSize)
                        elide: Text.ElideRight
                    }
                }

                ApolloLayout.ApolloSpacer {}

                Buttons.ApolloPillButton {
                    text: Tokens.Theme.modeName
                    iconText: Tokens.Theme.dark ? "☾" : "☀"
                    checkable: true
                    checked: Tokens.Theme.dark
                    onClicked: Tokens.Theme.toggleDarkMode()
                }
            }

            ApolloLayout.ApolloSection {
                Layout.fillWidth: true
                title: "Surfaces"
                subtitle: "Shared containers replace repeated colors, borders, radii and padding."

                ApolloLayout.ApolloGrid {
                    Layout.fillWidth: true
                    columns: 3

                    Surfaces.ApolloSurface {
                        Layout.fillWidth: true
                        Layout.preferredHeight: Tokens.Theme.scaled(112)
                        surfaceColor: Tokens.Theme.colors.surfaceContainerLow

                        Text {
                            anchors.centerIn: parent
                            text: "Surface"
                            color: Tokens.Theme.colors.onSurface
                            font.family: Tokens.Theme.typography.labelLarge.family
                            font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.labelLarge.pixelSize)
                        }
                    }

                    Surfaces.ApolloCard {
                        Layout.fillWidth: true
                        Layout.preferredHeight: Tokens.Theme.scaled(112)

                        ApolloLayout.ApolloColumn {
                            anchors.centerIn: parent
                            spacing: Tokens.Theme.scaled(Tokens.Theme.spacing.xxSmall)

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: "Card"
                                color: Tokens.Theme.colors.onSurface
                                font.family: Tokens.Theme.typography.labelLarge.family
                                font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.labelLarge.pixelSize)
                            }

                            Feedback.ApolloLoadingIndicator {
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }

                    Surfaces.ApolloPopup {
                        Layout.fillWidth: true
                        Layout.preferredHeight: Tokens.Theme.scaled(112)
                        open: root.popupOpen

                        ApolloLayout.ApolloColumn {
                            anchors.centerIn: parent
                            spacing: Tokens.Theme.scaled(Tokens.Theme.spacing.xxSmall)

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: "Popup"
                                color: Tokens.Theme.colors.onSurface
                                font.family: Tokens.Theme.typography.labelLarge.family
                                font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.labelLarge.pixelSize)
                            }

                            Buttons.ApolloPillButton {
                                Layout.alignment: Qt.AlignHCenter
                                text: root.popupOpen ? "Hide" : "Show"
                                onClicked: root.popupOpen = !root.popupOpen
                            }
                        }
                    }

                    Surfaces.ApolloCard {
                        Layout.columnSpan: 3
                        Layout.fillWidth: true
                        Layout.preferredHeight: Tokens.Theme.scaled(84)
                        contentPadding: 0

                        Text {
                            anchors.centerIn: parent
                            z: 2
                            text: "Scrim preview"
                            color: Tokens.Theme.colors.inverseOnSurface
                            font.family: Tokens.Theme.typography.labelLarge.family
                            font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.labelLarge.pixelSize)
                        }

                        Surfaces.ApolloScrim {
                            anchors.fill: parent
                            active: true
                            closeOnClick: false
                            z: 1
                        }
                    }
                }
            }

            ApolloLayout.ApolloSection {
                Layout.fillWidth: true
                title: "Buttons"
                subtitle: "The same interaction states are shared by text, icon, pill and app buttons."

                ApolloLayout.ApolloRow {
                    Layout.fillWidth: true

                    Buttons.ApolloButton {
                        text: "Primary action"
                        iconText: "+"
                        selected: true
                    }

                    Buttons.ApolloPillButton {
                        text: "Tonal pill"
                        iconText: "◆"
                    }

                    Buttons.ApolloIconButton {
                        iconText: "⋮"
                    }

                    Buttons.ApolloAppButton {
                        name: "Apollo"
                        iconText: "A"
                        running: true
                        active: true
                    }

                    ApolloLayout.ApolloSpacer {}

                    Feedback.ApolloTooltip {
                        text: "Reusable tooltip"
                        shown: root.tooltipShown
                    }
                }
            }

            ApolloLayout.ApolloSection {
                Layout.fillWidth: true
                title: "Controls"
                subtitle: "Interactive values use one visual language and react to the global theme."

                Surfaces.ApolloCard {
                    Layout.fillWidth: true

                    ApolloLayout.ApolloColumn {
                        anchors.fill: parent

                        ApolloLayout.ApolloRow {
                            Layout.fillWidth: true

                            Text {
                                text: "Wi-Fi"
                                color: Tokens.Theme.colors.onSurface
                                font.family: Tokens.Theme.typography.titleMedium.family
                                font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.titleMedium.pixelSize)
                            }

                            ApolloLayout.ApolloSpacer {}

                            Controls.ApolloToggle {
                                checked: true
                            }
                        }

                        Controls.ApolloSlider {
                            Layout.fillWidth: true
                            value: root.sliderValue
                            onMoved: nextValue => root.sliderValue = nextValue
                        }

                        Controls.ApolloProgress {
                            Layout.fillWidth: true
                            value: root.sliderValue
                        }

                        Controls.ApolloSegmentedControl {
                            Layout.fillWidth: true
                            model: ["Compact", "Standard", "Expanded"]
                            currentIndex: root.segmentIndex
                            onActivated: (index, label) => root.segmentIndex = index
                        }
                    }
                }
            }

            ApolloLayout.ApolloSection {
                Layout.fillWidth: true
                title: "Layout and feedback"
                subtitle: "Sections, grids, rows, columns, spacers and feedback states compose without custom spacing."

                ApolloLayout.ApolloGrid {
                    Layout.fillWidth: true
                    columns: 2

                    Surfaces.ApolloCard {
                        Layout.fillWidth: true
                        Layout.preferredHeight: Tokens.Theme.scaled(190)

                        ApolloLayout.ApolloGrid {
                            anchors.fill: parent
                            columns: 2

                            Repeater {
                                model: ["S", "M", "L", "XL"]

                                delegate: Surfaces.ApolloSurface {
                                    required property string modelData

                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    contentPadding: Tokens.Theme.scaled(Tokens.Theme.spacing.small)
                                    cornerRadius: Tokens.Theme.scaled(Tokens.Theme.shapes.medium)
                                    surfaceColor: Tokens.Theme.colors.secondaryContainer

                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData
                                        color: Tokens.Theme.colors.onSecondaryContainer
                                        font.family: Tokens.Theme.typography.labelLarge.family
                                        font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.labelLarge.pixelSize)
                                    }
                                }
                            }
                        }
                    }

                    Surfaces.ApolloCard {
                        Layout.fillWidth: true
                        Layout.preferredHeight: Tokens.Theme.scaled(190)

                        Feedback.ApolloEmptyState {
                            anchors.fill: parent
                            iconText: "☆"
                            title: "Component ready"
                            description: "This state can be reused by every future module."
                            actionText: "Action"
                        }
                    }

                    Surfaces.ApolloCard {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: Tokens.Theme.scaled(76)
                        contentPadding: 0

                        Text {
                            anchors.centerIn: parent
                            text: "Click for ripple feedback"
                            color: Tokens.Theme.colors.onSurface
                            font.family: Tokens.Theme.typography.labelLarge.family
                            font.pixelSize: Tokens.Theme.scaled(Tokens.Theme.typography.labelLarge.pixelSize)
                        }

                        Feedback.ApolloRipple {
                            id: ripple
                            anchors.fill: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onPressed: mouse => ripple.trigger(mouse.x, mouse.y)
                        }
                    }
                }
            }
        }
    }
}
