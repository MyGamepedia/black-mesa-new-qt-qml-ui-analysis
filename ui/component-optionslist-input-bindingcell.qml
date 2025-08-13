import QtQuick 2.9
import CrowbarCollective 1.0

Item { id: root
    objectName: "ui:option-item"
    readonly property string type: "binding"

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

    Rectangle { id: background
        anchors.fill: parent
        color: Theme.colors.highlight
        opacity: 0
    }

    MouseArea { id: clicker
        anchors.fill: parent
        hoverEnabled: true
        scrollGestureEnabled: false

        function makeSelectionRequest() {
            root.requestInputSelection(function beginBinding() {
                clicker.state = "binding";
            }, function endBinding(event) {
                clicker.state = clicker.containsMouse ? "focused" : "blurred";
            });
        }

        function startBinding() {
            InputBindingsManager.startBindingRequest();
        }

        Text { id: text
            anchors.centerIn: parent

            font.capitalization: Font.AllUppercase
            font.family: Theme.fonts.bold
            font.pixelSize: Math.ceil(24 * Theme.heightScale)

            text: key
        }

        state: "blurred"
        states: [
            State {
                name: "focused"
                PropertyChanges { target: text; color: Theme.colors.highlight }
                PropertyChanges { target: background; opacity: 0.2 }
                StateChangeScript {
                    script: {
                        Sound.playEffect(Theme.sounds.buttonFocused);
                    }
                }
            },
            State {
                name: "blurred"
                PropertyChanges { target: text; color: Theme.colors.buttonText }
                PropertyChanges { target: background; opacity: 0 }
            },
            State {
                name: "selected"
                PropertyChanges { target: text; color: Theme.colors.text }
                PropertyChanges { target: background; opacity: 0.5 }
            },
            State {
                name: "binding"
                PropertyChanges { target: text; color: "transparent" }
                PropertyChanges { target: background; opacity: 1  }
            }
        ]

        onEntered: {
            if (state !== "binding" && state !== 'selected') {
                state = "focused"
            }
        }

        onExited: {
            if (state !== "binding" && state !== 'selected') {
                state = "blurred"
            }
        }

        onClicked: function(event) {
            if (state !== "binding" && state !== 'selected') {
                makeSelectionRequest();
            } else if (state === 'selected') {
                startBinding();
            }

            mouse.accepted = true;
        }

        transitions: [
            Transition {
                from: "blurred"
                to: "focused"
                reversible: true

                ColorAnimation {
                    target: text
                    duration: 150
                    easing.type: Easing.OutQuint
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

                    ColorAnimation {
                        target: background
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

                    ColorAnimation {
                        target: background
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

                    ColorAnimation {
                        target: background
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                }
            }
        ]
    }
}
