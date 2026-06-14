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


    function updateBackgroundImage() {
		var newBG = "image://game/ui/bs_campaign/bg/bg0" + appRoot.randomBackgroundChapter + ( (appRoot.randomBackgroundVariant === 1) ? ("a" + Theme.setImgDefJpg ) : Theme.setImgDefJpg );
		
        if ( backgroundImageUrl !== newBG ) {
            backgroundImageUrl = newBG;
        }
		
    }


    Image { id: backgroundImage
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
		
		cache: false
		asynchronous: true
		visible: !appRoot.isInGame && status == Image.Ready
				
        opacity: ( !appRoot.isInGame || showImage ) && status == Image.Ready ? 1.0 : 0.0

        Behavior on opacity {
            enabled: !suppressAnimations
            NumberAnimation { target: backgroundImage; property: "opacity"; duration: 1050 }
        }
    }

    Rectangle { id: skrim
        color: Theme.colors.skrim
        anchors.fill: parent
        opacity: showSkrim ? _skrimOpacity : 0.0

        Behavior on opacity {
            enabled: !suppressAnimations
            NumberAnimation { target: skrim; property: "opacity"; duration: 400 }
        }
    }

    Rectangle { id: backgroundGradient
        opacity: showExtras ? ( showImage ? 0.45 : 0.7 ) : 0.35
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
            NumberAnimation { target: backgroundGradient; property: "opacity"; duration: 1050 }
        }
    }

    Image { id: backgroundGraph
        opacity: showExtras ? 1.0 : 0.6
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "image://game/ui/images/menu_filler" + Theme.setImgDef

		cache: false
		asynchronous: true
		visible: status == Image.Ready
		
        Behavior on opacity {
            enabled: !suppressAnimations
            NumberAnimation { target: backgroundImage; property: "opacity"; duration: 1050 }
        }
    }
}
