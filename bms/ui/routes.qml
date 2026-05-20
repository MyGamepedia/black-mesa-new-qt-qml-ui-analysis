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

    // index route
    readonly property Route index: Route {
        name: "index"
        path: "index"
        qmlFile: "routeview-index.qml"
    }

    // quit alert
    readonly property Route quit: Route {
        name: "quit"
        path: "quit"
        alert: true
        qmlFile: "routeview-quit.qml"
    }

    // save before quit alert
    readonly property Route savebeforequit: Route {
        name: "savebeforequit"
        path: "savebeforequit"
        alert: true
        qmlFile: "routeview-savebeforequit.qml"
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

    // multiplayer routes
    readonly property Route multiplayer: Route {
        name: "multiplayer"
        path: "multiplayer"
        passthrough: true
        destination: "join"
        rank: 2.0
    }

    readonly property Route join: Route {
        name: "join"
        path: "multiplayer.join"
        qmlFile: "routeview-join.qml"
        rank: 2.1
    }

    readonly property Route host: Route {
        name: "host"
        path: "multiplayer.host"
        qmlFile: "routeview-host.qml"
        rank: 2.2
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
        rank: 3.3
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

    readonly property Route policy: Route {
        name: "policy"
        path: "options.policy"
        qmlFile: "routeview-policy.qml"
        rank: 3.6
    }

    readonly property Route translators: Route {
        name: "translators"
        path: "options.translators"
        qmlFile: "routeview-translators.qml"
        rank: 3.7
    }

    // achievements routes
    readonly property Route achievements: Route {
        name: "achievements"
        path: "achievements"
        qmlFile: "routeview-achievements.qml"
        rank: 4.0
    }

    // steam workshop routes
    readonly property Route steamworkshop: Route {
        name: "steamworkshop"
        path: "steamworkshop"
        passthrough: true
        destination: "addons"
        rank: 5.0
    }

    readonly property Route addons: Route {
        name: "addons"
        path: "steamworkshop.addons"
        qmlFile: "routeview-addons.qml"
        rank: 5.1
    }

    readonly property Route browse: Route {
        name: "browse"
        action: "OPEN_STEAMWORKSHOP"
        rank: 5.2
    }
}
