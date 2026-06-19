import QtQuick 2.9

Item { id: selectInput
    property variant model

    signal requestSettingsChange(var model, var value)

    anchors.fill: parent

    Binding {
        target: selectInput
        property: "selectedValue"
        value: model.value
        when: model
    }

    onSelectedValueChanged: {
        if (model.options) {
            for (var i = 0; i < model.options.count; i++) {
                if (model.value === model.options.get(i).value) {
                    selectedIndex = i;
                }
            }
        }
    }

    property int selectedIndex: 0
    property variant selectedValue

    state: "blurred"
    states: [
        State {
            name: "focused"
            PropertyChanges { target: selectedValueText; color: Theme.colors.highlight }
        },
        State {
            name: "blurred"
            PropertyChanges { target: selectedValueText; color: Theme.colors.buttonText }
        },
        State {
            name: "disabled"
            PropertyChanges { target: selectedValueText; color: Theme.colors.dimmedText }
        }
    ]

    property int valueTextFontSize: Math.ceil(22 * Theme.heightScale)
    property int triangleButtonWidth: Math.ceil(30 * Theme.widthScale)
    property int tabHeight: Math.ceil(3 * Theme.heightScale)
    property int tabSpacing: Math.ceil(5 * Theme.widthScale)
    property int triangleHeight: Math.ceil(20 * Theme.heightScale)

    TriangleButton { id: leftArrow
        width: triangleButtonWidth
        height: parent.height
        triangleWidth: triangleHeight
        triangleHeight: triangleHeight
        direction: leftArrow.directions.left

        visible: selectedIndex !== 0
        enabled: !model.disabled
        opacity: enabled ? 1.0 : 0.0

        anchors.left: parent.left

        onClicked: {
            Sound.playEffect(Theme.sounds.buttonClicked);
            selectInput.requestSettingsChange(model, model.options.get(selectedIndex - 1).value);
        }

        Behavior on opacity {
            NumberAnimation { duration: 350 }
        }
    }

    Row { id: tabsContainer
        visible: model.options.count > 2
        width: parent.width - leftArrow.width * 2
        height: tabHeight

        anchors.left: leftArrow.right
        anchors.top: selectedValueText.bottom
        anchors.topMargin: 2
        spacing: tabSpacing

        Repeater { id: tabRepeater
            model: selectInput.model.options
            delegate: Rectangle {
                width: (tabsContainer.width - (tabsContainer.spacing * (tabRepeater.count - 1))) / tabRepeater.count
                height: tabsContainer.height
                opacity: 0.75

                color: {
                    var color = Theme.colors.dimmedText;

                    if (index === selectedIndex) {
                        color = selectInput.state === "focused" ? Theme.colors.highlight : Theme.colors.buttonText;
                    }

                    return color;
                }

                Behavior on color {
                    ColorAnimation { duration: 75 }
                }
            }
        }
    }

    Text { id: selectedValueText
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.verticalCenterOffset: model.options.count ? -2 : 0

        font.family: Theme.fonts.bold
        font.pixelSize: valueTextFontSize
        font.capitalization: Font.AllUppercase
        text: L10n.getString(model.options.get(selectedIndex).label)
    }

    TriangleButton { id: rightArrow
        width: triangleButtonWidth
        height: parent.height
        triangleWidth: triangleHeight
        triangleHeight: triangleHeight
        direction: rightArrow.directions.right

        visible: selectedIndex !== model.options.count - 1
        enabled: !model.disabled
        opacity: enabled ? 1.0 : 0.0
        anchors.right: parent.right

        onClicked: {
            Sound.playEffect(Theme.sounds.buttonClicked);
            selectInput.requestSettingsChange(model, model.options.get(selectedIndex + 1).value);
        }

        Behavior on opacity {
            NumberAnimation { duration: 350 }
        }
    }

    transitions: [
        Transition {
            from: "blurred"
            to: "focused"
            reversible: true

            ColorAnimation { target: selectedValueText; duration: 75 }
        },
        Transition {
            from: "blurred"
            to: "disabled"
            reversible: true

            ColorAnimation { target: selectedValueText; duration: 350 }
        }
    ]
}
