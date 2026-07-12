import QtQuick 2.9  
import QtGraphicalEffects 1.0  
import CrowbarCollective 1.0  
  
Item {  
    id: profileWidget  
    anchors.fill: parent  
    opacity: 0  
  
    // ── DYNAMIC DATA ─────────────────────────────────────────────────────────  
    property string _dynamicUserName:    BlackMesaEngine.getLocalizedString("#QTUI_Unknown_UserName")  
    property color  _circleColor:        Theme.colors.highlight  // sv_hcad_user_col_mainring  
    property color  _circleAccentColor:  "#FFD700"               // sv_hcad_user_col_subrings  
    property color  _gradientColor:      "black"                 // sv_hcad_user_col_blckgrad  
    property color  _userTextColor:      "white"                 // sv_hcad_user_col_usertext  
    property color  _guestTextColor:     "white"                 // sv_hcad_user_col_gesttext  
    property color  _gradientFrameColor: "#000000"               // sv_hcad_user_col_mborders  
  
    // ── MACROS ──────────────────────────────────────────────────────────────  
  
    // Animation  
    readonly property int   popupDelay:       2000  
    readonly property int   popupDuration:    600  
    readonly property int   slideOffsetX:     Math.ceil(200 * Theme.widthScale)  
    //readonly property int   confettiDuration: 4540  
  
    // Layout base Y — tied to logo position, drives gradient and text  
    readonly property int   layoutY: Math.ceil(parent.height / 2  
                                         - 80  * Theme.heightScale  
                                         - 157 * Theme.heightScale / 2)  
  
    // Avatar — has its own independent vertical offset from layoutY  
    readonly property int   avatarSize:    Math.ceil(80  * Theme.heightScale)  
    readonly property int   avatarX:       Math.ceil(1080 * Theme.widthScale)  
    readonly property int   avatarOffsetY: Math.ceil(10 * Theme.heightScale)  
    readonly property int   avatarY:       layoutY + avatarOffsetY  
  
    // Main circle  
    readonly property int   circleSize:  Math.ceil(104 * Theme.heightScale)  
    readonly property int   circleWidth: Math.ceil(10  * Theme.heightScale)  
  
    // Accent circles  
    readonly property int   circleInnerAccentSize:  Math.ceil(84  * Theme.heightScale)  
    readonly property int   circleInnerAccentWidth: Math.ceil(2   * Theme.heightScale)  
    readonly property int   circleOuterAccentSize:  Math.ceil(108 * Theme.heightScale)  
    readonly property int   circleOuterAccentWidth: Math.ceil(2   * Theme.heightScale)  
  
    // Circle glow  
    readonly property real  circleGlowRadius: Math.ceil(.1 * Theme.heightScale)  
    readonly property real  circleGlowSpread: 0.005  
  
    // Derived: all circles share the same center as the avatar  
    readonly property int   _cx: avatarX + avatarSize / 2  
    readonly property int   _cy: avatarY + avatarSize / 2  
  
    // Gradient  
    readonly property int   gradientX:         parent.width  
    readonly property int   gradientWidth:     Math.ceil(840 * Theme.widthScale)  
    readonly property int   gradientTopCut:    layoutY - Math.ceil(24 * Theme.heightScale)  
    readonly property int   gradientBottomCut: layoutY + circleOuterAccentSize + Math.ceil(24 * Theme.heightScale)  
  
    // Frame gradients  
    readonly property int   gradientFrameWidth:     Math.ceil(4 * Theme.heightScale)  
    readonly property int   gradientFrameFadeWidth: gradientWidth  

    // Transparent endpoints must use the same RGB as the opaque side.
    // Plain "transparent" is transparent black, which can make colored
    // gradients look dirty/dim while fading.
    property color _gradientColorTransparent:      Qt.rgba(_gradientColor.r,      _gradientColor.g,      _gradientColor.b,      0.0)
    property color _gradientFrameColorTransparent: Qt.rgba(_gradientFrameColor.r, _gradientFrameColor.g, _gradientFrameColor.b, 0.0)
  
    
    property int    _guestType:       -1
    property string _guestPhraseKey:  "GUEST_NONE"
    property string _welcomeMessage:  BlackMesaEngine.getLocalizedString("#QTUI_SpecialGuest_Regular_1")
    property string _specialGuestMsg: ""

    readonly property bool _isSpecialGuest: _guestPhraseKey !== "GUEST_NONE"
    readonly property int  welcomeTextWidth: Math.max(Math.ceil(260 * Theme.widthScale),
                                                      parent.width - welcomeX - Math.ceil(48 * Theme.widthScale))

    function isTranslationKey(text) {
        return text && text.length > 0 && text.charAt(0) === "#";
    }

    function resolveText(text) {
        if (isTranslationKey(text))
            return BlackMesaEngine.getLocalizedString(text);

        return text;
    }

    function getGuestPhraseKeyFromSteamID64(steamid64) {
        switch (steamid64) {
            case "76561197961102600": return "ADAMBOMB";
            case "76561198041881220": return "VOID";
            case "76561197967489794": return "HUBI";
            case "76561198110766640": return "GUEST_ORIGCREATORS";
            case "76561198025560622": return "BLACKPRIEST";
            case "76561198349941420": return "GUEST_ORIGCREATORS";
            case "76561198146406111": return "GUEST_ORIGCREATORS";
            case "76561198249577996": return "FABER";
            case "76561198049257710": return "CYVO";
            case "76561198161437557": return "HECUCOLLECTIVEMEMBER";
            case "76561197971619595": return "HECUCOLLECTIVEMEMBER";
            case "76561197972018075": return "HECUCOLLECTIVEMEMBER";
            case "76561198053856640": return "HECUCOLLECTIVEMEMBER";
            case "76561198050885177": return "HECUCOLLECTIVEMEMBER";
            case "76561198072098435": return "HECUCOLLECTIVEMEMBER";
            case "76561197969789250": return "HECUCOLLECTIVEMEMBER";
            case "76561198131663561": return "HECUCOLLECTIVEMEMBER";
            case "76561198050127445": return "HECUCOLLECTIVEMEMBER";
            case "76561198813787617": return "BLACKBOXMEMBER";
            case "76561198025761869": return "BLACKBOXMEMBER";
            case "76561199001798703": return "BLACKBOXMEMBER";
            case "76561197983224468": return "SALO";
            case "76561198071553465": return "NECRO";
            case "76561198023098849": return "GUEST_NONE";
            case "76561197981106529": return "GUEST_NONE";
            case "76561198015495922": return "STALKEROS";
            case "76561197970357445": return "BOLOXED";
            case "76561198012433678": return "Tazik29";
            case "76561198084645699": return "LUCIA";
            case "76561198356280039": return "NOCLICK";
            case "76561198052527876": return "THEMASTER";
            case "76561198049667296": return "GOR";
            case "76561197961279779": return "POLL";
            case "76561198066414125": return "HECUSOILDER";
        }

        return "GUEST_NONE";
    }

    function getGuestPhraseKeyFromGuestType(guest) {
        switch (guest) {
            case 0:  return "Tazik29";
            case 1:  return "STALKEROS";
            case 2:  return "FABER";
            case 3:  return "CYVO";
            case 4:  return "BOLOXED";
            case 5:  return "BLACKPRIEST";
            case 6:  return "THEMASTER";
            case 7:  return "HECUSOILDER";
            case 8:  return "ADAMBOMB";
            case 9:  return "VOID";
            case 10: return "HUBI";
            case 11: return "GOR";
            case 12: return "LUCIA";
            case 13: return "NOCLICK";
            case 14: return "SALO";
            case 15: return "NECRO";
            case 16: return "POLL";
            case 17: return "SOURCECOOPLEAD";
            case 18: return "HECUCOLLECTIVEMEMBER";
            case 19: return "BLACKBOXMEMBER";
            case 20: return "GUEST_ORIGCREATORS";
        }

        return "GUEST_NONE";
    }

    function getGuestMessageListByKey(key) {
        switch (key) {
            case "Tazik29": return [
                "Садись, ДВА!",
                "Поросячий визг! ААААА! Добрый вечер.",
                "Да ты нищий... О ДЕНЬГИ!"
            ];

            case "STALKEROS": return [
                "Верховный галактический суд постановил, мир для путника STALKEROS станет строго монохромным. Вот и дошутился, добрый путник.",
                "Верховный галактический суд постановил, мир для путника STALKEROS станет строго монохромным. Вот и дошутился, добрый путник.",
                "Верховный галактический суд постановил, мир для путника STALKEROS станет строго монохромным. Вот и дошутился, добрый путник."
            ];

            case "FABER": return [
                "Ах! Голова HECU Collective долучився... Схоже конкуренція не долучиться.",
                "Чи багато конкуренції ви зізнали ? Що ж, вирішуйте наодинці це питання.",
                "Чи повезло вам чи ні ? Більше таких не буде, конкуренції також..."
            ];

            case "CYVO": return [
                "Der GOAT ist da! Das ist, was GOAT bedeutet! DER GOAT!",
                "Hey! Wird es Damocles 2 geben?",
                "Wir glauben, dass Ihre Fähigkeiten größer sind, als Sie denken!"
            ];

            case "BOLOXED": return [
                "Too many potatoes on images ... can we without ?",
                "As usually potato does, it will put potatoes on images... or not this time ?",
                "More potatoes on images, more! There is too many already anyway!"
            ];

            case "BLACKPRIEST": return [
                "Спасибо, но надеюсь, повернешь верной дорогой.",
                "Подарил фундамент, подарил будущее, но где сейчас оказался ?",
                "Нужный человек не в том месте может перевернуть мир. Угадаем не то место снова ?"
            ];

            case "THEMASTER": return [
                "Thank you for your videos! This is why this mesage exists.",
                "Too smart to take SteamID64 to recognize you, right ? Well, I didn't come up with it.",
                "You have illuminated the art of BriJee tricks, now we use them for good. Thanks!"
            ];

            case "HECUSOILDER": return [
                "Hope you end up well after after that undeserved criticism.",
                "They killed the competition, we both well know it and can feel. We’ll stay afloat!",
                "When someone tries to compare you with a huge team, it's unpleasant, unfair, painful. That's why we must support each other."
            ];

            case "ADAMBOMB": return [
                "There’s a forgotten corner of modding you don’t like looking at. Remember? And no, we’re not talking about HECU Collective.",
                "Touching something forgotten makes you an illusion wizard... unless it’s HECU Collective.",
                "It's not by HECU Collective! Oh wait... it exists... or it doesn't ?"
            ];

            case "VOID": return [
                "Вдячний за певну співпрацю, майбутнє у ваших руках! Ох... А Ви опинились тут ?",
                "Найнижщій рівень саме в цього повідомлення, але вдячний за певну співпрацю, майбутнє у ваших руках!",
                "Ви вирішили опинитись тут ? Якщо так... Майбутнє у ваших руках! Ми вдячні за певну співпрацю."
            ];

            case "HUBI": return [
                "OH! Hello.",
                "Ah, Josh Hubi! It's nice to see you.",
                "Nice to meet you!"
            ];

            case "GOR": return [
                "Я конечно все понимаю, но можно меньше вопросов ?",
                "Много вопросов ты мне задал, много... по этому ты здесь.",
                "Я ценю тех кто ценит мой труд, но иногда можно задавать меньше вопросов."
            ];

            case "LUCIA": return [
                "Nein, ich bin kein Zauberer, der mit dem Kopf nickt, das ist alles Informatik!",
                "Da ist keine Magie oder Tricks dahinter, nur ein bisschen Schulbildung.",
                "Wer versteht, wie Programme funktionieren, dem sind keine Grenzen gesetzt."
            ];

            case "NOCLICK": return [
                "The sun is leaking...",
                "Why is \"Why is \"Why is Realistic Half-Life So Bad?\" So Bad?\" So Bad?",
                "You put that there! I cannot even begin to get into how bad this looks to you."
            ];

            case "SALO": return [
                "Дякую за все! Без тебе цей мод був би у іншому світлі.",
                "Без тебе, цей мод був би у іншому світлі. Дякую!",
                "Цей мод у кращому світлі, завдяки тобі!"
            ];

            case "NECRO": return [
                "Дякую, що дозволив мені проявитись!",
                "Ти дозволив мені проявитись, дякую!",
                "Завдяки тобі, я зміг себе проявити, дуже вдячний!"
            ];

            case "POLL": return [
                "Павел в игре! Я знал что этот день настанет!",
                "Павел в игре! Я знал что этот день настанет!",
                "Павел в игре! Я знал что этот день настанет!"
            ];

            case "SOURCECOOPLEAD": return [
                "#QTUI_SpecialGuest_SourceCoopLead_1",
                "#QTUI_SpecialGuest_SourceCoopLead_2",
                "#QTUI_SpecialGuest_SourceCoopLead_3"
            ];

            case "HECUCOLLECTIVEMEMBER": return [
                "#QTUI_SpecialGuest_HecuCollectiveMember_1",
                "#QTUI_SpecialGuest_HecuCollectiveMember_2",
                "#QTUI_SpecialGuest_HecuCollectiveMember_3"
            ];

            case "BLACKBOXMEMBER": return [
                "#QTUI_SpecialGuest_BlackBoxMember_1",
                "#QTUI_SpecialGuest_BlackBoxMember_2",
                "#QTUI_SpecialGuest_BlackBoxMember_3"
            ];

            case "GUEST_ORIGCREATORS": return [
                "#QTUI_SpecialGuest_OrigCreator_1",
                "#QTUI_SpecialGuest_OrigCreator_2",
                "#QTUI_SpecialGuest_OrigCreator_3"
            ];

            case "GUEST_NONE": return [
                "#QTUI_SpecialGuest_Regular_1",
                "#QTUI_SpecialGuest_Regular_2",
                "#QTUI_SpecialGuest_Regular_3",
                "#QTUI_SpecialGuest_Regular_4",
                "#QTUI_SpecialGuest_Regular_5",
                "#QTUI_SpecialGuest_Regular_6"
            ];
        }

        return getGuestMessageListByKey("GUEST_NONE");
    }

    function getRawSpecialGuestLabel(key) {
        switch (key) {
            // Russian phrases
            case "Tazik29":
            case "STALKEROS":
            case "BLACKPRIEST":
            case "GOR":
            case "POLL":
                return "Режим особого гостя активирован!";

            // Ukrainian phrases
            case "FABER":
            case "VOID":
            case "SALO":
            case "NECRO":
                return "Режим особливого гостя активовано!";

            // German phrases
            case "CYVO":
            case "LUCIA":
                return "Spezialgastmodus aktiviert!";

            // English phrases and translation-key groups
            default:
                return "Special guest mode activated!";
        }
    }

    function selectGuestMessage(steamid64, guest) {
        var key = getGuestPhraseKeyFromSteamID64(steamid64);

        // Fallback for debug mode/manual guestnum selection, or if a SteamID64
        // is unavailable. Exact SteamID64 mapping always has priority.
        if (key === "GUEST_NONE" && guest !== -1)
            key = getGuestPhraseKeyFromGuestType(guest);

        var messages = getGuestMessageListByKey(key);

        if (!messages || messages.length <= 0) {
            key = "GUEST_NONE";
            messages = getGuestMessageListByKey(key);
        }

        var index = Math.floor(Math.random() * messages.length);
        if (index < 0)
            index = 0;
        if (index >= messages.length)
            index = messages.length - 1;

        var selected = messages[index];

        _guestType = guest;
        _guestPhraseKey = key;
        _welcomeMessage = resolveText(selected);

        if (_guestPhraseKey === "GUEST_NONE") {
            _specialGuestMsg = "";
        } else if (isTranslationKey(selected)) {
            _specialGuestMsg = BlackMesaEngine.getLocalizedString("#QTUI_SpecialGuestIsInTheHouse");
        } else {
            _specialGuestMsg = getRawSpecialGuestLabel(_guestPhraseKey);
        }
    }

    // Text — special guest label / username / random phrase
    readonly property int   _textGap:            Math.ceil(8 * Theme.heightScale)
    readonly property int   _specialGuestHeight: _isSpecialGuest ? welcomeSize : 0
    readonly property int   _specialGuestGap:    _isSpecialGuest ? _textGap : 0
    readonly property int   _textBlockHeight:    _specialGuestHeight + _specialGuestGap + userNameSize + _textGap + welcomeSize
    readonly property int   userNameX:           _cx + circleOuterAccentSize / 2 + Math.ceil(20 * Theme.widthScale)
    readonly property int   welcomeX:            userNameX
    readonly property int   specialGuestY:       layoutY + avatarSize / 2 - _textBlockHeight / 2
    readonly property int   userNameY:           specialGuestY + _specialGuestHeight + _specialGuestGap
    readonly property int   welcomeY:            userNameY + userNameSize + _textGap
    readonly property int   userNameSize:        Math.ceil(32 * Theme.heightScale)
    readonly property int   welcomeSize:         Math.ceil(18 * Theme.heightScale)
  
    // ── TIMER ────────────────────────────────────────────────────────────────  
    Timer {  
        id: _loadTimer  
        interval: popupDelay  
        repeat:   false  
        onTriggered: {  
            // Username  
            var userName = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_user_name");  
            _dynamicUserName = (userName && userName.length > 0)  
                ? userName  
                : BlackMesaEngine.getLocalizedString("#QTUI_Unknown_UserName");  
  
            // Avatar  
            if (userName && userName.length > 0)  
                _avatarSource.source = "image://game/ui/users/" + userName + "/avatar.jpg";  
  
            // Colors  
            var v;  
            v = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_user_col_mainring");  
            if (v && v.length > 0) _circleColor = v;  
  
            v = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_user_col_subrings");  
            if (v && v.length > 0) _circleAccentColor = v;  
  
            v = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_user_col_blckgrad");  
            if (v && v.length > 0) _gradientColor = v;  
  
            v = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_user_col_usertext");  
            if (v && v.length > 0) _userTextColor = v;  
  
            v = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_user_col_gesttext");  
            if (v && v.length > 0) _guestTextColor = v;  
  
            v = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_user_col_mborders");  
            if (v && v.length > 0) _gradientFrameColor = v;  
  
            

            // Special guest phrase
            var guestValue = parseInt(BlackMesaEngine.getConsoleVariableAsString("sv_hcad_user_guestnum"));
            if (isNaN(guestValue))
                guestValue = -1;

            selectGuestMessage(BlackMesaEngine.getConsoleVariableAsString("sv_hcad_user_steamid64"), guestValue);// Confetti  
            //_confettiAnim.playing = true;  
            //_confettiTimer.start();  
  
            // Show  
            profileWidget.state = "visible";  
        }  
    }  
  
    /*Timer {  
        id: _confettiTimer  
        interval: confettiDuration  
        repeat:   false  
        onTriggered: {  
            _confettiAnim.playing = false;  
            _confettiAnim.visible = false;  
        }  
    }*/  
  
    Component.onCompleted: {  
		if (BlackMesaEngine.isLevelMainMenuBackground())  
			_loadTimer.start();  
	}
  
    // ── STATES & TRANSITIONS ─────────────────────────────────────────────────  
    state: "hidden"  
  
    states: [  
        State {  
            name: "hidden"  
            PropertyChanges { target: profileWidget;   opacity: 0 }  
            PropertyChanges { target: _slideTranslate; x: slideOffsetX }  
        },  
        State {  
            name: "visible"  
            PropertyChanges { target: profileWidget;   opacity: 1 }  
            PropertyChanges { target: _slideTranslate; x: 0 }  
        }  
    ]  
  
    transitions: [  
        Transition {  
            from: "hidden"  
            to: "visible"  
            ParallelAnimation {  
                NumberAnimation {  
                    target:   _slideTranslate  
                    property: "x"  
                    from:     slideOffsetX  
                    to:       0  
                    duration: popupDuration  
                    easing.type: Easing.OutQuint  
                }  
                NumberAnimation {  
                    target:   profileWidget  
                    property: "opacity"  
                    from:     0.0  
                    to:       1.0  
                    duration: popupDuration  
                    easing.type: Easing.OutQuint  
                }  
            }  
        }  
    ]  
  
    // ── CONFETTI (disabled, i'm not happy how it looks and seems to take limited memory) ──────────  
    /*AnimatedImage {  
        id: _confettiAnim  
        anchors.fill: parent  
        source:   "vfs:///ui/videos/hirken8_confetti-confetti-from-right-121985.gif"  
        fillMode: Image.Stretch  
        playing:  false  
    
        visible:  playing  }*/  
  
    // ── SLIDING CONTENT ───────────────────────────────────────────────────────  
    Item {  
        id: _slidingContent  
        anchors.fill: parent  
        transform: Translate { id: _slideTranslate; x: slideOffsetX }
        // ── BLACK GRADIENT ────────────────────────────────────────────────────
        LinearGradient {
            x:      gradientX - gradientWidth
            y:      gradientTopCut
            width:  gradientWidth
            height: gradientBottomCut - gradientTopCut
            start:  Qt.point(width, 0)
            end:    Qt.point(0, 0)
            opacity: 1.0
            gradient: Gradient {
                GradientStop { position: 0.0; color: _gradientColor }
                GradientStop { position: 1.0; color: _gradientColorTransparent }
            }
        }  
  
        // ── TOP FRAME GRADIENT ────────────────────────────────────────────────  
        LinearGradient {  
            x:      gradientX - gradientFrameFadeWidth  
            y:      gradientTopCut - gradientFrameWidth / 2  
            width:  gradientFrameFadeWidth  
            height: gradientFrameWidth  
            start:  Qt.point(gradientFrameFadeWidth, 0)  
            end:    Qt.point(0, 0)  
            gradient: Gradient {  
                GradientStop { position: 0.0; color: _gradientFrameColor }  
                GradientStop { position: 1.0; color: _gradientFrameColorTransparent }  
            }  
        }  
  
        // ── BOTTOM FRAME GRADIENT ─────────────────────────────────────────────  
        LinearGradient {  
            x:      gradientX - gradientFrameFadeWidth  
            y:      gradientBottomCut - gradientFrameWidth / 2  
            width:  gradientFrameFadeWidth  
            height: gradientFrameWidth  
            start:  Qt.point(gradientFrameFadeWidth, 0)  
            end:    Qt.point(0, 0)  
            gradient: Gradient {  
                GradientStop { position: 0.0; color: _gradientFrameColor }  
                GradientStop { position: 1.0; color: _gradientFrameColorTransparent }  
            }  
        }  
  
        // ── CIRCLE GLOW ───────────────────────────────────────────────────────  
        RectangularGlow {  
            x:            _cx - circleSize / 2 - circleGlowRadius  
            y:            _cy - circleSize / 2 - circleGlowRadius  
            width:        circleSize + circleGlowRadius * 2  
            height:       circleSize + circleGlowRadius * 2  
            glowRadius:   circleGlowRadius  
            spread:       circleGlowSpread  
            color:        _circleColor  
            cornerRadius: circleSize / 2 + circleGlowRadius  
        }  
  
        // ── OUTER ACCENT CIRCLE ───────────────────────────────────────────────  
        Rectangle {  
            x:      _cx - circleOuterAccentSize / 2  
            y:      _cy - circleOuterAccentSize / 2  
            width:  circleOuterAccentSize  
            height: circleOuterAccentSize  
            radius: circleOuterAccentSize / 2  
            color:  "transparent"  
            border.color: _circleAccentColor  
            border.width: circleOuterAccentWidth  
        }  
  
        // ── MAIN CIRCLE ───────────────────────────────────────────────────────  
        Rectangle {  
            x:      _cx - circleSize / 2  
            y:      _cy - circleSize / 2  
            width:  circleSize  
            height: circleSize  
            radius: circleSize / 2  
            color:  "transparent"  
            border.color: _circleColor  
            border.width: circleWidth  
        }  
  
        // ── INNER ACCENT CIRCLE ───────────────────────────────────────────────  
        Rectangle {  
            x:      _cx - circleInnerAccentSize / 2  
            y:      _cy - circleInnerAccentSize / 2  
            width:  circleInnerAccentSize  
            height: circleInnerAccentSize  
            radius: circleInnerAccentSize / 2  
            color:  "transparent"  
            border.color: _circleAccentColor  
            border.width: circleInnerAccentWidth  
        }  
  
        // ── AVATAR (round-masked via OpacityMask) ─────────────────────────────  
        Image {  
            id: _avatarSource  
            x: avatarX;  y: avatarY  
            width: avatarSize;  height: avatarSize  
            source: "image://game/ui/images/avatarplaceholder.png"  
            fillMode: Image.Stretch  
            asynchronous: true  
            cache: false  
            visible: false  
            onStatusChanged: {  
                if (status === Image.Error  
                        && source !== "image://game/ui/images/avatarplaceholder.png")  
                    source = "image://game/ui/images/avatarplaceholder.png";  
            }  
        }  
  
        Rectangle {  
            id: _avatarMask  
            x: avatarX;  y: avatarY  
            width: avatarSize;  height: avatarSize  
            radius: avatarSize / 2  
            visible: false  
        }  
  
        OpacityMask {  
            x: avatarX;  y: avatarY  
            width: avatarSize;  height: avatarSize  
            source:     _avatarSource  
            maskSource: _avatarMask  
        }  
  
        // ── TEXT ──────────────────────────────────────────────────────────────
        // Special guest label (hidden for GUEST_NONE)
        Text {
            id: specialGuestLabel
            x: welcomeX;  y: specialGuestY
            width: welcomeTextWidth
            visible: _isSpecialGuest
            text: _specialGuestMsg
            color: _guestTextColor
            font.family:    Theme.fonts.regular
            font.pixelSize: welcomeSize
            wrapMode: Text.WordWrap
        }
// Username  
        Text {  
            x: userNameX;  y: userNameY  
            text: _dynamicUserName  
            color: _userTextColor  
            font.family:        Theme.fonts.regular  
            font.pixelSize:     userNameSize  
            font.letterSpacing: 2  
        }
        // Random guest phrase
        Text {
            id: welcomeMessageText
            x: welcomeX;  y: welcomeY
            width: welcomeTextWidth
            text: _welcomeMessage
            color: _userTextColor
            font.family:    Theme.fonts.regular
            font.pixelSize: welcomeSize
            wrapMode: Text.WordWrap
        }
}  
}