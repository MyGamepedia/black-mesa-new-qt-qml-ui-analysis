import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import CrowbarCollective 1.0

Item { id: textInput
    objectName: "ui:option-item"
    readonly property string type: "text"

    property variant model
    property bool selectedValue
    property int valueTextFontSize: Math.ceil(22 * Theme.heightScale)

    signal requestSettingsChange(var model, var value)

    anchors.fill: parent

//    onSelectedValueChanged: {}

    Binding {
        target: textInput
        property: "selectedValue"
        value: model.value
        when: model
    }

    state: "blurred"

    TextField { id: textField
        anchors.fill: parent
        anchors.topMargin: 8 * Theme.heightScale
        anchors.bottomMargin: 8 * Theme.heightScale
        anchors.leftMargin: 32 * Theme.widthScale
        anchors.rightMargin: 32 * Theme.widthScale

        font.pixelSize: valueTextFontSize;
        font.family: Theme.fonts.regular

        text: model.value
        background: Rectangle {
            anchors.fill: parent
            color: Theme.colors.modalBackground
        }

        onTextChanged: {
            textInput.requestSettingsChange(model, textField.text)
        }

        Behavior {
            ColorAnimation  { duration: 75 }
        }
    }

    states: [
        State {
            name: "focused"
            PropertyChanges { target: textField; color: Theme.colors.highlight }
        },
        State {
            name: "blurred"
            PropertyChanges { target: textField; color: Theme.colors.buttonText }
        },
        State {
            name: "disabled"
            PropertyChanges { target: textField; color: Theme.colors.dimmedText }
        }
    ]
}
