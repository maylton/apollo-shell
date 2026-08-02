pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property bool loaded: defaultsFile.loaded
    readonly property bool debugEnvironment: {
        const rawValue = Quickshell.env("APOLLO_DEBUG")
        if (rawValue === null)
            return false

        const normalizedValue = String(rawValue).toLowerCase()
        return normalizedValue === "1"
            || normalizedValue === "true"
            || normalizedValue === "yes"
            || normalizedValue === "on"
    }

    property alias darkMode: defaults.darkMode
    property alias animationsEnabled: defaults.animationsEnabled
    property alias interfaceScale: defaults.interfaceScale
    property alias launcherShortcut: defaults.launcherShortcut
    property alias showBootstrapSurface: defaults.showBootstrapSurface
    property alias hotReloadEnabled: defaults.hotReloadEnabled
    property bool debugLogging: defaults.debugLogging || debugEnvironment

    readonly property real effectiveScale: Math.max(0.75, Math.min(interfaceScale, 2.0))

    FileView {
        id: defaultsFile

        path: Qt.resolvedUrl("defaults.json")
        blockLoading: true
        watchChanges: true
        printErrors: true

        onFileChanged: reload()

        adapter: JsonAdapter {
            id: defaults

            property bool darkMode: false
            property bool animationsEnabled: true
            property real interfaceScale: 1.0
            property string launcherShortcut: "SUPER"
            property bool showBootstrapSurface: true
            property bool debugLogging: false
            property bool hotReloadEnabled: true
        }
    }
}
