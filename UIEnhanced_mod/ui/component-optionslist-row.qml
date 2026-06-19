import QtQuick 2.9
import CrowbarCollective 1.0


FocusScope { id: optionRow
    property variant model

    property int labelFontSize: Math.ceil(24 * Theme.heightScale)
    property int labelPaddingRight: Math.ceil(48 * Theme.widthScale)

    readonly property QtObject inputComponents: QtObject {
        readonly property string select: "component-optionslist-input-select.qml"
        readonly property string slider: "component-optionslist-input-slider.qml"
        readonly property string separator: "component-optionslist-input-separator.qml"
        readonly property string binding: "component-optionslist-input-binding.qml"
        readonly property string text: "component-optionslist-input-text.qml"
        readonly property string checkbox: "component-optionslist-input-checkbox.qml"
        readonly property string map: "component-optionslist-input-map.qml"
    }

    signal requestSettingsChange(var model, var value)

    Binding {
        target: loader.item
        property: "state"
        value: state
        when: loader.item
    }


    anchors.fill: parent
    state: activeFocus ? "focused" : "blurred"

    MouseArea { id: optionRowArea
        enabled: optionRow.model && !optionRow.model.disabled
        hoverEnabled: true
        anchors.fill: parent
        onEntered: {
            if ( optionRow.model.type !==  "separator" ) { // a separator is not affected by mouse event
                Sound.playEffect(Theme.sounds.buttonFocused);
                optionRow.state = "focused";
                if ( typeof(onSelectionChanged) !== "undefined" ) { // if the entry has a 'onSelectionChanged' event
                    onSelectionChanged(optionRow.model);
                }
            }
        }

        onEnabledChanged: {
            var newState;

            if (!enabled) {
                newState = "disabled"
            } else {
                newState = optionRowArea.containsMouse ? "focused" : "blurred"
            }

            optionRow.state = newState
        }

        onExited: {
            if ( model.type !==  "separator" ) { // a separator is not affected by mouse event
                optionRow.state = "blurred";
            }
        }
    }

    Text { id: labelText
        width: parent.width / 2
        height: parent.height

        anchors.left: parent.left
        anchors.leftMargin: 48*Theme.widthScale
        rightPadding: labelPaddingRight

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight

        font.capitalization: Font.AllUppercase
        font.family: Theme.fonts.regular
        font.pixelSize: labelFontSize

        text: model && L10n.getString(model.label)

        Component.onCompleted: {
            // separator is a special Text having a different formatting.
            if ( model.type === "separator" ) {
                labelText.font.family = Theme.fonts.bold;
                labelText.color = Theme.colors.highlight;
                labelText.anchors.verticalCenter = parent.verticalCenter;
                labelText.font.pixelSize = headerFontSize;
                labelText.font.capitalization = Font.AllUppercase;
                labelText.leftPadding = headerMargin;
                horizontalAlignment = Text.AlignLeft;
            }

            // reduce size of the label text if it's too long.
            if ( text.length > 30 ) {
                labelText.font.pixelSize = (labelFontSize * 22) / 28
            }
        }


    }

    Loader { id: loader
        width: (parent.width / 2) - (128*Theme.widthScale)
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
