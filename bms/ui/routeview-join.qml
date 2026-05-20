import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import CrowbarCollective 1.0

RouteView {
    property int total
    property int cellH: Math.ceil(200  * Theme.heightScale)
    property int serverDescriptionMainTextSize: Math.ceil(32 * Theme.heightScale)

	// 0 -> before search
	// 1 -> searching LAN servers
	// 2 -> searching Internet servers
    property int stepServerList: 0

    property string searchTextState: BlackMesaEngine.getLocalizedString("#BlackMesaUI_Multiplayer_SearchingServersLocal")
    property variant fastpathServerName: /(fastpath)/ig

	QtObject {
		id: d
		property string queryHandle
	}

	Timer {
		id: deferredCompletedTimer
		interval: 1250
		repeat: false
		triggeredOnStart: false
		running: true
		onTriggered: {
			var listSaveEntries = BlackMesaEngine.listSaveEntries()
			// first : search LAN servers ...
			d.queryHandle = BlackMesaEngine.requestLANServerList()
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

				if ( stepServerList === 1 ) { // if currently searching LAN
					serverEntry.lan = 1; // set entry as LAN
				}
				else { 
					serverEntry.lan = 0; // set entry as Internet
				}

                if (serverEntry.name.search(fastpathServerName) == -1 && serverEntry.gameDescription.search(fastpathServerName) == -1) {
                    serverList.append(serverEntry) // add entry in server list
                }
			}
		}

		// when server listing is finished
		onMatchmakingQueryCompleted: {
			if ( stepServerList === 1 ) { // if currently searching LAN servers
				// switch to Internet searching ...
                searchTextState = BlackMesaEngine.getLocalizedString("#BlackMesaUI_Multiplayer_SearchingServersInternet")
				d.queryHandle = BlackMesaEngine.requestInternetServerList()
				stepServerList = 2;
			}
			else if ( stepServerList === 2 ) { // if currently searching Internet servers

				// write final results
				if ( serverList.count === 0 ) {
                    searchTextState = BlackMesaEngine.getLocalizedString("#BlackMesaUI_Multiplayer_NoServersFound")
				}
				else {
                    searchTextState = BlackMesaEngine.getLocalizedString("#BlackMesaUI_Multiplayer_ServersFoundCount").arg(serverList.count)
				}

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
                visible: stepServerList !== 2
                source: "image://game/ui/images/Rolling-1s-200px.png"

                RotationAnimation on rotation {
                    loops: Animation.Infinite
                    from: 0
                    to: 360
                    duration: 500
                }
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

                    property var callback: function() {
                        BlackMesaEngine.executeClientCommandUnrestricted("disconnect; connect " + connectionAddressString);
                    };

                    states: [
                        State {
                            name: "blurred"
                            when: !activeFocus
                            PropertyChanges { target: background; border.width: 0; color: "#40000000" }
                            PropertyChanges { target: image; border.width: 1 }
                            PropertyChanges { target: serverPing; color: Theme.colors.headerText }
                        },
                        State {
                            name: "focused"
                            when: activeFocus
                            PropertyChanges { target: background; border.width: 2; color: "#40000000" }
                            PropertyChanges { target: image; border.width: 1 }
                            PropertyChanges { target: serverPing; color: Theme.colors.headerText }
                        }
                    ]
                    onEntered: {
                        state = "focused"
                        Sound.playEffect(Theme.sounds.buttonFocused);
                    }
                    onExited: {
                        state = "blurred"
                    }
                    onDoubleClicked: {
                        BlackMesaEngine.executeClientCommandUnrestricted("disconnect; connect " + connectionAddressString);
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
                                    source: "image://game/materials/vgui/multiplayer/map_backgrounds/"+map+"_0_widescreen_16_10.vtf"
                                    height: image.height - 32
                                    width: image.width
                                    fillMode: Image.Stretch
                                    anchors.top: image.top
                                    asynchronous: true;
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

                                // displaying if server is LAN or Internet
                                Text {
                                    id: serverNetworkType
                                    anchors.bottomMargin: 16
                                    anchors.bottom : parent.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    text: lan == 1 ? BlackMesaEngine.getLocalizedString("#BlackMesaUI_Multiplayer_ServerTypeLocal") : BlackMesaEngine.getLocalizedString("#BlackMesaUI_Multiplayer_ServerTypeInternet")
                                    font.pixelSize: serverDescriptionMainTextSize * 0.5
                                    font.family: Theme.fonts.bold
                                    color: Theme.colors.highlight
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
                            }
                        }
                    }
                    // Server list item end
                }

            }
        }
    }
}
