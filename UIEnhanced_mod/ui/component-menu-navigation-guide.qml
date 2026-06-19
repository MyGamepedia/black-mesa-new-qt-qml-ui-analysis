import QtQuick 2.9
import QtQuick.Layouts 1.1
import CrowbarCollective 1.0

Item {
    id: controllerGuideNotification

    property int containerWidth: Math.ceil(1024 * Theme.widthScale)
    property int fontSize: Math.ceil(18 * Theme.heightScale)
    property int isControllerUsed: 0;

    width: containerWidth
    height: parent.height

    Connections {
        target: BlackMesaEngine
        onNavigationSourceChanged: function(type) {
            isControllerUsed = type;
        }
    }

    GridLayout {
        anchors.fill: parent
        rowSpacing: Math.ceil(32 * Theme.heightScale);

        Column {
            Row {
                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    source: isControllerUsed ? "image://game/ui/images/navigation/lb-white.png" : "image://game/ui/images/navigation/a-key.png"
                    width: Math.ceil(54 * Theme.widthScale)
                    fillMode: Image.PreserveAspectFit
                }
                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    source: isControllerUsed ? "image://game/ui/images/navigation/rb-white.png" : "image://game/ui/images/navigation/d-key.png"
                    width: Math.ceil(54 * Theme.widthScale)
                    fillMode: Image.PreserveAspectFit
                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: Math.ceil(20 * Theme.widthScale)
                    text: L10n.strings.navigation.change_tabs
                    font.pixelSize: fontSize
                    font.family: Theme.fonts.regular
                    color: Theme.colors.text
                    font.capitalization: Font.AllUppercase
                }
            }
        }
        Column {
            Row {
                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    source: isControllerUsed ? "image://game/ui/images/navigation/controller-arrows.png" : "image://game/ui/images/navigation/keyboard-arrows.png"
                    width: Math.ceil(54 * Theme.widthScale)
                    fillMode: Image.PreserveAspectFit
                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: Math.ceil(18 * Theme.widthScale)
                    text: L10n.strings.navigation.options
                    font.pixelSize: fontSize
                    font.family: Theme.fonts.regular
                    color: Theme.colors.text
                    font.capitalization: Font.AllUppercase
                }
            }
        }
        Column {
            Row {
                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    source: isControllerUsed ? "image://game/ui/images/navigation/b-color.png" : "image://game/ui/images/navigation/backspace.png"
                    width: Math.ceil(42 * Theme.widthScale)
                    fillMode: Image.PreserveAspectFit
                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: Math.ceil(20 * Theme.widthScale)
                    text: L10n.strings.navigation.discard
                    font.pixelSize: fontSize
                    font.family: Theme.fonts.regular
                    color: Theme.colors.text
                    font.capitalization: Font.AllUppercase
                }
            }
        }
        Column {
            Row {
                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    source: isControllerUsed ? "image://game/ui/images/navigation/a-color.png" : "image://game/ui/images/navigation/enter-key.png"
                    width: Math.ceil(42 * Theme.widthScale)
                    fillMode: Image.PreserveAspectFit
                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: Math.ceil(20 * Theme.widthScale)
                    text: L10n.strings.navigation.select
                    font.pixelSize: fontSize
                    font.family: Theme.fonts.regular
                    color: Theme.colors.text
                    font.capitalization: Font.AllUppercase
                }
            }
        }
    }
}