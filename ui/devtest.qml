import QtQuick 2.9

import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2

import QtGraphicalEffects 1.0

import CrowbarCollective 1.0

FocusScope {
    id: rootItem

    width: 1600
    height: 900

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
            console.log(JSON.stringify(listSaveEntries, null, "\t"))

            listSaveEntriesGrid.model = listSaveEntries

            d.queryHandle = BlackMesaEngine.requestInternetServerList()

            console.log(JSON.stringify(BlackMesaEngine.listAchievementEntries(), null, 2))
        }
    }

    Connections {
        target: BlackMesaEngine
        onMatchmakingServerResponded: {

            // 730 - CS:GO, since Black Mesa Server List is empty right now
            // 362890 - Black Mesa


            /* Server Entry Example, lastPlayed is valid only for Favorites/History
            {
                "botsOnServerCurrently": 1,
                "connectionAddressString": "193.104.68.59:27032",
                "gameDescription": "Counter-Strike: Global Offensive",
                "gameDirectory": "csgo",
                "isPasswordProtected": true,
                "isSecure": true,
                "lastPlayed": "1970-01-01T00:00:00.000Z",
                "map": "de_dust2",
                "name": "KPMG CS GO",
                "ping": 63,
                "playersOnServerCurrently": 1,
                "playersOnServerMaximum": 12,
                "steamApplicationId": 730
            }
            */
            console.log(queryHandle, serverEntry.steamApplicationId,
                        BlackMesaEngine.getSteamApplicationId())

            // if (serverEntry.steamApplicationId === 362890 && serverEntry.gameDirectory === "bms") {
            // if (serverEntry.steamApplicationId === 730 && serverEntry.gameDirectory === "csgo") {
            if (serverEntry.steamApplicationId === BlackMesaEngine.getSteamApplicationId() && serverEntry.gameDirectory === "bms") {
                console.log(JSON.stringify(serverEntry, null, 2))
                serverEntriesList.model.append(serverEntry)
            }
        }
    }

    Rectangle {
        anchors.fill: parent

        color: "grey"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 5

            GridView {
                id: listSaveEntriesGrid

                clip: true

                Layout.fillWidth: true
                Layout.fillHeight: true

                cellWidth: 160
                cellHeight: 90

                header: Text {
                    width: parent.width
                    height: 40

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    font.pixelSize: 20
                    color: "white"

                    text: "Save Entries"

                    Rectangle {
                        anchors.fill: parent

                        border.color: "black"
                        border.width: 1

                        color: "transparent"
                    }
                }

                delegate: Item {
                    width: GridView.view.cellWidth
                    height: GridView.view.cellHeight

                    Image {
                        anchors.fill: parent
                        anchors.margins: 5

                        source: modelData.thumbnailUrl

                        MouseArea {
                            anchors.fill: parent
                            preventStealing: true

                            acceptedButtons: Qt.RightButton

                            onClicked: {
                                BlackMesaEngine.removeSaveEntry(modelData.name)
                                listSaveEntriesGrid.model = BlackMesaEngine.listSaveEntries()
                            }
                        }
                    }
                }

                Rectangle {
                    anchors.fill: parent

                    border.color: "black"
                    border.width: 1

                    color: "transparent"
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Button {
                    Layout.fillWidth: true

                    text: "friends"
                    onClicked: BlackMesaEngine.activateSteamOverlay("friends")
                }

                Button {
                    Layout.fillWidth: true

                    text: "community"
                    onClicked: BlackMesaEngine.activateSteamOverlay("community")
                }

                Button {
                    Layout.fillWidth: true

                    text: "players"
                    onClicked: BlackMesaEngine.activateSteamOverlay("players")
                }

                Button {
                    Layout.fillWidth: true

                    text: "settings"
                    onClicked: BlackMesaEngine.activateSteamOverlay("settings")
                }

                Button {
                    Layout.fillWidth: true

                    text: "officialgamegroup"
                    onClicked: BlackMesaEngine.activateSteamOverlay("officialgamegroup")
                }

                Button {
                    Layout.fillWidth: true

                    text: "stats"
                    onClicked: BlackMesaEngine.activateSteamOverlay("stats")
                }

                Button {
                    Layout.fillWidth: true

                    text: "achievements"
                    onClicked: BlackMesaEngine.activateSteamOverlay("achievements")
                }

                Button {
                    Layout.fillWidth: true

                    text: "web - workshop"
                    onClicked: BlackMesaEngine.activateSteamOverlayToWebPage("https://steamcommunity.com/app/362890/workshop")
                }

                Button {
                    Layout.fillWidth: true

                    text: "matchmaking cancel query"
                    onClicked: BlackMesaEngine.matchmakingCancelQuery(d.queryHandle)
                }

                Rectangle {
                    anchors.fill: parent

                    border.color: "black"
                    border.width: 1

                    color: "transparent"
                }
            }

            ListView {
                id: serverEntriesList

                clip: true

                Layout.fillWidth: true
                Layout.fillHeight: true

                model: ListModel {}

                header: Text {
                    width: parent.width
                    height: 40

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    font.pixelSize: 20
                    color: "white"

                    text: "Server Entries"

                    Rectangle {
                        anchors.fill: parent

                        border.color: "black"
                        border.width: 1

                        color: "transparent"
                    }
                }

                delegate: RowLayout {
                    width: parent.width
                    height: 20

                    Text {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter

                        font.pixelSize: 12
                        color: "white"

                        text: model.name
                    }

                    Text {
                        Layout.preferredWidth: 200
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        font.pixelSize: 12
                        color: "white"

                        text: model.connectionAddressString
                    }

                    Text {
                        Layout.preferredWidth: 100
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter

                        font.pixelSize: 12
                        color: "white"

                        text: model.ping
                    }

                    Text {
                        Layout.preferredWidth: 100
                        Layout.fillHeight: true

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        font.pixelSize: 12
                        color: "white"

                        text: "%1(%3)/%2".arg(
                                  model.playersOnServerCurrently).arg(
                                  model.playersOnServerMaximum).arg(
                                  model.botsOnServerCurrently)
                    }
                }

                Rectangle {
                    anchors.fill: parent

                    border.color: "black"
                    border.width: 1

                    color: "transparent"
                }
            }
        }
    }
}
