import QtQuick 2.9
import CrowbarCollective 1.0

MouseArea { id: carouselButton
    property string direction: "left"
    property alias scale: image.scale

    property int buttonHeight: Math.ceil(214 * Theme.widthScale)
    property int buttonWidth: Math.ceil(100 * Theme.widthScale)

    height: buttonHeight
    width: buttonWidth
    hoverEnabled: true

    state: "blurred"

    states: [
        State {
            name: "blurred"
            PropertyChanges { target: image; opacity: 0.5; }
        },
        State {
            name: "focused"
            PropertyChanges { target: image; opacity: 1; }
        }
    ]

    onEntered: {
        state = "focused"
        Sound.playEffect(Theme.sounds.buttonFocused);
    }

    onExited: {
        state = "blurred"
    }

    onReleased: {
        Sound.playEffect(Theme.sounds.buttonClicked);
    }

    transitions: [
        Transition {
            from: "blurred"
            to: "focused"

            ParallelAnimation {
                NumberAnimation {
                    target: image
                    property: "opacity"
                    duration: 150
                }
            }
        },
        Transition {
            from: "focused"
            to: "blurred"

            ParallelAnimation {
                NumberAnimation {
                    target: image
                    duration: 150
                    property: "opacity"
                }
            }
        }

    ]

    Image { id: image
        height: Math.ceil(sourceSize.height * Theme.widthScale)
        width: Math.ceil(sourceSize.width * Theme.widthScale)

        source: direction === "left" ? "image://game/ui/images/chevron-left.png" : "image://game/ui/images/chevron-right.png"
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
    }
}
