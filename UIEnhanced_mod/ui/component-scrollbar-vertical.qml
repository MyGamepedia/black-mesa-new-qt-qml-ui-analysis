import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

ScrollBar {
    visible: true
    policy: ScrollBar.AlwaysOn
    wheelEnabled: true
    stepSize: 0.02

    property int scrollbarDimension: Math.ceil(16 * Theme.widthScale)

    contentItem: Rectangle {
        implicitWidth: scrollbarDimension
        implicitHeight: scrollbarDimension

        color: Theme.colors.highlight
    }
}
