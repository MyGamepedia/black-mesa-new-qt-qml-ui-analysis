import QtQuick 2.9
import CrowbarCollective 1.0

Item { id: checkboxInput
    objectName: "ui:option-item"
    readonly property string type: "checkbox"

    property variant model
    property bool selectedValue

    signal requestSettingsChange(var model, var value)

    anchors.fill: parent

    onSelectedValueChanged: {}

    Binding {
        target: checkboxInput
        property: "selectedValue"
        value: model.value
        when: model
    }

    state: "blurred"
    states: [
        State {
            name: "focused"
            PropertyChanges { target: fill; color: Theme.colors.highlight; border.color: Theme.colors.highlight }
        },
        State {
            name: "blurred"
            PropertyChanges { target: fill; color: Theme.colors.buttonText; border.color: Theme.colors.dimmedText }
        },
        State {
            name: "disabled"
            PropertyChanges { target: fill; color: Theme.dimmedSlider; border.color: Theme.colors.dimmedText }
        }
    ]

    Rectangle { id: background
        width: Math.ceil(50 * Theme.heightScale)
        height: Math.ceil(50 * Theme.heightScale)
        color: Theme.colors.modalBackground
        anchors.centerIn: parent

        MouseArea {
            anchors.fill: parent
            enabled: !model.disabled

            onClicked: {
                Sound.playEffect(Theme.sounds.buttonClicked);
                checkboxInput.requestSettingsChange(model, model.value !== 'true' ? 'true' : 'false');
            }
        }

        Rectangle { id: fill
            visible: model.value === "true"

            anchors.fill: parent
            anchors.centerIn: parent
            anchors.margins: Math.ceil(7 * Theme.widthScale)

            border.color: Theme.colors.dimmedText
            border.width: Math.ceil(2 * Theme.widthScale)

            Behavior on color {
                ColorAnimation { duration: 75 }
            }
        }
    }
}
