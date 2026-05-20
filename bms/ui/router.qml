import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

StackView { id: outlet
    width: parent.width
    height: parent.height
    property Route currentRoute
    property bool isInGame

    signal saveGameRequest(string filename)
    signal loadGameRequest(variant savegame)
    signal loadMapRequest(string filename, string mapname)

    Component.onCompleted: {
        outlet.setRoute(emptyRoute.name)
    }

    property var actions: ({
        OPEN_STEAMWORKSHOP: function () {
            BlackMesaEngine.activateSteamOverlayToWebPage("https://steamcommunity.com/app/362890/workshop")
        }
    })

    // handles route request signals from child and sibling components.
    // attach this to anything that needs to make a route request
    function _routeRequestHandler(routeName) {
        //console.log('_routeRequestHandler got a routeRequest to route:', routeName);
        outlet.setRoute(routeName);
    }

    function _loadGameRequestHandler(savegame) {
        outlet.loadGameRequest(savegame);
    }

    function _loadMapRequestHandler(filename, mapname) {
        outlet.loadMapRequest(filename, mapname);
    }

    function _saveGameRequestHandler(filename) {
        outlet.saveGameRequest(filename);
    }

    function _getRouteTransitionConfig(currentRoute, route, skipTransition) {
        var config = {
            fn: 'push',
            operation: !skipTransition ? StackView.Transition : StackView.Immediate,
            properties: {
                routeName: route.name,
                isInGame: outlet.isInGame
            },
            transitions: routeTransitions.down
        };

        // figure out how the route transition should animate.
        if (!currentRoute) {
            //console.log("setRoute: there is no current route");
        } else if (route.name === Routes.back.name) {
            //console.log("setRoute: going back");
            config.transitions = routeTransitions[currentRoute.alert ? 'down' : 'up'];
            config.fn = 'pop';
        } else if (route.alert || route.name === Routes.empty.name) {
            //console.log("setRoute: alert route or navigating to empty route");
            config.transitions = routeTransitions.up;
        } else if (currentRoute.name === Routes.index.name || route.name === Routes.empty.name) {
            //console.log("setRoute: current route is index or we are navigating to the empty route");
            config.transitions = routeTransitions.down;
        } else if (currentRoute.name === Routes.empty.name) {
            //console.log("setRoute: navigating away from empty route");
            config.transitions = routeTransitions.down;
        } else {
            //console.log("setRoute: rank transition");
            config.transitions = routeTransitions[currentRoute.rank > route.rank ? 'right' : 'left'];
            config.fn = 'replace';
        }

        return config;
    }

    // function to handle all route requests. a route request only needs to specify
    // the route that the requestor would like to transition to. this function is responsible for
    // taking the appropriate routing action based on that request.
    // 'allowSameRoute': Special case argument that allow to reload the same route
    function setRoute(newRouteName, skipTransition, allowSameRoute) {
        //console.log('setRoute: trying to route to', newRouteName);
        //console.log('setRoute: currentRoute', currentRoute && currentRoute.name);

        var route = Routes[newRouteName];

        if (route.passthrough) {
            route = Routes[route.destination];
            //console.log("setRoute: resolved passthrough route to", route.name);
        }

        if (!allowSameRoute && currentRoute && newRouteName === currentRoute.name) {
            //console.log("setRoute: the current route is the same");
            return;
        }

        if (outlet.currentItem && typeof outlet.currentItem.onRouteWillChange === 'function') {
            if (outlet.currentItem.onRouteWillChange(newRouteName)) {
                ///console.log("setRoute: INTERCEPTED by", currentRoute);
                return;
            }
        }

        // route has an action. execute the action rather than loading the new routeview
        // TODO: probably better to assume actions also causes the router to continue executing
        //		 and let the action override this behaviour via a return value
        if (route.action) {
            return actions[route.action]();
        }

        var config = _getRouteTransitionConfig(currentRoute, route, skipTransition);

        if (config.fn === 'pop') {
            popEnter = config.transitions.enter;
            popExit = config.transitions.exit;
            outlet.pop(config.operation);
            currentRoute = Routes[outlet.currentItem.routeName];
        } else {
            this[config.fn + 'Enter'] = config.transitions.enter;
            this[config.fn + 'Exit'] = config.transitions.exit;
            outlet[config.fn](route.qmlFile, config.properties, config.operation);
            currentRoute = route;
        }

        // connect the routeRequest signal so that RouteViews can make route requests
        outlet.currentItem.routeRequest.connect(_routeRequestHandler);

        // to consolidate the logic for loading and saving games, allow routes
        // to simply fire a signal whenever a child component wants to load or
        // save the game.
        // TODO: this is kinda dumb, but I don't want to duplicate load/save game
        //       console command logic in different components. there's a better way.
        outlet.currentItem.loadGameRequest.connect(_loadGameRequestHandler);
        outlet.currentItem.loadMapRequest.connect(_loadMapRequestHandler);
        outlet.currentItem.saveGameRequest.connect(_saveGameRequestHandler);
    }

    function parseRouteUIItems() {
        BlackMesaUtils.traverseUIElements(appRoot);
        BlackMesaUtils.afterTraverseCallback();
    }

    readonly property QtObject routeTransitions: QtObject {
        readonly property QtObject down: QtObject {
            readonly property Transition enter: downEnterTransition
            readonly property Transition exit: downExitTransition
        }

        readonly property QtObject up: QtObject {
            readonly property Transition enter: upEnterTransition
            readonly property Transition exit: upExitTransition
        }

        readonly property QtObject left: QtObject {
            readonly property Transition enter: leftEnterTransition
            readonly property Transition exit: leftExitTransition
        }

        readonly property QtObject right: QtObject {
            readonly property Transition enter: rightEnterTransition
            readonly property Transition exit: rightExitTransition
        }
    }

    Transition { id: rightEnterTransition
        ParallelAnimation {
            NumberAnimation {
                property: "x"
                from: -300
                to: 0
                duration: 600
                easing.type: Easing.InOutQuint
            }
            SequentialAnimation {
                ScriptAction { script: BlackMesaUtils.clearUIElementsData(); }
                PauseAnimation {
                    duration: 300
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0.0
                    to: 1.0
                    duration: 300
                }
                ScriptAction { script: parseRouteUIItems(); }
            }
        }
    }

    Transition { id: rightExitTransition
        ParallelAnimation {
            NumberAnimation {
                property: "x"
                from: 0
                to: 300
                duration: 600
                easing.type: Easing.InOutQuint
            }
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
                duration: 300
            }
        }
    }

    Transition { id: leftEnterTransition
        ParallelAnimation {
            NumberAnimation {
                property: "x"
                from: 300
                to: 0
                duration: 600
                easing.type: Easing.InOutQuint
            }
            SequentialAnimation {
                ScriptAction { script: BlackMesaUtils.clearUIElementsData(); }
                PauseAnimation {
                    duration: 300
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0.0
                    to: 1.0
                    duration: 300
                }
                ScriptAction { script: parseRouteUIItems(); }
            }
        }
    }

    Transition { id: leftExitTransition
        ParallelAnimation {
            NumberAnimation {
                property: "x"
                from: 0
                to: -300
                duration: 600
                easing.type: Easing.InOutQuint
            }
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
                duration: 300
            }
        }
    }

    Transition { id: upEnterTransition
        ParallelAnimation {
            NumberAnimation {
                property: "y"
                from: 300
                to: 0
                duration: 600
                easing.type: Easing.InOutQuint
            }
            SequentialAnimation {
                ScriptAction { script: BlackMesaUtils.clearUIElementsData(); }
                PauseAnimation {
                    duration: 300
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0.0
                    to: 1.0
                    duration: 300
                }
                ScriptAction { script: parseRouteUIItems(); }
            }
        }
    }

    Transition { id: upExitTransition
        ParallelAnimation {
            NumberAnimation {
                property: "y"
                from: 0
                to: -300
                duration: 600
                easing.type: Easing.InOutQuint
            }
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
                duration: 300
            }
        }
    }

    Transition { id: downEnterTransition
        ParallelAnimation {
            NumberAnimation {
                property: "y"
                from: -300
                to: 0
                duration: 600
                easing.type: Easing.InOutQuint
            }
            SequentialAnimation {
                ScriptAction { script: BlackMesaUtils.clearUIElementsData(); }
                PauseAnimation {
                    duration: 300
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0.0
                    to: 1.0
                    duration: 300
                }
                ScriptAction { script: parseRouteUIItems(); }
            }
        }
    }

    Transition { id: downExitTransition
        ParallelAnimation {
            NumberAnimation {
                property: "y"
                from: 0
                to: 300
                duration: 600
                easing.type: Easing.InOutQuint
            }
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
                duration: 300
            }
        }
    }
}
