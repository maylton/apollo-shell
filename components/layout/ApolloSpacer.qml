import QtQuick
import QtQuick.Layouts

Item {
    property bool fillHorizontal: true
    property bool fillVertical: false

    Layout.fillWidth: fillHorizontal
    Layout.fillHeight: fillVertical
    implicitWidth: 0
    implicitHeight: 0
}
