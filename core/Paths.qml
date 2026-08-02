pragma Singleton

import Quickshell

Singleton {
    readonly property string shellRoot: Quickshell.shellDir
    readonly property string assetsRoot: shellPath("assets")
    readonly property string configRoot: shellPath("config")
    readonly property string stateRoot: Quickshell.stateDir
    readonly property string cacheRoot: Quickshell.cacheDir
    readonly property string dataRoot: Quickshell.dataDir

    function normalize(relativePath) {
        const value = String(relativePath ?? "")
        return value.startsWith("/") ? value.slice(1) : value
    }

    function shellPath(relativePath) {
        return Quickshell.shellPath(normalize(relativePath))
    }

    function statePath(relativePath) {
        return Quickshell.statePath(normalize(relativePath))
    }

    function cachePath(relativePath) {
        return Quickshell.cachePath(normalize(relativePath))
    }

    function dataPath(relativePath) {
        return Quickshell.dataPath(normalize(relativePath))
    }
}
