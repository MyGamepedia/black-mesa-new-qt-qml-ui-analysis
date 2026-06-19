import QtQuick 2.9
import QtGraphicalEffects 1.0

Item { id: mapInput
    objectName: "ui:option-item"
    readonly property string type: "map"

    property variant model
    property bool selectedValue

    property int chevronWidth: 16 * Theme.widthScale
    property int chevronHeight: 32 * Theme.heightScale

    signal requestSettingsChange(var model, var value)

    anchors.fill: parent
    anchors.margins: 0

    onSelectedValueChanged: {}

    Binding {
        target: mapInput
        property: "selectedValue"
        value: model.value
        when: model
    }

    state: "blurred"
    states: [
        State {
            name: "focused"
            when: activeFocus
            PropertyChanges { target: mapText; color: Theme.colors.highlight }
        },
        State {
            name: "blurred"
            when: !activeFocus
            PropertyChanges { target: mapText; color: Theme.colors.buttonText }
        },
        State {
            name: "disabled"
            PropertyChanges { target: mapText; color: Theme.colors.dimmedSlider }
        }
    ]

    Image { id: chevronLeft
        source: "image://game/ui/images/chevron-left.png"
        height: chevronHeight
        width: chevronWidth
        opacity: 0.5
        anchors.rightMargin: 8 * Theme.widthScale
        anchors.right: thumbnail.left
        anchors.verticalCenter: thumbnail.verticalCenter

        Behavior on opacity {
            NumberAnimation { duration: 75 }
        }

        MouseArea {
            enabled: !model.disabled
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                var currentIndex = model.options.indexOf(model.value);
                var index = currentIndex === 0 ? model.options.length - 1 : currentIndex - 1;

                mapInput.requestSettingsChange(model, model.options[index]);
            }

            onEntered: {
                Sound.playEffect(Theme.sounds.buttonFocused);
                chevronLeft.opacity = 1.0
            }

            onExited: {
                chevronLeft.opacity = 0.5;
            }
        }
    }

    Image { id: thumbnail
        anchors.fill: parent
        anchors.leftMargin: 32 * Theme.widthScale
        anchors.rightMargin: 32 * Theme.widthScale
        source: {
            return [
                "image://game/materials/vgui/multiplayer/map_backgrounds/",
                model.value,
                "_0_widescreen.vtf"
            ].join('');
        }
        // Used for lazy load of map thumbnail
        // so ui thread is not blocked
        asynchronous: true;

        Rectangle {
            color: Theme.colors.modalBackground
            opacity: 0.8
            width: parent.width
            anchors.bottom: parent.bottom
            height: 24

            Text { id: mapText
                text: model.value
                anchors.centerIn: parent
                font.pixelSize: 12
                color: Theme.colors.buttonText
            }
        }
    }

    Image { id: chevronRight
        source: "image://game/ui/images/chevron-right.png"
        height: chevronHeight
        width: chevronWidth
        opacity: 0.5
        anchors.leftMargin: 8 * Theme.widthScale
        anchors.left: thumbnail.right
        anchors.verticalCenter: thumbnail.verticalCenter

        Behavior on opacity {
            NumberAnimation { duration: 75 }
        }

        MouseArea {
            enabled: !model.disabled
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                var currentIndex = model.options.indexOf(model.value);
                var index = currentIndex === model.options.length - 1 ? 0 : currentIndex + 1;

                mapInput.requestSettingsChange(model, model.options[index]);
            }

            onEntered: {
                Sound.playEffect(Theme.sounds.buttonFocused);
                chevronRight.opacity = 1.0;
            }

            onExited: {
                chevronRight.opacity = 0.5;
            }
        }
    }
}
