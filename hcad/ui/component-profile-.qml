import QtQuick 2.9  
import QtGraphicalEffects 1.0  
import CrowbarCollective 1.0  
  
Item {  
    id: profileWidget  
    anchors.fill: parent  
    opacity: 0  
  
    // ── DYNAMIC DATA ─────────────────────────────────────────────────────────  
    property string _dynamicUserName: BlackMesaEngine.getLocalizedString("#QTUI_Unknown_UserName")  
  
    // ── MACROS ──────────────────────────────────────────────────────────────  
  
    // Animation  
    readonly property int   popupDelay:    2000  
    readonly property int   popupDuration: 600  
    readonly property int   slideOffsetX:  Math.ceil(200 * Theme.widthScale)  
  
    // Layout base Y — tied to logo position, drives gradient and text  
    readonly property int   layoutY:      Math.ceil(parent.height / 2  
                                              - 80  * Theme.heightScale  
                                              - 157 * Theme.heightScale / 2)  
  
    // Avatar — has its own independent vertical offset from layoutY  
    readonly property int   avatarSize:   Math.ceil(80  * Theme.heightScale)  
    readonly property int   avatarX:      Math.ceil(1080 * Theme.widthScale)  
    readonly property int   avatarOffsetY: Math.ceil(10 * Theme.heightScale)  
    readonly property int   avatarY:      layoutY + avatarOffsetY  
  
    // Main circle (green)  
    readonly property int   circleSize:  Math.ceil(104 * Theme.heightScale)  
    readonly property int   circleWidth: Math.ceil(10  * Theme.heightScale)  
    readonly property color circleColor: Theme.colors.highlight  
  
    // Accent circles (gold)  
    readonly property color circleAccentColor:      "#FFD700"  
    readonly property int   circleInnerAccentSize:  Math.ceil(84  * Theme.heightScale)  
    readonly property int   circleInnerAccentWidth: Math.ceil(2   * Theme.heightScale)  
    readonly property int   circleOuterAccentSize:  Math.ceil(108 * Theme.heightScale)  
    readonly property int   circleOuterAccentWidth: Math.ceil(2   * Theme.heightScale)  
  
    // Circle glow  
    readonly property real  circleGlowRadius: Math.ceil(.1 * Theme.heightScale)  
    readonly property real  circleGlowSpread: .015  
  
    // Derived: all circles share the same center as the avatar  
    readonly property int   _cx: avatarX + avatarSize / 2  
    readonly property int   _cy: avatarY + avatarSize / 2  
  
    // User name text — block is vertically centered on the avatar midpoint  
    readonly property int   userNameSize: Math.ceil(32 * Theme.heightScale)  
    readonly property int   welcomeSize:  Math.ceil(18 * Theme.heightScale)  
    readonly property int   _textGap:     Math.ceil(8  * Theme.heightScale)  
    readonly property int   _textBlockHeight: userNameSize + _textGap + welcomeSize  
  
    readonly property int   userNameX:    _cx + circleOuterAccentSize / 2 + Math.ceil(20 * Theme.widthScale)  
    readonly property int   userNameY:    layoutY + avatarSize / 2 - _textBlockHeight / 2  
  
    // Welcome message text  
    readonly property int   welcomeX:    userNameX  
    readonly property int   welcomeY:    userNameY + userNameSize + _textGap  
  
    // Black gradient — anchored to layoutY  
    readonly property int   gradientTopCut:    layoutY - Math.ceil(24 * Theme.heightScale)  
    readonly property int   gradientBottomCut: layoutY + circleOuterAccentSize + Math.ceil(24 * Theme.heightScale)  
    readonly property int   gradientWidth:     Math.ceil(840 * Theme.widthScale)  
    readonly property color gradientColor:     "#CC000000"  
  
    // Gold frame gradients  
    readonly property color gradientFrameColor:     "#FFD700"  
    readonly property int   gradientFrameWidth:     Math.ceil(4   * Theme.heightScale)  
    readonly property int   gradientFrameFadeWidth: gradientWidth  
  
    // ── SLIDE TRANSFORM ──────────────────────────────────────────────────────  
  
    transform: Translate { id: _slideTranslate; x: slideOffsetX }  
  
    // ── TIMER & DATA LOAD ────────────────────────────────────────────────────  
  
    Timer { id: _loadTimer  
        interval: popupDelay  
        repeat:   false  
        onTriggered: {  
            var userName = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_user_name");  
            _dynamicUserName = (userName && userName.length > 0)  
                ? userName  
                : BlackMesaEngine.getLocalizedString("#QTUI_Unknown_UserName");  
  
            if (userName && userName.length > 0) {  
                _avatarSource.source = "image://game/ui/users/" + userName + "/avatar.jpg";  
            }  
  
            // Start confetti and profile animation together  
            _confettiAnim.playing = true;  
            profileWidget.state = "visible";  
        }  
    }  
  
    Component.onCompleted: {  
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
  
    // ── GRADIENT (black) ────────────────────────────────────────────────────  
  
    LinearGradient {  
        x:      parent.width - gradientWidth  
        y:      gradientTopCut  
        width:  gradientWidth  
        height: gradientBottomCut - gradientTopCut  
        start:  Qt.point(width, 0)  
        end:    Qt.point(0, 0)  
        gradient: Gradient {  
            GradientStop { position: 0.0; color: gradientColor }  
            GradientStop { position: 1.0; color: "transparent" }  
        }  
    }  
  
    // ── GRADIENT FRAME (gold, on top of black gradient) ──────────────────────  
  
    LinearGradient {  
        x:      parent.width - gradientFrameFadeWidth  
        y:      gradientTopCut - gradientFrameWidth / 2  
        width:  gradientFrameFadeWidth  
        height: gradientFrameWidth  
        start:  Qt.point(width, 0)  
        end:    Qt.point(0, 0)  
        gradient: Gradient {  
            GradientStop { position: 0.0; color: gradientFrameColor }  
            GradientStop { position: 1.0; color: "transparent" }  
        }  
    }  
  
    LinearGradient {  
        x:      parent.width - gradientFrameFadeWidth  
        y:      gradientBottomCut - gradientFrameWidth / 2  
        width:  gradientFrameFadeWidth  
        height: gradientFrameWidth  
        start:  Qt.point(width, 0)  
        end:    Qt.point(0, 0)  
        gradient: Gradient {  
            GradientStop { position: 0.0; color: gradientFrameColor }  
            GradientStop { position: 1.0; color: "transparent" }  
        }  
    }  
  
    // ── CIRCLE GLOW (rendered first, behind everything) ──────────────────────  
  
    RectangularGlow {  
        x:      _cx - circleSize / 2 - circleGlowRadius  
        y:      _cy - circleSize / 2 - circleGlowRadius  
        width:  circleSize + circleGlowRadius * 2  
        height: circleSize + circleGlowRadius * 2  
        glowRadius:   circleGlowRadius  
        spread:       circleGlowSpread  
        color:        circleColor  
        cornerRadius: circleSize / 2 + circleGlowRadius  
    }  
  
    // ── OUTER GOLD ACCENT CIRCLE ─────────────────────────────────────────────  
  
    Rectangle {  
        x:      _cx - circleOuterAccentSize / 2  
        y:      _cy - circleOuterAccentSize / 2  
        width:  circleOuterAccentSize  
        height: circleOuterAccentSize  
        radius: circleOuterAccentSize / 2  
        color:  "transparent"  
        border.color: circleAccentColor  
        border.width: circleOuterAccentWidth  
    }  
  
    // ── MAIN GREEN CIRCLE ────────────────────────────────────────────────────  
  
    Rectangle {  
        x:      _cx - circleSize / 2  
        y:      _cy - circleSize / 2  
        width:  circleSize  
        height: circleSize  
        radius: circleSize / 2  
        color:  "transparent"  
        border.color: circleColor  
        border.width: circleWidth  
    }  
  
    // ── INNER GOLD ACCENT CIRCLE ─────────────────────────────────────────────  
  
    Rectangle {  
        x:      _cx - circleInnerAccentSize / 2  
        y:      _cy - circleInnerAccentSize / 2  
        width:  circleInnerAccentSize  
        height: circleInnerAccentSize  
        radius: circleInnerAccentSize / 2  
        color:  "transparent"  
        border.color: circleAccentColor  
        border.width: circleInnerAccentWidth  
    }  
  
    // ── AVATAR (round-masked via OpacityMask) ────────────────────────────────  
  
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
                    && source !== "image://game/ui/images/avatarplaceholder.png") {  
                source = "image://game/ui/images/avatarplaceholder.png";  
            }  
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
  
    // ── TEXT ─────────────────────────────────────────────────────────────────  
  
    Text {  
        x: userNameX;  y: userNameY  
        text: _dynamicUserName  
        color: "white"  
        font.family:        Theme.fonts.regular  
        font.pixelSize:     userNameSize  
        font.letterSpacing: 2  
    }  
  
    Text {  
        x: welcomeX;  y: welcomeY  
        text: "Welcome to the Black Mesa Research Facility soilder!"  
        color: "white"  
        font.family:    Theme.fonts.regular  
        font.pixelSize: welcomeSize  
    }  
  
    // ── CONFETTI (on top of everything, stationary — does not slide) ──────────  
  
	AnimatedImage {  
		id: _confettiAnim  
		anchors.fill: parent  
		source:   "vfs:///ui/videos/hirken8_confetti-confetti-from-right-121985.gif"  
		fillMode: Image.Stretch  
		playing:  false    // don't start until the timer fires  
		// Play once: stop when the last frame is reached  
		onFrameChanged: {  
			if (frameCount > 1 && currentFrame === frameCount - 1) {  
				playing = false;  
			}  
		}  
		// Counter-transform: negates the parent's slide so the GIF stays  
		// full-screen while the rest of the widget slides in from the right.  
		transform: Translate { x: -_slideTranslate.x }  
	} 
}