import QtQuick 2.9
import CrowbarCollective 1.0

MouseArea { id: container
    readonly property QtObject directions: QtObject {
        readonly property int left: -45
        readonly property int right: 135
    }

    property color focusedColor: Theme.colors.highlight
    property color blurredColor: Theme.colors.buttonText
    property int triangleHeight: 20
    property int triangleWidth: 20

    property int direction: directions.left

    hoverEnabled: true
    height: parent.height
    width: 30

    onEnabledChanged: {
        if (!enabled) {
            state = "blurred"
        }
    }

    onEntered: {
        Sound.playEffect(Theme.sounds.buttonFocused);
        state = "focused"
    }

    onExited: {
        state = "blurred"
    }

    state: "blurred"
    states: [
        State {
            name: "blurred"
            PropertyChanges { target: triangle; color: blurredColor }
        },
        State {
            name: "focused"
            PropertyChanges { target: triangle; color: focusedColor }
        }
    ]

    Triangle { id: triangle
        height: triangleHeight
        width: triangleWidth
        rotation: direction
        anchors.horizontalCenterOffset: direction === directions.left ? 5 : -5
        anchors.centerIn: parent
    }

    transitions: [
        Transition {
            from: "blurred"
            to: "focused"

            ColorAnimation { target: triangle; duration: 75 }
        },
        Transition {
            from: "focused"
            to: "blurred"

            ColorAnimation { target: triangle; duration: 75 }
        }
    ]
}
