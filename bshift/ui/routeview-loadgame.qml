import QtQuick 2.9
import CrowbarCollective 1.0

RouteView {
	id: loadGame
    property variant selectedModel
        
        Carousel { id: loadGameCarousel
			titleNameText: L10n.strings.menus.loadgame
		
            itemComponent: CarouselLoadGameItem {
                buttonText: model.buttonText
                thumbnailUrl: model.thumbnailUrl
                chapterName: model.chapterName
                date: Theme.getDateTimeString(model.date)
                saveType: model.saveType
                onSelected:                router.loadGameRequest(model)
                onSelectedWithDoubleClick: router.loadGameRequest(model)

                secondaryButtonVisible: true
                buttonTextSecondary: BlackMesaEngine.getLocalizedString("#GameUI_Delete")
                    
                onSelectedSecondary: {
				
                    loadGame.selectedModel = model;
					isAlertVisible = true;
                    confirmDeleteAlert.show();
                }
            }

            levels: ListModel {
                Component.onCompleted: {
                    BlackMesaUtils.getSaveGames().forEach(function (save) {
                        append({
                            savename: save.savename,
                            chapter: save.chapter,
                            chapterName: save.chapterName,
                            date: save.dateCreated,
                            thumbnailUrl: save.thumbnail,
                            saveType: save.type,
                            buttonText: L10n.strings.buttons.resume
                        });
                    });
                }
            }
        }

        Item {
            id: footerGraphicDescription
            height: Math.ceil(69 * Theme.heightScale)		// OptionsList Footer Height

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
					hintTextText: appRoot.isLeftMenuFocused ? L10n.strings.hints.hintselect : L10n.strings.hints.hintload
					hintButtonColor: appRoot.hintSelectColor
				}
				Hint {
					id: hint2
					hintButtonText: appRoot.hintRIcon
					hintTextText: L10n.strings.hints.hintdelete
					
					isHintVisible: !appRoot.isLeftMenuFocused
				}
				Hint {
					id: hint3
					hintButtonText: ( appRoot.isLeftMenuFocused && appRoot.isInGame ) ? ( "<font color=\"" + appRoot.hintBackColor + "\">" + appRoot.hintBackIcon + "</font>" + appRoot.hintCloseIcon ) : appRoot.hintBackIcon
					hintTextText: !appRoot.isLeftMenuFocused ? L10n.strings.hints.hintback : ( appRoot.isInGame ? L10n.strings.hints.hintclosemenu : L10n.strings.hints.hintquitgame )
					hintButtonColor: ( appRoot.isLeftMenuFocused && appRoot.isInGame ) ? Theme.colors.text : appRoot.hintBackColor
				}
				Hint {
					id: hint4
					hintButtonText: appRoot.hintCloseIcon
					hintTextText: L10n.strings.hints.hintclosemenu
					
					isHintVisible: !appRoot.isLeftMenuFocused && appRoot.isInGame
				}
			}
        }
		
		
        Alert { id: confirmDeleteAlert
            titleText: L10n.strings.headers.deleteSaveConfirmation
            messageText: L10n.strings.modalMessages.deleteSaveConfirmation
			lastTraversalLevel: 2
			
            buttons: VisualItemModel { id: deleteButtons
			
                BSButton {
                    objectName: "ui--navigation:bsbutton:level_4"
                    bsInnerColor: Theme.colors.warning
                    text: L10n.strings.buttons.deleteSave
                    callback: function() {
						if (BlackMesaEngine.removeSaveEntry(selectedModel.savename)) {
							loadGameCarousel.levels.clear()
							loadGameCarousel.levels.Component.completed()
							
							if  (!BlackMesaUtils.getSaveGames()[0]) {
								rank = -1;
								appRoot.isSubMenuOpenedFunction( false );
								isLoadGameMenuVisible = false;
								outlet.setCategory(Routes.empty.qmlFile,  0, false);
							}
						}

						selectedModel = null;
						isAlertVisible = false;
						confirmDeleteAlert.hide();
                    }
                    onClicked: {
						if (BlackMesaEngine.removeSaveEntry(selectedModel.savename)) {
							loadGameCarousel.levels.clear()
							loadGameCarousel.levels.Component.completed()
							
							if  (!BlackMesaUtils.getSaveGames()[0]) {
								rank = -1;
								appRoot.isSubMenuOpenedFunction( false );
								isLoadGameMenuVisible = false;
								outlet.setCategory(Routes.empty.qmlFile,  0, false);
							}
							
						}

						selectedModel = null;
						isAlertVisible = false;
						confirmDeleteAlert.hide();
					}
					Keys.onPressed: {
						if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
							Sound.playEffect("sndclick");
							isAlertVisible = false;
							confirmDeleteAlert.hide();
							return;
						}
					}
                }

                BSButton {
                    objectName: "ui--navigation:bsbutton:level_4"
                    text: L10n.strings.buttons.cancel
                    callback: function() {
						isAlertVisible = false;
                        confirmDeleteAlert.hide();
                    }
                    onClicked: {
						isAlertVisible = false;
                        confirmDeleteAlert.hide();
                    }
					Keys.onPressed: {
						if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
							Sound.playEffect("sndclick");
							isAlertVisible = false;
							confirmDeleteAlert.hide();
							return;
						}
					}
                }
            }
        }
}
