pragma Singleton

import Quickshell

Singleton {
    readonly property string applicationName: "Apollo Shell"
    readonly property string applicationId: "io.github.maylton.apollo-shell"
    readonly property string version: "0.1.0-alpha.3"
    readonly property string projectUrl: "https://github.com/maylton/apollo-shell"

    readonly property int minimumQuickshellMajor: 0
    readonly property int minimumQuickshellMinor: 3

    readonly property int bootstrapWidth: 900
    readonly property int bootstrapHeight: 720
    readonly property int bootstrapMargin: 24
    readonly property int bootstrapRadius: 36

    readonly property string shellCategory: "SHELL"
    readonly property string themeCategory: "THEME"
    readonly property string componentsCategory: "COMPONENTS"
    readonly property string appsCategory: "APPS"
    readonly property string hyprlandCategory: "HYPRLAND"
    readonly property string audioCategory: "AUDIO"
}
