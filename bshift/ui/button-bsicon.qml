import QtQuick 2.9
import CrowbarCollective 1.0

MouseArea { id: button
    property bool disabled: false
    // Used for call function that has assigned to specific button,
    // because UI elements should be handled by controller, keyboard or mouse we need
    // one solution for all situations
    property var callback: null

    property string imageSource: "image://game/ui/images/warning" + Theme.setImgDef
    property string text: "DEFAULT TEXT"

    property int buttonHeight: Math.ceil(50 * Theme.heightScale)
    property int buttonWidth: buttonHeight
    property int fontSize: Math.ceil(22 * Theme.heightScale)

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
        color: "transparent"

        
            Image {
                id: icon
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit

                source: button.imageSource

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 150
                    }
                }
            }
        
        
        
    }

    Text { id: buttonText
        text: button.text
        visible: false
        font.family: Theme.fonts.regular
        font.pixelSize: fontSize
        font.capitalization: Font.AllUppercase
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 0;
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
                    target: icon;
                    opacity: 0.77
                }
            },
            State {
                name: "focused"
                PropertyChanges {
                    target: icon;
                    opacity: 1
                }
                StateChangeScript {
                    name: "focusedScript"
                    script: {
						Sound.playEffect("sndfocus");
                    } 
                }
            },
            State {
                name: "disabled"
                PropertyChanges {
                    target: icon;
                    opacity: 0
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
				Sound.playEffect("sndclick");
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
                    NumberAnimation {
                        target: icon
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                }
            },

            Transition {
                from: "blurred"
                to: "disabled"
                reversible: true

                ParallelAnimation {
                    NumberAnimation {
                        target: icon
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                }
            },

            Transition {
                from: "focused"
                to: "disabled"
                reversible: true

                ParallelAnimation {
                    NumberAnimation {
                        target: icon
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                }
                
            }
        ]
    }
}
