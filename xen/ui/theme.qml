pragma Singleton

import QtQuick 2.9

QtObject {
    property int rootWidth
    property int rootHeight

    property real widthScale
    property real heightScale

    function getDateTimeString(date) {
        return date && date.toLocaleString(Qt.locale("en_US"), "dddd, MMMM d yyyy h:mm:ss") || "";
    }

    readonly property QtObject colors: QtObject {
        readonly property color highlight: "#e47125"
        readonly property color text: "white"
        readonly property color buttonText: "white"
        readonly property color headerText: "white"
        readonly property color dimmedText: "#888888"
        readonly property color dimmedSlider: "#aaaaaa"
        readonly property color subNavBackground: "#111111"
        readonly property color skrim: "#2d2d2d"
        readonly property color modalBackground: "#222222"
        readonly property color warning: "#c72424"
        readonly property color warningText: "black"
    }

    readonly property QtObject opacity: QtObject {
        readonly property real subNav: 0.5
        readonly property real mainNav: 0.75
        readonly property real modal: 0.95
        readonly property real modalHeader: 0.85
        readonly property real modalSkrim: 0.9
        readonly property real pageSkrimLight: 0.75
        readonly property real pageSkrimDark: 0.85
    }

    readonly property QtObject sounds: QtObject {
        readonly property string buttonFocused: "common/launch_glow1.wav"
        readonly property string buttonClicked: "bms_objects/clickbeep/beep1.wav"
        readonly property string ambient: "ui/gamestartup_1.ogg"
    }

    readonly property QtObject fonts: QtObject {
        readonly property QtObject _loaders: QtObject {
            readonly property FontLoader dinProLight: FontLoader { source: "vfs:///resource/DINPro-Light.ttf" }
            readonly property FontLoader dinBold: FontLoader { source: "vfs:///resource/DIN-Bold.ttf" }
            readonly property FontLoader dinPro: FontLoader { source: "vfs:///resource/dinpro.ttf" }
        }

        readonly property string light: _loaders.dinProLight.name
        readonly property string bold: _loaders.dinBold.name
        readonly property string regular: _loaders.dinPro.name
    }
}
