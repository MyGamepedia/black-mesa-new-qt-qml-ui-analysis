import QtQuick 2.9

Item { id: wallpaper
    property alias backgroundImageUrl: backgroundImage.source
    property bool showImage: true
    property bool showExtras: false
    property bool showSkrim: false
    property bool darkenSkrim: false
    property bool suppressAnimations: false

    property real _skrimOpacity: darkenSkrim ? Theme.opacity.pageSkrimDark : Theme.opacity.pageSkrimLight
    property string _mapname
    property variant _maps
    property variant _files

    Component.onCompleted: {
        // TODO: i would love it if there was a 1-1 between the mapname and the background image
        //       filename. if there is, all these maps go away.
        _files = {
            background01: "image://game/materials/console/xenbackground01.vtf",
            background01_widescreen: "image://game/materials/console/xenbackground01_widescreen.vtf",
        };

        _maps = {
            xenbackground01: 'xenbackground01',

            // TODO: this is probably leftovers from when i thought qml would
            // show during inter-chapter loads
            bm_c0a0a: 'xenbackground01'

            // TODO: multiplayer maps?
        };
    }

    function updateBackgroundImage(mapname) {
        if (mapname) {
            _mapname = mapname;
        }

        var url = _getUrl(_mapname, appRoot.width / appRoot.height >= 1.586);

        if (url && backgroundImageUrl !== url) {
            backgroundImageUrl = url;
        }
    }

    function _getUrl(mapname, widescreen) {
        var key = _maps[mapname];

        if (widescreen) {
            key += '_widescreen';
        }

        return _files[key];
    }

    Image { id: backgroundImage
        anchors.fill: parent
        opacity: showImage ? 1.0 : 0.0

        Behavior on opacity {
            enabled: !suppressAnimations
            NumberAnimation { target: backgroundImage; property: "opacity"; duration: 1250 }
        }
    }

    Rectangle { id: backgroundGradient
        opacity: showExtras ? 0.5 : 0.0
        anchors.top: parent.bottom
        transformOrigin: Item.TopLeft

        rotation: -90
        width: parent.height
        height: parent.width

        gradient: Gradient {
            GradientStop { position: 0.0; color: Theme.colors.highlight }
            GradientStop { position: 1; color: "transparent" }
        }

        Behavior on opacity {
            enabled: !suppressAnimations
            NumberAnimation { target: backgroundGradient; property: "opacity"; duration: 1250 }
        }
    }

    Rectangle { id: skrim
        color: Theme.colors.skrim
        anchors.fill: parent
        opacity: showSkrim ? _skrimOpacity : 0.0

        Behavior on opacity {
            enabled: !suppressAnimations
            NumberAnimation { target: skrim; property: "opacity"; duration: 600 }
        }
    }

    Image { id: backgroundGraph
        opacity: showExtras ? 1.0 : 0.0
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "image://game/ui/images/graph-placeholder.png"

        Behavior on opacity {
            enabled: !suppressAnimations
            NumberAnimation { target: backgroundImage; property: "opacity"; duration: 1250 }
        }
    }
}
