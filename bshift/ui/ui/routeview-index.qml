import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

RouteView { id: index
    property bool isInGame: false
	
    property bool isWidescreen: appRoot.width / appRoot.height >= 1.586

    property int logoVerticalCenterOffset: Math.ceil(-136 * Theme.heightScale)
    property int logoVerticalCenterOffsetSub: isWidescreen ? Math.ceil(-115 * Theme.heightScale) :  Math.ceil(-99 * Theme.heightScale)
	
	property int logoMarginFull: isWidescreen ? Math.ceil(160 * Theme.widthScale) :  Math.ceil(30 * Theme.widthScale)
	property int logoMarginSub: isWidescreen ? Math.ceil(80 * Theme.widthScale) :  Math.ceil(15 * Theme.widthScale)
	
	property int logoWidthFull: isWidescreen ? Math.ceil(1200 * Theme.widthScale) : Math.ceil(1300 * Theme.widthScale)
    property int logoWidthSub: isWidescreen ? Math.ceil(590 * Theme.widthScale) : Math.ceil(560 * Theme.widthScale)
	
	
    property int childTopMargin: Math.ceil(-20 * Theme.heightScale)
    property int childMargin: isWidescreen ? Math.ceil(120 * Theme.widthScale) :  Math.ceil(20 * Theme.widthScale)
	
    property int titleNameFontSize: Math.ceil(80 * Theme.heightScale)
    property int hintFontSize: Math.ceil(24 * Theme.heightScale)

	property bool isAlertVisible: false
	property bool isLoadGameMenuVisible: BlackMesaUtils.getSaveGames()[0]
	anchors.fill: parent
    
    property int rightpanelWidth: isWidescreen ? Math.ceil(1200 * Theme.widthScale) :  Math.ceil(1300 * Theme.widthScale)
	
    
    property int rank: -1

    Component.onCompleted: {
		appRoot.changeIndexLogoWidth = false;
		outlet.setCategory(Routes.empty.qmlFile,  rank, true);
    }
	
    Timer {
        id: autoLogoTimer
        interval: 1
        repeat: false
        running: true
        triggeredOnStart: false

        onTriggered: {
			//This one is for changing icons in menu hints
			
			//In order:
			
			//DS4 DPAD LEFT-RIGHT	- "!"
			//DS4 DPAD UP-DOWN		- "^"
			//DS4 DPAD RIGHT		- "_"
			
			//DS4 Cross				- "*"
			//DS4 Circle			- "+"
			//DS4 Square			- ","
			//DS4 Triangle			- "-"
			
			//DS4 Options			- ";"
			//DS4 Touchpad			- "="
			
			
			//XBOX DPAD LEFT-RIGHT	- "("
			//XBOX DPAD UP-DOWN		- "'"
			//XBOX DPAD RIGHT		- ")"
			
			//XBOX A				- "#"
			//XBOX B				- "$"
			//XBOX X				- "%"
			//XBOX Y				- "&"
			
			//XBOX Start			- ":"
			//XBOX Back				- "?"
			
			
			//KB Backspace			- " "
			//KB ENTER				- "a"
			//KB DEL				- "p"
			
			//KB UP					- "q"
			//KB DOWN				- "r"
			//KB LEFT				- "t"
			//KB RIGHT				- "s"
			
			//KB ESCAPE				- "y"
			//KB TAB				- "©"
			
            appRoot.iconsType = BlackMesaEngine.getConsoleVariableAsInt("hud_draw_fixed_reticle");
			
			appRoot.hintsIconTypeChange();
			
			//appRoot.isIndexHints = true;
		
			//workaround, you have to open index menu to fix the weapon choosing panels
			var fixTheDamnHUDW = BlackMesaEngine.getConsoleVariableAsBoolean("hud_fastswitch");
			if ( fixTheDamnHUDW === 2 ) {
				BlackMesaEngine.setConsoleVariableAsString( "hud_fastswitch", 0 );
			}
			
			
			appRoot.playerName = BlackMesaEngine.getConsoleVariableAsString("name");
        }
    }
	
    Item { id: indexMenu
        anchors.fill: parent
    
		Image { id: logo
			height: Math.ceil(200 * Theme.heightScale)
			width: ( appRoot.changeIndexLogoWidth | appRoot.isConsoleOpened ) ? logoWidthSub : logoWidthFull
			
			source: "image://game/ui/images/logo" + Theme.setImgDef
			
			fillMode: Image.PreserveAspectFit
			horizontalAlignment: Image.AlignLeft
			
			anchors.left: parent.left
			anchors.leftMargin: ( appRoot.changeIndexLogoWidth | appRoot.isConsoleOpened ) ? logoMarginSub : logoMarginFull
			anchors.verticalCenter: parent.verticalCenter
			anchors.verticalCenterOffset: ( appRoot.changeIndexLogoWidth | appRoot.isConsoleOpened ) ? logoVerticalCenterOffsetSub : logoVerticalCenterOffset
					
			Behavior on width {
				NumberAnimation { duration: 75; easing.type: Easing.Linear }
			}
			
			Behavior on anchors.leftMargin {
				NumberAnimation { duration: 75; easing.type: Easing.Linear }
			}
			
			Behavior on anchors.verticalCenterOffset {
				NumberAnimation { duration: 75; easing.type: Easing.Linear }
			}
		}
		
		Column { id: buttonsContainer
				
			anchors.top: parent.verticalCenter
			anchors.topMargin: childTopMargin
			
			anchors.left: parent.left
			anchors.leftMargin: childMargin
				
			spacing: Math.ceil(10 * Theme.heightScale)
			
			BSButton { id: continueButton
				objectName: (rank === -1) ? "ui--navigation:bsbutton:level_2" : "ui--navigation:bsbutton:level_1"
				visible: BlackMesaUtils.getSaveGames()[0] || isInGame
				text: isInGame ? L10n.strings.buttons.resume : L10n.strings.buttons.continue + " (" + Theme.getDateTimeMainMenuString(BlackMesaUtils.getSaveGames()[0].dateCreated) + ")"
				callback: function() {
					if (!isInGame) {
						appRoot.isSubMenuOpenedFunction( false );
						index.loadGameRequest(BlackMesaUtils.getSaveGames()[0])
					} else {
						BlackMesaEngine.executeClientCommand('gameui_hide');
					}
				}
				onClicked: {
					if (!isInGame ) {
						appRoot.isSubMenuOpenedFunction( false );
						index.loadGameRequest(BlackMesaUtils.getSaveGames()[0])
					} else {
						BlackMesaEngine.executeClientCommand('gameui_hide');
					}
				}
				Keys.onPressed: {
					if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
						if ( isInGame ) {
							BlackMesaEngine.executeClientCommand('gameui_hide');
							return;
						} else {
							appRoot.isSubMenuOpenedFunction( false );
							Sound.playEffect("sndclick");
							index.routeRequest(Routes.quit.name);
							return;
						}
					}
				}
			}
			
			BSLetterboxButton {
				id: savegameTab
				visible: isInGame
				objectName: !selected ? ( (rank === -1) ? "ui--navigation:bstab:level_2" : "ui--navigation:bstab:level_1") : ""
				selected:  rank == 0
				text: L10n.strings.menus.savegame
				callback: function() {
					rank = 0;
					outlet.setCategory( Routes.savegame.qmlFile,  rank, false );
					appRoot.isSubMenuOpenedFunction( true );
				}
				onClicked: {
					rank = 0;
					outlet.setCategory( Routes.savegame.qmlFile,  rank, false );
					appRoot.isSubMenuOpenedFunction( true );
				}
				Keys.onPressed: {
						if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
						if ( isInGame ) {
							BlackMesaEngine.executeClientCommand('gameui_hide');
							return;
						} else {
							appRoot.isSubMenuOpenedFunction( false );
							Sound.playEffect("sndclick");
							index.routeRequest(Routes.quit.name);
							return;
						}
					}
				}
			}
				
			BSLetterboxButton {
				id: loadgameTab
				visible: isLoadGameMenuVisible
				objectName: !selected ? ( (rank === -1) ? "ui--navigation:bstab:level_2" : "ui--navigation:bstab:level_1") : ""
				selected: rank == 1
				text: L10n.strings.menus.loadgame
				callback: function() {
					rank = 1;
					outlet.setCategory( Routes.loadgame.qmlFile,  rank, false );
					appRoot.isSubMenuOpenedFunction( true );
				}
				onClicked: {
					rank = 1;
					outlet.setCategory( Routes.loadgame.qmlFile,  rank, false );
					appRoot.isSubMenuOpenedFunction( true );
				}
				Keys.onPressed: {
						if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
						if ( isInGame ) {
							BlackMesaEngine.executeClientCommand('gameui_hide');
							return;
						} else {
							appRoot.isSubMenuOpenedFunction( false );
							Sound.playEffect("sndclick");
							index.routeRequest(Routes.quit.name);
							return;
						}
					}
				}
			}
			
			BSLetterboxButton {
				id: newgameTab
				objectName: !selected ? ( (rank === -1) ? "ui--navigation:bstab:level_2" : "ui--navigation:bstab:level_1") : ""
				selected: rank == 2
				text: L10n.strings.menus.newgame
				callback: function() {
					rank = 2;
					outlet.setCategory( Routes.newgame.qmlFile,  rank, false );
					appRoot.isSubMenuOpenedFunction( true );
				}
				onClicked: {
					rank = 2;
					outlet.setCategory( Routes.newgame.qmlFile,  rank, false );
					appRoot.isSubMenuOpenedFunction( true );
				}
				Keys.onPressed: {
					if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
						if ( isInGame ) {
							BlackMesaEngine.executeClientCommand('gameui_hide');
							return;
						} else {
							appRoot.isSubMenuOpenedFunction( false );
							Sound.playEffect("sndclick");
							index.routeRequest(Routes.quit.name);
							return;
						}
					}
				}
			}
			
			BSButton { id: optionsButton
				objectName: (rank === -1) ? "ui--navigation:bsbutton:level_2" : "ui--navigation:bsbutton:level_1"
				text: L10n.strings.menus.options
				callback: function() {
					if ( isInGame ) {
						appRoot.isIndexHints = false;
					}
					appRoot.isSubMenuOpenedFunction( false );
					index.routeRequest(Routes.bsoptions.name);
				}
				onClicked: {
					if ( isInGame ) {
						appRoot.isIndexHints = false;
					}
					appRoot.isSubMenuOpenedFunction( false );
					index.routeRequest(Routes.bsoptions.name);
				}
				Keys.onPressed: {
					if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
						if ( isInGame ) {
							BlackMesaEngine.executeClientCommand('gameui_hide');
							return;
						} else {
							appRoot.isSubMenuOpenedFunction( false );
							Sound.playEffect("sndclick");
							index.routeRequest(Routes.quit.name);
							return;
						}
					}
				}
			}
			
			BSButton { id: quitButton
				objectName: (rank === -1) ? "ui--navigation:bsbutton:level_2" : "ui--navigation:bsbutton:level_1"
				text: L10n.strings.buttons.quit
				callback: function() {
					if ( isInGame ) {
						appRoot.isIndexHints = false;
					}
					appRoot.isSubMenuOpenedFunction( false );
					index.routeRequest(Routes.quit.name)
				}
				onClicked: {
					if ( isInGame ) {
						appRoot.isIndexHints = false;
					}
					appRoot.isSubMenuOpenedFunction( false );
					index.routeRequest(Routes.quit.name)
				}
				
				Keys.onPressed: {
					if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
						if ( isInGame ) {
							BlackMesaEngine.executeClientCommand('gameui_hide');
							return;
						} else {
							appRoot.isSubMenuOpenedFunction( false );
							Sound.playEffect("sndclick");
							index.routeRequest(Routes.quit.name);
							return;
						}
					}
				}
			}
		}   //buttonsContainer
	}   //indexMenu
    
	
	
	
	
	
	
	
	
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
					width: rightpanelWidth
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
					height: Math.floor(69 * Theme.heightScale)
					
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
				
				width: parent.width
				height: parent.height
                anchors.right: parent.right
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
					
					opacity: !isAlertVisible ? 1 : 0
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
			
					Behavior on opacity {
						SequentialAnimation {
							OpacityAnimator { duration: 150; easing.type: Easing.OutQuint }
						}
					}
				}
				
				Item {
					id: footLineBody
					
					opacity: !isAlertVisible ? 1 : 0
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
					
					Behavior on opacity {
						SequentialAnimation {
							OpacityAnimator { duration: 150; easing.type: Easing.OutQuint }
						}
					}
				}

    }   //stackBodyItem
	
	
	
	
	
	
	
	
	
	
}   //index
