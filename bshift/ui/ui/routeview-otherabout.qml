import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

RouteView {
    OtherList { id: aboutOther

		titleNameText: L10n.strings.menus.links

        anchors.centerIn: parent

        model: ListModel { id: aboutOtherModel
            Component.onCompleted: {
                var labels = L10n.strings.links;

				
                append({
                    label: labels.ourmedia,
                    type: "title"
                });
				
                append({
                    label: labels.website,
                    type: "credits",
					link: "https://www.moddb.com/mods/black-mesa-blue-shift-remake",
                    descr: labels.websiteDescr,
                    avatar: "l1"
                });
                
                append({
                    label: labels.workshop,
                    type: "credits",
					link: "https://steamcommunity.com/sharedfiles/filedetails/?id=2424633574",
                    descr: labels.workshopDescr,
                    avatar: "l2"
                });
				
                append({
                    label: labels.discord,
                    type: "credits",
					link: "https://discord.gg/YYTYHJq3XB",
                    descr: labels.discordDescr,
                    avatar: "l3"
                });
				
                append({
                    label: labels.teamYT,
                    type: "credits",
					link: "https://www.youtube.com/channel/UC-CXgyZw2hS0IP2i8ODaxOA",
                    descr: labels.teamYTDescr,
                    avatar: "l4"
                });
				
                append({
                    label: labels.davYT,
                    type: "credits",
					link: "https://www.youtube.com/channel/UCjoL6M9_8-93vmxjO4W5R9w",
                    descr: labels.davYTDescr,
                    avatar: "l4"
                });
				
                append({
                    label: labels.support,
                    type: "title"
                });
				
                append({
                    label: "Patreon",
                    type: "credits",
					link: "https://www.patreon.com/user/overview?u=27329565",
                    descr: labels.patreonDescr,
                    avatar: "l5"
                });
				
                append({
                    label: labels.downloads,
                    type: "title"
                });
				
                append({
                    label: labels.altCrowbars,
                    type: "credits",
					link: "https://www.moddb.com/mods/black-mesa-blue-shift-remake/addons/alternative-crowbars",
                    descr: labels.altCrowbarsDescr,
                    avatar: "l1"
                });
				
                append({
                    label: labels.wallpapers,
                    type: "credits",
					link: "https://drive.google.com/drive/folders/1Y127-LEqIF8piojcyAHKTWUTWMXXugzU?usp=sharing",
                    descr: labels.wallpapersDescr,
                    avatar: "l6"
                });
				
                append({
                    label: labels.checkmore,
                    type: "title"
                });
				
                append({
                    label: labels.hecuprojects,
                    type: "subtitle"
                });
				
                append({
                    label: "Black Mesa: Black Ops",
                    type: "credits",
					link: "https://www.moddb.com/mods/black-mesa-black-ops",
                    descr: labels.blackopsDescr,
                    avatar: "l7"
                });
				
                append({
                    label: "Azure Sheep",
                    type: "credits",
					link: "https://www.moddb.com/mods/black-mesa-azure-sheep",
                    descr: labels.azureDescr,
                    avatar: "l8"
                });
				
                append({
                    label: labels.personalprojects,
                    type: "subtitle"
                });
				
                append({
                    label: "Black Mesa: Damocles (Phase I)",
                    type: "credits",
					link: "https://steamcommunity.com/sharedfiles/filedetails/?id=1679082670",
                    descr: labels.damoclesModDescr,
                    avatar: "l9"
                });
            }
        }

        Item {
            id: footerGraphicDescription
            height: Math.ceil(69 * Theme.heightScale)		// OptionsList Footer Height

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

			property bool isButtonVisible: false

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
					hintTextText: appRoot.isLeftMenuFocused ? L10n.strings.hints.hintselect : L10n.strings.hints.hintopen
					hintButtonColor: appRoot.hintSelectColor
					
					isHintVisible: appRoot.isLeftMenuFocused || footerGraphicDescription.isButtonVisible
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
					
					isHintVisible: appRoot.isInGame
				}
			}
        }


        function onSelectionChanged( modelHasLinks ) {
			if ( modelHasLinks ) {
				footerGraphicDescription.isButtonVisible = true;
			} else {
				footerGraphicDescription.isButtonVisible = false;
			}
			
        }
		
		
    }
}
