import QtQuick 2.9

MouseArea { id: optionRow
    property variant model

    signal requestSettingsChange(var model, var value)

    enabled: model && !model.disabled
    hoverEnabled: true

    onEnabledChanged: {
        var newState;

        if (!enabled) {
            newState = "disabled"
        } else {
            newState = optionRow.containsMouse ? "focused" : "blurred"
        }

        state = newState
    }

    Binding {
        target: loader.item
        property: "state"
        value: state
        when: loader.item
    }

    anchors.fill: parent

    state: "blurred"
    states: [
        State {
            name: "focused"
            PropertyChanges { target: labelText; color: Theme.colors.highlight }
        },
        State {
            name: "blurred"
            PropertyChanges { target: labelText; color: model.fake ? Theme.colors.warning : Theme.colors.buttonText }
        },
        State {
            name: "disabled"
            PropertyChanges { target: labelText; color: Theme.colors.dimmedText }
        }
    ]

    onEntered: {
        Sound.playEffect(Theme.sounds.buttonFocused);
        state = "focused"
    }

    onExited: {
        state = "blurred";
    }

    property int labelFontSize: Math.ceil(28 * Theme.heightScale)
    property int labelPaddingRight: Math.ceil(100 * Theme.widthScale)
    property int inputWidth: Math.ceil((parent.width / 2) - (300 * Theme.widthScale))

    Text { id: labelText
        width: parent.width / 2
        height: parent.height

        font.capitalization: Font.AllUppercase
        font.family: Theme.fonts.regular
        font.pixelSize: labelFontSize

        anchors.left: parent.left
        rightPadding: labelPaddingRight

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight

        text: model && L10n.getString(model.label)
    }

    readonly property QtObject inputComponents: QtObject {
        readonly property string select: "component-optionslist-input-select.qml"
        readonly property string slider: "component-optionslist-input-slider.qml"
        readonly property string binding: "component-optionslist-input-binding.qml"
    }

    Loader { id: loader
        width: inputWidth
        height: parent.height

        anchors.left: labelText.right

        Component.onCompleted: {
            var properties = {
                    model: model,
                    state: optionRow.state
                },
                url = inputComponents[model.type];

            if (!model) {
                console.error("OptionRow Component does not have a model to give to", url);
            } else {
                loader.setSource(url, properties);
            }
        }

        onLoaded: {
            var item = loader.item

            if (item) {
                item.requestSettingsChange && item.requestSettingsChange.connect(requestSettingsChange);
            }
        }
    }

    transitions: [
        Transition {
            from: "blurred"
            to: "focused"

            ColorAnimation { target: labelText; duration: 75 }
        },
        Transition {
            from: "focused"
            to: "blurred"

            ColorAnimation { target: labelText; duration: 75 }
        },
        Transition {
            from: "blurred"
            to: "disabled"

            ColorAnimation { target: labelText; duration: 350 }
        },
        Transition {
            from: "disabled"
            to: "blurred"

            ColorAnimation { target: labelText; duration: 350 }
        }
    ]
}
