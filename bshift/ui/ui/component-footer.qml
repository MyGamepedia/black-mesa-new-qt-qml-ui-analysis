import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import CrowbarCollective 1.0

Item { id: footer
    property Route currentRoute
    property bool isLoading: false
    property bool showLoadingProgress: true
    property string levelName: ""
    property real loadPercent: 0
	

    property int circleBodyHeight: Math.ceil(120 * Theme.heightScale)
    property int circleHeight: Math.ceil(60 * Theme.heightScale)

    property color bsOuterColor: Theme.colors.bssecondaryhighlight
    property real bsOuterOpacity: Theme.opacity.bsSecondary
    
    anchors.bottom: parent.bottom
	
    width: parent.width
    height: 0

    Component { id: menuFooter
		
		Item {
			id: allBG
			
			anchors.fill: appRoot
			
			property bool isWidescreen: appRoot.width / appRoot.height >= 1.586
			property int rightpanelWidth: isWidescreen ? Math.ceil(1200 * Theme.widthScale) :  Math.ceil(1300 * Theme.widthScale)
			property real bsRightPanelOpacity: Theme.opacity.bsRightPanel
			
			Item {
				id: rMenuBG
				
				state: !appRoot.isSubMenuOpened ? "blur" : "focused"
				
				anchors.fill: allBG

				states: [
					State {
						name: "blur"
						
						PropertyChanges {
							target: rMenuBG
							anchors.rightMargin: 0 - rMenuBG.width
							opacity: 0
						}
					},
					State {
						name: "focused"
						
						PropertyChanges {
							target: rMenuBG
							anchors.rightMargin: 0
							opacity: 1
						}
					}
				]
					
				Behavior on opacity {
					SequentialAnimation {
						PauseAnimation { duration: !appRoot.isSubMenuOpened ? 150 : 0 }
						OpacityAnimator { duration: 150; easing.type: Easing.OutQuint }
						NumberAnimation {
							properties: "anchors.rightMargin"
							duration: 150
							easing.type: Easing.OutQuint
						}
					}
				}
				
				Rectangle {
					id: lightBackDrop
					opacity: bsOuterOpacity
					anchors.top: contBG.top
					anchors.bottom: contBG.bottom
					anchors.left: contBG.left
					anchors.leftMargin: Math.ceil(-6 * Theme.heightScale)
					anchors.right: contBG.right
					
					color: bsOuterColor
				}
				
				Item {
					id: contBG
					anchors.top: appRoot.top
					anchors.bottom: rMenuBG.bottom
					anchors.right: rMenuBG.right
					width: allBG.rightpanelWidth
					height: appRoot.height
					
					Rectangle {
						id: rectBG
						opacity: allBG.bsRightPanelOpacity
						rotation: -90
						height: contBG.width
						width: contBG.height
						anchors.centerIn: contBG
						
						gradient: Gradient {
							GradientStop { position: 0; color: Theme.colors.skrim }
							GradientStop { position: 1; color:  Theme.colors.bsMenuBackDropRight }
						}
						
					}
					
				}
				
			}//Item END
			
			Item {
				id: hintsBody
				anchors.bottom: allBG.bottom
				anchors.bottomMargin: Math.ceil(60 * Theme.widthScale)
				anchors.left: allBG.left
				anchors.right: allBG.right
				
				height: Math.ceil(30 * Theme.heightScale)
				
				opacity: ( !appRoot.isSubMenuOpened && !appRoot.isConsoleOpened ) ? 1 : 0
				
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
					opacity: bsRightPanelOpacity
					
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
						GradientStop { position: 0.7; color: Theme.colors.subMenuHintPrimary }
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
						hintButtonText: ( appRoot.isInGame && appRoot.isIndexHints ) ? ( "<font color=\"" + appRoot.hintBackColor + "\">" + appRoot.hintBackIcon + "</font>" + appRoot.hintCloseIcon ) : appRoot.hintBackIcon
						hintTextText: ( appRoot.isInGame && appRoot.isIndexHints ) ? L10n.strings.hints.hintclosemenu : ( ( router.currentRoute === Routes.index ) ? L10n.strings.hints.hintquitgame : L10n.strings.hints.hintback )
						hintButtonColor: ( appRoot.isInGame && appRoot.isIndexHints ) ? Theme.colors.text : appRoot.hintBackColor
					}
					Hint {
						id: hint3
						hintButtonText: appRoot.hintCloseIcon
						hintTextText: L10n.strings.hints.hintclosemenu
						
						isHintVisible: appRoot.isInGame && !appRoot.isIndexHints
					}
				
				}
				
			}//HINTS BG END
			
        }//ItemAll END
        
    }//Component END



    // no animations in loading footer. the engine uses too many resources
    // and animations become jittery or are passed over all together
    //
    //Stavaas: Did you think you could stop me from doing that?
    
    Component { id: loadingFooter
        
        Item {
            id: loadFooterBody
            
            property int loadingLabelFontSize: Math.ceil(28 * Theme.heightScale)
            property int levelNameFontSize: Math.ceil(38 * Theme.heightScale)
            
            property color bsInnerColor: Theme.colors.highlight
            property int innerRectMargin: Math.ceil(4 * Theme.heightScale)
            
            property real bsInnerOpacity: Theme.opacity.bsPrimary
        
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Math.ceil(160 * Theme.heightScale)
            
            Item {
                id: bgBody
                width: Math.ceil(700 * Theme.widthScale)
                height: Math.ceil(100 * Theme.heightScale)
                
                anchors.right: loadFooterBody.right
                anchors.verticalCenter: loadFooterBody.verticalCenter
                
                Rectangle {
                    id: border
                    anchors.centerIn: bgBody

                    rotation: -90
                    
                    width: bgBody.height
                    height: bgBody.width
                    
                    color: "transparent"
                    
                    Rectangle {
                        id: focusShape
                        anchors.left: border.left
                        anchors.top: border.top
                        anchors.right: border.right
                        anchors.bottom: border.bottom
                        anchors.leftMargin: innerRectMargin - Math.ceil(1 * Theme.heightScale)
                        anchors.rightMargin: innerRectMargin
                        
                        opacity: bsInnerOpacity
                        
                        height: border.height
                        width: border.width
                        
                        gradient: Gradient {
                            GradientStop { position: 0; color: "transparent" }
                            GradientStop { position: 0.87; color: bsInnerColor }
                            GradientStop { position: 1; color: bsInnerColor }
                        }
                    }
                    
                    Rectangle {
                        id: topShape
                        anchors.top: border.top
                        anchors.right: border.right
                        
                        opacity: bsOuterOpacity
                        
                        width: Math.ceil(8 * Theme.heightScale)
                        height: border.height
                        
                        gradient: Gradient {
                            GradientStop { position: 0.1; color: "transparent" }
                            GradientStop { position: 0.88; color: bsOuterColor }
                            GradientStop { position: 1; color: bsOuterColor }
                        }
                    }
                    
                    Rectangle {
                        id: bottomShape
                        anchors.top: border.top
                        anchors.left: border.left
                        
                        opacity: bsOuterOpacity
                        
                        width: Math.ceil(6 * Theme.heightScale)
                        height: border.height
                        
                        gradient: Gradient {
                            GradientStop { position: 0.3; color: "transparent" }
                            GradientStop { position: 0.88; color: bsOuterColor }
                            GradientStop { position: 1; color: bsOuterColor }
                        }
                    }
                }
            }
			
            
            Rectangle {
                id: loadCircleBody
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                width: circleBodyHeight
                height: circleBodyHeight
                color: "transparent"
                rotation: 0

                    Image {
                        id: loadCircle
                        anchors.centerIn: parent
                        width: circleHeight
                        height: circleHeight
                        fillMode: Image.PreserveAspectFit

                        source: "image://game/ui/images/loading_icon" + Theme.setImgDef

                    }
                    
                        Behavior on rotation {
                            RotationAnimator {
                                duration: 100
                            }
                        }
                    
                Timer {
                    triggeredOnStart: true
                    interval: 100
                    repeat: true
                    running: true
                    onTriggered: {
                        loadCircleBody.rotation = loadCircleBody.rotation + 36;
                    }
                }
            }
            
            
            Text {
                text: levelName ? levelName : L10n.strings.loading.pleaseWait
                color: Theme.colors.buttonText
                
                font.family: Theme.fonts.regular
                font.pixelSize: levelNameFontSize
                
                anchors.right: loadCircleBody.left
                anchors.verticalCenter: loadCircleBody.verticalCenter
                anchors.verticalCenterOffset: Math.ceil(-18 * Theme.heightScale)
            }
            
            Text {
                text: L10n.strings.loading.loadingLevel + " " + ( ( loadPercent < 0.75 ) ? Math.round(loadPercent * 131) : "99" ) + "%"
                color: Theme.colors.buttonText
                
                font.family: Theme.fonts.light
                font.pixelSize: loadingLabelFontSize
                
                anchors.right: loadCircleBody.left
                anchors.verticalCenter: loadCircleBody.verticalCenter
                anchors.verticalCenterOffset: Math.ceil(20 * Theme.heightScale)
            }

        }
        
    }
    
    

    Loader {
        anchors.fill: parent
        sourceComponent: isLoading ? loadingFooter : menuFooter
    }
}
