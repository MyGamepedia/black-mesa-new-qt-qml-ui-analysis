import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import CrowbarCollective 1.0

RouteView {
    property int total
    property int cellH: Math.ceil(200  * Theme.heightScale)
    property int serverDescriptionMainTextSize: Math.ceil(32 * Theme.heightScale)
    property int fieldWidth: Math.ceil(640 * Theme.heightScale)

	// 0 -> before search
	// 1 -> searching LAN servers
	// 2 -> searching Internet servers
    property int stepServerList: 0

    property int serversInternet: 0
    property int serversLAN: 0

    property string searchTextState: BlackMesaEngine.getLocalizedString("#BlackMesaUI_Multiplayer_SearchingServersInternet")
    property string passwordServerIP: ""
    property variant fastpathServerName: /(fastpath)/ig

	function onRouteWillChange(newRouteName) {
		cancelSearch();
		unfocusPass();
		passwordField.visible = false;
	}

	function cancelSearch() {
		BlackMesaEngine.matchmakingCancelQuery(d.queryHandle)
		BlackMesaEngine.matchmakingCancelQuery(d.queryHandle)
	}

	function focusPass() {
		passwordField.visible = true;
		passwordField.focus = true;
	}

	function unfocusPass() {
		passwordField.visible = false;
		passwordField.focus = false;
	}

	function doTheConnectThing(ip, pass) {
		if (pass) {
			passwordServerIP = ip;
			passwordAlert.show();
			focusPass();
		}
		else {
			BlackMesaEngine.executeClientCommandUnrestricted("disconnect; connect " + ip);
		}
	}

	QtObject {
		id: d
		property string queryHandle
	}

	Timer {
		id: deferredCompletedTimer
		interval: 0
		repeat: false
		triggeredOnStart: false
		running: true
		onTriggered: {
			//var listSaveEntries = BlackMesaEngine.listSaveEntries()
			// first : search Internet servers ...
			d.queryHandle = BlackMesaEngine.requestInternetServerList()
			stepServerList = 1;
			/*
			// example to append 1 fake entry. Keep it for debugging.
			serverList.append(
			{
				"botsOnServerCurrently": 1,
				"connectionAddressString": "193.104.68.59:27032",
				"gameDescription": "Counter-Strike: Global Offensive",
				"gameDirectory": "csgo",
				"isPasswordProtected": true,
				"isSecure": true,
				"lastPlayed": "1970-01-01T00:00:00.000Z",
				"map": "dm_gasworks",
				"name": "KPMG CS GO",
				"ping": 63,
				"playersOnServerCurrently": 1,
				"playersOnServerMaximum": 12,
				"steamApplicationId": 730
			})
			*/
		}
	}


	Connections {
		target: BlackMesaEngine
		onMatchmakingServerResponded: {

			if ( serverEntry.steamApplicationId === BlackMesaEngine.getSteamApplicationId() && serverEntry.gameDirectory === "bms" ) {
				// console.log(JSON.stringify(serverEntry.connectionAddressString))

				if ( stepServerList === 1 ) { // if currently searching Internet
					serverEntry.lan = 0; // set entry as Internet
				}
				else { 
					serverEntry.lan = 1; // set entry as LAN
				}

                if (serverEntry.name.search(fastpathServerName) == -1 && serverEntry.gameDescription.search(fastpathServerName) == -1) {
                    serverList.append(serverEntry) // add entry in server list
                }
			}
		}

		// when server listing is finished
		onMatchmakingQueryCompleted: {
			if ( stepServerList === 1 ) { // if currently searching Internet servers
				// get number of Internet servers found
				serversInternet = serverList.count
				// switch to LAN searching ...
				searchTextState = BlackMesaEngine.getLocalizedString("#BlackMesaUI_Multiplayer_SearchingServersLocal")
				d.queryHandle = BlackMesaEngine.requestLANServerList()
				stepServerList = 2;
			}
			else if ( stepServerList === 2 ) { // if currently searching Lan servers

				// find number of LAN servers
				serversLAN = serverList.count - serversInternet
				// write final results
				if ( serverList.count === 0 ) {
					searchTextState = BlackMesaEngine.getLocalizedString("#BlackMesaUI_Multiplayer_NoServersFound")
				}
				else {
					searchTextState = BlackMesaEngine.getLocalizedString("#BlackMesaUI_Multiplayer_ServersFoundCount").arg(serversLAN + "/" + serversInternet)
				}

				stepServerList = 3;
				BlackMesaUtils.clearUIElementsData();
				BlackMesaUtils.traverseUIElements(appRoot);
				BlackMesaUtils.afterTraverseCallback();
			}
		}
	}

    GridLayout {
        anchors.fill: parent
        width: parent.width
        height: parent.height

        rows: 2
        rowSpacing: 8
        columns: 1
        columnSpacing: 0

        anchors.margins: 16

        // Server list loader info
        Item {
            Layout.preferredHeight: 40*Theme.heightScale
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignVCenter

            Text {
                id: serverSearchingState
                text: searchTextState
                font.pixelSize: serverDescriptionMainTextSize*0.6
                font.family: Theme.fonts.bold
                color: Theme.colors.headerText
                anchors.verticalCenter: parent.verticalCenter
            }

            Image {
                anchors.left: serverSearchingState.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 16
                width: 32*Theme.heightScale
                height: 32*Theme.heightScale
                visible: stepServerList !== 3
                source: "image://game/ui/images/Rolling-1s-200px.png"

                RotationAnimation on rotation {
                    loops: Animation.Infinite
                    from: 0
                    to: 360
                    duration: 500
                }
            }

            CTAButton { id: refreshButton
                objectName: "ui:btn:action[discard]"
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: stepServerList === 3 ? BlackMesaEngine.getLocalizedString("#QTUI_Menu_Multiplayer_Refresh") : BlackMesaEngine.getLocalizedString("#QTUI_Buttons_Cancel")
                onClicked: stepServerList === 3 ? router.setRoute(router.currentRoute.name.toString(), false, true) : cancelSearch()
            }
        }

        // Server list view
        Rectangle {
            id: serverListContainer
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width

            border.width: 2*Theme.widthScale
            border.color: 'white'
            color: "#10000000"

            GridView {
                id: grid
                clip: true
                cacheBuffer: 8000;
                anchors.fill: parent

                anchors.topMargin: 8
                anchors.bottomMargin: 8
                anchors.leftMargin: 8
                anchors.rightMargin: 8

                width: parent.width
                height: parent.height

                cellWidth: parent.width
                cellHeight: cellH

                interactive: true
                boundsBehavior: Flickable.StopAtBounds

                ScrollBar.vertical: VerticalScrollBar {
                    visible: true
                }

                model: ListModel { id: serverList }

                // Server list
                delegate: MouseArea {
                    objectName: "ui:option-item"
                    readonly property string type: "join"

                    width: parent.width - 16
                    height: cellH - 4

                    state: 'blurred'
                    hoverEnabled: true
/*
                    property var callback: function() {
                        BlackMesaEngine.executeClientCommandUnrestricted("disconnect; connect " + connectionAddressString);
                    };
*/
                    states: [
                        State {
                            name: "blurred"
                            when: !activeFocus
                            PropertyChanges { target: background; border.width: 0; color: "#40000000" }
                            PropertyChanges { target: image; border.width: 1 }
                            PropertyChanges { target: serverPing; color: Theme.colors.headerText }
                            PropertyChanges { target: serverAdressText; visible: false }
                        },
                        State {
                            name: "focused"
                            when: activeFocus
                            PropertyChanges { target: background; border.width: 2; color: "#40000000" }
                            PropertyChanges { target: image; border.width: 1 }
                            PropertyChanges { target: serverPing; color: Theme.colors.headerText }
                            PropertyChanges { target: serverAdressText; visible: true }
                        }
                    ]
                    onEntered: {
                        state = "focused"
                        Sound.playEffect(Theme.sounds.buttonFocused);
                    }
                    onExited: {
                        state = "blurred"
                    }
                    onClicked: {
                        BlackMesaEngine.printConsoleMessage(Theme.devConsole.colors.message, "Server IP: " + connectionAddressString);
                    }
                    onDoubleClicked: {
                        if (state === "focused") doTheConnectThing(connectionAddressString, isPasswordProtected);
                    }

                    // Server list item start
                    Rectangle {
                        id: background
                        anchors.fill: parent
                        border.color: Theme.colors.highlight

                        GridLayout {
                            anchors.fill: parent
                            anchors.margins: 2
                            width: parent.width - 4
                            height: parent.height - 4

                            rows: 0
                            rowSpacing: 0
                            columnSpacing: 8

                            // Map thumbnail & map name
                            Rectangle {
                                id: image
                                Layout.preferredWidth: cellH
                                Layout.fillHeight: true
                                color: '#111111'

                                Image {
                                    id: serverThumbnailImage
                                    source: "image://game/materials/vgui/multiplayer/map_backgrounds/"+map+"_0.vtf"
                                    height: image.height - 32
                                    width: image.width
                                    fillMode: Image.Stretch
                                    anchors.top: image.top
                                    asynchronous: true;
                                }

                                Image {
                                    id: serverLockedImage
                                    source: "image://game/ui/images/lock.png"
                                    height: image.height / 3
                                    width: image.width / 4
                                    //fillMode: Image.Stretch
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    visible: isPasswordProtected
                                }

                                // write map name over map thumbnail.
                                Text { id: mapNameOnThumbnail
                                    anchors.top: serverThumbnailImage.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.topMargin: 8
                                    text:  ( map.indexOf("dm_") === 0 ) ? map.substring(3) : map   // remove  dm_*
                                    font.pixelSize: 14
                                    font.family: Theme.fonts.bold
                                    color: Theme.colors.headerText
                                }
                            }

                            // Players count info
                            Item {
                                Layout.fillHeight: true
                                Layout.preferredWidth: 96

                                GridLayout {
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    rows: 0
                                    rowSpacing: 0
                                    columns: 3
                                    columnSpacing: 4

                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: playersOnServerCurrently >= 10 ? playersOnServerCurrently.toString() : "  " + playersOnServerCurrently.toString()
                                        font.pixelSize: serverDescriptionMainTextSize
                                        font.family: Theme.fonts.bold
                                        color: Theme.colors.headerText
                                    }
                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: "/"
                                        font.pixelSize: serverDescriptionMainTextSize
                                        font.family: Theme.fonts.bold
                                        color: Theme.colors.highlight
                                    }
                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: playersOnServerMaximum.toString()
                                        font.pixelSize: serverDescriptionMainTextSize
                                        font.family: Theme.fonts.bold
                                        color: Theme.colors.highlight
                                    }
                                }

                                // displaying number of bots
                                GridLayout {
                                    anchors.bottomMargin: 36
                                    anchors.bottom : parent.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    rows: 0
                                    rowSpacing: 0
                                    columns: 3
                                    columnSpacing: 4
                                    visible: botsOnServerCurrently >= 1

                                    Text {
                                        text: botsOnServerCurrently >= 10 ? botsOnServerCurrently.toString() : "  " + botsOnServerCurrently.toString()
                                        font.pixelSize: serverDescriptionMainTextSize * 0.75
                                        font.family: Theme.fonts.bold
                                        color: Theme.colors.headerText
                                    }
                                    Text {
                                        text: " " + BlackMesaEngine.getLocalizedString("#BlackMesaUI_Multiplayer_ServerBots")
                                        font.pixelSize: serverDescriptionMainTextSize * 0.75
                                        font.family: Theme.fonts.bold
                                        color: Theme.colors.highlight
                                    }
                                }

                                // displaying if server is LAN or Internet
                                Text {
                                    id: serverNetworkType
                                    //anchors.bottomMargin: 16
                                    anchors.bottom : parent.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    text: lan == 1 ? BlackMesaEngine.getLocalizedString("#BlackMesaUI_Multiplayer_ServerTypeLocal") : BlackMesaEngine.getLocalizedString("#BlackMesaUI_Multiplayer_ServerTypeInternet")
                                    font.pixelSize: serverDescriptionMainTextSize * 0.5
                                    font.family: Theme.fonts.bold
                                    color: Theme.colors.highlight
                                }

                                // server game description
                                Text {
                                    id: serverDescText
                                    //anchors.bottomMargin: 16
                                    anchors.bottom : parent.bottom
                                    anchors.left: serverNetworkType.right
                                    anchors.leftMargin: 24

                                    text: gameDescription
                                    font.pixelSize: serverDescriptionMainTextSize * 0.5
                                    font.family: Theme.fonts.bold
                                    color: Theme.colors.headerText
                                }

                                // server adress
                                Text {
									visible: false
                                    id: serverAdressText
                                    //anchors.bottomMargin: 16
                                    anchors.bottom : parent.bottom
                                    anchors.left: serverDescText.right
                                    anchors.leftMargin: 24

                                    text: connectionAddressString
                                    font.pixelSize: serverDescriptionMainTextSize * 0.5
                                    font.family: Theme.fonts.bold
                                    color: Theme.colors.headerText
                                }
                            }

                            // Server name
                            Item {
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                Text {
                                    id: serverName
                                    width: parent.width
                                    anchors.verticalCenter: parent.verticalCenter

                                    text: name.trim();
                                    font.pixelSize: serverDescriptionMainTextSize
                                    font.family: Theme.fonts.bold
                                    color: Theme.colors.headerText
                                    elide: Text.ElideRight
                                }
                            }

                            // Ping
                            Item {
                                Layout.preferredWidth: 64
                                Layout.fillHeight: true

                                Text {
                                    id: serverPing
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    text: ping
                                    font.family: Theme.fonts.regular
                                    wrapMode: Text.WordWrap
                                    font.pixelSize: serverDescriptionMainTextSize
                                    color: Theme.colors.headerText
                                }
                                Image {
                                    id: secureTypeImage
                                    source: "image://game/ui/images/vac.png"
                                    height: image.height / 5
                                    width: image.width / 6
                                    anchors.topMargin: 16
                                    anchors.top : parent.top
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: isSecure
                                }
                            }
                        }
                    }
                    // Server list item end
                }

            }
        }
    }

    Alert { id: passwordAlert
        titleText: BlackMesaEngine.getLocalizedString("#GameUI_PasswordPrompt")

            TextField { id: passwordField
                width: fieldWidth
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Rectangle { id: background
                    anchors.fill: parent
                    color: '#111111'
                    opacity: 0.35
                }

                background: Item {
                    anchors.fill: parent
                }

                color: Theme.colors.headerText

                selectionColor: Theme.devConsole.colors.inputText
                selectedTextColor: Theme.devConsole.colors.background

                font.family: Theme.fonts.devConsole
                font.pixelSize: Math.ceil(16 * Theme.heightScale)

                selectByMouse: true

                placeholderText: BlackMesaEngine.getLocalizedString("#Valve_Server_Password")
            }

        buttons: VisualItemModel {
            CTAButton {
                objectName: "ui:btn:action[apply]"
                text: L10n.strings.buttons.confirm
                onClicked: {
                    unfocusPass();
                    passwordAlert.hide();
                    if (passwordField.text) {
                        BlackMesaEngine.executeClientCommandUnrestricted("disconnect; connect " + passwordServerIP + ";password " + passwordField.text);
                    }
                    else {
                        BlackMesaEngine.executeClientCommandUnrestricted("disconnect; connect " + ip);
                    }
                }
            }

            WarningButton {
                objectName: "ui:btn:action[cancel]"
                text: L10n.strings.buttons.cancel
                onClicked: {
                    unfocusPass();
                    passwordAlert.hide();
                }
            }
        }
    }
}
