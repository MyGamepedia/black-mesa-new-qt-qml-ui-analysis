pragma Singleton

import QtQuick 2.9
import CrowbarCollective 1.0

QtObject {
    property int rootWidth
    property int rootHeight

    property real widthScale
    property real heightScale

    readonly property QtObject dictionary: QtObject {
        readonly property string brazilian: "pt_BR"
        readonly property string bulgarian: "bg_BG"
        readonly property string czech: "cs_CS"
        readonly property string danish: "da_DK"
        readonly property string dutch: "nl_NL"
        readonly property string english: "en_US"
        readonly property string finnish: "fi_FI"
        readonly property string french: "fr_FR"
        readonly property string german: "de_DE"
        readonly property string greek: "el_GR"
        readonly property string hungarian: "hu_HU"
        readonly property string italian: "it_IT"
        readonly property string japanese: "ja_JP"
        readonly property string korean: "ko_KR"
        readonly property string koreana: "ko_KR"
        readonly property string norwegian: "no_NO"
        readonly property string polish: "pl_PL"
        readonly property string portuguese: "pt_PT"
        readonly property string romanian: "ro_RO"
        readonly property string russian: "ru_RU"
        readonly property string schinese: "zh_CN"
        readonly property string spanish: "es_ES"
        readonly property string swedish: "sv_SE"
        readonly property string tchinese: "zh_CN"
        readonly property string thai: "th_TH"
        readonly property string turkish: "tr_TR"
        readonly property string ukrainian: "uk_UA"
    }

    function getDateTimeString(date) {
        var localeName = dictionary[BlackMesaEngine.getConsoleVariableAsString("cl_language")] || "C";
        return date && date.toLocaleString(Qt.locale(localeName), BlackMesaEngine.getLocalizedString("#BlackMesaUI_Generic_DateFormat")) || "";
    }

    readonly property QtObject colors: QtObject {
        readonly property color highlight: "#00af00"
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
        readonly property string music1: "#ui/gamestartup_1.wav" // make sure to add leading '#' in front of ambient (music) file name. (cf. CHAR_DRYMIX in snd_dma.cpp)
        readonly property string music2: "#ui/gamestartup_2.wav" //
    }

    readonly property QtObject fonts: QtObject {
        readonly property QtObject _loaders: QtObject {
			readonly property FontLoader firaMonoRegular: FontLoader { 
				source: "vfs:///ui/fonts/firamono-regular.ttf"
			}
			readonly property FontLoader notoSansLight: FontLoader { 
				source: "vfs:///ui/fonts/notosans-light.ttf"
			}
            readonly property FontLoader notoSansBold: FontLoader { 
				source: "vfs:///ui/fonts/notosans-bold.ttf"
			}
            readonly property FontLoader notoSansRegular: FontLoader { 
				source: "vfs:///ui/fonts/notosans-regular.ttf"
			}
            readonly property FontLoader notoSansCJKLight: FontLoader { 
				source: "vfs:///ui/fonts/notosanscjkjp-light.otf"
			}
            readonly property FontLoader notoSansCJKBold: FontLoader { 
				source: "vfs:///ui/fonts/notosanscjkjp-bold.otf"
			}
            readonly property FontLoader notoSansCJKRegular: FontLoader { 
				source: "vfs:///ui/fonts/notosanscjkjp-regular.otf"
			}
        }

        readonly property string devConsole: _loaders.firaMonoRegular.name
        readonly property string light: [_loaders.notoSansLight.name, _loaders.notoSansCJKLight.name].join(", ")
        readonly property string bold: [_loaders.notoSansBold.name, _loaders.notoSansCJKBold.name].join(", ")
        readonly property string regular: [_loaders.notoSansRegular.name, _loaders.notoSansCJKRegular.name].join(", ")
    }

    readonly property QtObject devConsole: QtObject {
        readonly property QtObject colors: QtObject {
            readonly property color background: "#d0202020"
            readonly property color message: "lightgray"
            readonly property color inputText: "#ffd0d0d0";
        }
    }
}
