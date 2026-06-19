import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import CrowbarCollective 1.0

Item {
    id: appRoot
    objectName: "ui:root"

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
    // Tells us that player in multiplayer mode or not
    property bool isInMultiplayerMode: false
    // It's responce for proper ui transition disable when saving game
    property bool isSaving: false
    // this bool tells us whether or not a loading event is the loading event for the
    // main menu map, or if this is a load event for a legitimate game/multiplayer session
    property bool _isInitialLoad: true
    // if TRUE, it means last map loading failed ( in most of cases, it's related to not being able to connect to server )
    property bool loadingErrorFlag: false
    // if loadingErrorFlag is TRUE, this string is the error message.
    property string levelLoadingFinished_FailureReason: ""
    // how much of the level has been loaded. used by footer.
    property real loadPercent: 0.0

    // Used to properly handle fast ESC and ~ keys pressing
    //while animation of menu is still running, i.e. menu open/close state.
    property bool isMenuBlocked: false;

    Binding {
        target: Theme
        property: "widthScale"
        value: appRoot.width / 1920;
    }

    Binding {
        target: Theme
        property: "heightScale"
        value: appRoot.height / 1080;
    }

    onWidthChanged: {
        Theme.rootWidth = appRoot.width;
        wallpaper.updateBackgroundImage();
    }

    onHeightChanged: {
        Theme.rootHeight = appRoot.height;
        wallpaper.updateBackgroundImage();
    }

    focus: true
    visible: true;
    onVisibleChanged: BlackMesaEngine.setRootPanelVisibility(visible)

    Keys.onPressed: {
        if (BlackMesaUtils.disableUINavigation)
            return;

        BlackMesaUtils.navigationUIHandle(event);
    }

    Behavior on opacity {
        enabled: !didLoadLevel && !appRoot.isSaving // do not animate appRoot opacity if opacity is changing due to a level load
        SequentialAnimation {
            ScriptAction { script: { isMenuBlocked = true; } }
            NumberAnimation { target: appRoot; property: "opacity"; duration: 625  }
            ScriptAction { script: { isMenuBlocked = false; } }
        }
    }

    Wallpaper {
        id: wallpaper
        anchors.fill: parent
        showSkrim: isInGame || router.currentRoute !== Routes.index
        darkenSkrim: isInGame
        suppressAnimations: isLoadingLevel
    }

    GridLayout {
        width: parent.width
        height: parent.height
        flow: GridLayout.TopToBottom

        rows: 3
        rowSpacing: 0
        columns: 0
        columnSpacing: 0

        Header {
            id: header
            hide: true
            visible: !appRoot.isLoadingLevel
            currentRoute: router.currentRoute
            isInGame: appRoot.isInGame
            onRouteRequest: router.setRoute(routeName)

            Layout.preferredHeight: 128 * Theme.heightScale
            Layout.preferredWidth: parent.width
        }

        Router {
            id: router
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width
            isInGame: appRoot.isInGame

            width: parent.width
            height: parent.height
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
                // TODO: A little hack, but this one is related to proper state management,
                // so it should be refactored and implemented carefully. ( e.g. Because of UI
                // transition is not very fast we have a bug with game save screenshot, the main
                // menu overlay is saved on save game thumbnail...
                appRoot.isSaving = true
                appRoot.visible = false;
                BlackMesaUtils.saveGame(filename, function() {
                    appRoot.isSaving = false
                });
            }
        }

        Footer {
            id: footer
            isLoading: appRoot.isLoadingLevel
            currentRoute: router.currentRoute
            isInGame: appRoot.isInGame
            loadPercent: appRoot.loadPercent
            showLoadingProgress: !appRoot._isInitialLoad

            onRouteRequest: router.setRoute(routeName)

            Layout.preferredHeight: 72 * Theme.heightScale
            Layout.preferredWidth: parent.width
        }
    }

    MouseArea {
       enabled: InputBindingsManager.isBinding
       anchors.fill: parent
       hoverEnabled: InputBindingsManager.isBinding
       acceptedButtons: Qt.AllButtons

       z: 2000

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

    // TODO: Refactor to use state. too much bitfucking
    Connections {
        enabled: !isMenuBlocked
        target: BlackMesaEngine
        ignoreUnknownSignals: true;

        onKeyCaptured: {
           var buttonCodeString = BlackMesaEngine.keyButtonCodeToString(keyButtonCode);

           if (InputBindingsManager.isBinding) {
               InputBindingsManager.handleBindingResponse({
                   key: buttonCodeString,
                   code: keyButtonCode
               });
           } else if (InputBindingsManager.isSelected && event.key === Qt.Key_Escape) {
               InputBindingsManager.clearSelection();
           }
        }

        onGameUIActived: {
            BlackMesaEngine.grabInputForGameUI();

            isInGame = BlackMesaEngine.isInGame() && !_isInitialLoad && !BlackMesaEngine.isLevelMainMenuBackground() && !isLoadingLevel

            if (_isInitialLoad) {
                wallpaper.updateBackgroundImage(BlackMesaEngine.getMainMenuBackgroundName());
            }

            // if UI activated after an error flag raised, this means the loading failed - so we go back to the server list.
            if ( loadingErrorFlag ) {
                loadingErrorFlag = false; // reset the flag
                header.hide = false;
                router.setRoute(Routes.multiplayer.name);
            }

            else if (
            !isLoadingLevel // <-- we don't want to route to main menu if we are currently loading - this is happening in MP when map is changing: UI is suddenly activated to show progress bar.
            && (_isInitialLoad || !appRoot.visible) ) {
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

            appRoot.visible = true;
            appRoot.forceActiveFocus();

            if (BlackMesaEngine.getMaxClients() < 2 && !BlackMesaEngine.isLevelMainMenuBackground() && BlackMesaEngine.isInGame()) {
                BlackMesaEngine.executeClientCommandUnrestricted("setpause nomsg");
            }
        }

        onGameUIHidden: {
            didLoadLevel = false;
            devConsole.state = "closed";
            appRoot.visible = false;
            // hide the header because the header will transition in and out when hidden, as well
            // as fade with appRoot
            // don't hide the footer because the footer never transitions. it will fade with appRoot.
            header.hide = true;
            // if the UI is being hidden because we just loaded a level, then
            // immediately transition to empty (loading screen cut).
            // otherwise, animate to empty (ui fade out because the user exited it)
            router.setRoute(emptyRoute.name, didLoadLevel);
            BlackMesaEngine.releaseInputFromGameUI();

            if (BlackMesaEngine.getMaxClients() < 2 && !BlackMesaEngine.isLevelMainMenuBackground() && BlackMesaEngine.isInGame()) {
                BlackMesaEngine.executeClientCommandUnrestricted("unpause nomsg");
            }
        }

        onLevelLoadingStarted: {
            BlackMesaEngine.executeClientCommandUnrestricted("unpause nomsg");
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
            footer.isInGame = BlackMesaEngine.isInGame() && !BlackMesaEngine.isLevelMainMenuBackground();

            isLevelMainMenuBackground = BlackMesaEngine.isLevelMainMenuBackground();
            currentLevelName = BlackMesaEngine.getLevelName();
            isInMultiplayerMode = BlackMesaEngine.isInGame() && BlackMesaEngine.isInMultiplayerMode();

            // if there was an error, raise the error flag.
            // note that the "isError" variable name comes from BlackMesaUIInstance.cpp
            if ( isError === true ) {
                // fill the error string.  note that the "failureReason" variable name comes from BlackMesaUIInstance.cpp
                levelLoadingFinished_FailureReason = failureReason;
                // show the error message in an Alert box.
                alertLoadFailed.show();
                loadingErrorFlag = true;
                didLoadLevel = false;
                isInGame = false;
            } else if (isLevelMainMenuBackground) {
                Sound.startMusic();
                header.hide = false;
                router.setRoute(mainMenuIndexRoute.name);
                wallpaper.updateBackgroundImage(BlackMesaEngine.getMainMenuBackgroundName());
                BlackMesaEngine.grabInputForGameUI();
            } else {
                didLoadLevel = false;
                isInGame = false;
                header.hide = false;
                Sound.stopMusic();
                router.setRoute(mainMenuIndexRoute.name);
                wallpaper.updateBackgroundImage(BlackMesaEngine.getMainMenuBackgroundName());
            }
        }

        onDisconnectedFromServer: {
            footer.isInGame = appRoot.isInGame = BlackMesaEngine.isInGame() && !BlackMesaEngine.isLevelMainMenuBackground()
        }

        onUpdateProgressValue: {
            appRoot.loadPercent = progressValue;
        }
    }

    Timer {
        id: autoBackgroundMusicTimer
        interval: 1250
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
            wallpaper.updateBackgroundImage(BlackMesaEngine.getMainMenuBackgroundName());
            Sound.startMusic();
        }
    }

    DevConsole {
        id: devConsole
    }
    // Alert reporting loading error failed
    Alert { id: alertLoadFailed
        titleText: BlackMesaEngine.getLocalizedString("#BlackMesaUI_Error")
        messageText: levelLoadingFinished_FailureReason

        buttons: VisualItemModel { id: buttons

            DefaultButton {
                objectName: "ui:btn:action[apply]"
                text: BlackMesaEngine.getLocalizedString("#GameUI_OK")
                onClicked: {
                    levelLoadingFinished_FailureReason = ""; // reset variable
                    alertLoadFailed.hide();
                }
            }
        }
    }
}
