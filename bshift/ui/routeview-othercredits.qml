import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

RouteView {
    OtherList { id: creditsOther

		titleNameText: L10n.strings.menus.credits

        anchors.centerIn: parent

        model: ListModel { id: creditsOtherModel
            Component.onCompleted: {
                var labels = L10n.strings.credits;


            // ----------------------------------------------
                append({
                    label:"Hecu Collective",
                    type: "title"
                });
            // ----------------------------------------------
				
            // ----------------------------------------------
                append({
                    label: labels.devs,
                    type: "subtitle"
                });
            // ----------------------------------------------
			
                append({
                    label: "Aslan Akhmetov",
                    nick: "Daver",
                    type: "credits",
                    //descr: labels.davDescr,
                    avatar: "davDescr"
                });
                append({
                    label: "Bella Jasso",
                    nick: "bONES!!",
                    type: "credits",
                    //descr: labels.bonesDescr,
                    avatar: "bonesDescr"
                });
                append({
                    label: "Benjamin Henssler",
                    nick: "Ben'",
                    type: "credits",
                    //descr: labels.benDescr,
                    avatar: "benDescr"
                });
                append({
                    label: "Dmitry Serov",
                    nick: "Imperial Officer",
                    type: "credits",
                    //descr: labels.impoffiDescr,
                    avatar: "impoffiDescr"
                });
                append({
                    label: "Ethan Wallstedt",
                    nick: "Validator",
                    type: "credits",
                    //descr: labels.validDescr,
                    avatar: "validDescr"
                });
                append({
                    label: "Evgeny Latanov",
                    nick: "StavaasEVG",
                    type: "credits",
                    //descr: labels.stavDescr,
                    avatar: "stavDescr"
                });
                append({
                    label: "Florian Becker",
                    nick: "Cyv0",
                    type: "credits",
                    //descr:labels.cyvoDescr,
                    avatar: "cyvoDescr"
                });
                append({
                    label: "Jacob Fossum",
                    nick: "Jofoyo",
                    type: "credits",
                    //descr: labels.jjonahjamesonDescr,
                    avatar: "jjonahjamesonDescr"
                });
				
                append({
                    label: "Kevin Sisk",
                    nick: "debeerguy007",
                    type: "credits",
                    //descr: labels.kevinDescr,
                    avatar: "kevinDescr"
                });
                append({
                    label: "Leonardo Fuentes",
                    nick: "LeoJFC",
                    type: "credits",
                    //descr: labels.leojfcDescr,
                    avatar: "leojfcDescr"
                });
                append({
                    label: "Mike Hillard",
                    nick: "Cornet",
                    type: "credits",
                    //descr: labels.hillardDescr,
                    avatar: "hillardDescr"
                });
                append({
                    label: "Noah Deibler",
                    nick: "UnstoppableGiant",
                    type: "credits",
                    //descr: labels.giantDescr,
                    avatar: "giantDescr"
                });
                append({
                    label: "Orest Zhuk",
                    nick: "Faber",
                    type: "credits",
                    //descr: labels.fabDescr,
                    avatar: "fabDescr"
                });
                append({
                    label: "Rex Camarillo",
                    nick: "CitizenFive",
                    type: "credits",
                    //descr: labels.citifiveDescr,
                    avatar: "citifiveDescr"
                });
                append({
                    label: "Ronald Hamrák",
                    nick: "RonaldVA",
                    type: "credits",
                    //descr: labels.ronDescr,
                    avatar: "ronDescr"
                });
                append({
                    label: "Samir Kanbarov",
                    nick: "RIMAS",
                    type: "credits",
                    //descr: labels.rimasDescr,
                    avatar: "rimasDescr"
                });
                append({
                    label: "Stanislav Epifantsev",
                    nick: "LIL-PIF",
                    type: "credits",
                    //descr: labels.lilDescr,
                    avatar: "lilDescr"
                });
                append({
                    label: "Stephen Otten",
                    nick: "ICEBIRD112",
                    type: "credits",
                    //descr: labels.icebirbDescr,
                    avatar: "icebirbDescr"
                });
                append({
                    label: "William Chouffart",
                    nick: "Skwallie",
                    type: "credits",
                    //descr: labels.skwallieDescr,
                    avatar: "skwallieDescr"
                });

            // ----------------------------------------------
                append({
                    label: labels.pastDevs,
                    type: "subtitle"
                });
            // ----------------------------------------------
				
                append({
                    label: "Artur Reshetnyak",
                    nick: "BlackPriest",
                    type: "credits",
                    //descr: labels.bprDescr,
                    avatar: "bprDescr"
                });
                append({
                    label: "Andrey Sirenko",
                    nick: "Avesome Vourden",
                    type: "credits",
                    //descr: labels.avevourDescr,
                    avatar: "avevourDescr"
                });
                append({
                    label: "Alexey Belyakov",
                    nick: "Decoy",
                    type: "credits",
                    //descr: labels.decoyDescr,
                    avatar: "decoyDescr"
                });
                append({
                    label: "Artyom Bogomolov",
                    nick: ".mdl",
                    type: "credits",
                    //descr: labels.mdlDescr,
                    avatar: "mdlDescr"
                });
                append({
                    label: "Eduard Kirillov",
                    nick: "MyCbEH",
                    type: "credits",
                    //descr: labels.musienDescr,
                    avatar: "musienDescr"
                });
                append({
                    label: "Vladislav Lisovichenko",
                    nick: "ZloiKot",
                    type: "credits",
                    //descr: labels.zloikotDescr,
                    avatar: "zloikotDescr"
                });

            // ----------------------------------------------
                append({
                    label: labels.playtesters,
                    type: "subtitle"
                });
            // ----------------------------------------------

                append({
                    label: "Adam Engels",
                    nick: "Adam-Bomb",
                    type: "credits",
                    descr: labels.adamCCDescr,
                    avatar: "adamCCDescr"
                });
                append({
                    label: "Anthony Stone",
                    nick: "Sentinel",
                    type: "credits",
                    descr: labels.sentinelCCDescr,
                    avatar: "sentinelCCDescr"
                });
                append({
                    label: "Chon Kemp",
                    nick: "DIGITAL SPORTS",
                    type: "credits",
                    descr: labels.digispCCDescr,
                    avatar: "digispCCDescr"
                });
                append({
                    label: "Johnathan Welsh",
                    nick: "Comrade Badger",
                    type: "credits",
                    descr: labels.sentinelCCDescr,
                    avatar: "comradeCCDescr"
                });
                append({
                    label: "Thomas Shkurti",
                    nick: "Autom",
                    type: "credits",
                    descr: labels.automDescr,
                    avatar: "automDescr"
                });


            // ----------------------------------------------
                append({
                    label: labels.support,
                    type: "subtitle"
                });
            // ----------------------------------------------
				
                append({
                    label: "Crowbar Collective",
                    type: "credits",
                    descr: labels.crowbarsDescr,
                    avatar: "crowbarsDescr",
					link: "https://discord.gg/crowbarcollective"
                });
                append({
                    label: "ALLAN",
                    type: "credits",
                    descr: labels.allanDescr,
                    avatar: "allanDescr"
                });
                append({
                    label: "breakin bones",
                    type: "credits",
                    descr: labels.randomguyDescr,
                    avatar: "randomguyDescr"
                });
                append({
                    label: "JuliaMonoArt",
                    type: "credits",
                    descr: labels.juliaDescr,
                    avatar: "juliaDescr"
                });
                append({
                    label: "Paweł Perepelica",
                    type: "credits",
                    descr: labels.guestCompDescr,
                    avatar: "guestCompDescr",
					link: "https://www.youtube.com/@weirdsoutherner"
                });
                append({
                    label: "skyms2663",
                    type: "credits",
                    descr: labels.skymsDescr,
                    avatar: "skymsDescr"
                });
                append({
                    label: labels.everyoneelse,
                    type: "credits",
                    descr: labels.everyoneelseDescr,
                    avatar: "everyoneelseDescr"
                });
            // ----------------------------------------------
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
