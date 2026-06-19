import QtQuick 2.9
import CrowbarCollective 1.0

RouteView { id: saveBeforeQuitView

    Alert { id: alert
        skrim: false
        titleText: L10n.strings.headers.saveBeforeQuit
        messageText: L10n.strings.modalMessages.saveBeforeQuit
        buttons: VisualItemModel { id: buttons

            CTAButton {
                objectName: "ui--navigation:button:level_3"
                text: L10n.strings.buttons.cancel
                callback: function() {
                    saveBeforeQuitView.routeRequest(Routes.back.name);
                }
                onClicked: {
                    saveBeforeQuitView.routeRequest(Routes.back.name);
                }
            }

            CTAButton {
                objectName: "ui--navigation:button:level_3"
                text: L10n.strings.buttons.dontSave
                callback: function() {
                    BlackMesaEngine.executeClientCommandUnrestricted("quit");
                }
                onClicked: {
                    BlackMesaEngine.executeClientCommandUnrestricted("quit");
                }
            }

            DefaultButton  {
                objectName: "ui--navigation:button:level_3"
                text: L10n.strings.buttons.save
                callback: function() {
                    saveBeforeQuitView.saveGameRequest(null);
                    BlackMesaEngine.executeClientCommandUnrestricted("quit");
                }
                onClicked: {
                    saveBeforeQuitView.saveGameRequest(null);
                    BlackMesaEngine.executeClientCommandUnrestricted("quit");
                }
            }

        }

        Component.onCompleted: {
            alert.show();
        }
    }
}
