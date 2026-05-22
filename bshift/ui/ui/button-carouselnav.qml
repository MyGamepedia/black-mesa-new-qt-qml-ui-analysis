import QtQuick 2.9
import CrowbarCollective 1.0

MouseArea { id: carouselButton
    property string direction: "up"
    property alias scale: image.scale

    property int buttonHeight: Math.ceil(44 * Theme.heightScale)
    property int buttonWidth: Math.ceil(100 * Theme.heightScale)

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
        Sound.playEffect("sndfocus");
    }

    onExited: {
        state = "blurred"
    }

    onReleased: {
		Sound.playEffect("sndclick");
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
        height: buttonHeight
        width: buttonWidth

        source: direction === "up" ? "image://game/ui/images/arrow_up" + Theme.setImgDef : "image://game/ui/images/arrow_down" + Theme.setImgDef
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
    }
}
