pragma Singleton

import QtQuick 2.9
import CrowbarCollective 1.0

QtObject {
    property int rootWidth
    property int rootHeight

    property real widthScale
    property real heightScale
	
	//Decide which image size to use in BSQTUI
    property string setImgDef: rootHeight < 1081 ? "_1.png" :  "_2.png"
    property string setImgDefJpg: rootHeight < 1081 ? "_1.jpg" :  "_2.jpg"

    readonly property QtObject dictionary: QtObject {
        readonly property string english: "en_US"
        readonly property string ukrainian: "uk_UA"
        readonly property string russian: "ru_RU"
        readonly property string czech: "cs_CS"
        readonly property string korean: "ko_KR"
        readonly property string koreana: "ko_KR"
        readonly property string tchinese: "zh_TW"
        readonly property string schinese: "zh_CN"
        readonly property string vietnamese: "vi_VN"
        readonly property string brazilian: "pt_BR"
        readonly property string bulgarian: "bg_BG"
        readonly property string danish: "da_DK"
        readonly property string dutch: "nl_NL"
        readonly property string finnish: "fi_FI"
        readonly property string french: "fr_FR"
        readonly property string german: "de_DE"
        readonly property string greek: "el_GR"
        readonly property string hungarian: "hu_HU"
        readonly property string italian: "it_IT"
        readonly property string japanese: "ja_JP"
        readonly property string norwegian: "no_NO"
        readonly property string polish: "pl_PL"
        readonly property string portuguese: "pt_PT"
        readonly property string romanian: "ro_RO"
        readonly property string spanish: "es_ES"
        readonly property string swedish: "sv_SE"
        readonly property string thai: "th_TH"
        readonly property string turkish: "tr_TR"
    }
	
    function getYourLanguage() {
        var localeName = dictionary[BlackMesaEngine.getConsoleVariableAsString("cl_language")] || "C";
		
        return localeName;
    }
	
	
    function getDateTimeString(date) {
        return date && date.toLocaleString(Qt.locale(getYourLanguage()), BlackMesaEngine.getLocalizedString("#BlackMesaUI_Generic_DateFormat")) || "";
    }

    function getDateTimeMainMenuString(date) {
        return date && date.toLocaleString(Qt.locale(getYourLanguage()), BlackMesaEngine.getLocalizedString("#BSQTUI_Generic_DateFormatMenu")) || "";
    }
	
    readonly property QtObject colors: QtObject {
        readonly property color highlight: "#1d63a3"
        readonly property color bssecondaryhighlight: "#728eb0"
        readonly property color texthighlight: "#7DABCC"
        readonly property color textdevs: "#dcdcdc"
        readonly property color text: "white"
        readonly property color buttonText: "white"
        readonly property color headerText: "white"
        readonly property color dimmedText: "#888888"
        readonly property color dimmedSlider: "#aaaaaa"
        readonly property color subNavBackground: "#38424f"
        readonly property color skrim: "#1d242e"
        readonly property color modalBackground: "#38424f"
        readonly property color warning: "#e6134e"
        readonly property color warningText: "black"
    // Used when button has active selection but
    // you navigate to it with controller/keyboard
        readonly property color navigationHighlight: "#7DABCC"
        readonly property color bsMenuBackDropRight: "#000000"
        readonly property color alertLeftBg: "#0d365c"
        readonly property color subMenuHintPrimary: "#202834"
	//Used for menu navigation hints
        readonly property color hintButtonA: "#3fef58"
        readonly property color hintButtonBCircle: "#ef3f53"
        readonly property color hintButtonX: "#1d98f7"
        readonly property color hintButtonY: "#edde37"
        readonly property color hintButtonCross: "#5eb6db"
        readonly property color hintButtonSquare: "#f8a2dd"
        readonly property color hintButtonTriangle: "#41e9b0"
    }

    readonly property QtObject opacity: QtObject {
        readonly property real subNav: 0.85
        readonly property real mainNav: 0.85
        readonly property real modal: 0.85
        readonly property real modalHeader: 1.0
        readonly property real modalSkrim: 0.85
        readonly property real pageSkrimLight: 0
        readonly property real pageSkrimDark: 0.6
        readonly property real headerFull: 1.0
        readonly property real bsRightPanel: 0.8
        readonly property real bsPrimary: 0.77
        readonly property real bsSecondary: 0.6
        readonly property real bsOptionsFooter: 0.5
    }

    readonly property QtObject sounds: QtObject {
        readonly property string buttonFocused: "#ui/buttonrollover.wav"
        readonly property string buttonClicked: "#ui/buttonclickrelease.wav"
		
        readonly property string buttonFocusedO1: "#vo/npc/otis/otis_ow01.wav"
        readonly property string buttonFocusedO2: "#vo/npc/otis/otis_ow03.wav"
        readonly property string buttonFocusedO3: "#vo/npc/otis/otis_ow04.wav"
        readonly property string buttonFocusedO4: "#vo/npc/otis/otis_ow05.wav"
        readonly property string buttonFocusedO5: "#vo/npc/otis/otis_ow06.wav"
		
        readonly property string buttonClickedO1: "#vo/npc/otis/otis_ow07.wav"
        readonly property string buttonClickedO2: "#vo/npc/otis/otis_pain01.wav"
        readonly property string buttonClickedO3: "#vo/npc/otis/otis_pain02.wav"
        readonly property string buttonClickedO4: "#vo/npc/otis/otis_pain03.wav"
        readonly property string buttonClickedO5: "#vo/npc/otis/otis_pain04.wav"
        readonly property string buttonClickedO6: "#vo/npc/otis/otis_pain05.wav"
        readonly property string buttonClickedO7: "#vo/npc/otis/otis_pain06.wav"
        readonly property string buttonClickedO8: "#vo/npc/otis/otis_pain07.wav"
        readonly property string buttonClickedO9: "#vo/npc/otis/otis_pain08.wav"
        readonly property string buttonClickedO10: "#vo/npc/otis/otis_pain09.wav"
        readonly property string buttonClickedO11: "#vo/npc/otis/otis_pain10.wav"
        readonly property string buttonClickedO12: "#vo/npc/otis/otis_pain11.wav"
        readonly property string buttonClickedO13: "#vo/npc/otis/otis_pain12.wav"
        readonly property string buttonClickedO14: "#vo/npc/otis/otis_pain13.wav"
        readonly property string buttonClickedO15: "#vo/npc/otis/otis_pain14.wav"
        readonly property string buttonClickedO16: "#vo/npc/otis/otis_pain15.wav"
        readonly property string buttonClickedO17: "#vo/npc/otis/otis_pain16.wav"
		readonly property string sp: "#bshift/scripted_incident/incident_controlroom_break.wav"
		
        readonly property string music1: "#ui/gamestartup_1.wav" // make sure to add leading '#' in front of ambient (music) file name. (cf. CHAR_DRYMIX in snd_dma.cpp)
		readonly property string music2: "#ui/gamestartup_2.wav"
    }
	
    property bool currentDay: ( Qt.formatDateTime(new Date(), "MMdd") === "0401" )
	
	
    readonly property QtObject fonts: QtObject {
        readonly property QtObject _loaders: QtObject {
		
			readonly property FontLoader controlsIcons: FontLoader { 
				source: "vfs:///ui/fonts/controlsiconsblack.ttf"
			}
			
			readonly property FontLoader controlsIconsHints: FontLoader { 
				source: "vfs:///ui/fonts/controlsiconsmenublack.ttf"
			}
		
			readonly property FontLoader firaMonoRegular: FontLoader { 
				source: "vfs:///ui/fonts/firamono-regular.ttf"
			}
			
			//Stylized fonts
            readonly property FontLoader rajdhaniRegular: FontLoader { 
				source: "vfs:///ui/fonts/RajdhaniNanumGothic-Regular.ttf"
			}
			
			//Other languages font (default)
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
        readonly property string light: [ _loaders.rajdhaniRegular.name, _loaders.notoSansCJKLight.name ].join(", ")
        readonly property string bold: [ _loaders.rajdhaniRegular.name, _loaders.notoSansCJKBold.name].join(", ")
        readonly property string regular: [ _loaders.rajdhaniRegular.name, _loaders.notoSansCJKRegular.name].join(", ")
        readonly property string regularDefault: [ _loaders.rajdhaniRegular.name, _loaders.notoSansCJKRegular.name].join(", ")
		
        readonly property string controlsIcons: [_loaders.controlsIcons.name].join(", ")
        readonly property string controlsIconsHints: [_loaders.controlsIconsHints.name].join(", ")
    }
	
    readonly property QtObject devConsole: QtObject {
        readonly property QtObject colors: QtObject {
            readonly property color background: "#d0202020"
            readonly property color message: "lightgray"
            readonly property color inputText: "#ffd0d0d0";
        }
    }
}
