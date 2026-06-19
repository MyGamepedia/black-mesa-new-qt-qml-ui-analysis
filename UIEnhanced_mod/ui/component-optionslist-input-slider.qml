import QtQuick 2.9
import CrowbarCollective 1.0

Item { id: sliderInput
    objectName: "ui:option-item"
    readonly property string type: "slider"

    property variant model
    property real selectedValue
    property real sliderValue

    signal requestSettingsChange(var model, var value)

    anchors.fill: parent

    Binding {
        target: sliderInput
        property: "selectedValue"
        value: model.value
        when: model
    }

    onSelectedValueChanged: {
        setSliderValue(model.value);
    }

    readonly property QtObject formatters: QtObject {

        function percent(value) {
            return Number(value * 100).toFixed(0);
        }


        function decimal(value) {

            // the mode "replaceMinByOff" means we replace the value=min by OFF.  ( used in autoaim slider )
            if ( model.replaceMinByOff === "1" && Number(value) === Number(model.minValue) ) {
                return L10n.strings.options.values.off;
            }

            return Number(value).toFixed(model.precision);
        }


        function whole(value) {
            return Number(value).toFixed(0);
        }
    }

    function setSliderCoords(coords) {
        sliderValue = coordsToValue(coords);
        sliderHighlight.width = coords;
        sliderHandle.x = coords;
    }

    function setSliderValue(value) {
        var clampedValue = Math.min(Math.max(value, model.minValue), model.maxValue),
            coords = valueToCoords(clampedValue);

        sliderValue = clampedValue;
        sliderHighlight.width = coords;
        sliderHandle.x = coords;
    }

    function valueToCoords(value) {
        return (value - model.minValue) / (model.maxValue - model.minValue) * (sliderContainer.width - sliderHandle.width);
    }

    function coordsToValue(x) {
        var outval = model.minValue + (x / (sliderContainer.width - sliderHandle.width) * (model.maxValue - model.minValue));
        return Math.floor(outval/model.stepValue)*model.stepValue;
    }

    state: "blurred"
    states: [
        State {
            name: "focused"
            when: sliderInput.activeFocus
            PropertyChanges { target: sliderHighlight; color: Theme.colors.highlight }
            PropertyChanges { target: sliderHandle; color: Theme.colors.highlight; opacity: 1 }
            PropertyChanges { target: valueText; color: Theme.colors.highlight }
        },
        State {
            name: "blurred"
            when: !sliderInput.activeFocus
            PropertyChanges { target: sliderHighlight; color: Theme.colors.buttonText }
            PropertyChanges { target: sliderHandle; color: Theme.colors.buttonText; opacity: 1 }
            PropertyChanges { target: valueText; color: Theme.colors.buttonText }
        },
        State {
            name: "disabled"
            PropertyChanges { target: sliderHighlight; color: Theme.colors.dimmedSlider }
            PropertyChanges { target: sliderHandle; color: Theme.colors.dimmedText; opacity: 0 }
            PropertyChanges { target: valueText; color: Theme.colors.dimmedText }
        }
    ]

    property int sliderWidthPadding: Math.ceil(60 * Theme.widthScale)
    property int sliderMargin: Math.ceil(40 * Theme.widthScale)
    property int sliderHeight: Math.ceil(10 * Theme.heightScale)
    property int handleHeight: Math.ceil(30 * Theme.heightScale)
    property int handleWidth: Math.ceil(15 * Theme.heightScale)
    property int handleBorderWidth: Math.ceil(2 * Theme.widthScale)
    property int valueTextFontSize: Math.ceil(22 * Theme.heightScale)
    property int valueTextWidth: Math.ceil(50 * Theme.widthScale)

    Item { id: sliderContainer
        property bool didDrag: false

        width: parent.width - sliderMargin * 2
        height: parent.height
        anchors.left: parent.left
        anchors.leftMargin: sliderMargin
        anchors.rightMargin: sliderMargin
        anchors.verticalCenter: parent.verticalCenter

        Rectangle { id: sliderBackground
            color: Theme.colors.dimmedText
            opacity: 0.75
            height: sliderHeight
            width: parent.width
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            Rectangle { id: sliderHighlight
                height: parent.height
                anchors.left: parent.left

                Behavior on color {
                    ColorAnimation { duration: 75 }
                }

                Behavior on width {
                    enabled: !mouseArea.drag.active
                    NumberAnimation { duration: 350; easing.type: Easing.OutQuint }
                }
            }
        }

        Rectangle { id: sliderHandle
            width: handleWidth
            height: handleHeight
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0
            border.color: Theme.colors.modalBackground
            border.width: handleBorderWidth

            Behavior on color {
                ColorAnimation { duration: 75 }
            }

            Behavior on x {
                enabled: !mouseArea.drag.active
                NumberAnimation { duration: 350; easing.type: Easing.OutQuint }
            }

            Behavior on opacity {
                NumberAnimation { duration: 350; easing.type: Easing.OutQuint }
            }
        }

        MouseArea { id: mouseArea
            anchors.fill: parent
            enabled: !model.disabled

            drag.threshold: 0
            drag.target: sliderHandle
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: parent.width - handleWidth

            onPositionChanged: {
                !sliderContainer.didDrag && Sound.playEffect(Theme.sounds.buttonClicked);
                sliderContainer.didDrag = true;
                setSliderCoords(sliderHandle.x);
            }

            onClicked: {
                sliderInput.forceActiveFocus();
                sliderInput.state = "focused";
            }

            onReleased: {
                var didDrag = sliderContainer.didDrag,
                    coords = didDrag ? sliderHandle.x : mouseX,
                    value = coordsToValue(coords).toFixed(model.precision);

                !didDrag && Sound.playEffect(Theme.sounds.buttonClicked);
                sliderInput.requestSettingsChange(model, value.toString());
                sliderContainer.didDrag = false;
            }
        }
    }

    Text { id: valueText
        width: valueTextWidth
        anchors.left: sliderContainer.right
        anchors.leftMargin: 8
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.family: Theme.fonts.bold
        font.pixelSize: valueTextFontSize
        text: formatters[model.formatter](sliderValue)

        Behavior on color {
            ColorAnimation { duration: 75 }
        }
    }
}

