import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

RouteView {
    OtherList { id: patronsOther

		titleNameText: L10n.strings.menus.ourpatrons

        anchors.centerIn: parent

        model: ListModel { id: patronsOtherModel
            Component.onCompleted: {
                append({ type: "credits", label: "Bolloxed", descr: "Separately from Patreon" });
                append({ type: "credits", label: "Tim Hochberger", descr: "Separately from Patreon" });
				
				append({ type: "credits", label: "The One Freeman" });
				append({ type: "credits", label: "Knoster" });
				append({ type: "credits", label: "Alfredo Moreno" });
				append({ type: "credits", label: "F - good" });
				append({ type: "credits", label: "Simone1234" });
				append({ type: "credits", label: "Ondřej Mejzlík" });
				append({ type: "credits", label: "Peter C." });
				append({ type: "credits", label: "Daniel Anthony" });
				append({ type: "credits", label: "Antonio Germano" });
				append({ type: "credits", label: "Samuel Lewis" });
				append({ type: "credits", label: "Isaac Williams" });
				append({ type: "credits", label: "Colonel Orange" });
				append({ type: "credits", label: "Stephen Tures" });
				append({ type: "credits", label: "Will Wing" });
				append({ type: "credits", label: "Brett Redvers" });
				append({ type: "credits", label: "Brandon Eldridge" });
				append({ type: "credits", label: "KorteZZ Lambda" });
				append({ type: "credits", label: "Florian Thurn" });
				append({ type: "credits", label: "Jirka486" });
				append({ type: "credits", label: "Riman21" });
				append({ type: "credits", label: "ElectronicV" });
				append({ type: "credits", label: "Tóth Milán" });
				append({ type: "credits", label: "Conor Boran" });
				append({ type: "credits", label: "Евгений Бердин" });
				append({ type: "credits", label: "eugene" });
				append({ type: "credits", label: "Scoopio" });
				append({ type: "credits", label: "DrCI" });
				append({ type: "credits", label: "Ryan Dulavitch" });
				append({ type: "credits", label: "Daria Podrezova" });
				append({ type: "credits", label: "warbrand2" });
				append({ type: "credits", label: "Søren Ansbjerg" });
				append({ type: "credits", label: "Nan Zhao" });
				append({ type: "credits", label: "Scott Tracy" });
				append({ type: "credits", label: "Sean Weber" });
				append({ type: "credits", label: "Daniel" });
				append({ type: "credits", label: "Zyntec" });
				append({ type: "credits", label: "Catharine Pierce" });
				append({ type: "credits", label: "RCThreeEight" });
				append({ type: "credits", label: "Gideon Ritter" });
				append({ type: "credits", label: "AC" });
				append({ type: "credits", label: "Hellman4710" });
				append({ type: "credits", label: "Henry Smith" });
				append({ type: "credits", label: "Baldarek" });
				append({ type: "credits", label: "Cole Kuretich" });
				append({ type: "credits", label: "Elan S." });
				append({ type: "credits", label: "iunknownmango" });
				append({ type: "credits", label: "Vinnie" });
				append({ type: "credits", label: "Aras Sidlauskas" });
				append({ type: "credits", label: "Boondock Free" });
				append({ type: "credits", label: "h4r4ld" });
				append({ type: "credits", label: "Joe Enneking" });
				append({ type: "credits", label: "Robert Hoffman" });
				append({ type: "credits", label: "nickstormm" });
				append({ type: "credits", label: "Ruvin Blue" });
				append({ type: "credits", label: "Tristen Smidt" });
				append({ type: "credits", label: "Phantom 485" });
				append({ type: "credits", label: "David Špimrvimr" });
				append({ type: "credits", label: "Alexis Michaux" });
				append({ type: "credits", label: "Ian Griffiths" });
				append({ type: "credits", label: "Ben Clendenen" });
				append({ type: "credits", label: "Moucha" });
				append({ type: "credits", label: "Matic Kelvisar" });
				append({ type: "credits", label: "Smit" });
				append({ type: "credits", label: "Mikhfell" });
				append({ type: "credits", label: "Almost Night" });
				append({ type: "credits", label: "Austin Gabriel" });
				append({ type: "credits", label: "CJ Henderson" });
				append({ type: "credits", label: "Iroquois Pliskin" });
				append({ type: "credits", label: "Matt DieBold" });
				append({ type: "credits", label: "stormcoldcrow" });
				append({ type: "credits", label: "The Mindful Moron" });
				append({ type: "credits", label: "your evil twin" });
				append({ type: "credits", label: "Андрей Горбанёв" });
				append({ type: "credits", label: "NaughtyDino" });
				append({ type: "credits", label: "Stefan Weigel" });
				append({ type: "credits", label: "ArtieS" });
				append({ type: "credits", label: "BonnyChongo" });
				append({ type: "credits", label: "Digital Exordium" });
				append({ type: "credits", label: "Wes Parker" });
				append({ type: "credits", label: "Hydra" });
				append({ type: "credits", label: "Tai Lucas" });
				append({ type: "credits", label: "CP" });
				append({ type: "credits", label: "Илья Булатецкий" });
				append({ type: "credits", label: "Игорь Владимирович" });
				append({ type: "credits", label: "BonnieRobloxRIP" });
				append({ type: "credits", label: "maximo160m" });
				append({ type: "credits", label: "Wayward Scholar" });
				append({ type: "credits", label: "William Venner" });
				append({ type: "credits", label: "Linden Chance" });
				append({ type: "credits", label: "Oliver" });
				append({ type: "credits", label: "Saphire -sama" });
				append({ type: "credits", label: "KobraThor" });
				append({ type: "credits", label: "Martin Naď" });
				append({ type: "credits", label: "CrAzGaming" });
				append({ type: "credits", label: "Dimitri Korottchenko" });
				append({ type: "credits", label: "Case Boux" });
				append({ type: "credits", label: "Deadpool" });
				append({ type: "credits", label: "General Chicken" });
				append({ type: "credits", label: "Heavy3p0" });
				append({ type: "credits", label: "Jon Fuhrmann" });
				append({ type: "credits", label: "Kris" });
				append({ type: "credits", label: "Matt Rhea" });
				append({ type: "credits", label: "Miles07" });
				append({ type: "credits", label: "Thomas Degroot" });
				append({ type: "credits", label: "Дмитрий Кутузов" });
				append({ type: "credits", label: "Ayaxis Cantador" });
				append({ type: "credits", label: "Enzo Sigueñas" });
				append({ type: "credits", label: "ImmortalTheOwl" });
				append({ type: "credits", label: "ClassixGamer" });
				append({ type: "credits", label: "Marius Müller" });
				append({ type: "credits", label: "S'Aarum" });
				append({ type: "credits", label: "Andronikos Koutroumpelis" });
				append({ type: "credits", label: "Daniel" });
				append({ type: "credits", label: "Merudiana" });
				append({ type: "credits", label: "MrMagoffin" });
				append({ type: "credits", label: "MrShooter" });
				append({ type: "credits", label: "stevie" });
				append({ type: "credits", label: "The Gaming Council" });
				append({ type: "credits", label: "Сергей Шмелев" });
				append({ type: "credits", label: "BOOZ" });
				append({ type: "credits", label: "AdminDolphinOFFICIAL" });
				append({ type: "credits", label: "Jay" });
				append({ type: "credits", label: "Nim" });
				append({ type: "credits", label: "Gubbins" });
				append({ type: "credits", label: "RL LR" });
				append({ type: "credits", label: "programmist11180" });
				append({ type: "credits", label: "Caleb Williams" });
				append({ type: "credits", label: "Ashley Davis" });
				append({ type: "credits", label: "AvgUSGamer" });
				append({ type: "credits", label: "MEVAR448" });
				append({ type: "credits", label: "Markus0815" });
				append({ type: "credits", label: "Darkwolf" });
				append({ type: "credits", label: "bjs" });
				append({ type: "credits", label: "chenmozx" });
				append({ type: "credits", label: "Chron1Cone" });
				append({ type: "credits", label: "Evfist" });
				append({ type: "credits", label: "Orgfet" });
				append({ type: "credits", label: "P.R." });
				append({ type: "credits", label: "PAVEL KOTSIUBA" });
				append({ type: "credits", label: "KipTheAnimal" });
				append({ type: "credits", label: "atanda" });
				append({ type: "credits", label: "작고 날개달린 데코트" });
				append({ type: "credits", label: "Henning Schreiber" });
				append({ type: "credits", label: "Alexander 'Kav' Kashev" });
				append({ type: "credits", label: "TGC Duc" });
				append({ type: "credits", label: "Игорь Борисенко" });
				append({ type: "credits", label: "Jonathan Veiga" });
				append({ type: "credits", label: "Sveriges-Största-SG-Fan" });
				append({ type: "credits", label: "José Ángel" });
				append({ type: "credits", label: "Rundas" });
				append({ type: "credits", label: "Brian Carlson" });
				append({ type: "credits", label: "Trav!s" });
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
