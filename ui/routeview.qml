import QtQuick 2.9
import CrowbarCollective 1.0

FocusScope {
    anchors.fill: parent
    width: parent.width
    height: parent.height
    // signal that allows any child of the route view to make a route request
    signal routeRequest(string routeName)

    // signal that the child route wants to load a savegame file
    signal loadGameRequest(variant savegame);

    // signal that the child route wants to load a map
    signal loadMapRequest(string filename, string mapname);

    // signal that the child route wants to save the game.
    // if savegame is null, a new save should be created
    signal saveGameRequest(string filename);

    // this is a hack so that we can find out what route we are at
    // after blindly popping the current route
    property string routeName

    property bool isInGame

    opacity: 0
}
