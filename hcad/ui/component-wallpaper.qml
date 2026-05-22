import QtQuick 2.9
import CrowbarCollective 1.0

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
            background01: "image://game/materials/console/background01.vtf",
            background01_widescreen: "image://game/materials/console/background01_widescreen.vtf",
            background02: "image://game/materials/console/background02.vtf",
            background02_widescreen: "image://game/materials/console/background02_widescreen.vtf",
            background03: "image://game/materials/console/background03.vtf",
            background03_widescreen: "image://game/materials/console/background03_widescreen.vtf",
            background04: "image://game/materials/console/background04.vtf",
            background04_widescreen: "image://game/materials/console/background04_widescreen.vtf",
            background05: "image://game/materials/console/background05.vtf",
            background05_widescreen: "image://game/materials/console/background05_widescreen.vtf",
            background06: "image://game/materials/console/background06.vtf",
            background06_widescreen: "image://game/materials/console/background02_widescreen.vtf",
            background07: "image://game/materials/console/background07.vtf",
            background07_widescreen: "image://game/materials/console/background07_widescreen.vtf",
            background08: "image://game/materials/console/background08.vtf",
            background08_widescreen: "image://game/materials/console/background08_widescreen.vtf",
            background09: "image://game/materials/console/background09.vtf",
            background09_widescreen: "image://game/materials/console/background10_widescreen.vtf",
            background10: "image://game/materials/console/background10.vtf",
            background10_widescreen: "image://game/materials/console/background11_widescreen.vtf",
            background11: "image://game/materials/console/background11.vtf",
            background11_widescreen: "image://game/materials/console/background12_widescreen.vtf",
            background12: "image://game/materials/console/background12.vtf",
            background12_widescreen: "image://game/materials/console/background12_widescreen.vtf",
            background13: "image://game/materials/console/background13.vtf",
            background13_widescreen: "image://game/materials/console/background13_widescreen.vtf",
            background14: "image://game/materials/console/background14.vtf",
            background14_widescreen: "image://game/materials/console/background14_widescreen.vtf",
            background15: "image://game/materials/console/background15.vtf",
            background15_widescreen: "image://game/materials/console/background15_widescreen.vtf",
            background16: "image://game/materials/console/background16.vtf",
            background16_widescreen: "image://game/materials/console/background16_widescreen.vtf",
            background17: "image://game/materials/console/background17.vtf",
            background17_widescreen: "image://game/materials/console/background17_widescreen.vtf",
            background18: "image://game/materials/console/background18.vtf",
            background18_widescreen: "image://game/materials/console/background18_widescreen.vtf",
            background19: "image://game/materials/console/background19.vtf",
            background19_widescreen: "image://game/materials/console/background19_widescreen.vtf",
        };

        _maps = {
            background01: 'background01',
            background02: 'background02',
            background03: 'background03',
            background04: 'background04',
            background05: 'background05',
            background06: 'background06',
            background07: 'background07',
            background08: 'background08',
            background09: 'background09',
            background10: 'background10',
            background11: 'background11',
            background12: 'background12',
            background13: 'background13',
            background14: 'background14',
            background15: 'background15',
            background16: 'background16',
            background17: 'background17',
            background18: 'background18',
            background19: 'background19',

            // TODO: this is probably leftovers from when i thought qml would
            // show during inter-chapter loads
            bm_c0a0a: 'background01',
            bm_c0a0b: 'background01',
            bm_c0a0c: 'background01',
            bm_c1a0a: 'background02'

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
