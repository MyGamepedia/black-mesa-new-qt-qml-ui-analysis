pragma Singleton

import QtQuick 2.9
import CrowbarCollective 1.0

Item {
    // special back route that tells the route handler to pop a view
    readonly property Route back: Route {
        name: "back"
    }

    // empty route that displays nothing
    readonly property Route empty: Route {
        name: "empty"
        path: "empty"
        qmlFile: "routeview-empty.qml"
    }

    readonly property Route emptydefault: Route {
        name: "emptydefault"
        path: "emptydefault"
        qmlFile: "routeview-default-empty.qml"
    }
	
    // index route
    readonly property Route index: Route {
        name: "index"
        path: "index"
        qmlFile: "routeview-index.qml"
    }

    // BS Options Menu route
    readonly property Route bsoptions: Route {
        name: "bsoptions"
        path: "bsoptions"
        qmlFile: "routeview-bsdeepoptionsmenu.qml"
    }

    // BS Other Menu route
    readonly property Route bsother: Route {
        name: "bsother"
        path: "bsother"
        qmlFile: "routeview-bsdeepothermenu.qml"
    }
	
    // quit alert
    readonly property Route quit: Route {
        name: "quit"
        path: "quit"
        alert: true
        qmlFile: "routeview-quit.qml"
    }

    // campaign routes
    readonly property Route campaign: Route {
        name: "campaign"
        path: "campaign"
        passthrough: true
        destination: "newgame"
        rank: 1.0
    }

    readonly property Route newgame: Route {
        name: "newgame"
        path: "campaign.newgame"
        qmlFile: "routeview-newgame.qml"
        rank: 1.1
    }

    readonly property Route loadgame: Route {
        name: "loadgame"
        path: "campaign.loadgame"
        qmlFile: "routeview-loadgame.qml"
        rank: 1.2
    }

    readonly property Route savegame: Route {
        name: "savegame"
        path: "campaign.savegame"
        qmlFile: "routeview-savegame.qml"
        rank: 1.3
    }

    // options routes
    readonly property Route options: Route {
        name: "options"
        path: "options"
        passthrough: true
        destination: "game"
        rank: 3.0
    }

    readonly property Route game: Route {
        name: "game"
        path: "options.game"
        qmlFile: "routeview-game.qml"
        rank: 3.1
    }

    readonly property Route input: Route {
        name: "input"
        path: "options.input"
        qmlFile: "routeview-input.qml"
        rank: 3.2
    }

    readonly property Route bindings: Route {
        name: "bindings"
        path: "options.bindings"
        qmlFile: "routeview-bindings.qml"
    }

    readonly property Route video: Route {
        name: "video"
        path: "options.video"
        qmlFile: "routeview-video.qml"
        rank: 3.4
    }

    readonly property Route audio: Route {
        name: "audio"
        path: "options.audio"
        qmlFile: "routeview-audio.qml"
        rank: 3.5
    }
	
    readonly property Route othercredits: Route {
        name: "othercredits"
        qmlFile: "routeview-othercredits.qml"
        rank: 6.1
    }
    readonly property Route othertranslators: Route {
        name: "translators"
        qmlFile: "routeview-othertranslators.qml"
        rank: 6.2
    }
    readonly property Route otherpatrons: Route {
        name: "otherpatrons"
        qmlFile: "routeview-otherpatrons.qml"
        rank: 6.3
    }
	
    readonly property Route otherabout: Route {
        name: "otherabout"
        qmlFile: "routeview-otherabout.qml"
        rank: 6.4
    }
}
