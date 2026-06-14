import QtQuick 2.9
import CrowbarCollective 1.0

MouseArea { id: alert
    property bool skrim: true
    property alias titleText: headerText.text
    property alias messageTextKey: iconText.text
    property alias messageText: bodyText.text
    property VisualItemModel buttons

    property bool messageKeyVisible: false
	
	property int lastTraversalLevel: 2
    property int modalWidth: Theme.rootWidth
    property int modalHeight: Math.ceil(215 * Theme.heightScale)
    property int spacing: Math.ceil(25 * Theme.heightScale)
    property int padding: Math.ceil(25 * Theme.widthScale)
    property int sidepadding: Math.ceil(550 * Theme.widthScale)
    property int headerFontSize: Math.ceil(22 * Theme.heightScale)



    property bool isWidescreen: appRoot.width / appRoot.height >= 1.586

    property int logoVerticalCenterOffset: Math.ceil(-123 * Theme.heightScale)
    property int childTopMargin: Math.ceil(69 * Theme.heightScale)
    property int titleNameFontSize: Math.ceil(60 * Theme.heightScale)
    property int iconFontSize: Math.ceil(36 * Theme.heightScale)
    property int descrFontSize: Math.ceil(28 * Theme.heightScale)
	
    property int childLogoMargin: isWidescreen ? Math.ceil(200 * Theme.widthScale) : Math.ceil(70 * Theme.widthScale)
    property int childMargin: isWidescreen ? Math.ceil(120 * Theme.widthScale) : Math.ceil(20 * Theme.widthScale)
	
    property int buttonSpacing: Math.ceil(10 * Theme.heightScale)


    anchors.top: parent.top
	anchors.bottom: parent.bottom
	anchors.right: parent.right
	
	width: appRoot.width
	
    hoverEnabled: true

    function show() {
        state = "visible";
    }

    function hide() {
        state = "hidden";
    }

    onClicked: {
        mouse.accepted = true;
    }

    onEntered: { /* do nothing but intercept and halt event propagation */ }
    onExited: { /* do nothing but intercept and halt event propagation */ }

    state: "hidden"
    states: [
        State {
            name: "hidden"
            PropertyChanges { target: skrimRect; opacity: 0 }
            PropertyChanges { target: modal; opacity: 0 }
            PropertyChanges { target: alert; enabled: false; hoverEnabled: false }
        },
        State {
            name: "visible"
            PropertyChanges { target: skrimRect; opacity: 1 }
            PropertyChanges { target: modal; opacity: Theme.opacity.modal }
            PropertyChanges { target: alert; enabled: true; hoverEnabled: true }
        }
    ]
	
	Item {
		id: skrimRect
	
		anchors.fill: parent
		
	
		Image { id: backgroundImage
			anchors.fill: parent
			fillMode: Image.PreserveAspectCrop
			
			source: "image://game/ui/bs_campaign/bg/bg0" + appRoot.randomBackgroundChapter + ( (appRoot.randomBackgroundVariant === 1) ? ("a" + Theme.setImgDefJpg ) : Theme.setImgDefJpg )
			
			visible: !appRoot.isInGame
		}
		
		Rectangle {
			opacity: appRoot.isInGame ? 1 : 0
			rotation: -90
			height: parent.width
			width: parent.height
			anchors.centerIn: parent
			color: Theme.colors.bsMenuBackDropRight
		}
		
		Rectangle {
			opacity:  appRoot.isInGame ? 0.7 : 0.45
			rotation: -90
			height: parent.width
			width: parent.height
			anchors.centerIn: parent
							
			gradient: Gradient {
				GradientStop { position: 0; color: Theme.colors.highlight }
				GradientStop { position: 1; color: "transparent" }
			}
		}
		
		Image { id: backgroundGraph
			anchors.fill: parent
			fillMode: Image.PreserveAspectCrop
			source: "image://game/ui/images/menu_filler" + Theme.setImgDef
		}
		
		
			Item {
				id: hintsBody
				anchors.bottom: parent.bottom
				anchors.bottomMargin: Math.ceil(60 * Theme.widthScale)
				anchors.left: parent.left
				anchors.right: parent.right
				
				height: Math.ceil(30 * Theme.heightScale)
				
				opacity: !appRoot.isConsoleOpened ? 1 : 0
				
				Behavior on opacity {
						OpacityAnimator { duration: 200; easing.type: Easing.OutQuint }
				}
				
				Rectangle {
					id: hintsBGSecond
					height: hintsBody.width + Math.ceil(2 * Theme.widthScale)
					width: hintsBody.height
					anchors.centerIn: hintsBody
					anchors.verticalCenterOffset: Math.ceil(14 * Theme.heightScale)
					rotation: -90
					opacity: Theme.opacity.bsRightPanel
					
					gradient: Gradient {
						GradientStop { position: 0.6; color:  "transparent" }
						GradientStop { position: 0.8; color: Theme.colors.highlight }
					}
				}
				
				Rectangle {
					id: hintsBG
					height: hintsBody.width + Math.ceil(2 * Theme.widthScale)
					width: hintsBody.height + Math.ceil(9 * Theme.heightScale)
					anchors.centerIn: hintsBody
					rotation: -90
					opacity: 0.9
					
					gradient: Gradient {
						GradientStop { position: 0.5; color:  "transparent" }
						GradientStop { position: 0.7; color: Theme.colors.skrim }
					}
				}
				
				
				Row {
					anchors.verticalCenter: hintsBody.verticalCenter
					anchors.verticalCenterOffset: Math.ceil(10 * Theme.heightScale)
					anchors.right: hintsBody.right
					anchors.rightMargin: Math.ceil(60 * Theme.widthScale)
					
					Hint {
						id: hint1
						hintButtonText: appRoot.hintSelectIcon
						hintTextText: L10n.strings.hints.hintselect
						hintButtonColor: appRoot.hintSelectColor
					}
					Hint {
						id: hint2
						hintButtonText: appRoot.hintBackIcon
						hintTextText: L10n.strings.hints.hintback
						hintButtonColor: appRoot.hintBackColor
					}
					Hint {
						id: hint3
						hintButtonText: appRoot.hintCloseIcon
						hintTextText: L10n.strings.hints.hintclosemenu
						
						visible: appRoot.isInGame
					}
					
				}
				
			}//HINTS BG END
	}
	

    Item { id: modal
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -30000

        width: parent.width
        height: parent.height


            Text {
                id: titleTextShadowRight
                anchors.left: parent.left
                anchors.leftMargin: childLogoMargin + Math.ceil(2 * Theme.heightScale)
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: logoVerticalCenterOffset + Math.ceil(2 * Theme.heightScale)
                text: headerText.text
                font.capitalization: Font.MixedCase
                font.pixelSize: alert.titleNameFontSize
                font.family: Theme.fonts.regular
                font.bold: true
                color: Theme.colors.bsMenuBackDropRight
                opacity: 0.7
            }
            
            Text {
                id: headerText
                anchors.left: parent.left
                anchors.leftMargin: childLogoMargin
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: logoVerticalCenterOffset
                font.capitalization: Font.MixedCase
                font.pixelSize: alert.titleNameFontSize
                font.family: Theme.fonts.regular
                font.bold: true
                color: Theme.colors.buttonText
            }
			
			
            Text {
                id: iconText
                anchors.top: headerText.bottom
				anchors.topMargin: Math.ceil(-4 * Theme.heightScale)
                anchors.left: parent.left
                anchors.leftMargin: childLogoMargin
                font.capitalization: Font.MixedCase
                font.pixelSize: alert.iconFontSize
                font.family: Theme.fonts.controlsIcons
                color: Theme.colors.buttonText
				
				visible: alert.messageKeyVisible
            }
			
            Text {
                id: bodyText
                anchors.top: headerText.bottom
                anchors.left: iconText.visible ? iconText.right : parent.left
                anchors.leftMargin: iconText.visible ? Math.ceil(10 * Theme.heightScale) : childLogoMargin
                font.capitalization: Font.MixedCase
                font.pixelSize: alert.descrFontSize
                font.family: Theme.fonts.regular
                color: Theme.colors.buttonText
            }
			
			
			

        ListView {
            width: parent.width
			height: Math.ceil(500 * Theme.heightScale)
            anchors.top: headerText.bottom
            anchors.topMargin: childTopMargin
            anchors.left: parent.left
            anchors.leftMargin: childMargin

            orientation: Qt.Vertical
            spacing: alert.buttonSpacing

            interactive: false;
            cacheBuffer: 1000;

            model: buttons
        }
    }

    transitions: [
        Transition {
            from: "hidden"
            to: "visible"

            ParallelAnimation {
                NumberAnimation {
                    target: skrimRect
                    property: "opacity"
                    duration: 150
                }

                NumberAnimation {
                    target: modal
                    property: "anchors.horizontalCenterOffset"
                    from: -300
                    to: 0
                    duration: 150
                    easing.type: Easing.InOutQuint
                }

                SequentialAnimation {
                    PauseAnimation {
                        duration: 150
                    }
                    NumberAnimation {
                        target: modal
                        property: "opacity"
                        from: 0.0
                        to: 0.85
                        duration: 150
                    }
                    PauseAnimation {
                        duration: 150
                    }
                    ScriptAction {
                        script: {
                            BlackMesaUtils.clearTraversalTree([4]);
                            BlackMesaUtils.parseTraversalTree(modal);
                            BlackMesaUtils.traversalDepth = 4;
                            BlackMesaUtils.updateCurrentUISelection();
                        }
                    }
                }
            }
        },
        Transition {
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation {
                        target: skrimRect
                        property: "opacity"
                        duration: 150
                    }
                    NumberAnimation {
                        target: modal
                        property: "anchors.horizontalCenterOffset"
                        from: 0
                        to: -1000
                        duration: 150
                        easing.type: Easing.InOutQuint
                    }
                    NumberAnimation {
                        target: modal
                        property: "opacity"
                        from: 1.0
                        to: 0.0
                        duration: 150
                    }
                }
                NumberAnimation {
                    target: modal
                    property: "anchors.horizontalCenterOffset"
                    from: -1000
                    to: -30000
                    duration: 1
                }
                ScriptAction {
                    script: {
                        BlackMesaUtils.clearTraversalTree([lastTraversalLevel]);
                        BlackMesaUtils.parseTraversalTree(appRoot);
                        BlackMesaUtils.traversalDepth = lastTraversalLevel;
                        BlackMesaUtils.updateCurrentUISelection();
                    }
                }
            }
        }
    ]
}
