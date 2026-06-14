import QtQuick 2.9
import CrowbarCollective 1.0

Item { id: selectInput
    objectName: "ui--navigation:option-item:level_2"
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
            var found = 0;
            for (var i = 0; i < model.options.count; i++) {
                if (model.value === model.options.get(i).value) {
                    selectedIndex = i;
                    found = 1;
                }
            }
            if ( found === 0 ) {
                console.warn(model.label, ": No select for value: ", model.value);
            }
        }
    }

    property bool warningEnabled: model.options.get(selectedIndex).warning ? true : false;
    property int selectedIndex: 0
    property variant selectedValue

    state: "blurred"
    states: [
        State {
            name: "focused"
            when: selectInput.activeFocus
            PropertyChanges { target: selectInput.parent.parent; state: "focused" }
            PropertyChanges { target: selectedValueText; color:  warningEnabled ? Theme.colors.warning : Theme.colors.buttonText; opacity: 1 }
            PropertyChanges { target: leftArrow; opacity: 1 }
            PropertyChanges { target: rightArrow; opacity: 1 }
            
        },
        State {
            name: "blurred"
            when: !selectInput.activeFocus
            PropertyChanges { target: selectInput.parent.parent; state: "blurred" }
            PropertyChanges { target: selectedValueText; color: warningEnabled ? Theme.colors.warning : Theme.colors.buttonText; opacity: 1 }
            PropertyChanges { target: leftArrow; opacity: 0 }
            PropertyChanges { target: rightArrow; opacity: 0 }
        },
        State {
            name: "disabled"
            PropertyChanges { target: selectInput.parent.parent; state: "disabled" }
            PropertyChanges { target: selectedValueText; color: Theme.colors.dimmedText; opacity: 1 }
            PropertyChanges { target: leftArrow; opacity: 0 }
            PropertyChanges { target: rightArrow; opacity: 0 }
        }
    ]

    property int valueTextFontSize: Math.ceil(22 * Theme.heightScale)
    property int labelFontSize: Math.ceil(28 * Theme.heightScale)
    
    property int tabHeight: Math.ceil(2 * Theme.heightScale)
    property int tabSpacing: 0
    
    property int triangleHeight: Math.ceil(28 * Theme.heightScale)
    property int triangleButtonWidth: Math.ceil(30 * Theme.widthScale)
    
    property color bsOuterColor: Theme.colors.bssecondaryhighlight

    /**
     * Handle joystick/keyboard navigation
     */
    Keys.onLeftPressed: {
        var currIndex = parseInt(selectedIndex);
        var totalItems = parseInt(model.options.count) - 1;

        if ( currIndex > 0 ) {
			Sound.playEffect("sndclick");
            selectedIndex = currIndex - 1;
        }

        selectInput.requestSettingsChange(model, model.options.get(selectedIndex).value);
    }

    Keys.onRightPressed: {
        var currIndex = parseInt(selectedIndex);
        var totalItems = parseInt(model.options.count) - 1;

        if ( currIndex < totalItems ) {
			Sound.playEffect("sndclick");
            selectedIndex = currIndex + 1;
        }

        selectInput.requestSettingsChange(model, model.options.get(selectedIndex).value);
    }





    TriangleButton { id: leftArrow
        width: triangleButtonWidth
        height: triangleHeight
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: Math.ceil(1 * Theme.heightScale)

        visible: selectedIndex !== 0
        enabled: !model.disabled
        opacity: enabled ? 1.0 : 0.0
        anchors.left: parent.left

        imageSource: "image://game/ui/images/arrow_options_left" + Theme.setImgDef
        
        onClicked: {
			Sound.playEffect("sndclick");
            selectInput.requestSettingsChange(model, model.options.get(selectedIndex - 1).value);
        }

        Behavior on opacity {
            NumberAnimation { duration: 150 }
        }
    }
    
    
    
    
    



    Rectangle { id: bgShape
        visible: tabsContainer.visible
        anchors.centerIn: tabsContainer
        width: tabsContainer.height
        height: tabsContainer.width + Math.ceil(50 * Theme.widthScale)
        opacity: 0.75
        rotation: -90

        gradient: Gradient {
            GradientStop { position: 0; color: "transparent" }
            GradientStop { position: 0.5; color: bsOuterColor }
            GradientStop { position: 1; color: "transparent" }
        }
    }


    Row { id: tabsContainer
        visible: model.options.count > 2
        width: parent.width - ( leftArrow.width * 2 ) - Math.ceil(50 * Theme.widthScale)
        height: tabHeight

        anchors.verticalCenter: Text.verticalCenter
        anchors.left: leftArrow.right
        anchors.top: selectedValueText.bottom
        anchors.topMargin: Math.ceil(2 * Theme.heightScale)
        anchors.leftMargin: Math.ceil(25 * Theme.widthScale)
        anchors.rightMargin: triangleButtonWidth/2 + Math.ceil(25 * Theme.widthScale)
        spacing: tabSpacing

        Repeater { id: tabRepeater
            model: selectInput.model.options
            
            delegate: Rectangle {
                width: (tabsContainer.width - (tabsContainer.spacing * (tabRepeater.count - 1))) / tabRepeater.count
                height: tabsContainer.height

                color: "transparent"

                Rectangle { id: focusShapeHovered
                    anchors.centerIn: parent
                    width: parent.height * 2
                    height: parent.width
                    rotation: -90
                    visible: (index === selectedIndex) ? 1 : 0;
                    gradient: Gradient {
                        GradientStop { position: 0; color: "transparent" }
                        GradientStop { position: 0.5; color: warningEnabled ? Theme.colors.warning : Theme.colors.buttonText }
                        GradientStop { position: 1; color: "transparent" }
                    }
                }

            }
        }
    }





    Text { id: selectedValueText
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.verticalCenterOffset: tabsContainer.visible ? Math.ceil(-4 * Theme.heightScale) : 0

        font.family: Theme.fonts.regular
        font.bold: true
        font.pixelSize: tabsContainer.visible ? valueTextFontSize : labelFontSize
        font.capitalization: Font.AllUppercase
        text: L10n.getString(model.options.get(selectedIndex).label)
        
        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }




    TriangleButton { id: rightArrow
        width: triangleButtonWidth
        height: triangleHeight
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: Math.ceil(1 * Theme.heightScale)

        visible: selectedIndex !== model.options.count - 1
        enabled: !model.disabled
        opacity: enabled ? 1 : 0
        anchors.right: parent.right
        anchors.leftMargin: triangleButtonWidth/2

        imageSource: "image://game/ui/images/arrow_options_right" + Theme.setImgDef
        
        onClicked: {
			Sound.playEffect("sndclick");
            selectInput.requestSettingsChange(model, model.options.get(selectedIndex + 1).value);
        }

        Behavior on opacity {
            NumberAnimation { duration: 150 }
        }
    }




    // Warning sign  ( used for Video Options )
    Image { id: warningSign
        opacity: warningEnabled ? 1 : 0
        source: "image://game/ui/images/warning" + Theme.setImgDef
        height: Math.ceil(28 * Theme.heightScale)
        width: Math.ceil(28 * Theme.heightScale)
        anchors.left: parent.right
        anchors.leftMargin: Math.ceil(-7 * Theme.widthScale)
        fillMode: Image.Stretch
        anchors.verticalCenter: parent.verticalCenter

        onVisibleChanged: {
            if ( typeof(updateHeaderWarningVisibility) !== "undefined" ) { // if this option has a 'updateHeaderWarningVisibility' event
                updateHeaderWarningVisibility();
            }
        }
        
         Behavior on opacity {
            NumberAnimation { duration: 150 }
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
            ColorAnimation { target: selectedValueText; duration: 150 }
        },
        Transition {
            from: "focused"
            to: "blurred"
			
            ColorAnimation { target: selectedValueText; duration: 150 }
        },
        Transition {
            from: "blurred"
            to: "disabled"
            reversible: true

            ColorAnimation { target: selectedValueText; duration: 150 }
        }
    ]
}
