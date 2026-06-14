import QtQuick 2.9
import CrowbarCollective 1.0

Item { id: checkboxInput
    objectName: "ui--navigation:option-item:level_2"
    property variant model
    property bool selectedValue
    
    property int rightPaddingSize: Math.ceil(63 * Theme.widthScale)
    property int borderWidth: Math.ceil(2 * Theme.heightScale)
    property int roundSizeOutline: Math.ceil(8 * Theme.heightScale)
    property int roundSizeInner: roundSizeOutline / 2
    property int marginSizeInner: borderWidth + Math.ceil(3 * Theme.heightScale)
    
    property color bsOuterColor: Theme.colors.bssecondaryhighlight

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
            when: checkboxInput.activeFocus
            PropertyChanges { target: checkboxInput.parent.parent; state: "focused" }
            PropertyChanges { target: fill; color: Theme.colors.buttonText }
        },
        State {
            name: "blurred"
            when: !checkboxInput.activeFocus
            PropertyChanges { target: checkboxInput.parent.parent; state: "blurred" }
            PropertyChanges { target: fill; color: Theme.colors.buttonText }
        },
        State {
            name: "disabled"
            PropertyChanges { target: checkboxInput.parent.parent; state: "disabled" }
            PropertyChanges { target: fill; color: "transparent" }
        }
    ]

    Rectangle { id: background
        width: Math.ceil(30 * Theme.heightScale)
        height: Math.ceil(30 * Theme.heightScale)
        
        border.width: borderWidth
        border.color: bsOuterColor
        radius: roundSizeOutline
        color: "transparent"
        opacity: 0.75
        
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: rightPaddingSize

        MouseArea {
            anchors.fill: parent
            enabled: !model.disabled

            onClicked: {
				Sound.playEffect("sndclick");
                checkboxInput.requestSettingsChange(model, model.value !== 'true' ? 'true' : 'false');
            }
        }
    }
    
    /**
     * Handle joystick/keyboard navigation
     */
    Keys.onEnterPressed: {
				Sound.playEffect("sndclick");
                checkboxInput.requestSettingsChange(model, model.value !== 'true' ? 'true' : 'false');
    }
    
    
    
        Rectangle { id: fill
            visible: model.value === "true"

            anchors.fill: background
            anchors.centerIn: background
            anchors.margins: marginSizeInner
            radius: roundSizeInner

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
