import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

// PRIORITY
// TODO: HUD Post Processing doesn't work (unknown command)

// TODO: qt triggered saves have qt ui visible. see about delaying save command until after ui disappears
// TODO: Add alert confirmation/save prompt whenever you're trying to load a game/map while ingame
// TODO: Quit/Save confirmation modal on in-game quit
// TODO: Keyboard Icons (RIGHTARROW becomes a right arrow key icon)

// SAVE GAME
// TODO: Add delete save button to each carousel item on Save screen

// MULTIPLAYER
// TODO: Define multiplayer server list data bridge
// TODO: Handle level load failures
// TODO: Multiplayer->Join
// TODO: Multiplayer->Refresh
// TODO: Multiplayer->Host

// ACHIEVEMENTS
// TODO: Achievements

// STEAM WORKSHOP
// TODO: Steam Workshop->Campaigns
// TODO: Steam Workshop->Add-ons
// TODO: Steam Workshop->Browse

// EXTERNAL
// TODO: Complete Wallpaper _maps/_files lookups or defer to engine fix

// POLISH
// TODO: Carousel Items flicker on pagination due to async image loading (probably just an animation/transition property bug)
// TODO: Keyboard/Controller Navigation
// TODO: CarouselItems don't go into hover state if the mouse is already over them after the route transition finishes
// TODO: CarouselItems should stay in hover/focused state while the alert modal is visible
// TODO: Why does the footer background have a seizure when navigating to/from quit over a subnav and changing focus (skrim opacity glitch?)
// TODO: Select input selectedText transitions on selection change
// TODO: Wallpaper effects (graph) animation
// TODO: Address all TODOs
// TOOD: Hook up correct locale based on... what?
// TODO: musicloadingtimer can trigger after you've already started using the ui [only effects -dev mode]
FocusScope { id: appRoot
    Binding {
        target: Theme
        property: "widthScale"
        value: appRoot.width / 1920.0
    }

    Binding {
        target: Theme
        property: "heightScale"
        value: appRoot.height / 1080.0
    }

    onWidthChanged: {
        Theme.rootWidth = appRoot.width;
        wallpaper.updateBackgroundImage();
    }

    onHeightChanged: {
        Theme.rootHeight = appRoot.height;
        wallpaper.updateBackgroundImage();
    }

    layer.enabled: true
    focus: true

    visible: opacity > 0.000244140625
    onVisibleChanged: BlackMesaEngine.setRootPanelVisibility(visible)

    Behavior on opacity {
        enabled: !didLoadLevel // do not animate appRoot opacity if opacity is changing due to a level load
        NumberAnimation { target: appRoot; property: "opacity"; duration: 625  }
    }

    readonly property Route emptyRoute: Routes.empty
    readonly property Route mainMenuIndexRoute: Routes.index

    // is the engine is currently loading a level
    property bool isLoadingLevel: false

    // hack bool used so onGameUIHidden can tell if the UI is being hidden because a level finished loading
    // or because the user hit "Esc" to close the menu. onGameUIHidden gives Qml no context as to why the UI
    // is hiding. If it is hiding because a level loaded, we don't want it to animate out. If it is hiding
    // because the user is "Esc"ing out of it, we want to animate it out.
    property bool didLoadLevel: false

    // can't trust the BlackMesaEngine.isInGame() response, because it considers the main menu level
    // to be "in game". make our own based on what we know of the Qml state and the engine events
    property bool isInGame: false

    // this bool tells us whether or not a loading event is the loading event for the
    // main menu map, or if this is a load event for a legitimate game/multiplayer session
    property bool _isInitialLoad: true

    // how much of the level has been loaded. used by footer.
    property real loadPercent: 0.0

    Wallpaper { id: wallpaper
        anchors.fill: parent
        showSkrim: isInGame || router.currentRoute !== Routes.index
        darkenSkrim: isInGame
        suppressAnimations: isLoadingLevel
    }

    MouseArea { id: bubbleCapture
        anchors.fill: parent
        enabled: InputBindingsManager.isSelected

        onClicked: {
            InputBindingsManager.clearSelection();
        }

        Router { id: router
            anchors.fill: parent
            isInGame: appRoot.isInGame
            focus: true

            // the engine is bad at telling you what level it is loading. you can call `getChapterName`
            // throughout the entire load, but it won't actually give you the correct level until it's
            // halfway through the load. use signals from the router to handle loading maps and savegames
            // so that we can tell the loading screen what map is loading because the engine can't.
            onLoadGameRequest: {
                footer.levelName = savegame.chapterName;
                BlackMesaUtils.loadGame(savegame.savename);
            }

            onLoadMapRequest: {
                footer.levelName = mapname;
                BlackMesaUtils.loadMap(filename);
            }

            onSaveGameRequest: {
                BlackMesaUtils.saveGame(filename);
            }
        }
    }

    Header { id: header
        hide: true
        visible: !appRoot.isLoadingLevel
        currentRoute: router.currentRoute
        isInGame: appRoot.isInGame

        onRouteRequest: router.setRoute(routeName)
    }

    Footer { id: footer
        isLoading: appRoot.isLoadingLevel
        currentRoute: router.currentRoute
        isInGame: appRoot.isInGame
        loadPercent: appRoot.loadPercent
        showLoadingProgress: !appRoot._isInitialLoad

        onRouteRequest: router.setRoute(routeName)
    }

    function _printEngineState() {
        console.log("==== Engine State");
        console.log("isLevelMainMenuBackground:", BlackMesaEngine.isLevelMainMenuBackground());
        console.log("mainMenuBackgroundName:", BlackMesaEngine.getMainMenuBackgroundName());
        console.log("currentLevelName:", BlackMesaEngine.getLevelName());
        console.log("isInGame:", BlackMesaEngine.isInGame());
        console.log("getChapterName:", BlackMesaEngine.getChapterName());
        console.log("getLevelNameShort", BlackMesaEngine.getLevelNameShort());
        console.log("getLevelVersion", BlackMesaEngine.getLevelVersion());
        console.log("getLocalizedString", BlackMesaEngine.getLocalizedString(BlackMesaEngine.getChapterName()));
    }

    MouseArea {
        enabled: InputBindingsManager.isBinding
        anchors.fill: parent
        hoverEnabled: InputBindingsManager.isBinding
        acceptedButtons: Qt.AllButtons

        onWheel: {
            InputBindingsManager.handleBindingResponse({
                                                           key: InputBindingsManager.mouseMap[wheel.angleDelta.y > 0 ? 'wheelUp' : 'wheelDown']
                                                       });
        }

        onClicked: {
            InputBindingsManager.handleBindingResponse({
                                                           key: InputBindingsManager.mouseMap[mouse.button],
                                                           code: mouse.button
                                                       });
        }
    }

    Keys.onReleased: {
        if (InputBindingsManager.isBinding) {
            InputBindingsManager.handleBindingResponse({
                                                           key: InputBindingsManager.keyMap[event.key],
                                                           code: event.key
                                                       });
        } else if (InputBindingsManager.isSelected && event.key === Qt.Key_Escape) {
            InputBindingsManager.clearSelection();
        }
    }

    // TODO: Refactor to use state. too much bitfucking
    Connections {
        target: BlackMesaEngine

        onGameUIActived: {
            BlackMesaEngine.grabInputForGameUI();

            isInGame = !_isInitialLoad && !BlackMesaEngine.isLevelMainMenuBackground() && !isLoadingLevel

            if (_isInitialLoad) {
                wallpaper.updateBackgroundImage(BlackMesaEngine.getMainMenuBackgroundName());
            }

            if (_isInitialLoad || appRoot.opacity === 0) {
                // TODO: This is terrible. Fix this awful mess of cross-invokation

                // GameUIActived is fired by onLevelLoadingStarted, breaking the contract of this handler.
                // because of this, we need to know the difference between a valid invocation of this
                // handler by the engine, or the fake invocation in the loading handler below.

                // If it's an invokation from below, then the UI is already active. In this case,
                // we don't want to do anything here, otherwise the
                // router will try to transtition to the index route with an animation just before
                // it is told to transition again to the empty route without a transition by onLevelLoadingStarted.
                // the fact that the router is already transitioning to index with a transition delays
                // the real immediate transition to empty for the loading screen that we actually want
                // and produces visual artifacts.

                // only unhide the header and route to index if this is either the initial load of the ui,
                // or if the UI is not already active
                header.hide = false;
                router.setRoute(mainMenuIndexRoute.name);
            }

            appRoot.opacity = 1.0;
        }

        onGameUIHidden: {
            BlackMesaEngine.releaseInputFromGameUI();

            appRoot.opacity = 0.0;

            // hide the header because the header will transition in and out when hidden, as well
            // as fade with appRoot
            // don't hide the footer because the footer never transitions. it will fade with appRoot.
            header.hide = true;

            // if the UI is being hidden because we just loaded a level, then
            // immediately transition to empty (loading screen cut).
            // otherwise, animate to empty (ui fade out because the user exited it)
            router.setRoute(emptyRoute.name, didLoadLevel);
            didLoadLevel = false;
        }

        onLevelLoadingStarted: {
            // this is false whenever the Qt loading screen is not supposed to show during the load
            // (defer to in-game HUD "LOADING" modal)
            var shouldUpdateProgressBar = showProgressDialog || BlackMesaEngine.isLevelMainMenuBackground() || BlackMesaEngine.getLevelNameShort().length === 0;

            //TODO: this is not good. don't cross event handlers...
            //      this is the reason that nasty if/else in the actived handler is there.
            if (shouldUpdateProgressBar && appRoot.visible) {
                BlackMesaEngine.gameUIActived();
            }

            wallpaper.updateBackgroundImage(levelName);

            BlackMesaEngine.setShouldUpdateProgressBar(shouldUpdateProgressBar);
            BlackMesaEngine.releaseInputFromGameUI();

            isInGame = false
            isLoadingLevel = true
            wallpaper.showImage = true
            wallpaper.showExtras = false
            autoBackgroundMusicTimer.stop();
            router.setRoute(emptyRoute.name, true);
            header.hide = true
        }

        onLevelLoadingFinished: {
            var isLevelMainMenuBackground, currentLevelName;

            _isInitialLoad = false
            isLoadingLevel = false
            didLoadLevel = true
            isInGame = !_isInitialLoad && !BlackMesaEngine.isLevelMainMenuBackground()
            wallpaper.showImage = false
            wallpaper.showExtras = true;
            appRoot.loadPercent = 0;
            footer.levelName = "";

            isLevelMainMenuBackground = BlackMesaEngine.isLevelMainMenuBackground();
            currentLevelName = BlackMesaEngine.getLevelName();

            if (isLevelMainMenuBackground) {
                Sound.startAmbient(Theme.sounds.ambient);
                header.hide = false;
                router.setRoute(mainMenuIndexRoute.name);
                BlackMesaEngine.grabInputForGameUI();
            } else {
                Sound.stopAmbient();
                router.setRoute(emptyRoute.name, isInGame);
            }
        }

        onUpdateProgressValue: {
            appRoot.loadPercent = progressValue;
        }
    }

    Item {
        id: consoleContainer

        Rectangle {
            anchors.fill: parent
            color: "#D0202020"
        }

        anchors.left: parent.left
        anchors.right: parent.right

        height: parent.height * 0.375

        opacity: 0.0
        visible: opacity > 0.0009765625

        enabled: visible

        state: "closed"

        clip: true

        ListModel {
            id: consoleOutputModel

            dynamicRoles: false

            ListElement {
                elementColor: "gold"
                elementText: "Black Mesa Console Initialized"
            }

            onCountChanged: if (consoleContainer.state === "opened") consoleOutputView.positionViewAtEnd()
        }

        ListView {
            id: consoleOutputView

            anchors.left: parent.left
            anchors.right: parent.right

            anchors.top: parent.top
            anchors.bottom: consoleCommandField.top

            clip: true

            model: consoleOutputModel

            ScrollBar.vertical: ScrollBar {
            }

            delegate: TextField {
                id: delegateRoot

                padding: 0

                width: parent.width
                height: contentHeight

                readOnly: true
                wrapMode: TextInput.Wrap

                selectionColor: "#D0D0D0D0"
                selectedTextColor: "#D0202020"

                font.family: "Consolas"
                font.pointSize: 11.25

                background: Item {
                    anchors.fill: parent
                }

                color: elementColor
                text: elementText
            }
        }

        TextField {
            id: consoleCommandField

            QtObject {
                id: consoleCommandsHistory

                property var entries: []
                property int entryIndex: 0

                onEntriesChanged: {
                    entryIndex = entries.length;
                }

                onEntryIndexChanged: {
                    if (entryIndex < 0) {
                        entryIndex = 0;

                        return;
                    }

                    if (entryIndex > entries.length) {
                        entryIndex = entries.length;

                        return;
                    }

                    consoleCommandField.clear();

                    if (entryIndex < entries.length) {
                        consoleCommandField.text = entries[entryIndex];
                    }
                }
            }

            QtObject {
                id: consoleCommandsAutocomplete

                property var autocompleteList: []
                property int storedAutocompleteIndex: -1

                property string storedSearchString: ""
                property string storedSearchStringPrefix: ""
            }

            anchors.left: parent.left
            anchors.right: parent.right

            anchors.bottom: parent.bottom

            color: "#FFD0D0D0"

            selectionColor: "#FFD0D0D0"
            selectedTextColor: "#D0202020"

            font.family: "Consolas"
            font.pointSize: 11.25

            selectByMouse: true

            background: Item {
                anchors.fill: parent
            }

            onAccepted: {
                if (text.toLowerCase().trim() !== "clear") {
                    BlackMesaEngine.printConsoleMessage("lightgray", "> " + text + "\n");
                }

                BlackMesaEngine.executeClientCommandUnrestricted(text);

                consoleCommandsHistory.entries.push(text);
                consoleCommandsHistory.entries = consoleCommandsHistory.entries;
            }

            Keys.onUpPressed: consoleCommandsHistory.entryIndex--
            Keys.onDownPressed: consoleCommandsHistory.entryIndex++

            Keys.onPressed: {
                if (event.key === Qt.Key_unknown) {
                    return;
                }

                if (event.key !== Qt.Key_Tab) {
                    consoleCommandsAutocomplete.storedAutocompleteIndex = -1;
                }
            }

            Keys.onTabPressed: {
                var inputString, searchString, whiteSpaceIndexOf, consoleHelpString;

                event.accepted = true;

                if (length === 0) {
                    return;
                }

                inputString = text.replace(/\s+/g, " ");

                if (consoleCommandsAutocomplete.storedAutocompleteIndex < 0) {
                    whiteSpaceIndexOf = inputString.indexOf(" ");

                    if (whiteSpaceIndexOf !== -1) {
                        consoleCommandsAutocomplete.storedSearchStringPrefix = inputString.substring(0, whiteSpaceIndexOf + 1);
                        consoleCommandsAutocomplete.storedSearchString = inputString.substring(whiteSpaceIndexOf + 1, inputString.length);

                        consoleCommandsAutocomplete.autocompleteList = BlackMesaEngine.listConsoleSuggestions(consoleCommandsAutocomplete.storedSearchStringPrefix, consoleCommandsAutocomplete.storedSearchString);
                    } else {
                        consoleCommandsAutocomplete.storedSearchStringPrefix = ""
                        consoleCommandsAutocomplete.storedSearchString = inputString;

                        consoleCommandsAutocomplete.autocompleteList = BlackMesaEngine.listConsoleAutocompleteEntries(consoleCommandsAutocomplete.storedSearchString);
                    }

                    BlackMesaEngine.printConsoleMessage("lightgray", "] " + inputString + "\n");

                    if (consoleCommandsAutocomplete.autocompleteList.length === 0) {
                        return;
                    }

                    consoleCommandsAutocomplete.storedAutocompleteIndex = 0;

                    consoleHelpString = consoleCommandsAutocomplete.autocompleteList.reduce(function (accumulator, currentValue) {
                        return accumulator + "\t" + currentValue + "\n";
                    }, "");

                    BlackMesaEngine.printConsoleMessage("lightgray", consoleHelpString);
                }

                searchString = consoleCommandsAutocomplete.storedSearchStringPrefix + consoleCommandsAutocomplete.storedSearchString;

                text = consoleCommandsAutocomplete.storedSearchStringPrefix + consoleCommandsAutocomplete.autocompleteList[consoleCommandsAutocomplete.storedAutocompleteIndex];
                select(searchString.length, text.length);

                consoleCommandsAutocomplete.storedAutocompleteIndex++;

                if (consoleCommandsAutocomplete.storedAutocompleteIndex >= consoleCommandsAutocomplete.autocompleteList.length) {
                    consoleCommandsAutocomplete.storedAutocompleteIndex = 0;
                }
            }
        }

        states: [
            State {
                name: "closed"
                PropertyChanges {
                    target: consoleContainer
                    y: -consoleContainer.height
                    opacity: 0.0
                }
            },
            State {
                name: "opened"
                PropertyChanges {
                    target: consoleContainer
                    y: 0
                    opacity: 1.0
                }
            }
        ]

        transitions: [
            Transition {
                from: "closed"
                to: "opened"
                SequentialAnimation {
                    NumberAnimation {
                        properties: "y, opacity"
                        duration: 250
                    }
                    ScriptAction {
                        script: {
                            consoleOutputView.positionViewAtEnd();
                            consoleCommandField.forceActiveFocus();
                        }
                    }
                }
            },
            Transition {
                from: "opened"
                to: "closed"
                SequentialAnimation {
                    ScriptAction {
                        script: {
                            consoleCommandField.focus = false;
                        }
                    }
                    NumberAnimation {
                        properties: "y, opacity"
                        duration: 250
                    }
                }
            }
        ]

        Connections {
            target: BlackMesaEngine

            onGameConsoleMessagesReceived: {
                var i, messageEntry, messagesListLength;

                messagesListLength = messagesList.length;
                for (i = 0; i < messagesListLength; i++) {
                    messageEntry = messagesList[i];

                    consoleOutputModel.append({
                                                  elementColor: messageEntry.color.toString(),
                                                  elementText: messageEntry.text
                                              });
                }
            }

            onGameConsoleActived: {
                consoleContainer.state = "opened";
            }

            onGameConsoleHidden: {
                consoleContainer.state = "closed";
            }

            onGameConsoleCleared: {
                consoleOutputModel.clear();
            }
        }
    }

    Connections {
        target: BlackMesaEngine

        onGameUIActived: {
            if (BlackMesaEngine.getMaxClients() < 2 && !BlackMesaEngine.isLevelMainMenuBackground() && BlackMesaEngine.isInGame()) {
                BlackMesaEngine.executeClientCommandUnrestricted("setpause nomsg");
            }
        }

        onGameUIHidden: {
            if (BlackMesaEngine.getMaxClients() < 2 && !BlackMesaEngine.isLevelMainMenuBackground() && BlackMesaEngine.isInGame()) {
                BlackMesaEngine.executeClientCommandUnrestricted("unpause nomsg");
            }
        }

        onLevelLoadingStarted: {
            BlackMesaEngine.executeClientCommandUnrestricted("unpause nomsg");
        }
    }

    Timer {
        id: autoBackgroundMusicTimer
        interval: 1500
        repeat: false
        running: true
        triggeredOnStart: false

        // TODO: again, ...bitfucking
        onTriggered: {
            _isInitialLoad = false;
            isLoadingLevel = false;
            header.hide = false;
            wallpaper.showExtras = true;
            router.setRoute(mainMenuIndexRoute.name);
            Sound.startAmbient(Theme.sounds.ambient);
        }
    }
}
