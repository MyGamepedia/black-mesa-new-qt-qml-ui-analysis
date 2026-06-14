import QtQuick 2.9
import CrowbarCollective 1.0

Item { id: bindcellItem
    height: parent.height
    width: parent.width

    property string key
    property bool selected

    signal requestInputSelection(var begin, var end)

    onSelectedChanged: {
        if (clicker.state === 'binding') {
            return;
        }

        if (selected) {
            clicker.state = 'selected';
        } else {
            clicker.state = clicker.containsMouse ? 'focused' : 'blurred';
        }
    }
    
    Keys.onUpPressed: {
        if (!selected) {
			BlackMesaUtils.addedIndx = -1;
            BlackMesaUtils.traverseBackward();
            BlackMesaUtils.updateCurrentUISelection();
        }
    }
    
    Keys.onDownPressed: {
        if (!selected) {
			BlackMesaUtils.addedIndx = 1;
            BlackMesaUtils.traverseForward();
            BlackMesaUtils.updateCurrentUISelection();
        }
    }
    
    Rectangle { id: background
        height: Math.ceil(30 * Theme.heightScale)
        width: parent.width
        anchors.top: parent.top
        anchors.topMargin: Math.ceil(14 * Theme.heightScale)
        opacity: 0
        
        color: "transparent"
        
        Rectangle { id: bgShape
            anchors.verticalCenter: background.bottom
            anchors.horizontalCenter: background.horizontalCenter
            width: Math.ceil(2 * Theme.widthScale)
            height: background.width
            rotation: -90

            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.5; color: (clicker.state === "blurred") ? bsOuterColor : Theme.colors.buttonText }
                GradientStop { position: 1; color: "transparent" }
            }
        }
    }

    MouseArea { id: clicker
        anchors.fill: parent
        hoverEnabled: true
        scrollGestureEnabled: false

        function makeSelectionRequest() {
            bindcellItem.requestInputSelection(
            function beginBinding() {
                clicker.state = "binding";
            },
            
            function endBinding(event) {
                clicker.state = "focused";
            });
        }

        function startBinding() {
            InputBindingsManager.startBindingRequest();
        }

        Text { id: text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: Math.ceil(3 * Theme.heightScale)
            anchors.top: parent.top
            anchors.topMargin: Math.ceil(3 * Theme.heightScale)

            font.family: Theme.fonts.controlsIcons
            font.pixelSize: Math.ceil(32 * Theme.heightScale)
            
            text: BlackMesaUtils.getKeyIcon(key)
        }

        state: "blurred"
        states: [
            State {
                name: "focused"
                PropertyChanges { target: bindcellItem.parent.parent.parent.parent.parent; state: "focused" }
                PropertyChanges { target: text; color: Theme.colors.buttonText; anchors.topMargin: Math.ceil(3 * Theme.heightScale); opacity: 1.0 }
                PropertyChanges { target: background; opacity: 0.75 }
                PropertyChanges { target: bgShape; height: background.width / 2 }
                StateChangeScript {
                    script: {
                        Sound.playEffect("sndfocus");
                    }
                }
            },
            State {
                name: "blurred"
                PropertyChanges { target: bindcellItem.parent.parent.parent.parent.parent; state: "blurred" }
                PropertyChanges { target: text; color: Theme.colors.buttonText; anchors.topMargin: Math.ceil(7 * Theme.heightScale); opacity: 1.0 }
                PropertyChanges { target: background; opacity: 0 }
                PropertyChanges { target: bgShape; height: 0 }
            },
            State {
                name: "selected"
                PropertyChanges { target: bindcellItem.parent.parent.parent.parent.parent; state: "focused" }
                PropertyChanges { target: text; color: Theme.colors.buttonText; anchors.topMargin: Math.ceil(3 * Theme.heightScale); opacity: 1.0 }
                PropertyChanges { target: background; opacity: 1 }
                PropertyChanges { target: bgShape; height: background.width }
            },
            State {
                name: "binding"
                PropertyChanges { target: bindcellItem.parent.parent.parent.parent.parent; state: "focused" }
                PropertyChanges { target: text; color: "transparent"; anchors.topMargin: Math.ceil(3 * Theme.heightScale); opacity: 1.0 }
                PropertyChanges { target: background; opacity: 1  }
                PropertyChanges { target: bgShape; height: background.width }
            }
        ]

        property var callback: function() {
            if (state !== "binding" && state !== 'selected') {
                makeSelectionRequest();
            } else if (state === 'selected') {
                startBinding();
            }
        }

        onEntered: {
            if (state !== "binding" && state !== 'selected') {
                state = "focused";
				forceActiveFocus();
            }
        }

        onExited: {
            if (state !== "binding" && state !== 'selected') {
                state = "blurred"
            }
        }

        onClicked: {
            callback();
            Sound.playEffect("sndclick");
            mouse.accepted = true;
        }

        transitions: [
            Transition {
                from: "blurred"
                to: "focused"
				
				ScriptAction {
					script: {
						onSelectionChanged(optionRow.model.type);
					}
				}
				
                ParallelAnimation {
                    ColorAnimation {
                        target: text
                        duration: 150
                        easing.type: Easing.OutQuint
                    }

                    NumberAnimation {
                        target: text
                        property: "anchors.topMargin"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: bgShape
                        property: "height"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                }
            },
            Transition {
                from: "focused"
                to: "blurred"

                ParallelAnimation {
                    ColorAnimation {
                        target: text
                        duration: 150
                        easing.type: Easing.OutQuint
                    }

                    NumberAnimation {
                        target: text
                        property: "anchors.topMargin"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: bgShape
                        property: "height"
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
                    ColorAnimation {
                        target: text
                        duration: 150
                        easing.type: Easing.OutQuint
                    }

                    NumberAnimation {
                        target: text
                        property: "anchors.topMargin"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: bgShape
                        property: "height"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                }
            },

            Transition {
                from: "selected"
                to: "binding"
                reversible: true

                ParallelAnimation {
                    ColorAnimation {
                        target: text
                        duration: 150
                        easing.type: Easing.OutQuint
                    }

                    NumberAnimation {
                        target: text
                        property: "anchors.topMargin"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: bgShape
                        property: "height"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                }
            },

            Transition {
                from: "binding"
                to: "focused"
                reversible: true

                ParallelAnimation {
                    ColorAnimation {
                        target: text
                        duration: 150
                        easing.type: Easing.OutQuint
                    }

                    NumberAnimation {
                        target: text
                        property: "anchors.topMargin"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                    
                    NumberAnimation {
                        target: bgShape
                        property: "height"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                }
            }
        ]
    }
}
