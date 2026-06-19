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
            background01: "image://game/materials/console/damo_background01.vtf",
            background01_widescreen: "image://game/materials/console/damo_background01_widescreen.vtf",
            background02: "image://game/materials/console/damo_background02.vtf",
            background02_widescreen: "image://game/materials/console/damo_background02_widescreen.vtf",
            background03: "image://game/materials/console/damo_background03.vtf",
            background03_widescreen: "image://game/materials/console/damo_background03_widescreen.vtf",
            background04: "image://game/materials/console/damo_background04.vtf",
            background04_widescreen: "image://game/materials/console/damo_background04_widescreen.vtf",

		//	Collection of map specific loading screens.
		//	DAMOCLES Phase I starts HERE!
		    loadingscreen00: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo00.png",
						loadingscreen00_widescreen: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo00_widescreen.png",
			loadingscreen01: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo01.png",
						loadingscreen01_widescreen: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo01_widescreen.png",
			loadingscreen01a: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo01a.png",
						loadingscreen01a_widescreen: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo01a_widescreen.png",
			loadingscreen01b: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo01b.png",
						loadingscreen01b_widescreen: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo01b_widescreen.png",
			loadingscreen01c: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo01c.png",
						loadingscreen01c_widescreen: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo01c_widescreen.png",
            loadingscreen02: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo02.png",
						loadingscreen02_widescreen: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo02_widescreen.png",
			loadingscreen02a: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo02a.png",
						loadingscreen02a_widescreen: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo02a_widescreen.png",
			loadingscreen03: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo03.png",
						loadingscreen03_widescreen: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo03_widescreen.png",
			loadingscreen03c: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo03c.png",
						loadingscreen03c_widescreen: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo03c_widescreen.png",
			loadingscreen03d: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo03d.png",
						loadingscreen03d_widescreen: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo03d_widescreen.png",
			loadingscreen04a: "image://game/ui/campaign/loadingscreens/loadingscreen_bm_damo04a.png",
        };

        _maps = {
            damo_background01: 'background01',
            damo_background02: 'background02',
            damo_background03: 'background03',
            damo_background04: 'background04',


			// TODO: Add more background chapters when done!

            // TODO: this is probably leftovers from when i thought qml would
            // show during inter-chapter loads
			// DAMOCLES NOTICE: This might be useful when implementing an inter-chapter load with map specific images for loadingscreans
			bm_damo00: 		'loadingscreen00',
			bm_damo01:		'loadingscreen01',
			bm_damo01a: 	'loadingscreen01a',
			bm_damo01b: 	'loadingscreen01b',
			bm_damo01c: 	'loadingscreen01c',
            bm_damo02: 		'loadingscreen02',
			bm_damo02a: 	'loadingscreen02a',
			bm_damo03: 		'loadingscreen03',
			bm_damo03a: 	'loadingscreen03',
			bm_damo03a2:	'loadingscreen03',
			bm_damo03b: 	'loadingscreen03',
			bm_damo03b1:	'loadingscreen03',
			bm_damo03c: 	'loadingscreen03c',
			bm_damo03d: 	'loadingscreen03d',
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
