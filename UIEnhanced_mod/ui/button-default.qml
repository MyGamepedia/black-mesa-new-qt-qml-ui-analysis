import QtQuick 2.9
import CrowbarCollective 1.0

MouseArea { id: button
    property bool disabled: false

    property string text: "DEFAULT TEXT"
    property bool bold: false
    property string clickedSoundPath: Theme.sounds.buttonClicked
    property string focusedSoundPath: Theme.sounds.buttonFocused

    property color boxColor: Theme.colors.buttonText
    property color disabledBoxColor: Theme.colors.dimmedText
    property color blurredTextColor: Theme.colors.buttonText
    property color focusedTextColor: Theme.colors.highlight
    property color disabledTextColor: Theme.colors.dimmedText

    property int buttonHeight: Math.ceil(46 * Theme.heightScale)
    property int buttonWidth: Math.ceil(buttonText.contentWidth + 46 * Theme.heightScale)
    property int buttonTextVerticalCenterOffsetBlurred: Math.ceil(-4 * Theme.heightScale)
    property int borderWidth: Math.ceil(2 * Theme.widthScale)
    property int fontSize: Math.ceil(16 * Theme.heightScale)
    property int focusShapeHeightBlurred: Math.ceil(8 * Theme.heightScale)

    height: buttonHeight
    width: buttonWidth

    propagateComposedEvents: true

    onDisabledChanged: {
        if (disabled) {
            mouseArea.state = "disabled"
        } else {
            mouseArea.state = button.containsMouse ? "focused" : "blurred"
        }
    }

    Rectangle { id: border
        anchors.fill: parent

        border.width: borderWidth
        border.color: boxColor
        color: "transparent"

        Behavior on border.color {
            ColorAnimation { duration: 150 }
        }
    }

    Rectangle { id: focusShape
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: boxColor
    }

    Text { id: buttonText
        text: button.text
        font.family: bold ? Theme.fonts.bold : Theme.fonts.regular
        font.pixelSize: fontSize
        font.capitalization: Font.AllUppercase
        anchors.centerIn: parent
    }

    MouseArea { id: mouseArea
        anchors.fill: parent
        hoverEnabled: !button.disabled
        scrollGestureEnabled: false
        propagateComposedEvents: !button.disabled
        state: button.disabled ? "disabled" : "blurred"

        states: [
            State {
                name: "blurred"
                PropertyChanges {
                    target: focusShape;
                    height: focusShapeHeightBlurred
                    color: boxColor
                }
                PropertyChanges {
                    target: buttonText;
                    anchors.verticalCenterOffset: buttonTextVerticalCenterOffsetBlurred
                    color: blurredTextColor
                }
                PropertyChanges {
                    target: border;
                    border.color: boxColor
                }
            },
            State {
                name: "focused"
                PropertyChanges {
                    target: focusShape;
                    height: parent.height;
                    color: boxColor
                }
                PropertyChanges {
                    target: buttonText;
                    anchors.verticalCenterOffset: 0;
                    color: focusedTextColor
                }
                PropertyChanges {
                    target: border;
                    border.color: boxColor
                }
                StateChangeScript {
                    name: "focusedScript"
                    script: {
                        Sound.playEffect(button.focusedSoundPath);
                    } 
                }
            },
            State {
                name: "disabled"
                PropertyChanges {
                    target: focusShape;
                    height: focusShapeHeightBlurred
                    color: disabledBoxColor
                }
                PropertyChanges {
                    target: buttonText;
                    anchors.verticalCenterOffset: buttonTextVerticalCenterOffsetBlurred
                    color: disabledTextColor
                }
                PropertyChanges {
                    target: border;
                    border.color: disabledBoxColor
                }
            }
        ]

        onEntered: {
            if (state !== "disabled") {
                state = "focused"
            }
        }

        onExited: {
            if (state !== "disabled") {
                state = "blurred"
            }
        }

        onClicked: {
            if (state !== "disabled") {
                Sound.playEffect(button.clickedSoundPath);
            } else {
                mouse.accepted = true;
            }

            mouse.accepted = false;
        }

        transitions: [
            Transition {
                from: "blurred"
                to: "focused"
                reversible: true

                ParallelAnimation {
                    ColorAnimation {
                        target: buttonText
                        duration: 150
                        easing.type: Easing.OutQuint
                    }

                    NumberAnimation {
                        target: focusShape
                        property: "height"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }

                    NumberAnimation {
                        target: buttonText
                        duration: 150
                        property: "anchors.verticalCenterOffset"
                        easing.type: Easing.OutQuint
                    }
                }
            },

            Transition {
                from: "blurred"
                to: "disabled"
                reversible: true

                ParallelAnimation {
                    ColorAnimation {
                        target: buttonText
                        duration: 150
                    }

                    ColorAnimation {
                        target: focusShape
                        duration: 150
                    }
                }
            },

            Transition {
                from: "focused"
                to: "disabled"
                reversible: true

                ParallelAnimation {
                    ColorAnimation {
                        target: buttonText
                        duration: 150
                        easing.type: Easing.OutQuint
                    }

                    ColorAnimation {
                        target: focusShape
                        duration: 150
                        easing.type: Easing.OutQuint
                    }

                    NumberAnimation {
                        target: focusShape
                        property: "height"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }

                    NumberAnimation {
                        target: buttonText
                        duration: 150
                        property: "anchors.verticalCenterOffset"
                        easing.type: Easing.OutQuint
                    }
                }
            }
        ]
    }
}
