import QtQuick 2.9
import CrowbarCollective 1.0

MouseArea { id: button
    property bool disabled: false
    // Used for call function that has assigned to specific button,
    // because UI elements should be handled by controller, keyboard or mouse we need
    // one solution for all situations
    property var callback: null

    property string text: "DEFAULT TEXT"

    property int fontSize: Math.ceil(24 * Theme.heightScale)
    
    property color bsInnerColor: Theme.colors.highlight
    property color bsOuterColor: Theme.colors.bssecondaryhighlight
    
    property real bsInnerOpacity: Theme.opacity.bsPrimary
    property real bsOuterOpacity: Theme.opacity.bsSecondary

    property int innerRectMargin: Math.ceil(4 * Theme.heightScale)
    property int textMargin: Math.ceil(104 * Theme.widthScale)
    
    property int buttonHeight: Math.ceil(48 * Theme.heightScale)
    property int buttonWidth: Math.ceil(800 * Theme.widthScale)

    property color textColor: Theme.colors.buttonText
    property color textColorHovered: Theme.colors.buttonText
    property color textDisabledColor: Theme.colors.dimmedText
    
    property int focusShapeHeightBlurred: 0

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
        
        anchors.centerIn: parent
        
        anchors.horizontalCenterOffset: Math.ceil(0 * Theme.widthScale)

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
            
            
            height: parent.height
            width: parent.width
            
            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.45; color: bsInnerColor }
                GradientStop { position: 0.55; color: bsInnerColor }
                GradientStop { position: 1; color: "transparent" }
            }
            
        }
        
        
        Rectangle { id: topShape
            anchors.top: parent.top
            anchors.right: parent.right
            
            
            width: Math.ceil(8 * Theme.heightScale)
            height: parent.height
            
            gradient: Gradient {
                GradientStop { position: 0.05; color: "transparent" }
                GradientStop { position: 0.47; color: bsOuterColor }
                GradientStop { position: 0.53; color: bsOuterColor }
                GradientStop { position: 0.95; color: "transparent" }
            }
            
        }


        Rectangle { id: bottomShape
            anchors.top: parent.top
            anchors.left: parent.left
            
            
            width: Math.ceil(6 * Theme.heightScale)
            height: parent.height
            
            gradient: Gradient {
                GradientStop { position: 0.05; color: "transparent" }
                GradientStop { position: 0.47; color: bsOuterColor }
                GradientStop { position: 0.53; color: bsOuterColor }
                GradientStop { position: 0.95; color: "transparent" }
            }
            
        }
        
    }

    Text { id: buttonText
        text: button.text
        font.family: Theme.fonts.regular
        font.pixelSize: fontSize
        font.capitalization: Font.AllUppercase
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 0
		anchors.horizontalCenter: parent.horizontalCenter
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
                    target: buttonText;
                    color: textColor;
                }
                
                
                PropertyChanges {
                    target: border;
                    opacity: 0
                }
                
                PropertyChanges {
                    target: topShape;
                    opacity: 0
                }
                
                PropertyChanges {
                    target: bottomShape;
                    opacity: 0
                }
                
                PropertyChanges {
                    target: focusShape;
                    opacity: 0
                }
                
            },
            State {
                name: "focused"
                
                PropertyChanges {
                    target: buttonText;
                    color: textColorHovered
                }
                
                PropertyChanges {
                    target: border;
                    opacity: 1
                }
                
                PropertyChanges {
                    target: topShape;
                    opacity: bsOuterOpacity
                }
                
                PropertyChanges {
                    target: bottomShape;
                    opacity: bsOuterOpacity
                }
                
                PropertyChanges {
                    target: focusShape;
                    opacity: bsInnerOpacity
                }
                
                StateChangeScript {
                    name: "focusedScript"
                    script: {
						if ( !appRoot.isLeftMenuFocused ) {
							appRoot.isLeftMenuFocusedFunction( true );
						}
                    } 
                }
                
            },
            State {
                name: "disabled"
                
                PropertyChanges {
                    target: buttonText;
                    color: textDisabledColor
                }
                
                PropertyChanges {
                    target: border;
                    opacity: 0
                }
                
                PropertyChanges {
                    target: topShape;
                    opacity: 0
                }
                
                PropertyChanges {
                    target: bottomShape;
                    opacity: 0
                }
                
                PropertyChanges {
                    target: focusShape;
                    opacity: 0
                }
                
            }
        ]

        onEntered: {
            if (state !== "disabled") {
                state = "focused"
                Sound.playEffect("sndfocus");
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

                    ColorAnimation {
                        target: buttonText
                        duration: 150
                        easing.type: Easing.OutQuint
                    }

                    NumberAnimation {
                        target: border
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: topShape
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: bottomShape
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: focusShape
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

                    ColorAnimation {
                        target: buttonText
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: border
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: topShape
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: bottomShape
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: focusShape
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

                    ColorAnimation {
                        target: buttonText
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: border
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    
                    NumberAnimation {
                        target: topShape
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: bottomShape
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: focusShape
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                }
            }
        ]
    }
}
