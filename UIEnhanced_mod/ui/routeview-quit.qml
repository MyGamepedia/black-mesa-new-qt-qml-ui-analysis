import QtQuick 2.9
import CrowbarCollective 1.0

RouteView { id: quitView
    property variant quotes: (function () {
        return Object.keys(L10n.strings.quit).map(function (key) {
            return L10n.strings.quit[key];
        });
    }())

    Alert { id: alert
        skrim: false
        titleText: L10n.strings.headers.quit
        messageText: quotes[Math.floor(Math.random() * quotes.length)]
        buttons: VisualItemModel { id: buttons
            CTAButton {
                objectName: "ui:btn:action[apply]"
                text: L10n.strings.buttons.quit
                onClicked: {
                    BlackMesaEngine.executeClientCommandUnrestricted("quit");
                }
            }

            DefaultButton {
                objectName: "ui:btn:action[cancel]"
                text: L10n.strings.buttons.cancel
                onClicked: {
                    quitView.routeRequest(Routes.back.name);
                }
            }
        }

        Component.onCompleted: {
            alert.show();
        }
    }
}
