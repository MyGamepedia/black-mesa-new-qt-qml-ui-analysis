import QtQuick 2.9

Item { id: header
    width: parent.width

    signal routeRequest(string routeName)

    property Route currentRoute
    property bool hide: true
    property bool suppressAnimations: false
    property bool isInGame: false

    onIsInGameChanged: {
        // only show "Save Game" menu button when in game
        campaignNavModel.get(2).isEnabled = isInGame;
    }

    property int mainNavHeight: Math.ceil(63 * Theme.heightScale)
    property int mainNavBackgroundHeight: Math.ceil(63 * Theme.heightScale)
    property int subNavHeight: Math.ceil(126 * Theme.heightScale)
    property int logoDimension: Math.ceil(43 * Theme.heightScale)
    property int headerMargin: Math.ceil(35 * Theme.widthScale)

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
        if (!hide) {
            // only show the "Load Game" button when there are saved games to load
            campaignNavModel.get(1).isEnabled = !!BlackMesaUtils.getSaveGames().length
        }

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

    Item { id: mainNavContainer
        width: header.width
        height: mainNavHeight
        x: 0
        y: 0
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

        ListModel { id: mainNavModel
            Component.onCompleted: {
                var labels = L10n.strings.menus;

                append({ label: labels.campaign, routeName: "campaign" });
                //append({ label: labels.multiplayer, routeName: "multiplayer" });
                append({ label: labels.options, routeName: "options" });
                //append({ label: labels.achievements, routeName: "achievements" });
                //append({ label: labels.workshop, routeName: "steamworkshop" });
            }
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

                    fillMode: Image.Stretch
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
            }
        }

        ListModel { id: multiplayerNavModel
            Component.onCompleted: {
                var labels = L10n.strings.menus;

                append({ label: labels.join, routeName: "join", isEnabled: true });
                append({ label: labels.host, routeName: "host", isEnabled: true });
            }
        }

        ListModel { id: workshopNavModel
            Component.onCompleted: {
                var labels = L10n.strings.menus;

                append({ label: labels.campaigns, routeName: "campaigns", isEnabled: true });
                append({ label: labels.addons, routeName: "addons", isEnabled: true });
                append({ label: labels.browse, routeName: "browse", isEnabled: true });
            }
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
