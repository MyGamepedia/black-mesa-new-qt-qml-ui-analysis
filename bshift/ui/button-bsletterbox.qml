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

    property int fontSize: Math.ceil(24 * Theme.heightScale)
    
    property color bsInnerColor: Theme.colors.highlight
    property color bsOuterColor: Theme.colors.bssecondaryhighlight

    property real bsInnerOpacity: Theme.opacity.bsPrimary
    property real bsOuterOpacity: Theme.opacity.bsSecondary
    
    property int innerRectMargin: Math.ceil(4 * Theme.heightScale)
    property int textMargin: Math.ceil(104 * Theme.widthScale)
    
    property int buttonHeight: Math.ceil(50 * Theme.heightScale)
    property int buttonWidth: Math.ceil(600 * Theme.widthScale)
    
    property color textColor: Theme.colors.buttonText
    property color textDisabledColor: Theme.colors.dimmedText

    onSelectedChanged: {
        if (selected) {
            mouseArea.state = "selected";
			
			bsOuterColor = Theme.colors.highlight;
			bsInnerColor = Theme.colors.bssecondaryhighlight;
        } else {
            mouseArea.state = mouseArea.containsMouse ? "focused" : "blurred";
			
			bsInnerColor = Theme.colors.highlight;
			bsOuterColor = Theme.colors.bssecondaryhighlight;
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
    
    Rectangle { id: border
        
        anchors.centerIn: parent
        
        anchors.horizontalCenterOffset: Math.ceil(0 * Theme.heightScale)

        rotation: -90
        
        width: parent.height
        height: parent.width
        
        color: "transparent"
        
        Rectangle { id: focusShape
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            
            anchors.leftMargin: innerRectMargin - Math.ceil(1 * Theme.heightScale)
            anchors.rightMargin: innerRectMargin
            
            opacity: bsInnerOpacity
            
            height: parent.height
            width: parent.width
            
            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.15; color: bsInnerColor }
                GradientStop { position: 1; color: "transparent" }
            }
            
        }
        
        
        Rectangle { id: topShape
            anchors.top: parent.top
            anchors.right: parent.right
            
            width: Math.ceil(8 * Theme.heightScale)
            height: parent.height
            
            opacity: bsOuterOpacity
            
            gradient: Gradient {
                GradientStop { position: 0.05; color: "transparent" }
                GradientStop { position: 0.15; color: bsOuterColor }
                GradientStop { position: 0.9; color: "transparent" }
            }
            
        }


        Rectangle { id: bottomShape
            anchors.top: parent.top
            anchors.left: parent.left
            
            width: Math.ceil(6 * Theme.heightScale)
            height: parent.height
            
            opacity: bsOuterOpacity
            
            gradient: Gradient {
                GradientStop { position: 0.05; color: "transparent" }
                GradientStop { position: 0.15; color: bsOuterColor }
                GradientStop { position: 0.9; color: "transparent" }
            }
            
        }

        
    }
    

    Text { id: buttonText
        text: button.text
        font.family: Theme.fonts.regular
        font.pixelSize: fontSize
        font.capitalization: Font.AllUppercase
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 0
        color: !button.disabled ? textColor : textDisabledColor
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
                    target: buttonText;
                    anchors.leftMargin: textMargin
                }
                
                PropertyChanges {
                    target: border;
                    opacity: 0
                }
            },
            State {
                name: "focused"
                
                PropertyChanges {
                    target: buttonText;
                    anchors.leftMargin: textMargin + Math.ceil(4 * Theme.heightScale)
                }
                
                PropertyChanges {
                    target: border;
                    opacity: 1
                }
                
                StateChangeScript {
                    name: "focusedScript"
                    script: {
                        Sound.playEffect("sndfocus");
						
						if ( !appRoot.isLeftMenuFocused ) {
							appRoot.isLeftMenuFocusedFunction( true );
						}
                    }
                }
            },
            State {
                name: "selected"
                
                PropertyChanges {
                    target: buttonText;
                    anchors.leftMargin: textMargin + Math.ceil(4 * Theme.heightScale)
                }
                
                PropertyChanges {
                    target: border;
                    opacity: 1
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
                    target: buttonText;
                    anchors.leftMargin: textMargin
                }
                
                PropertyChanges {
                    target: border;
                    opacity: 0
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
                reversible: true

                ParallelAnimation {

                    NumberAnimation {
                        target: buttonText
                        property: "anchors.leftMargin"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: border
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                }
            },
            Transition {
                from: "focused"
                to: "selected"
                reversible: true

                ParallelAnimation {

                    NumberAnimation {
                        target: buttonText
                        property: "anchors.leftMargin"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: border
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                }
            },
            Transition {
                from: "selected"
                to: "blurred"
                reversible: true

                ParallelAnimation {

                    NumberAnimation {
                        target: buttonText
                        property: "anchors.leftMargin"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: border
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                }
                
            }
        ]
    }
}
