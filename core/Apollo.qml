pragma Singleton

import Quickshell
import "../config" as AppConfig

Singleton {
    id: root

    readonly property string name: Constants.applicationName
    readonly property string applicationId: Constants.applicationId
    readonly property string version: Constants.version
    readonly property string displayName: name + " " + version
    readonly property var config: AppConfig.Config
    readonly property var paths: Paths
    readonly property int screenCount: Quickshell.screens.length

    property bool initialized: false
    property date startedAt

    function initialize() {
        if (initialized) {
            Logger.debug(Constants.shellCategory, "Initialization request ignored; runtime already initialized")
            return
        }

        Quickshell.watchFiles = AppConfig.Config.hotReloadEnabled
        startedAt = new Date()
        initialized = true

        Logger.info(Constants.shellCategory, "Apollo Shell runtime initialized", {
            version: version,
            screens: screenCount,
            shellRoot: Paths.shellRoot,
            hotReload: Quickshell.watchFiles,
            debug: AppConfig.Config.debugLogging
        })
    }
}
