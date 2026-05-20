import QtQuick 2.9
import CrowbarCollective 1.0

RouteView {
    Image {
        width: Math.ceil(609 * Theme.widthScale)
        height: Math.ceil(108 * Theme.widthScale)

        source: "image://game/ui/images/unavailable.png"

        anchors.centerIn: parent
    }
}
