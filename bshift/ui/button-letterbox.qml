import QtQuick 2.9
import CrowbarCollective 1.0

MouseArea { id: button
    property alias text: buttonText.text
    property bool selected: false
    property bool disabled: false
    // Used for call function that has assigned to specific button,
    // because UI elements should be handled by controller, keyboard or mouse we need
    // one solution for all situations
    property var callback: null

    property color focusedColor: Theme.colors.texthighlight
    property color blurredColor: Theme.colors.buttonText
    property color selectedColor: Theme.colors.buttonText
    property color disabledColor: Theme.colors.dimmedText
    property real focusShapeOpacity: 0.9

    property int buttonWidth: Math.ceil(buttonText.contentWidth + 40 * Theme.heightScale)
    property int buttonHeight: Math.ceil(63 * Theme.heightScale)
    property int buttonTextFontSize: Math.ceil(22 * Theme.heightScale)
    property int barHeight: Math.ceil(8 * Theme.heightScale)
    property int focusShapeWidthFocused: Math.ceil(button.width - 10 * Theme.heightScale)
    property int focusShapeMargin: Math.ceil(5 * Theme.heightScale)

    onSelectedChanged: {
        if (selected) {
            mouseArea.state = "selected"
        } else {
            mouseArea.state = mouseArea.containsMouse ? "focused" : "blurred"
        }
    }

    onDisabledChanged: {
        if (disabled) {
            mouseArea.state = "disabled"
        } else {
            mouseArea.state = button.containsMouse ? "focused" : "blurred";
        }
    }

    height: buttonHeight
    width: buttonWidth

	Rectangle {
		visible: button.selected && button.activeFocus
		x: focusShape.x
		width: focusShape.width
		height: parent.height
		color: Theme.colors.navigationHighlight
		opacity: 0.4
	}

    Rectangle { id: focusShape
        color: button.focusedColor
        opacity: button.focusShapeOpacity
        anchors.bottom: button.bottom
        anchors.left: button.left
        anchors.leftMargin: focusShapeMargin
    }

    Text { id: buttonText
        font.family: Theme.fonts.regular
        font.pixelSize: buttonTextFontSize
        anchors.centerIn: parent
        font.capitalization: Font.AllUppercase
    }

    MouseArea { id: mouseArea
        anchors.fill: parent
        hoverEnabled: !button.disabled
        scrollGestureEnabled: false
        propagateComposedEvents: !button.disabled

        Component.onCompleted: {
            if (button.disabled) {
                state = "disabled";
            } else {
                state = button.selected ? "selected" : "blurred";
            }
        }

        states: [
            State {
                name: "blurred"
                PropertyChanges {
                    target: buttonText
                    color: blurredColor
                    font.bold: false
                }
                PropertyChanges {
                    target: focusShape
                    width: 0
                    height: 0
                }
            },
            State {
                name: "focused"
                PropertyChanges {
                    target: buttonText
                    color: selectedColor
                    font.bold: false
                }
                PropertyChanges {
                    target: focusShape
                    width: focusShapeWidthFocused
                    height: button.height
                }
                StateChangeScript {
                    name: "focusedScript"
                    script: {
                        Sound.playEffect("sndfocus");
                    }
                }
            },
            State {
                name: "selected"
                PropertyChanges {
                    target: buttonText
                    color: focusedColor
                    font.bold: true
                }
                PropertyChanges {
                    target: focusShape
                    width: focusShapeWidthFocused
                    height: barHeight
                }
                StateChangeScript {
                    name: "selectedScript"
                    script: {
						Sound.playEffect("sndclick");
                    } 
                }
            },
            State {
                name: "disabled"
                PropertyChanges {
                    target: buttonText
                    color: disabledColor
                    font.bold: false
                }
                PropertyChanges {
                    target: focusShape
                    width: 0
                    height: 0
                }
            }
        ]

        onEntered: {
            if (state !== "selected" && state !== "disabled") {
                state = "focused"
            }
        }

        onExited: {
            if (state !== "selected" && state !== "disabled") {
                state = "blurred"
            }
        }

        onClicked: {
            if (state !== "selected" && state !== "disabled") {
                mouse.accepted = false
            } else {
                mouse.accepted = true
            }
        }

        transitions: [
            Transition {
                from: "blurred"
                to: "focused"

                SequentialAnimation {
                    NumberAnimation {
                        target: focusShape
                        property: "width"
                        duration: 1
                    }

                    ParallelAnimation {
                        ColorAnimation {
                            target: buttonText
                            duration: 100
                            easing.type: Easing.OutQuint
                        }

                        NumberAnimation {
                            target: focusShape
                            property: "height"
                            duration: 100
                            easing.type: Easing.OutQuint
                        }
                    }
                }
            },
            Transition {
                from: "focused"
                to: "blurred"

                SequentialAnimation {
                    ParallelAnimation {
                        ColorAnimation {
                            target: buttonText
                            duration: 100
                            easing.type: Easing.OutQuint
                        }

                        NumberAnimation {
                            target: focusShape
                            property: "height"
                            duration: 100
                            easing.type: Easing.OutQuint
                        }
                    }

                    NumberAnimation {
                        target: focusShape
                        property: "width"
                        duration: 1
                    }
                }
            },
            Transition {
                from: "focused"
                to: "selected"

                ParallelAnimation {
                    NumberAnimation {
                        target: focusShape
                        property: "height"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }

                    ColorAnimation {
                        target: buttonText
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                }
            },
            Transition {
                from: "selected"
                to: "blurred"

                SequentialAnimation {
                    ParallelAnimation {
                        NumberAnimation {
                            target: focusShape
                            property: "height"
                            duration: 100
                        }

                        ColorAnimation {
                            target: buttonText
                            duration: 100
                        }
                    }

                    NumberAnimation {
                        target: focusShape
                        property: "width"
                        duration: 1
                    }
                }
            }
        ]
    }
}
