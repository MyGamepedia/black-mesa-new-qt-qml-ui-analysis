import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

RouteView {
    OtherList { id: translatorsOther

		titleNameText: L10n.strings.menus.translators

        anchors.centerIn: parent

        model: ListModel { id: translatorsOtherModel
            Component.onCompleted: {
                var labels = L10n.strings.options.values;

                //append({ label: labels.langArabic, type: "title" });
                append({ label: labels.langChineseSimplified, type: "title" });
					append({ type: "credits", label:"MXYLR" });
					
                append({ label: labels.langChineseTraditional, type: "title" });
					append({ type: "credits", label:"@plazehorta" });
					
                //append({ label: labels.langCroatian, type: "title" });
				//	append({ type: "credits", label:"@cosmictaco01" });
				
                append({ label: labels.langCzech, type: "title" });
					append({ type: "credits", label:"Jonáš Loskot" });
					append({ type: "credits", label:"@halflifeblazen" });
					append({ type: "credits", label:"Jan Jirsík" });
					
                //append({ label: labels.langDanish, type: "title" });
				
                //append({ label: labels.langDutch, type: "title" });
				
                //append({ label: labels.langFinnish, type: "title" });
				//	append({ type: "credits", label:"@dandeson" });
				
                append({ label: labels.langFrench, type: "title" });
					append({ type: "credits", label:"ModderOfGames" });
					append({ type: "credits", label:"Alexandre Juvanon" });
					append({ type: "credits", label:"@k.saiko" });
					append({ type: "credits", label:"FichierCorrompu" });
					append({ type: "credits", label:"@saarum" });
					append({ type: "credits", label:"@louis.vittaut" });
					
                //append({ label: labels.langGeorgian, type: "title" });
				
                append({ label: labels.langGerman, type: "title" });
					append({ type: "credits", label:"Florian Becker", nick: "Cyv0", tlflag: "de", avatar: "cyvoDescr" });
					append({ type: "credits", label:"@itzylol" });
					append({ type: "credits", label:"Constantin Coester" });
					append({ type: "credits", label:"Artur Neufeld" });
					append({ type: "credits", label:"@dantube" });
					
                //append({ label: labels.langGreek, type: "title" });
				//	append({ type: "credits", label:"@t0rr3r" });
				
                //append({ label: labels.langHungarian, type: "title" });
				//	append({ type: "credits", label:"@sndrkrly" });
				
                append({ label: labels.langIndonesian, type: "title" });
					append({ type: "credits", label:"@wolfheze2233" });
				
                append({ label: labels.langItalian, type: "title" });
					append({ type: "credits", label:"@kikkus" });
					append({ type: "credits", label:"@anticitizen1." });
				
                append({ label: labels.langJapanese, type: "title" });
					append({ type: "credits", label:"@braininavet" });
					
                append({ label: labels.langKorean, type: "title" });
					append({ type: "credits", label:"@ant7575ant" });
					append({ type: "credits", label:"@braininavet" });
					append({ type: "credits", label:"Seunghun Cha" });
					
                //append({ label: labels.langLithuanian, type: "title" });
				//	append({ type: "credits", label:"@uzgjty" });
				
                //append({ label: labels.langNorwegian, type: "title" });
				
                append({ label: labels.langPolish, type: "title" });
					append({ type: "credits", label:"Piotr Stawarski" });
					
                append({ label: labels.langPortuguese, type: "title" });
					append({ type: "credits", label:"Dinis Martins" });
				
                append({ label: labels.langPortugueseBrazilian, type: "title" });
					append({ type: "credits", label:"Lucas Del Fiol" });
					append({ type: "credits", label:"@steampunkcorvus" });
					append({ type: "credits", label:"Matheus Forte de Melo" });
					
                append({ label: labels.langRomanian, type: "title" });
					append({ type: "credits", label:"Chef Prowlnos" });
					append({ type: "credits", label:"Ferariu Alexandru Iulian" });
				
                append({ label: labels.langRussian, type: "title" });
					append({ type: "credits", label: "Evgeny Latanov", nick: "StavaasEVG", tlflag: "ru", avatar: "stavDescr" });
					
                append({ label: labels.langSpanish, type: "title" });
					append({ type: "credits", label:"@henryact" });
					append({ type: "credits", label:"Ernesto León" });
					append({ type: "credits", label:"@elbusalv" });
					
                append({ label: labels.langSpanishMexico, type: "title" });
					append({ type: "credits", label:"@tfs._" });
				
                append({ label: labels.langSwedish, type: "title" });
					append({ type: "credits", label:"@hnaledi" });
					
                append({ label: labels.langTurkish, type: "title" });
					append({ type: "credits", label:"@blink182." });
					append({ type: "credits", label:"@.kalasnikov" });
					append({ type: "credits", label:"@f.s.1285" });
					append({ type: "credits", label:"@swensai" });
					append({ type: "credits", label:"@perremian (@cordstim)" });
					append({ type: "credits", label:"@emirhanbudak" });
					append({ type: "credits", label:"@karetsin" });
					
                append({ label: labels.langUkrainian, type: "title" });
					append({ type: "credits", label: "Orest Zhuk", nick: "Faber", tlflag: "ua", avatar: "fabDescr" });
					
                append({ label: labels.langVietnamese, type: "title" });
					append({ type: "credits", label:"@shizuekaryan" });
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
