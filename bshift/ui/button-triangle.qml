import QtQuick 2.9
import CrowbarCollective 1.0

MouseArea { id: container
    property string imageSource: "image://game/ui/images/warning" + Theme.setImgDef

    hoverEnabled: true
    height: parent.height
    width: 30

    onEnabledChanged: {
        if (!enabled) {
            state = "blurred"
        }
    }

    onEntered: {
        Sound.playEffect("sndfocus");
        state = "focused"
    }

    onExited: {
        state = "blurred"
    }

    state: "blurred"
    states: [
        State {
            name: "blurred"
            when: !container.activeFocus
            PropertyChanges { target: icon; opacity: 0.77 }
        },
        State {
            name: "focused"
            when: container.activeFocus
            PropertyChanges { target: container.parent.parent.parent; state: "focused" }
            PropertyChanges { target: icon; opacity: 1 }
        }
    ]


    Image {
        id: icon
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit

        source: imageSource

        Behavior on opacity {
            OpacityAnimator {
                duration: 150
            }
        }
    }


    transitions: [
        Transition {
            from: "blurred"
            to: "focused"
            reversible: true

                    NumberAnimation {
                        target: icon
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
        }
    ]
}
