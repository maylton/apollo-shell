//@ pragma ShellId apollo-shell
//@ pragma AppId io.github.maylton.apollo-shell

import QtQuick
import Quickshell
import "core" as Core
import "modules/bootstrap" as Bootstrap

ShellRoot {
    id: root

    Component.onCompleted: Core.Apollo.initialize()

    Connections {
        target: Quickshell

        function onReloadCompleted() {
            Core.Logger.info(Core.Constants.shellCategory, "Quickshell reload completed")
        }

        function onReloadFailed(errorString) {
            Core.Logger.error(Core.Constants.shellCategory, "Quickshell reload failed", {
                error: errorString
            })
        }
    }

    Variants {
        model: Quickshell.screens

        delegate: Component {
            Bootstrap.BootstrapSurface {
                required property var modelData

                screen: modelData
            }
        }
    }
}
