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

    // handles route request signals from child and sibling components.
    // attach this to anything that needs to make a route request
    function _routeRequestHandler(routeName) {
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
        } else if (route.name === Routes.back.name) {
            config.transitions = routeTransitions[currentRoute.alert ? 'right' : 'left'];
            config.fn = 'pop';
        } else if (route.alert || route.name === Routes.empty.name) {
            config.transitions = routeTransitions.left;
        } else if (currentRoute.name === Routes.index.name || route.name === Routes.empty.name) {
            config.transitions = routeTransitions.right;
        } else if (currentRoute.name === Routes.empty.name) {
            config.transitions = routeTransitions.right;
        } else {
            config.transitions = routeTransitions[currentRoute.rank > route.rank ? 'down' : 'up'];
            config.fn = 'replace';
        }

        return config;
    }

    // function to handle all route requests. a route request only needs to specify
    // the route that the requestor would like to transition to. this function is responsible for
    // taking the appropriate routing action based on that request.
    // 'allowSameRoute': Special case argument that allow to reload the same route
    function setRoute(newRouteName, skipTransition, allowSameRoute) {

        var route = Routes[newRouteName];

        if (route.passthrough) {
            route = Routes[route.destination];
        }

        if (!allowSameRoute && currentRoute && newRouteName === currentRoute.name) {
            return;
        }

        if (outlet.currentItem && typeof outlet.currentItem.onRouteWillChange === 'function') {
            if (outlet.currentItem.onRouteWillChange(newRouteName)) {
                return;
            }
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

        /**
          * On each route we should reparse all elements to find our specific ui elements
          * that can be navigated/interacted with user actions from controller/keyboard
          */
    }

    function parseRouteUIItems() {
        BlackMesaUtils.clearTraversalTree([0,1,2,3]);
        BlackMesaUtils.parseTraversalTree(appRoot);
		
		//2 is to focus on the submenu, 1 is to focus on the main list of submenus. Default was 2
        BlackMesaUtils.traversalDepth = 2;
        
        if ( currentRoute.name === Routes.quit.name ) {
            BlackMesaUtils.traversalDepth = 1;
        }

        BlackMesaUtils.updateCurrentUISelection();
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
                duration: 300
                easing.type: Easing.InOutQuint
            }
            SequentialAnimation {
                PauseAnimation {
                    duration: 150
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0.0
                    to: 1.0
                    duration: 150
                }
                PauseAnimation {
                    duration: 120
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
                duration: 300
                easing.type: Easing.InOutQuint
            }
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
                duration: 150
            }
        }
    }

    Transition { id: leftEnterTransition
        ParallelAnimation {
            NumberAnimation {
                property: "x"
                from: 300
                to: 0
                duration: 300
                easing.type: Easing.InOutQuint
            }
            SequentialAnimation {
                PauseAnimation {
                    duration: 150
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0.0
                    to: 1.0
                    duration: 150
                }
                PauseAnimation {
                    duration: 120
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
                duration: 300
                easing.type: Easing.InOutQuint
            }
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
                duration: 150
            }
        }
    }

    Transition { id: upEnterTransition
        ParallelAnimation {
            NumberAnimation {
                property: "y"
                from: 300
                to: 0
                duration: 300
                easing.type: Easing.InOutQuint
            }
            SequentialAnimation {
                PauseAnimation {
                    duration: 150
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0.0
                    to: 1.0
                    duration: 150
                }
                PauseAnimation {
                    duration: 120
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
                duration: 300
                easing.type: Easing.InOutQuint
            }
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
                duration: 150
            }
        }
    }

    Transition { id: downEnterTransition
        ParallelAnimation {
            NumberAnimation {
                property: "y"
                from: -300
                to: 0
                duration: 300
                easing.type: Easing.InOutQuint
            }
            SequentialAnimation {
                PauseAnimation {
                    duration: 150
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0.0
                    to: 1.0
                    duration: 150
                }
                PauseAnimation {
                    duration: 120
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
                duration: 300
                easing.type: Easing.InOutQuint
            }
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
                duration: 150
            }
        }
    }
}