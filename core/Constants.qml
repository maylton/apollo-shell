pragma Singleton

import Quickshell

Singleton {
    readonly property string applicationName: "Apollo Shell"
    readonly property string applicationId: "io.github.maylton.apollo-shell"
    readonly property string version: "0.1.0-alpha.2"
    readonly property string projectUrl: "https://github.com/maylton/apollo-shell"

    readonly property int minimumQuickshellMajor: 0
    readonly property int minimumQuickshellMinor: 3

    readonly property int bootstrapWidth: 420
    readonly property int bootstrapHeight: 316
    readonly property int bootstrapMargin: 24
    readonly property int bootstrapRadius: 28

    readonly property string shellCategory: "SHELL"
    readonly property string themeCategory: "THEME"
    readonly property string appsCategory: "APPS"
    readonly property string hyprlandCategory: "HYPRLAND"
    readonly property string audioCategory: "AUDIO"
}
