import QtQuick 2.9
import CrowbarCollective 1.0


FocusScope { id: optionRow
    property variant model
    
    property int labelFontSize: Math.ceil(28 * Theme.heightScale)
    property int separatorFontSize: Math.ceil(38 * Theme.heightScale)
    
    property int labelPaddingLeft: Math.ceil(18 * Theme.widthScale)
    
    property int rightAllMargin: Math.ceil(34 * Theme.widthScale)
    property int rightComponentWidth: Math.ceil(518 * Theme.widthScale)
    property int rightComponentPaddingRight: Math.ceil(26 * Theme.widthScale)
    
	property bool isSeparator: ( model.type === "separator" )
    
    property color bsInnerColor: Theme.colors.highlight
    property color bsOuterColor: Theme.colors.bssecondaryhighlight
    
    property real bsInnerOpacity: Theme.opacity.bsPrimary
    property real bsOuterOpacity: Theme.opacity.bsSecondary
	
    property real gradPosOuterFirst: isSeparator ? 0.47 :  0.7
    property real gradPosOuterSecond: isSeparator ? 0.53 :  0.77

    property int innerRectMargin: Math.ceil(4 * Theme.heightScale)
    
    readonly property QtObject inputComponents: QtObject {
        readonly property string select: "component-optionslist-input-select.qml"
        readonly property string slider: "component-optionslist-input-slider.qml"
        readonly property string separator: "component-optionslist-input-title.qml"
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
    anchors.rightMargin: rightAllMargin
    state: activeFocus ? "focused" : "blurred"
	
    MouseArea { id: optionRowArea
        enabled: optionRow.model && !optionRow.model.disabled
        hoverEnabled: true
        anchors.fill: parent
        onEntered: {
            Sound.playEffect("sndfocus");
				if ( optionRow.state === "focused" ) {
					optionRow.state = "focused"
				} else {
					optionRow.state = "focused"
					forceActiveFocus();
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
            optionRow.state = "blurred";
        }
    }

    Rectangle { id: border
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 0

        rotation: -90
        
        width: parent.height
        height: parent.width
        
        color: "transparent"
        
        Rectangle { id: focusShape
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            
            anchors.leftMargin: innerRectMargin - Math.ceil(1 * Theme.heightScale)
            anchors.rightMargin: innerRectMargin
			
            visible: !isSeparator
            opacity: bsInnerOpacity
            
            height: parent.height
            width: parent.width
            
            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.67; color: bsInnerColor }
                GradientStop { position: 0.80; color: bsInnerColor }
                GradientStop { position: 1; color: "transparent" }
            }
            
        }
        
        Rectangle { id: topShape
            anchors.top: parent.top
            anchors.right: parent.right
            
            width: Math.ceil(8 * Theme.heightScale)
            height: parent.height
            
            visible: !isSeparator
            opacity: bsOuterOpacity
            
            gradient: Gradient {
                GradientStop { position: 0.05; color: "transparent" }
                GradientStop { position: 0.7; color: bsOuterColor }
                GradientStop { position: 0.77; color: bsOuterColor }
                GradientStop { position: 0.95; color: "transparent" }
            }
            
        }

        Rectangle { id: bottomShape
            anchors.top: parent.top
            anchors.left: parent.left
            
            width: isSeparator ? Math.floor(2 * Theme.heightScale) : Math.ceil(6 * Theme.heightScale)
            height: parent.height
            
            opacity: bsOuterOpacity
            
            gradient: Gradient {
                GradientStop { position: 0.05; color: "transparent" }
                GradientStop { position: gradPosOuterFirst; color: bsOuterColor }
                GradientStop { position: gradPosOuterSecond; color: bsOuterColor }
                GradientStop { position: 0.95; color: "transparent" }
            }
            
        }

        
    }


    Text { id: labelText
        width: ( parent.width / 2 ) + ( ( model.type === "checkbox" ) ? Math.ceil(428 * Theme.widthScale) : ( ( model.type === "slider" ) ? Math.ceil(53 * Theme.widthScale) : Math.ceil(-23 * Theme.widthScale) ) )
        height: parent.height
		
		clip: true
		elide: Text.ElideRight
		
		
        anchors.left: parent.left
        anchors.leftMargin: labelPaddingLeft

        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter

        font.capitalization: Font.AllUppercase
        font.family: Theme.fonts.regular
        font.pixelSize: labelFontSize

        text: model && L10n.getString(model.label)

        Component.onCompleted: {
            // separator is a special Text having a different formatting.
            if ( isSeparator ) {
                labelText.font.family = Theme.fonts.regular;
				labelText.font.bold = true;
                labelText.color = Theme.colors.buttonText;
                labelText.opacity = 1;
                
                labelText.width = parent.width;
                
                
                labelText.anchors.verticalCenter = parent.verticalCenter;
				labelText.anchors.verticalCenterOffset = Math.ceil(2 * Theme.heightScale)
                labelText.horizontalAlignment = Text.AlignHCenter;
                
                labelText.font.pixelSize = separatorFontSize;
                labelText.font.capitalization = Font.AllUppercase;
                
            }

            // reduce size of the label text if it's too long.
            //if ( text.length > 50 ) {
            //    labelText.font.pixelSize = (labelFontSize * 22) / 28
            //}
        }
    }


    Loader { id: loader
        width: rightComponentWidth
        height: parent.height

        anchors.right: parent.right
        anchors.rightMargin: rightComponentPaddingRight

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
            PropertyChanges { target: labelText; color: model.fake ? Theme.colors.warning : Theme.colors.buttonText; anchors.leftMargin: labelPaddingLeft + ( !isSeparator ? Math.ceil(4 * Theme.heightScale) : 0 ) }
            PropertyChanges { target: loader; anchors.rightMargin: rightComponentPaddingRight + Math.ceil(4 * Theme.heightScale) }
            PropertyChanges { target: border; opacity: 1 }
        },
        State {
            name: "blurred"
            PropertyChanges { target: labelText; color: model.fake ? Theme.colors.warning : Theme.colors.buttonText; anchors.leftMargin: labelPaddingLeft }
            PropertyChanges { target: loader; anchors.rightMargin: rightComponentPaddingRight }
            PropertyChanges { target: border; opacity: 0 }
        },
        State {
            name: "disabled"
            PropertyChanges { target: labelText; color: Theme.colors.dimmedText }
            PropertyChanges { target: border; opacity: 0 }
        }
    ]
    transitions: [
        Transition {
            from: "blurred"
            to: "focused"
            reversible: false

            ParallelAnimation {
			
            
                ColorAnimation { target: labelText; duration: 150 }
            
                NumberAnimation {
                    target: labelText
                    property: "anchors.leftMargin"
                    duration: 150
                    easing.type: Easing.OutQuint
                }
                    
                NumberAnimation {
                    target: loader
                    property: "anchors.rightMargin"
                    duration: 150
                    easing.type: Easing.OutQuint
                }
                    
                NumberAnimation {
                    target: border
                    property: "opacity"
                    duration: 150
                    easing.type: Easing.OutQuint
                }
            }
        },
        Transition {
            from: "focused"
            to: "blurred"
            reversible: false

            ParallelAnimation {
            
                ColorAnimation { target: labelText; duration: 150 }
            
                NumberAnimation {
                    target: labelText
                    property: "anchors.leftMargin"
                    duration: 150
                    easing.type: Easing.OutQuint
                }
                    
                NumberAnimation {
                    target: loader
                    property: "anchors.rightMargin"
                    duration: 150
                    easing.type: Easing.OutQuint
                }
                    
                NumberAnimation {
                    target: border
                    property: "opacity"
                    duration: 150
                    easing.type: Easing.OutQuint
                }
            }
        },
            Transition {
                from: "blurred"
                to: "disabled"
                reversible: true

                ParallelAnimation {
            
                ColorAnimation { target: labelText; duration: 150 }
                    
                    NumberAnimation {
                        target: border
                        property: "opacity"
                        duration: 150
                        easing.type: Easing.OutQuint
                    }
                }
            }
    ]
}
