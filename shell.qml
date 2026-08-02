//@ pragma ShellId apollo-shell
//@ pragma AppId io.github.maylton.apollo-shell

import QtQuick
import Quickshell
import "modules/bootstrap" as Bootstrap

ShellRoot {
    id: root

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
