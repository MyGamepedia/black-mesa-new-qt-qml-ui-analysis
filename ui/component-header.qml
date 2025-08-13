import QtQuick 2.9
import CrowbarCollective 1.0

Item { id: header
    height: parent.height
    width: parent.width

    signal routeRequest(string routeName)

    property Route currentRoute
    property bool hide: true
    property bool suppressAnimations: false
    property bool isInGame: false

    property int mainNavHeight: Math.ceil(64 * Theme.heightScale)
    property int mainNavBackgroundHeight: Math.ceil(64 * Theme.heightScale) // TODO: Hack!!! Logo image height is 63px should have 64px instead
    property int subNavHeight: Math.ceil(128 * Theme.heightScale)
    property int logoDimension: Math.ceil(40 * Theme.heightScale)
    property int headerMargin: Math.ceil(24 * Theme.widthScale)

    function checkButtonsActive() {
        if (!hide) {
            //show the "Load Game" menu button when there are saved games to load and if game is not multiplayer mode
            campaignNavModel.get(1).isEnabled = !!BlackMesaUtils.getSaveGames().length && !appRoot.isInMultiplayerMode;
            // show the "Save Game" menu button when in game and if game is not multiplayer mode
            campaignNavModel.get(2).isEnabled = isInGame && !appRoot.isInMultiplayerMode;
        }
    }

    onIsInGameChanged: function() {
        checkButtonsActive();
    }

    function setState() {
        if (hide) {
            state = "hidden"
        } else if (currentRoute) {
            if (currentRoute.alert) {
                state = "hidden"
            } else {
                state = currentRoute.path.indexOf('.') === -1 ? 'subnav-closed' : 'subnav-open';
            }
        }
    }

    onHideChanged: {
        checkButtonsActive();

        setState();
    }

    onCurrentRouteChanged: setState()

    state: "hidden"

    states: [
        State {
            name: "subnav-open"
            PropertyChanges { target: subNavContainer; y: 0 }
        },
        State {
            name: "subnav-closed"
            PropertyChanges { target: subNavContainer; y: -subNavContainer.height }
        },
        State {
            name: "hidden"
            PropertyChanges { target: subNavContainer; y: -subNavContainer.height }
            PropertyChanges { target: mainNavContainer; y: -mainNavContainer.height }
        }
    ]

    // --------------------------------
    // Main menu list model
    // --------------------------------
    ListModel { id: mainNavModel
        Component.onCompleted: {
            var labels = L10n.strings.menus;

            append({ label: labels.campaign, routeName: "campaign" });
            append({ label: labels.multiplayer, routeName: "multiplayer" });
            append({ label: labels.options, routeName: "options" });
            append({ label: labels.achievements, routeName: "achievements" });
            append({ label: labels.workshop, routeName: "steamworkshop" });
        }
    }

    // --------------------------------
    // Submenu list model
    // --------------------------------
    ListModel { id: campaignNavModel
        Component.onCompleted: {
            var labels = L10n.strings.menus;

            append({ label: labels.newgame, routeName: "newgame", isEnabled: true });
            append({ label: labels.loadgame, routeName: "loadgame", isEnabled: false });
            append({ label: labels.savegame, routeName: "savegame", isEnabled: false });
        }
    }

    ListModel { id: optionsNavModel
        Component.onCompleted: {
            var labels = L10n.strings.menus;

            append({ label: labels.game, routeName: "game", isEnabled: true });
            append({ label: labels.input, routeName: "input", isEnabled: true });
            append({ label: labels.bindings, routeName: "bindings", isEnabled: true });
            append({ label: labels.video, routeName: "video", isEnabled: true });
            append({ label: labels.audio, routeName: "audio", isEnabled: true });
            append({ label: labels.policy, routeName: "policy", isEnabled: true });
            append({ label: labels.translators, routeName: "translators", isEnabled: true })
        }
    }

    ListModel { id: multiplayerNavModel
        Component.onCompleted: {
            var labels = L10n.strings.menus;
            // this one is needed for correct host settings load
            BlackMesaEngine.executeClientCommandUnrestricted("exec server.cfg;");

            append({ label: labels.join, routeName: "join", isEnabled: true });
            append({ label: labels.host, routeName: "host", isEnabled: true });
        }
    }

    ListModel { id: workshopNavModel
        Component.onCompleted: {
            var labels = L10n.strings.menus;

            append({ label: labels.installed, routeName: "addons", isEnabled: true });
            append({ label: labels.browse, routeName: "browse", isEnabled: true });
        }
    }

    // --------------------------------
    Item { id: mainNavContainer
        width: parent.width
        height: mainNavHeight
        z: 2

        Image { id: backgroundImage
            source: "image://game/ui/images/nav-background.png"
            opacity: Theme.opacity.mainNav

            anchors.left: parent.left
            horizontalAlignment: Image.AlignLeft
            fillMode: Image.PreserveAspectFit
            width: parent.width
            height: mainNavBackgroundHeight
        }

        Item {
            anchors.fill: parent
            anchors.leftMargin: headerMargin

            Item { id: navLogo
                width: parent.height
                height: parent.height

                Image {
                    source: "image://game/ui/images/nav-logo.png"

                    height: logoDimension
                    width: logoDimension

                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                }
            }

            ListView { id: mainNavListView
                interactive: false
                orientation: Qt.Horizontal
                anchors.left: navLogo.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                model: mainNavModel

                delegate: MainNavButton {
                    readonly property string type: "main"
                    objectName: "ui:tab"
                    text: label
                    selected: currentRoute && currentRoute.path.split('.')[0] === routeName
                    onClicked: header.routeRequest(routeName)
                }
            }
        }
    }

    Item { id: subNavContainer
        width: parent.width
        height: subNavHeight
        y: 0
        x: 0
        z: 1

        Rectangle {
            anchors.fill: parent
            color: Theme.colors.subNavBackground
            opacity: Theme.opacity.subNav
        }

        ListView {
            interactive: false
            orientation: Qt.Horizontal
            anchors.left: parent.left
            anchors.leftMargin: headerMargin
            anchors.right: parent.right
            anchors.top: subNavContainer.verticalCenter
            model: {
                if (!currentRoute) {
                    return;
                }

                switch (currentRoute.path.split('.')[0]) {
                    case "campaign": return campaignNavModel;
                    case "multiplayer": return multiplayerNavModel;
                    case "options": return optionsNavModel;
                    case "steamworkshop": return workshopNavModel;
                    default: return null;
                }
            }

            delegate: LetterboxButton {
                readonly property string type: "sub"
                readonly property string actionRoute: routeName
                objectName: "ui:tab"
                disabled: !isEnabled
                text: label
                selected: currentRoute && currentRoute.path.split('.')[1] === routeName
                onClicked: header.routeRequest(routeName)
            }
        }
    }

    transitions: [
        Transition {
            from: "subnav-open"
            to: "subnav-closed"
            enabled: !suppressAnimations

            NumberAnimation {
                target: subNavContainer
                property: "y"
                duration: 250
                easing.type: Easing.OutQuint
            }
        },
        Transition {
            from: "subnav-closed"
            to: "subnav-open"
            enabled: !suppressAnimations

            NumberAnimation {
                target: subNavContainer
                property: "y"
                duration: 250
                easing.type: Easing.OutQuint
            }
        },
        Transition {
            from: "subnav-closed"
            to: "hidden"
            enabled: !suppressAnimations

            NumberAnimation {
                target: mainNavContainer
                property: "y"
                duration: 250
                easing.type: Easing.OutQuint
            }
        },
        Transition {
            from: "subnav-open"
            to: "hidden"
            enabled: !suppressAnimations

            ParallelAnimation {
                NumberAnimation {
                    target: subNavContainer
                    property: "y"
                    duration: 250
                    easing.type: Easing.OutQuint
                }

                NumberAnimation {
                    target: mainNavContainer
                    property: "y"
                    duration: 250
                    easing.type: Easing.OutQuint
                }
            }
        },
        Transition {
            from: "hidden"
            to: "subnav-open"
            enabled: !suppressAnimations

            ParallelAnimation {
                NumberAnimation {
                    target: subNavContainer
                    property: "y"
                    duration: 250
                    easing.type: Easing.OutQuint
                }

                NumberAnimation {
                    target: mainNavContainer
                    property: "y"
                    duration: 250
                    easing.type: Easing.OutQuint
                }
            }
        },
        Transition {
            from: "hidden"
            to: "subnav-closed"
            enabled: !suppressAnimations

            NumberAnimation {
                target: mainNavContainer
                property: "y"
                duration: 250
                easing.type: Easing.OutQuint
            }
        }
    ]
}
