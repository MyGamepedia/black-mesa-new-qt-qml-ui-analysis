import QtQuick 2.9
import CrowbarCollective 1.0

Item {
    anchors.fill: parent
    // width: parent.width
    // height: parent.height
    // name of the route
    property string name

    // path of the route
    property string path

    // location of the qml file that will be this route's `item`
    property string qmlFile

    // alert routes:
    //  - are always pushed onto the stackview
    //  - can not make navigation requests
    //  - can only ever be popped off the stackview
    property bool alert: false

    // This route executes an action instead of transitioning to a new routeview
    property string action

    // passthrough routes are replaced with their destinationPath
    property bool passthrough: false

    // the name of the route to redirect to if this is a passthrough route
    property string destination

    // what is the rank of this route relative to the rest of the routes.
    // used to determine the correct route transition to play
    property real rank: 0.0
}
