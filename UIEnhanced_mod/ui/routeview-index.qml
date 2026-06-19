import QtQuick 2.9
import CrowbarCollective 1.0
import QtQuick.LocalStorage 2.0

RouteView { id: index
	property variant lastSave
	property bool isInGame: false
	property bool showRoguePointCTA: true

	property int logoVerticalCenterOffset: Math.ceil(-80 * Theme.heightScale)
	property int childMargin: Math.ceil(75 * Theme.widthScale)
	property int gameNameFontSize: Math.ceil(51 * Theme.heightScale)

	Component.onCompleted: {
		lastSave = BlackMesaUtils.getSaveGames()[0];

		loadRoguePointCTAVisibility();

		if (isInGame) {
			loader.sourceComponent = indexInGame
			showRoguePointCTA = false
		} else if (lastSave) {
			loader.sourceComponent = indexContinue
		} else {
			loader.sourceComponent = indexNew
		}
	}

	function saveRoguePointCTAVisibility() {
		var db = LocalStorage.openDatabaseSync("BlackMesa", "1.0", "Settings", 100);
		db.transaction(function(tx) {
			tx.executeSql('CREATE TABLE IF NOT EXISTS Settings(key TEXT, value TEXT)');
			tx.executeSql('INSERT OR REPLACE INTO Settings VALUES(?, ?)', ["showRoguePointCTA", showRoguePointCTA]);
		});
	}

	function loadRoguePointCTAVisibility() {
		var db = LocalStorage.openDatabaseSync("BlackMesa", "1.0", "Settings", 100);
		db.transaction(function(tx) {
			tx.executeSql('CREATE TABLE IF NOT EXISTS Settings(key TEXT, value TEXT)');
			var rs = tx.executeSql('SELECT value FROM Settings WHERE key = ?', ["showRoguePointCTA"]);
			if (rs.rows.length > 0) {
				showRoguePointCTA = rs.rows.item(0).value === 'true';
			}
		});
	}

	Loader { id: loader
		anchors.fill: parent
		onStatusChanged: function() {
			if (loader.status == Loader.Ready) {
				BlackMesaUtils.clearUIElementsData();
				BlackMesaUtils.traverseUIElements(appRoot);
				BlackMesaUtils.afterTraverseCallback();
			}
		}
	}
	
	Image {
		id: roguePointCTA
        width: Math.ceil(652 * Theme.widthScale)
        height: Math.ceil(144 * Theme.widthScale)

		source: "image://game/ui/images/rp-wishlist-cta.png"

		anchors.top: parent.top
		anchors.right: parent.right
		anchors.topMargin: -50
		opacity: 1.0

		visible: showRoguePointCTA

		Behavior on opacity {
			NumberAnimation {
				duration: 200
			}
		}

		MouseArea {
			id: hoverArea
			anchors.fill: parent
			cursorShape: Qt.PointingHandCursor

			hoverEnabled: true

			onClicked: {
				BlackMesaEngine.activateSteamOverlayToWebPage("https://store.steampowered.com/app/1843840?utm_source=blackmesa_ui&utm_campaign=wishlists")
				Sound.playEffect(Theme.sounds.buttonClicked)
			}

			onEntered: {
				roguePointCTA.opacity = 0.6;
				Sound.playEffect(Theme.sounds.buttonFocused)
			}

			onExited: {
				roguePointCTA.opacity = 1.0;
			}

		}

		Rectangle {
			id: closeButton
			width: 30
			height: 30
			color: "transparent"
			border.color: "white"
			border.width: 2
			radius: 15
			anchors.top: parent.top
			anchors.right: parent.right
			anchors.margins: 15

			Text {
				text: "X"
				color: "white"
				anchors.centerIn: parent
			}

			MouseArea {
				anchors.fill: parent
				onClicked: {
					showRoguePointCTA = false;
					saveRoguePointCTAVisibility();
					Sound.playEffect(Theme.sounds.buttonClicked);
				}
			}
		}
	}

	Component { id: indexInGame
		Item { id: root
			property int logoDimension: Math.ceil(69 * Theme.heightScale)
			property int childTopMargin: Math.ceil(40 * Theme.heightScale)
			property int buttonTopMargin: Math.ceil(15 * Theme.heightScale)
			property int timerTopMargin: Math.ceil(15 * Theme.heightScale)

			Image { id: logo
				source: "image://game/ui/images/logo.png"

				width: parent.width
				height: root.logoDimension

				fillMode: Image.PreserveAspectFit
				horizontalAlignment: Image.AlignLeft

				anchors.left: parent.left
				anchors.leftMargin: childMargin
				anchors.verticalCenter: parent.verticalCenter
				anchors.verticalCenterOffset: logoVerticalCenterOffset
			}

			Text { id: gameNameText
				anchors.top: logo.bottom
				anchors.topMargin: root.childTopMargin
				anchors.left: parent.left
				anchors.leftMargin: childMargin
				text: BlackMesaEngine.getLocalizedString(BlackMesaEngine.getChapterName())
				font.capitalization: Font.MixedCase
				font.pixelSize: index.gameNameFontSize
				font.family: Theme.fonts.regular
				font.letterSpacing: 5
				color: Theme.colors.buttonText
			}

			Text { id: timerText
				color: Theme.colors.buttonText
				anchors.top: gameNameText.bottom
				anchors.topMargin: root.timerTopMargin
				anchors.left: parent.left
				anchors.leftMargin: childMargin
				font.family: Theme.fonts.light
				font.capitalization: Font.AllUppercase
				font.pixelSize: Math.ceil(21 * Theme.heightScale)
			}

			Row {
				width: parent.width
				anchors.top: timerText.bottom
				anchors.topMargin: root.buttonTopMargin
				anchors.left: parent.left
				anchors.leftMargin: childMargin
				spacing: 5

				CTAButton {
					objectName: "ui:btn:action[apply]"
					disabled: appRoot.isInMultiplayerMode
					text: L10n.strings.buttons.quicksave
					onClicked: {
						index.saveGameRequest("quick");
					}
				}

				CTAButton {
					disabled: appRoot.isInMultiplayerMode
					text: L10n.strings.buttons.saveGame
					onClicked: {
						index.routeRequest(Routes.savegame.name);
					}
				}

				CTAButton {
					objectName: "ui:btn:action[discard]"
					text: L10n.strings.buttons.disconnect
					onClicked: {
						BlackMesaEngine.executeClientCommandUnrestricted("disconnect");
						isInGame = false;
						appRoot.isInMultiplayerMode = false;
						loader.sourceComponent = indexContinue;
						index.routeRequest(Routes.index.name);
					}
				}
			}

			Timer {
				interval: 1000
				running: true
				repeat: true
				triggeredOnStart: true
				onTriggered: {
					timerText.text = Theme.getDateTimeString(new Date());
				}
			}
		}
	}

	Component { id: indexNew
		Item { id: root
			property int logoDimension: Math.ceil(168 * Theme.heightScale)
			property int buttonTopMargin: Math.ceil(25 * Theme.heightScale)

			Image { id: logo
				source: "image://game/ui/images/logo-new.png"

				width: parent.width
				height: root.logoDimension

				fillMode: Image.PreserveAspectFit
				horizontalAlignment: Image.AlignLeft

				anchors.left: parent.left
				anchors.leftMargin: childMargin
				anchors.verticalCenter: parent.verticalCenter
				anchors.verticalCenterOffset: logoVerticalCenterOffset
			}

			CTAButton {
				objectName: "ui:btn:action[apply]"
				anchors.left: parent.left
				anchors.leftMargin: childMargin
				anchors.topMargin: root.buttonTopMargin
				anchors.top: logo.bottom
				text: L10n.strings.buttons.startGame
				onClicked: index.routeRequest(Routes.newgame.name)
			}
		}
	}

	Component { id: indexContinue
		Item { id: root
			property int logoDimension: Math.ceil(69 * Theme.heightScale)
			property int childTopMargin: Math.ceil(40 * Theme.heightScale)

			Image { id: logo
				source: "image://game/ui/images/logo.png"

				width: parent.width
				height: root.logoDimension

				fillMode: Image.PreserveAspectFit
				horizontalAlignment: Image.AlignLeft

				anchors.left: parent.left
				anchors.leftMargin: childMargin
				anchors.verticalCenter: parent.verticalCenter
				anchors.verticalCenterOffset: logoVerticalCenterOffset
			}

			Item { id: continueGame
				visible: lastSave && !isInGame
				anchors.top: logo.bottom
				anchors.topMargin: root.childTopMargin
				anchors.left: parent.left
				anchors.leftMargin: childMargin

				property int saveTypeFontSize: Math.ceil(13 * Theme.heightScale)
				property int dateTextFontSize: Math.ceil(20 * Theme.heightScale)
				property int buttonTopMargin: Math.ceil(10 * Theme.heightScale)

				Item {
					Text { id: saveTypeText
						text: {
							var labels = L10n.strings.labels;

							switch (lastSave.type) {
							case 'auto': return labels.autoSave;
							case 'quick': return labels.quickSave;
							case 'manual': return labels.manualSave;
							}
						}
						font.pixelSize: continueGame.saveTypeFontSize
						font.capitalization: Font.AllUppercase
						font.family: Theme.fonts.light
						color: Theme.colors.buttonText
					}

					Text { id: gameNameText
						anchors.top: saveTypeText.bottom
						anchors.topMargin: -5
						text: lastSave.chapterName
						font.capitalization: Font.Capitalize
						font.pixelSize: index.gameNameFontSize
						font.family: Theme.fonts.regular
						font.letterSpacing: 5
						color: Theme.colors.buttonText
					}

					Text { id: dateText
						anchors.top: gameNameText.bottom
						anchors.topMargin: -2
						text: Theme.getDateTimeString(lastSave.dateCreated)
						font.pixelSize: continueGame.dateTextFontSize
						font.family: Theme.fonts.light
						color: Theme.colors.buttonText
					}

					CTAButton {
						objectName: "ui:btn:action[apply]"
						anchors.topMargin: continueGame.buttonTopMargin
						anchors.top: dateText.bottom
						text: L10n.strings.buttons.resume
						onClicked: index.loadGameRequest(lastSave)
					}
				}
			}
		}
	}
}
