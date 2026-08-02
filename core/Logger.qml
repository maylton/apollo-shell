pragma Singleton

import Quickshell
import "../config" as AppConfig

Singleton {
    id: root

    readonly property int debugLevel: 0
    readonly property int infoLevel: 1
    readonly property int warningLevel: 2
    readonly property int errorLevel: 3

    readonly property int minimumLevel: AppConfig.Config.debugLogging ? debugLevel : infoLevel

    signal entryWritten(string level, string category, string message)

    function normalizeCategory(category) {
        const value = String(category || "GENERAL").trim().toUpperCase()
        return value.length > 0 ? value : "GENERAL"
    }

    function levelName(level) {
        switch (level) {
        case debugLevel:
            return "DEBUG"
        case warningLevel:
            return "WARN"
        case errorLevel:
            return "ERROR"
        default:
            return "INFO"
        }
    }

    function serializeContext(context) {
        if (context === undefined || context === null)
            return ""

        try {
            return " " + JSON.stringify(context)
        } catch (serializationError) {
            return " " + String(context)
        }
    }

    function write(level, category, message, context) {
        if (level < minimumLevel)
            return

        const normalizedCategory = normalizeCategory(category)
        const normalizedMessage = String(message)
        const normalizedLevel = levelName(level)
        const output = "[APOLLO][" + normalizedCategory + "][" + normalizedLevel + "] "
            + normalizedMessage + serializeContext(context)

        if (level >= errorLevel)
            console.error(output)
        else if (level >= warningLevel)
            console.warn(output)
        else
            console.log(output)

        entryWritten(normalizedLevel, normalizedCategory, normalizedMessage)
    }

    function debug(category, message, context) {
        write(debugLevel, category, message, context)
    }

    function info(category, message, context) {
        write(infoLevel, category, message, context)
    }

    function warning(category, message, context) {
        write(warningLevel, category, message, context)
    }

    function error(category, message, context) {
        write(errorLevel, category, message, context)
    }
}
