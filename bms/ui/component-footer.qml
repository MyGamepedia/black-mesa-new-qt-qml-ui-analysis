import QtQuick 2.9
import CrowbarCollective 1.0

Item { id: footer
    signal routeRequest(string routeName)

    property Route currentRoute
    property bool isLoading: false
    property bool showLoadingProgress: true
    property string levelName: ""
    property bool isInGame: false
    property real loadPercent: 0

    property int footerHeight: Math.ceil(72 * Theme.heightScale)
    property int footerMargin: Math.ceil(32 * Theme.widthScale)
    property int compassIconDimension: Math.ceil(40 * Theme.heightScale)
    property int discordLinkWidth: Math.ceil(180 * Theme.widthScale)
	property int discordLinkHeight: Math.ceil(40 * Theme.heightScale)

    property int progressBarHeight: Math.ceil(16 * Theme.heightScale)
    property int progressBarWidth: Math.ceil(1000 * Theme.widthScale)
    property int loadingLabelFontSize: Math.ceil(40 * Theme.widthScale)
    property int levelNameFontSize: Math.ceil(68 * Theme.widthScale)
    property int levelNameMarginBottom: Math.ceil(24 * Theme.heightScale)
    property int loadingQuoteFontSize: Math.ceil(24 * Theme.heightScale)

    // don't show the back button if we're on the empty route or the index route.
    // all other routes can be popped
    property bool _showBackButton: currentRoute.name !== Routes.index.name && currentRoute.name !== Routes.empty.name

    // only show the back to game button if we are in-game at at the index route or empty route
    property bool _showBackToGameButton: isInGame && (currentRoute.name === Routes.index.name || currentRoute.name === Routes.empty.name)

    width: parent.width
    height: footerHeight

    anchors.bottom: parent.bottom

    Rectangle { id: letterboxBackground
        anchors.fill: parent
        color: Theme.colors.subNavBackground
        opacity: Theme.opacity.subNav
    }

    Component { id: menuFooter
        Item {
            anchors.fill: parent

            Row {
                anchors.fill: parent
                spacing: 0

                anchors.leftMargin: footerMargin
                anchors.rightMargin: footerMargin

                Item { id: iconDpad
                    width: footer.height
                    height: footer.height
                    anchors.verticalCenter: parent.verticalCenter

                    Image {
                        source: "image://game/ui/images/compass.png"
                        asynchronous: true

                        height: compassIconDimension
                        width: compassIconDimension

                        fillMode: Image.Stretch
                        anchors.centerIn: parent
                    }
                }

                LetterboxButton {
                    id: id_btn_quit
                    objectName: "ui:btn:action[quit]"
                    text: L10n.strings.buttons.quit
                    height: footer.height
                    anchors.left: iconDpad.right
                    anchors.verticalCenter: parent.verticalCenter

                    selected: currentRoute.name === Routes.quit.name
                    onClicked: {
                        if ( isInGame ) {
                            footer.routeRequest(Routes.savebeforequit.name)
                        } else {
                            footer.routeRequest(Routes.quit.name)
                        }
                    }
                }

                LetterboxButton {
                    id: id_btn_back
                    objectName: "ui:btn:action[back]"
                    visible: _showBackButton || _showBackToGameButton
                    text: _showBackButton ? L10n.strings.buttons.back : L10n.strings.buttons.backToGame
                    height: footer.height
                    anchors.left: id_btn_quit.right
                    anchors.verticalCenter: parent.verticalCenter

                    onClicked: {
                        if (_showBackButton) {
                            footer.routeRequest(Routes.back.name);
                        } else {
                            BlackMesaEngine.executeClientCommand('gameui_hide');
                        }
                    }
                }

                MenuNavGuide {
                    id: menuNavGuide

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: discordLinkItem.left
                }

                // Discord group link
                Item {
                    id: discordLinkItem
                    width: discordLinkWidth
                    height: discordLinkHeight

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right

                    MouseArea {
                        id: discordLinkArea
                        hoverEnabled: true
                        anchors.fill: parent
                        onEntered: function() {
                            Sound.playEffect(Theme.sounds.buttonFocused);
                        }
                        onClicked: function() {
                            // Click sound before open discord link
                            Sound.playEffect(Theme.sounds.buttonClicked);
                            BlackMesaUtils.setTimeout(function() {
                                // Open discord link here
                                Qt.openUrlExternally(BlackMesaUtils.discordLink)
                            }, 500);
                        }
                    }

                    Image {
                        source: discordLinkArea.containsMouse ? "image://game/ui/images/discord-purple.png" : "image://game/ui/images/discord-white.png"
                        asynchronous: true

                        height: discordLinkHeight
                        width: discordLinkWidth

                        mipmap: false
                        smooth: true

                        fillMode: Image.PreserveAspectFit

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }

    // no animations in loading footer. the engine uses too many resources
    // and animations become jittery or are passed over all together
    Component { id: loadingFooter
        Item {           
            Timer {
                property int quoteIndex: -1
                property variant quotes: (function () {
                    return Object.keys(L10n.strings.loading.quotes).map(function (key) {
                        return L10n.strings.loading.quotes[key];
                    });
                }())

                triggeredOnStart: true
                interval: 5000
                repeat: true
                running: showLoadingProgress
                onTriggered: {
                    // TODO: infinite loop if quotes.length === 1
                    var newIndex = quoteIndex;
                    while (newIndex === quoteIndex) {
                        newIndex = Math.floor(Math.random() * quotes.length)
                    }

                    loadingQuoteText.text = quotes[newIndex];
                    quoteIndex = newIndex;
                }
            }

            anchors.fill: parent

            Text { id: loadingQuoteText
                visible: showLoadingProgress
                anchors.left: parent.left
                anchors.leftMargin: footerMargin
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.colors.buttonText
                font.family: Theme.fonts.light
                font.pixelSize: loadingQuoteFontSize
            }

            Text {
                visible: !showLoadingProgress
                text: L10n.strings.loading.loadingLevel

                font.capitalization: Font.AllUppercase
                font.pixelSize: loadingLabelFontSize
                font.family: Theme.fonts.bold
                color: Theme.colors.highlight
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: footerMargin
            }

            Item { id: progressBar
                visible: showLoadingProgress
                width: progressBarWidth
                height: progressBarHeight
                anchors.bottom: parent.top
                anchors.right: parent.right

                Rectangle {
                    anchors.fill: parent
                    color: Theme.colors.dimmedText
                }

                Rectangle {
                    width: progressBar.width * loadPercent
                    height: parent.height
                    color: Theme.colors.highlight
                }
            }

            Text {
                visible: showLoadingProgress
                font.family: Theme.fonts.regular
                anchors.left: progressBar.left
                anchors.bottom: progressBar.top
                anchors.bottomMargin: levelNameMarginBottom
                color: Theme.colors.buttonText
                font.pixelSize: levelNameFontSize
                text: levelName
            }
        }
    }

    Loader {
        anchors.fill: parent
        sourceComponent: isLoading ? loadingFooter : menuFooter
    }
}
