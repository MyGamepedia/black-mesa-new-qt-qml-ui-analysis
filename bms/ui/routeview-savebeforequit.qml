import QtQuick 2.9
import CrowbarCollective 1.0

RouteView { id: saveBeforeQuitView

    Alert { id: alert
        skrim: false
        titleText: L10n.strings.headers.saveBeforeQuit
        messageText: L10n.strings.modalMessages.saveBeforeQuit
        buttons: VisualItemModel { id: buttons

            CTAButton {
                objectName: "ui:btn:action[cancel]"
                text: L10n.strings.buttons.cancel
                onClicked: {
                    saveBeforeQuitView.routeRequest(Routes.back.name);
                }
            }

            CTAButton {
                objectName: "ui:btn:action[discard]"
                text: L10n.strings.buttons.dontSave
                onClicked: {
                    BlackMesaEngine.executeClientCommandUnrestricted("quit");
                }
            }

            DefaultButton  {
                objectName: "ui:btn:action[apply]"
                text: L10n.strings.buttons.save
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
