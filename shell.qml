//@ pragma ShellId apollo-shell
//@ pragma AppId io.github.maylton.apollo-shell

import QtQuick
import Quickshell
import "core" as Core
import "modules/bootstrap" as Bootstrap

ShellRoot {
    id: root

    Component.onCompleted: Core.Apollo.initialize()

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
