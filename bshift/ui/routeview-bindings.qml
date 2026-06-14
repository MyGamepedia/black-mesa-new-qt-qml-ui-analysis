import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

RouteView { id: bindingsOptions
    property bool isWidescreen: appRoot.width / appRoot.height >= 1.586
    
    property int logoVerticalCenterOffset: Math.ceil(-93 * Theme.heightScale)
    property int childTopMargin: Math.ceil(-20 * Theme.heightScale)
    property int titleNameFontSize: Math.ceil(60 * Theme.heightScale)
    
    property int childLogoMargin: isWidescreen ? Math.ceil(200 * Theme.widthScale) :  Math.ceil(70 * Theme.widthScale)
    property int childMargin: isWidescreen ? Math.ceil(120 * Theme.widthScale) :  Math.ceil(20 * Theme.widthScale)

     anchors.fill: parent
     
    property int rightpanelWidth: isWidescreen ? Math.ceil(1200 * Theme.widthScale) :  Math.ceil(1300 * Theme.widthScale)
	
    property int footerHeight: Math.floor(183 * Theme.heightScale)
	
    property int buttonMargin: Math.ceil(35 * Theme.widthScale)
    property int buttonTopMargin: Math.ceil(10 * Theme.heightScale)
    property int buttonFooterMargin: Math.ceil(4 * Theme.heightScale)
    
    property int rank: -1

    function onRouteWillChange(newRouteName) {
        InputBindingsManager.clearSelection();
    }

    function goBack() {
		bindingsOptions.routeRequest(Routes.bsoptions.name);
		appRoot.isSubMenuOpenedFunction( false );
		return;
    }

    Component.onCompleted: {
        outlet.setCategory(Routes.empty.qmlFile,  rank, true);
		appRoot.isMenuBlocked = false;
    }

    Item { id: indexBindingsMenu
        anchors.fill: parent

            Text { id: titleTextShadowRight
                anchors.left: parent.left
                anchors.leftMargin: childLogoMargin + Math.ceil(2 * Theme.heightScale)
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: logoVerticalCenterOffset + Math.ceil(2 * Theme.heightScale)
                text: titleText.text
                font.capitalization: Font.MixedCase
                font.pixelSize: bindingsOptions.titleNameFontSize
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
                text: L10n.strings.menus.bindings
                font.capitalization: Font.MixedCase
                font.pixelSize: bindingsOptions.titleNameFontSize
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
			
                    BSLetterboxButton { id: firstTabButton
                        objectName: !selected ? ( (rank === -1) ? "ui--navigation:bstab:level_2" : "ui--navigation:bstab:level_1") : ""
                        selected: rank == 0
                        text: L10n.strings.options.labels.binding_movement
                        callback: function() {
                            rank = 0;
                            outlet.setCategory( "component-binding-movement.qml",  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
                        onClicked: {
                            rank = 0;
                            outlet.setCategory( "component-binding-movement.qml",  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
					
                    BSLetterboxButton { id: secondTabButton
                        objectName: !selected ? ( (rank === -1) ? "ui--navigation:bstab:level_2" : "ui--navigation:bstab:level_1") : ""
                        selected:  rank == 1
                        text: L10n.strings.options.labels.binding_combat
                        callback: function() {
                            rank = 1;
                            outlet.setCategory( "component-binding-combat.qml",  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
                        onClicked: {
                            rank = 1;
                            outlet.setCategory( "component-binding-combat.qml",  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                    
                    BSLetterboxButton { id: thirdTabButton
                        objectName: !selected ? ( (rank === -1) ? "ui--navigation:bstab:level_2" : "ui--navigation:bstab:level_1") : ""
                        selected:  rank == 2
                        text: L10n.strings.options.labels.binding_misc
                        callback: function() {
                            rank = 2;
                            outlet.setCategory( "component-binding-misc.qml",  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
                        onClicked: {
                            rank = 2;
                            outlet.setCategory( "component-binding-misc.qml",  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                    
                    BSLetterboxButton { id: fourthTabButton
                        objectName: !selected ? ( (rank === -1) ? "ui--navigation:bstab:level_2" : "ui--navigation:bstab:level_1") : ""
                        selected:  rank == 3
                        text: L10n.strings.options.labels.binding_weapons
                        callback: function() {
                            rank = 3;
                            outlet.setCategory( "component-binding-weapons.qml",  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
                        onClicked: {
                            rank = 3;
                            outlet.setCategory( "component-binding-weapons.qml",  rank, false );
							appRoot.isSubMenuOpenedFunction( true );
                        }
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                    
                    BSButton { id: fifthButton
                        objectName: (rank === -1) ? "ui--navigation:bsbutton:level_2" : "ui--navigation:bsbutton:level_1"
                        text: L10n.strings.buttons.execKBMPreset
                        callback: function() { resetDefaultsAlert.show(); }
                        onClicked: { resetDefaultsAlert.show(); }
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                    
                    BSButton { id: sixthButton
                        objectName: (rank === -1) ? "ui--navigation:bsbutton:level_2" : "ui--navigation:bsbutton:level_1"
                        text: "Steam Input"
                        callback: function() {
							BlackMesaUtils.setTimeout(function() {
                                BlackMesaEngine.executeClientCommandUnrestricted("steam_input_show_bindings");
                            }, 500);
						}
                        onClicked: {
							BlackMesaUtils.setTimeout(function() {
                                BlackMesaEngine.executeClientCommandUnrestricted("steam_input_show_bindings");
                            }, 500);
						}
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                    
                    BSButton { id: backButton
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
            
    }   //indexBindingsMenu
    
    
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
					height: footerHeight
					
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
				
				width: stackBodyItem.width
				height: stackBodyItem.height
				
                anchors.top: stackBodyItem.top
                anchors.bottom: stackBodyItem.bottom
				
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
									property: "x"
									from: parent.width
									to: 0
									duration: 150
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
                                property: "x"
                                from: 0
                                to: parent.width
                                duration: 150
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


    Item {
		id: footer
			
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
			
        anchors.right: parent.right
        anchors.rightMargin: 0

        width: rightpanelWidth - Math.ceil(6 * Theme.heightScale)
		height: footerHeight
			
		state: !appRoot.isSubMenuOpened ? "blur" : "focused"
				
		states: [
			State {
				name: "blur"

				PropertyChanges {
					target: footer;
					opacity: 0
				}
			},
			State {
				name: "focused"

				PropertyChanges {
					target: footer;
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
            id: footerGraphicDescription
            height: footerHeight		// OptionsList Footer Height

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

			Item {
				id: hintBGBase
				anchors.bottom: footerGraphicDescription.bottom
				anchors.left: footerGraphicDescription.left
				anchors.right: footerGraphicDescription.right
				
				height: 0
				width: footerGraphicDescription.width

				Rectangle {
					id: hintsBGSec
					height: hintBGBase.width + Math.ceil(2 * Theme.widthScale)
					width: Math.ceil(30 * Theme.heightScale)
					anchors.centerIn: hintBGBase
					anchors.verticalCenterOffset: Math.ceil(-20 * Theme.heightScale)
					
					rotation: -90
					opacity: Theme.opacity.bsRightPanel
					
					gradient: Gradient {
						GradientStop { position: 0.3; color:  "transparent" }
						GradientStop { position: 0.7; color: Theme.colors.highlight }
					}
				}
				
				Rectangle {
					id: hintsBG
					height: hintBGBase.width + Math.ceil(2 * Theme.widthScale)
					width: Math.ceil(39 * Theme.heightScale)
					anchors.centerIn: hintBGBase
					anchors.verticalCenterOffset: Math.ceil(-34 * Theme.heightScale)
					
					rotation: -90
					opacity: 0.9
					
					gradient: Gradient {
						GradientStop { position: 0.1; color:  "transparent" }
						GradientStop { position: 0.6; color: Theme.colors.subMenuHintPrimary }
					}
				}
			}
			
			Row {
				anchors.bottom: parent.bottom
				anchors.right: footerGraphicDescription.right
				anchors.rightMargin: Math.ceil(30 * Theme.widthScale)
				anchors.bottomMargin: Math.ceil(-10 * Theme.heightScale)

				Hint {
					id: hint1
					hintButtonText: appRoot.hintSelectIcon
					hintTextText: InputBindingsManager.isSelected ? L10n.strings.hints.hintchange : L10n.strings.hints.hintselect
					hintButtonColor: appRoot.hintSelectColor
					
					isHintVisible: !InputBindingsManager.isBinding
				}
				Hint {
					id: hint2
					hintButtonText: appRoot.hintRIcon
					hintTextText: L10n.strings.hints.hintclear
					
					isHintVisible: InputBindingsManager.isSelected
				}
				Hint {
					id: hint3
					hintButtonText: InputBindingsManager.isBinding ? "" : appRoot.hintBackIcon
					hintTextText: InputBindingsManager.isSelected ? L10n.strings.hints.hintcancel : ( InputBindingsManager.isBinding ? L10n.strings.hints.hintbinding : L10n.strings.hints.hintback )
					hintButtonColor: appRoot.hintBackColor
				}
				Hint {
					id: hint4
					hintButtonText: appRoot.hintCloseIcon
					hintTextText: InputBindingsManager.isBinding ? L10n.strings.hints.hintcancel : L10n.strings.hints.hintclosemenu
					
					isHintVisible: appRoot.isInGame || InputBindingsManager.isBinding
				}
			}
        }
				
				
                
            Column {
				anchors.top: parent.top
				anchors.topMargin: Math.ceil(13 * Theme.heightScale)
				
				anchors.left: footer.left
				anchors.leftMargin: ( footer.width - editBindingButton.width ) / 2
			
				spacing: buttonFooterMargin

                CTAButton {
                    id: editBindingButton
                    objectName: ( BlackMesaUtils.traversalDepth === 2 || BlackMesaUtils.traversalDepth === 3 ) ? "ui--navigation:button:level_2" : "ui--navigation:button:level_4"
                    disabled: !InputBindingsManager.isSelected
                    text: L10n.strings.buttons.editBinding
                    callback: function() {
                        InputBindingsManager.startBindingRequest();
                    }
                    onClicked: {
                        InputBindingsManager.startBindingRequest();
                    }
                }

                WarningButton {
                    id: clearBindingButton
                    objectName: ( BlackMesaUtils.traversalDepth === 2 || BlackMesaUtils.traversalDepth === 3 ) ? "ui--navigation:button:level_2" : "ui--navigation:button:level_4"
                    disabled: !InputBindingsManager.isSelected
                    text: L10n.strings.buttons.clearBinding
                    callback: function() {
                        InputBindingsManager.clearSelectedBinding();
                    }
                    onClicked: {
                        InputBindingsManager.clearSelectedBinding();
                    }
                }
            }
    }
        
        
    Alert { id: resetDefaultsAlert
        titleText: L10n.strings.headers.keyboardPresetWarning
        messageText: L10n.strings.modalMessages.keyboardPresetWarning
		descrFontSize: Math.ceil(24 * Theme.heightScale)
		lastTraversalLevel: (rank === -1) ? 2 : 1
		
        buttons: VisualItemModel {
            BSButton {
				disabled: resetDefaultsAlert.state === "hidden"
                objectName: "ui--navigation:bsbutton:level_4"
                text: L10n.strings.buttons.apply
                callback: function() {
                    resetDefaultsAlert.hide();
					
                    InputBindingsManager.restoreDefaultBindings();
                }
                onClicked: {
                    resetDefaultsAlert.hide();
					
                    InputBindingsManager.restoreDefaultBindings();
                }
				Keys.onPressed: {
					if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
						Sound.playEffect("sndclick");
						resetDefaultsAlert.hide();
						return;
					}
				}
            }

            BSButton {
				disabled: resetDefaultsAlert.state === "hidden"
                objectName: "ui--navigation:bsbutton:level_4"
                text: L10n.strings.buttons.cancel
                callback: function() {
                    resetDefaultsAlert.hide();
                }
                onClicked: {
                    resetDefaultsAlert.hide();
                }
				Keys.onPressed: {
					if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
						Sound.playEffect("sndclick");
						resetDefaultsAlert.hide();
						return;
					}
				}
            }
        }
    }


    Alert { id: confirmBindingOverwriteAlert
        titleText: L10n.strings.headers.confirmBindingOverwrite
		lastTraversalLevel: 2
		
        buttons: VisualItemModel {
            BSButton {
				disabled: confirmBindingOverwriteAlert.state === "hidden"
                objectName: "ui--navigation:bsbutton:level_4"
                text: L10n.strings.buttons.confirm
                callback: function() {
                    InputBindingsManager.conflictCfg.confirm();
                }
                onClicked: {
                    InputBindingsManager.conflictCfg.confirm();
                }
				Keys.onPressed: {
					if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
						Sound.playEffect("sndclick");
						InputBindingsManager.conflictCfg.cancel();
						return;
					}
				}
            }

            BSButton {
				disabled: confirmBindingOverwriteAlert.state === "hidden"
                objectName: "ui--navigation:bsbutton:level_4"
                text: L10n.strings.buttons.cancel
                callback: function() {
                    InputBindingsManager.conflictCfg.cancel();
                }
                onClicked: {
                    InputBindingsManager.conflictCfg.cancel();
                }
				Keys.onPressed: {
					if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
						Sound.playEffect("sndclick");
						InputBindingsManager.conflictCfg.cancel();
						return;
					}
				}
            }
        }
    }
        
        
    Connections {
        target: InputBindingsManager

        onConflictsChanged: {
            var message,
				thisKey,
                cfg,
                conflicts = InputBindingsManager.conflicts;

            if (conflicts) {
                message = L10n.strings.modalMessages.confirmBindingOverwrite;
                cfg = InputBindingsManager.conflictCfg;
				
                thisKey = BlackMesaUtils.getKeyIcon(cfg.key);
				
                message = message.replace('{0}', '');
                message = message.replace('{1}', conflicts );

                confirmBindingOverwriteAlert.messageKeyVisible = true;
                confirmBindingOverwriteAlert.messageTextKey = thisKey;
                confirmBindingOverwriteAlert.messageText = message;
                confirmBindingOverwriteAlert.show();
            } else {
                confirmBindingOverwriteAlert.hide();
            }
        }
    }

}   //indexCampaign
