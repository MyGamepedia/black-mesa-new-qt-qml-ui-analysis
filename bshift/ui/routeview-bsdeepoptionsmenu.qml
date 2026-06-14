import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

RouteView {
	id: indexOptions
    property bool isWidescreen: appRoot.width / appRoot.height >= 1.586
    
    property int logoVerticalCenterOffset: Math.ceil(-93 * Theme.heightScale)
    property int childTopMargin: Math.ceil(-20 * Theme.heightScale)
    property int titleNameFontSize: Math.ceil(60 * Theme.heightScale)
    
    property int childLogoMargin: isWidescreen ? Math.ceil(200 * Theme.widthScale) :  Math.ceil(70 * Theme.widthScale)
    property int childMargin: isWidescreen ? Math.ceil(120 * Theme.widthScale) :  Math.ceil(20 * Theme.widthScale)

     anchors.fill: parent
     
    property int rightpanelWidth: isWidescreen ? Math.ceil(1200 * Theme.widthScale) :  Math.ceil(1300 * Theme.widthScale)
    
    property int rank: -1

    function reloadVideoPage() {
		if ( appRoot.isLeftMenuFocused ) {
			appRoot.isLeftMenuFocusedFunction( false );
		}
		
		rank = 2;
		outlet.setCategory(Routes.video.qmlFile,  rank, false);
    }

    function goBack() {
		indexOptions.routeRequest(Routes.index.name);
		appRoot.isSubMenuOpenedFunction( false );
		
		if ( isInGame ) {
			appRoot.isIndexHints = true;
		}
		return;
    }

    Component.onCompleted: {
        outlet.setCategory(Routes.empty.qmlFile,  rank, true);
    }

    Item { id: indexOptionsMenu
        anchors.fill: parent

            Text { id: titleTextShadowRight
                anchors.left: parent.left
                anchors.leftMargin: childLogoMargin + Math.ceil(2 * Theme.heightScale)
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: logoVerticalCenterOffset + Math.ceil(2 * Theme.heightScale)
                text: titleText.text
                font.capitalization: Font.MixedCase
                font.pixelSize: indexOptions.titleNameFontSize
                font.family: Theme.fonts.regular
                font.bold: true
                color: Theme.colors.bsMenuBackDropRight
                opacity: 0.7
            }
            
            Text { id: titleText
                anchors.left: parent.left
                anchors.leftMargin: childLogoMargin
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: logoVerticalCenterOffset
                text: L10n.strings.menus.options
                font.capitalization: Font.MixedCase
                font.pixelSize: indexOptions.titleNameFontSize
                font.family: Theme.fonts.regular
                font.bold: true
                color: Theme.colors.buttonText
            }

			Column { id: buttonsContainer
			
				anchors.top: parent.verticalCenter
				anchors.topMargin: childTopMargin
				
                anchors.left: parent.left
                anchors.leftMargin: childMargin
				
				spacing: Math.ceil(10 * Theme.heightScale)
			
                    BSLetterboxButton {
						id: firstTabButton
                        objectName: !selected ? ( (rank === -1) ? "ui--navigation:bstab:level_2" : "ui--navigation:bstab:level_1") : ""
                        selected: rank == 0
                        text: L10n.strings.menus.game
                        callback: function() {
                            rank = 0;
                            outlet.setCategory( Routes.game.qmlFile,  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
                        onClicked: {
                            rank = 0;
                            outlet.setCategory( Routes.game.qmlFile,  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                    BSLetterboxButton {
						id: secondTabButton
                        objectName: !selected ? ( (rank === -1) ? "ui--navigation:bstab:level_2" : "ui--navigation:bstab:level_1") : ""
                        selected:  rank == 1
                        text: L10n.strings.menus.input
                        callback: function() {
                            rank = 1;
                            outlet.setCategory( Routes.input.qmlFile,  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
                        onClicked: {
                            rank = 1;
                            outlet.setCategory( Routes.input.qmlFile,  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                    
                    BSButton {
						id: thirdButton
                        objectName: (rank === -1) ? "ui--navigation:bsbutton:level_2" : "ui--navigation:bsbutton:level_1"
                        text: L10n.strings.menus.bindings
                        callback: function() {
							indexOptions.routeRequest(Routes.bindings.name);
							appRoot.isSubMenuOpenedFunction( false );
						}
                        onClicked: {
							indexOptions.routeRequest(Routes.bindings.name);
							appRoot.isSubMenuOpenedFunction( false );
						}
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                    
                    BSLetterboxButton {
						id: fourthTabButton
                        objectName: !selected ? ( (rank === -1) ? "ui--navigation:bstab:level_2" : "ui--navigation:bstab:level_1") : ""
                        selected:  rank == 2
                        text: L10n.strings.menus.video
                        callback: function() {
                            rank = 2;
                            outlet.setCategory( Routes.video.qmlFile,  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
                        onClicked: {
                            rank = 2;
                            outlet.setCategory( Routes.video.qmlFile,  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                    
                    BSLetterboxButton {
						id: fifthTabButton
                        objectName: !selected ? ( (rank === -1) ? "ui--navigation:bstab:level_2" : "ui--navigation:bstab:level_1") : ""
                        selected:  rank == 3
                        text: L10n.strings.menus.audio
                        callback: function() {
                            rank = 3;
                            outlet.setCategory( Routes.audio.qmlFile,  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                            }
                        onClicked: {
                            rank = 3;
                            outlet.setCategory( Routes.audio.qmlFile,  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                    
                    BSButton {
						id: sixthButton
                        objectName: (rank === -1) ? "ui--navigation:bsbutton:level_2" : "ui--navigation:bsbutton:level_1"
                        text: L10n.strings.menus.other
                        callback: function() {
							indexOptions.routeRequest(Routes.bsother.name);
							appRoot.isSubMenuOpenedFunction( false );
						}
                        onClicked: {
							indexOptions.routeRequest(Routes.bsother.name);
							appRoot.isSubMenuOpenedFunction( false );
						}
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                    
                    BSButton {
						id: backButton
                        objectName: (rank === -1) ? "ui--navigation:bsbutton:level_2" : "ui--navigation:bsbutton:level_1"
                        text: L10n.strings.buttons.back
                        callback: function() { goBack(); }
                        onClicked: { goBack(); }
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                
            }   //buttonsContainer
            
            
            
    }   //indexOptionsMenu
    
	
    Item { id: stackBodyItem
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: rightpanelWidth
				
				state: !appRoot.isSubMenuOpened ? "blur" : "focused"
				
				states: [
					State {
						name: "blur"
						
						PropertyChanges {
							target: stackBodyItem;
							opacity: 0
						}
					},
					State {
						name: "focused"
						
						PropertyChanges {
							target: stackBodyItem;
							opacity: 1
						}
					}
				]
					
				Behavior on opacity {
					SequentialAnimation {
						PauseAnimation { duration: 150 }
						OpacityAnimator { duration: 150; easing.type: Easing.OutQuint }
					}
				}
				
				
				Item {
					id: contBG
					
					anchors.top: stackBodyItem.top
					anchors.right: stackBodyItem.right
					width: parent.width
					height: Math.ceil(116 * Theme.heightScale)
					
						Rectangle {
							id: headerBGrect
							opacity: Theme.opacity.bsOptionsFooter
							
							anchors.centerIn: contBG
							
							rotation: -90
							
							height: contBG.width
							width: contBG.height
							
							gradient: Gradient {
								GradientStop { position: 0; color: Theme.colors.skrim }
								GradientStop { position: 1; color:  Theme.colors.bsMenuBackDropRight }
							}
						}
				}
			
			
				Item {
					id: contBGfooter
					
					clip: true
					
					anchors.bottom: stackBodyItem.bottom
					anchors.right: stackBodyItem.right
					width: rightpanelWidth
					height: ( rank !== 2 ) ? Math.floor(69 * Theme.heightScale) : Math.floor(183 * Theme.heightScale)
					
					Behavior on height {
							NumberAnimation { duration: 150; easing.type: Easing.OutQuint }
					}
				
						Rectangle {
							id: footerBGrect
							opacity: Theme.opacity.bsOptionsFooter
							
							anchors.centerIn: contBGfooter
							
							rotation: -90
							
							height: contBGfooter.width
							width: contBGfooter.height
							
							gradient: Gradient {
								GradientStop { position: 0; color: Theme.colors.skrim }
								GradientStop { position: 1; color:  Theme.colors.bsMenuBackDropRight }
							}
						}
				}

            StackView {
                id: outlet
                clip: true
				
				width: parent.width
				height: parent.height
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
				

                property int lastRank: 0;

                function setCategory(ourqml, newrank, skipTransition) {
                    var transition = skipTransition ? StackView.Immediate : StackView.Transition;

                    replaceExit = categoryTransitions.up.exit;
                    replaceEnter = categoryTransitions.up.enter;
                    
                    lastRank = newrank;
                    
                    outlet.replace( ourqml, {
                    opacity: skipTransition ? 1.0 : 0.0
                    }, transition);
                }

                readonly property QtObject categoryTransitions: QtObject {
                    readonly property QtObject up: QtObject {
                        readonly property Transition enter: upEnterTransition
                        readonly property Transition exit: upExitTransition
                    }
                }

                function parseRouteUIItems() {
                    // Clean all elements with navigation depth 2
                    BlackMesaUtils.clearTraversalTree([2]);
                    BlackMesaUtils.parseTraversalTree(appRoot);
                    BlackMesaUtils.traversalDepth = 2;
                    BlackMesaUtils.updateCurrentUISelection();
                }



                Transition {
                id: upEnterTransition
                        SequentialAnimation {
                            PauseAnimation {
                                duration: 150
                            }
							
							ScriptAction {
								script: {
									if ( appRoot.isLeftMenuFocused ) {
										appRoot.isLeftMenuFocusedFunction( false );
									}
								}
							}
							
							ParallelAnimation {
								NumberAnimation {
									property: "opacity"
									from: 0.0
									to: 1.0
									duration: 150
								}
								
								NumberAnimation {
									property: "anchors.leftMargin"
									from: rightpanelWidth
									to: 0
									duration: 100
								}
								
								NumberAnimation {
									property: "anchors.rightMargin"
									from: 0 - rightpanelWidth
									to: 0
									duration: 100
								}
							}
							
                            PauseAnimation {
                                duration: 30
                            }
                            ScriptAction {
                            script: parseRouteUIItems();
                            }
                        }
                }

                Transition {
                id: upExitTransition
						ParallelAnimation {
						
							NumberAnimation {
								property: "opacity"
								from: 1.0
								to: 0.0
								duration: 150
							}
							
                            NumberAnimation {
                                property: "anchors.leftMargin"
                                from: 0
                                to: rightpanelWidth
                                duration: 100
                            }
							
                            NumberAnimation {
                                property: "anchors.rightMargin"
                                from: 0
                                to: 0 - rightpanelWidth
                                duration: 100
                            }
						}
                }
            }
			
			
			
				Item {
					id: headLineBody
					
					anchors.top: stackBodyItem.top
					anchors.topMargin: contBG.height - Math.ceil( 6 * Theme.heightScale)
					anchors.right: stackBodyItem.right
					width: rightpanelWidth
					height: Math.ceil(12 * Theme.heightScale)
					
							Rectangle {
								id: headerLine
								opacity: Theme.opacity.bsSecondary
								
								rotation: -90
								
								anchors.centerIn: headLineBody
								
								height: headLineBody.width
								width: headLineBody.height
								
								gradient: Gradient {
									GradientStop { position: 0; color: "transparent" }
									GradientStop { position: 0.85; color: Theme.colors.bssecondaryhighlight }
								}
							}
			
				}
				
				Item {
					id: footLineBody
					
					anchors.bottom: stackBodyItem.bottom
					anchors.bottomMargin: contBGfooter.height - Math.ceil( 6 * Theme.heightScale)
					anchors.right: stackBodyItem.right
					width: rightpanelWidth
					height: Math.ceil(12 * Theme.heightScale)
					
							Rectangle {
								id: footerLine
								opacity: Theme.opacity.bsSecondary
								
								rotation: -90
								
								anchors.centerIn: footLineBody
								
								height: footLineBody.width
								width: footLineBody.height
								
								gradient: Gradient {
									GradientStop { position: 0; color: "transparent" }
									GradientStop { position: 0.85; color: Theme.colors.bssecondaryhighlight }
								}
							}
				}

    }   //stackBodyItem
	
}   //indexCampaign
