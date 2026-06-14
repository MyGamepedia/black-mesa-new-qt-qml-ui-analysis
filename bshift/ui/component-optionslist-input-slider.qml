import QtQuick 2.9
import CrowbarCollective 1.0

Item { id: sliderInput
    objectName: "ui--navigation:option-item:level_2"
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

    // ---------------------------------
    // Keyboard / Joystick control
    // ---------------------------------
    Keys.onLeftPressed: {
        var currentValue = parseFloat(model.value);
        var minValue = parseFloat(model.minValue);

        if (currentValue > minValue) {
            var valueDiff = currentValue - model.stepValue;
            sliderInput.requestSettingsChange(model, valueDiff.toString());
        }
    }

    Keys.onRightPressed: {
        var currentValue = parseFloat(model.value);
        var maxValue = parseFloat(model.maxValue);

        if (currentValue < maxValue) {
            var valueDiff = currentValue + model.stepValue;
            sliderInput.requestSettingsChange(model, valueDiff.toString());
        }
    }

    state: "blurred"
    states: [
        State {
            name: "focused"
            when: sliderInput.activeFocus
            PropertyChanges { target: sliderInput.parent.parent; state: "focused" }
            PropertyChanges { target: bgHighlightShape; opacity: 1 }
            PropertyChanges { target: sliderHandle; color: Theme.colors.buttonText; opacity: 1 }
            PropertyChanges { target: valueText; color: Theme.colors.buttonText; opacity: 1 }
        },
        State {
            name: "blurred"
            when: !sliderInput.activeFocus
            PropertyChanges { target: sliderInput.parent.parent; state: "blurred" }
            PropertyChanges { target: bgHighlightShape; opacity: 1 }
            PropertyChanges { target: sliderHandle; color: Theme.colors.buttonText; opacity: 1 }
            PropertyChanges { target: valueText; color: Theme.colors.buttonText }
        },
        State {
            name: "disabled"
            PropertyChanges { target: sliderInput.parent.parent; state: "disabled" }
            PropertyChanges { target: bgHighlightShape; opacity: 0 }
            PropertyChanges { target: sliderHandle; color: Theme.colors.dimmedText; opacity: 0 }
            PropertyChanges { target: valueText; color: Theme.colors.dimmedText }
        }
    ]

    property int sliderWidthPadding: Math.ceil(60 * Theme.widthScale)
    property int sliderMargin: Math.ceil(40 * Theme.widthScale)
    property int sliderHeight: Math.ceil(2 * Theme.heightScale)
    
    property int handleHeight: Math.ceil(40 * Theme.heightScale)
    property int handleWidth: sliderHeight * 2
    property int handleSecondHeight: Math.ceil(25 * Theme.heightScale)
    property int dotHeight: Math.ceil(20 * Theme.heightScale)
    property int dotCenterHeight: Math.ceil(15 * Theme.heightScale)
    
    property int valueTextFontSize: Math.ceil(22 * Theme.heightScale)
    property int valueTextWidth: Math.ceil(50 * Theme.widthScale)
    
    property color bsOuterColor: Theme.colors.bssecondaryhighlight

    Item { id: sliderContainer
        property bool didDrag: false

        width: parent.width - sliderMargin * 2 - Math.ceil(50 * Theme.widthScale)
        height: parent.height
        anchors.left: parent.left
        anchors.leftMargin: sliderMargin + Math.ceil(25 * Theme.widthScale)
        anchors.rightMargin: sliderMargin + Math.ceil(25 * Theme.widthScale)
        anchors.verticalCenter: parent.verticalCenter




        Rectangle { id: bgShape
            anchors.centerIn: sliderBackground
            width: sliderBackground.height
            height: sliderBackground.width + Math.ceil(50 * Theme.widthScale)
            opacity: 0.75
            rotation: -90

            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.5; color: bsOuterColor }
                GradientStop { position: 1; color: "transparent" }
            }
        }
    
        Rectangle { id: bgLeftShape
            anchors.verticalCenter: sliderBackground.verticalCenter
            width: sliderHeight
            height: dotHeight
            anchors.right: sliderBackground.left 
            opacity: 0.75

            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.5; color: bsOuterColor }
                GradientStop { position: 1; color: "transparent" }
            }
        }
        
        Rectangle { id: bgRightShape
            anchors.verticalCenter: sliderBackground.verticalCenter
            width: sliderHeight
            height: dotHeight
            anchors.left: sliderBackground.right 
            opacity: 0.75

            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.5; color: bsOuterColor }
                GradientStop { position: 1; color: "transparent" }
            }
        }
        
        Rectangle { id: bgCenterShape
            anchors.centerIn: sliderBackground
            width: sliderHeight
            height: dotCenterHeight
            opacity: 0.75

            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.5; color: bsOuterColor }
                GradientStop { position: 1; color: "transparent" }
            }
        }
    
    
    
        Rectangle { id: sliderBackground
            color: "transparent"
            height: sliderHeight
            width: parent.width
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            Rectangle { id: sliderHighlight
                height: handleWidth
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                color: "transparent"
                
                Rectangle { id: bgHighlightShape
                    anchors.centerIn: sliderHighlight
                    height: sliderHighlight.width
                    width: sliderHighlight.height
                    opacity: 1
                    rotation: -90

                    gradient: Gradient {
                        GradientStop { position: 0; color: "transparent" }
                        GradientStop { position: 1; color: Theme.colors.buttonText }
                    }
                }


                Behavior on width {
                    enabled: !mouseArea.drag.active
                    NumberAnimation { duration: 150; easing.type: Easing.OutQuint }
                }
            }
            
        }




        Rectangle { id: sliderHandle
            width: sliderHeight
            height: handleHeight
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0

            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.5; color: Theme.colors.buttonText }
                GradientStop { position: 1; color: "transparent" }
            }
            
            Rectangle { id: sliderSecondHandle
                width: handleWidth
                height: handleSecondHeight
                anchors.centerIn: sliderHandle
                opacity: 0.75

                gradient: Gradient {
                    GradientStop { position: 0; color: "transparent" }
                    GradientStop { position: 0.5; color: Theme.colors.buttonText }
                    GradientStop { position: 1; color: "transparent" }
                }
            }
            
            Behavior on color {
                ColorAnimation { duration: 75 }
            }

            Behavior on x {
                enabled: !mouseArea.drag.active
                NumberAnimation { duration: 150; easing.type: Easing.OutQuint }
            }

            Behavior on opacity {
                NumberAnimation { duration: 150; easing.type: Easing.OutQuint }
            }
        }

        MouseArea { id: mouseArea
            anchors.fill: parent
            enabled: !model.disabled

            drag.threshold: 0
            drag.target: sliderHandle
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: parent.width - sliderHeight

            onPositionChanged: {
                !sliderContainer.didDrag && Sound.playEffect("sndclick");
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

                !didDrag && Sound.playEffect("sndclick");
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
        font.family: Theme.fonts.regular
        font.bold: true
        font.pixelSize: valueTextFontSize
        text: formatters[model.formatter](sliderValue)

        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }
	
	
    transitions: [
        Transition {
            from: "blurred"
            to: "focused"
			
            ScriptAction {
                script: {
				
					if ( appRoot.isLeftMenuFocused ) {
						appRoot.isLeftMenuFocusedFunction( false );
					}
					
					onSelectionChanged(optionRow.model.type);
				}
			}
        }
    ]
	
}

