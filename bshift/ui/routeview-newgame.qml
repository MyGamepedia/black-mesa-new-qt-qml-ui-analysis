import QtQuick 2.9
import CrowbarCollective 1.0

RouteView {
        id: newGame
        
        Carousel {
            id: newGameCarousel
			
			titleNameText: L10n.strings.menus.newgame

            property var campaignEntries: BlackMesaEngine.listCampaignEntries().filter(function (campaign) { return campaign.isOfficial })
            property var currentlySelectedCampaign: null


            Component.onCompleted: {
                campaignEntries.forEach(function (item) {
                    item.levelName = ""
                        levels.append(item)
                })

                if (levels.count === 1) {
                    currentlySelectedCampaign = campaignEntries[0]
                }
            }

            onCurrentlySelectedCampaignChanged: {
                if (!currentlySelectedCampaign) {
                    return
                }

                levels.clear()

                currentlySelectedCampaign.chapters.forEach(function (item) {
                        levels.append(item)
                })

                showUp = false
                showDown = levels.count > 3

                if (levels.count === 1) {
                    router.loadMapRequest(
                                currentlySelectedCampaign.chapters[0].levelName,
                                BlackMesaEngine.getLocalizedString(
                                    currentlySelectedCampaign.chapters[0].title))
                }
            }


            itemComponent: CarouselNewGameItem {
                    property string localizedTitle: BlackMesaEngine.getLocalizedString(model.title)

                    buttonText: L10n.strings.buttons.startGame

                    //isLocked: ( index === 4 )

                    thumbnailUrl: model.imageSource + Theme.setImgDef
                    chapterName: localizedTitle
                    chapterNumber: (index + 1)

                    onSelected: router.loadMapRequest(model.levelName, localizedTitle)
                    onSelectedWithDoubleClick: router.loadMapRequest(model.levelName, localizedTitle)

                    type: BlackMesaEngine.getLocalizedString("#GameUI_Chapter")
                }

            levels: ListModel {}
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
					hintTextText: appRoot.isLeftMenuFocused ? L10n.strings.hints.hintselect : L10n.strings.hints.hintstart
					hintButtonColor: appRoot.hintSelectColor
				}
				
				Hint {
					id: hint2
					hintButtonText: ( appRoot.isLeftMenuFocused && appRoot.isInGame ) ? ( "<font color=\"" + appRoot.hintBackColor + "\">" + appRoot.hintBackIcon + "</font>" + appRoot.hintCloseIcon ) : appRoot.hintBackIcon
					hintTextText: !appRoot.isLeftMenuFocused ? L10n.strings.hints.hintback : ( appRoot.isInGame ? L10n.strings.hints.hintclosemenu : L10n.strings.hints.hintquitgame )
					hintButtonColor: ( appRoot.isLeftMenuFocused && appRoot.isInGame ) ? Theme.colors.text : appRoot.hintBackColor
				}
				
				Hint {
					id: hint3
					hintButtonText: appRoot.hintCloseIcon
					hintTextText: L10n.strings.hints.hintclosemenu
					
					isHintVisible: !appRoot.isLeftMenuFocused && appRoot.isInGame
				}
			}

        }
}
