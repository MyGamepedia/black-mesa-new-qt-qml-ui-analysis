import QtQuick 2.9
import CrowbarCollective 1.0


FocusScope { id: otherRow
    objectName: "ui--navigation:other-item:level_2"
	
    property variant model
	
    property int labelPaddingLeft: Math.ceil(18 * Theme.widthScale)
    
    property bool linkDisabled: false
	
    property int rightAllMargin: Math.ceil(34 * Theme.widthScale)
    property int rightComponentPaddingRight: Math.ceil(26 * Theme.widthScale)
	
    property int titleFontSize: Math.ceil(48 * Theme.heightScale)
    property int separatorFontSize: Math.ceil(38 * Theme.heightScale)
    
    property color bsInnerColor: Theme.colors.highlight
    property color bsOuterColor: Theme.colors.bssecondaryhighlight
    
    property real bsInnerOpacity: Theme.opacity.bsPrimary
    property real bsOuterOpacity: Theme.opacity.bsSecondary
	
    property real gradPosOuterFirst: labelText.visible ? 0.47 :  0.14
    property real gradPosOuterSecond: labelText.visible ? 0.53 :  0.34

    property int innerRectMargin: Math.ceil(4 * Theme.heightScale)
	
    property int moveThatThing: Math.ceil(4 * Theme.heightScale)
    property real thatOneOpacity: 1
    
    readonly property QtObject inputComponents: QtObject {
        readonly property string title: "component-optionslist-input-separator.qml"			//for title
        readonly property string subtitle: "component-optionslist-input-separator.qml"		//for title
        readonly property string credits: "component-otherlist-credits.qml"					//for credits
    }

    anchors.left: parent.left
	anchors.right: parent.right
	anchors.top: parent.top
	height: loader.height
    anchors.rightMargin: rightAllMargin
    state: activeFocus ? "focused" : "blurred"
	
	
    Keys.onEnterPressed: {
		if ( otherRow.model.link ) {
		//	otherRow.linkDisabled = true;
			Sound.playEffect("sndclick")
		//	linkClicked.start();
		//	
			BlackMesaUtils.setTimeout(function() {
				Qt.openUrlExternally(otherRow.model.link)
			}, 500);
		}
    }

    MouseArea { id: otherRowArea
        enabled: otherRow.model && !otherRow.model.disabled
        hoverEnabled: true
        anchors.fill: parent
		
        onEntered: {
				
				if ( otherRow.state === "focused" ) {
					otherRow.state = "focused"
				} else {
					otherRow.state = "focused"
					forceActiveFocus();
				}
        }
		
		
        onClicked: {
			if ( otherRow.model.link ) {
				Sound.playEffect("sndclick")
				//BlackMesaEngine.activateSteamOverlayToWebPage( otherRow.model.link );
				
				BlackMesaUtils.setTimeout(function() {
					Qt.openUrlExternally(otherRow.model.link)
				}, 500);
			}
        }

        onEnabledChanged: {
            var newState;

            if (!enabled) {
                newState = "disabled"
            } else {
                newState = otherRowArea.containsMouse ? "focused" : "blurred"
            }

            otherRow.state = newState
        }

        onExited: {
                otherRow.state = "blurred";
        }
    }

    Rectangle { id: border
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 0

        rotation: -90
        
        width: parent.height
        height: parent.width
        
        color: "transparent"
        
		
        // flag background
        Image {
            id: flagbg
            cache: false
			
            visible: model.tlflag
            opacity: 0.5
			
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            
            anchors.leftMargin: innerRectMargin - Math.ceil(1 * Theme.heightScale)
            anchors.rightMargin: innerRectMargin
			
            height: parent.height
            width: parent.width
            
            source: "image://game/ui/images/tl-flags/tl-" + model.tlflag + Theme.setImgDef
            fillMode: Image.Stretch
			
            asynchronous: true
        }
		
        Rectangle { id: focusShape
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            
            anchors.leftMargin: innerRectMargin - Math.ceil(1 * Theme.heightScale)
            anchors.rightMargin: innerRectMargin
			
            visible: !labelText.visible
            opacity: !model.tlflag ? bsInnerOpacity : ( bsInnerOpacity / 2 )
			
            height: parent.height
            width: parent.width
            
            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.12; color: bsInnerColor }
                GradientStop { position: 0.36; color: bsInnerColor }
                GradientStop { position: 1; color: "transparent" }
            }
        }
        
		
		
        Rectangle { id: topShape
            anchors.top: parent.top
            anchors.right: parent.right
            
            width: Math.ceil(8 * Theme.heightScale)
            height: parent.height
            
            visible: !labelText.visible
            opacity: bsOuterOpacity
            
            gradient: Gradient {
                GradientStop { position: 0.05; color: "transparent" }
                GradientStop { position: 0.14; color: bsOuterColor }
                GradientStop { position: 0.34; color: bsOuterColor }
                GradientStop { position: 0.95; color: "transparent" }
            }
        }

        Rectangle { id: bottomShape
            anchors.top: parent.top
            anchors.left: parent.left
			
            anchors.leftMargin: labelText.visible ? Math.ceil(20 * Theme.heightScale) : 0
            
            width:  labelText.visible ? Math.floor(2 * Theme.heightScale) : Math.ceil(6 * Theme.heightScale)
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
        width: parent.width
        height: parent.height
		visible: false
        anchors.left: parent.left
        anchors.leftMargin: labelPaddingLeft

        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter

        font.capitalization: Font.AllUppercase
        font.family: Theme.fonts.regular

        text: model && L10n.getString(model.label)

        Component.onCompleted: {
            // separator is a special Text having a different formatting.
            if ( model.type ==  "title" || model.type ==  "subtitle"  ) {
                labelText.font.family = Theme.fonts.regular;
				labelText.font.bold = true;
                labelText.color = Theme.colors.buttonText;
                labelText.opacity = 1;
                labelText.visible = true;
                
                labelText.anchors.verticalCenter = parent.verticalCenter;
                labelText.horizontalAlignment = Text.AlignHCenter;
				labelText.anchors.verticalCenterOffset = model.type === "title" ? Math.ceil(-7 * Theme.heightScale) : Math.ceil(-3 * Theme.heightScale)
                
                labelText.font.pixelSize = ( model.type === "title" ) ? titleFontSize : separatorFontSize;
                labelText.font.capitalization = Font.AllUppercase;
            }
        }
    }


    Loader { id: loader
	
        anchors.right: parent.right
        anchors.rightMargin: rightComponentPaddingRight
        anchors.left: parent.left
		anchors.leftMargin: labelPaddingLeft 
		
        Component.onCompleted: {
            var properties = {
                    model: model,
                    state: otherRow.state
                },
                url = inputComponents[model.type];

            if (!model) {
                console.error("OtherRow Component does not have a model to give to", url);
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
            when: otherRow.activeFocus
            PropertyChanges { target: loader; anchors.leftMargin: labelPaddingLeft + moveThatThing; anchors.rightMargin: rightComponentPaddingRight + moveThatThing }
            PropertyChanges { target: border; opacity: thatOneOpacity }
                
            StateChangeScript {
                name: "focusedScript"
                script: {
			
					if ( appRoot.isLeftMenuFocused ) {
						appRoot.isLeftMenuFocusedFunction( false );
					}
			
					onSelectionChanged(otherRow.model.link);
					
					if ( otherRow.thatOneOpacity ) {
						Sound.playEffect("sndfocus");
					}
                }
            }
        },
        State {
            name: "blurred"
            when: !otherRow.activeFocus
            PropertyChanges { target: loader; anchors.leftMargin: labelPaddingLeft; anchors.rightMargin: rightComponentPaddingRight }
            PropertyChanges { target: border; opacity: 0 }
        },
        State {
            name: "disabled"
            PropertyChanges { target: border; opacity: 0 }
        }
    ]
	
    transitions: [
        Transition {
            to: "blurred"
            from: "focused"

            ParallelAnimation {
					
                    NumberAnimation {
                        target: loader
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
            to: "focused"

            ParallelAnimation {
            
                    NumberAnimation {
                        target: loader
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
