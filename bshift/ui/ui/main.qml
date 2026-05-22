import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import CrowbarCollective 1.0

Item {
    id: appRoot
    objectName: "ui--navigation:root"

    readonly property Route emptyRoute: Routes.empty
    readonly property Route mainMenuIndexRoute: Routes.index
    // is the engine is currently loading a level
    property bool isLoadingLevel: false
    property bool shouldCancelLoading: true
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
    
    property int randomBackgroundChapter: ( !Theme.currentDay ) ? Math.ceil(Math.random() * 4.9) : 555
    property int randomBackgroundVariant: Math.floor(Math.random() * 1.9)
	
	property var playerName: "Barney"

    property bool isIndexHints: true
    property bool isSubMenuOpened: false
    property bool isConsoleOpened: false
	property bool changeIndexLogoWidth: false
	
    property bool isLeftMenuFocused: false
    
    property int isControllerUsed: 0
	//Keyboard - 0
	//Xbox One - 1
	//Dualshock 4 - 2
	property int iconsType
	
	property string hintSelectIcon: "a"
	property string hintBackIcon: "."
	property string hintCloseIcon: "y"
	property string hintLRIcon: "ts"
	property string hintUDIcon: "qr"
	property string hintRIcon: "s"
	
	property color hintSelectColor: Theme.colors.text
	property color hintBackColor: Theme.colors.text
	
    function hintsIconTypeChange() {
    
        if ( isControllerUsed ) {
            if ( iconsType === 0 ) {
				hintSelectIcon = "#";
				hintBackIcon = "$";
				hintCloseIcon =":";
				hintLRIcon ="(";
				hintUDIcon = "'";
				hintRIcon = ")";
				
				hintSelectColor = Theme.colors.hintButtonA;
				hintBackColor = Theme.colors.hintButtonBCircle;
				
				BlackMesaUtils.iconAColor = Theme.colors.hintButtonA;
				BlackMesaUtils.iconBColor = Theme.colors.hintButtonBCircle;
				BlackMesaUtils.iconXColor = Theme.colors.hintButtonX;
				BlackMesaUtils.iconYColor = Theme.colors.hintButtonY;
				return;
			} else if ( iconsType === 1 ) {
				hintSelectIcon = "*";
				hintBackIcon = "+";
				hintCloseIcon =";";
				hintLRIcon ="!";
				hintUDIcon = "^";
				hintRIcon = "_";
				
				hintSelectColor = Theme.colors.hintButtonCross;
				hintBackColor = Theme.colors.hintButtonBCircle;
				return;
			} else if ( iconsType === 2 ) {
				hintSelectIcon = "*";
				hintBackIcon = "+";
				hintCloseIcon ="3";
				hintLRIcon ="!";
				hintUDIcon = "^";
				hintRIcon = "_";
				
				hintSelectColor = Theme.colors.text;
				hintBackColor = Theme.colors.text;
				return;
			} else if ( iconsType === 3 ) {
				hintSelectIcon = "$";
				hintBackIcon = "#";
				hintCloseIcon ="6";
				hintLRIcon ="0";
				hintUDIcon = "1";
				hintRIcon = "2";
				
				hintSelectColor = Theme.colors.text;
				hintBackColor = Theme.colors.text;
				return;
			}
        } else {
			hintSelectIcon = "a";
			hintBackIcon = ".";
			hintCloseIcon ="y";
			hintLRIcon ="ts";
			hintUDIcon = "qr";
			hintRIcon = "s";
				
			hintSelectColor = Theme.colors.text;
			hintBackColor = Theme.colors.text;
			return;
		}
    }
	
    function isSubMenuOpenedFunction( thisthing ) {
		if ( thisthing === true )
			changeIndexLogoWidth = true;
		
		isSubMenuOpened = thisthing;
		return;
    }
	
    function isLeftMenuFocusedFunction( isitreally ) {
		isLeftMenuFocused = isitreally;
		return;
    }
	
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
    visible: opacity > 0.0
    onVisibleChanged: {
        BlackMesaEngine.setRootPanelVisibility(visible);
        isSubMenuOpenedFunction( false )
	}


    Keys.onPressed: {
        if (BlackMesaUtils.disableUINavigation)
            return;

        BlackMesaUtils.navigationUIHandle(event);

    }

    Behavior on opacity {
        enabled: !didLoadLevel && !appRoot.isSaving // do not animate appRoot opacity if opacity is changing due to a level load
        SequentialAnimation {
            ScriptAction { script: { isMenuBlocked = true; } }
            NumberAnimation { target: appRoot; property: "opacity"; duration: 180 }
            ScriptAction { script: { isMenuBlocked = false; } }
        }
    }

    Wallpaper {
        id: wallpaper
        anchors.fill: parent
        showSkrim: isInGame	// || router.currentRoute !== Routes.index
        darkenSkrim: isInGame
        suppressAnimations: appRoot.isLoadingLevel
    }

    GridLayout {
        anchors.fill: parent
        //width: parent.width
        //height: parent.height
        flow: GridLayout.TopToBottom

        rows: 2
        rowSpacing: 0
        columns: 0
        columnSpacing: 0


        Footer {
            id: footer
            isLoading: appRoot.isLoadingLevel
            currentRoute: router.currentRoute
            loadPercent: appRoot.loadPercent
            showLoadingProgress: !appRoot._isInitialLoad

            Layout.preferredHeight: 0
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
				
                
                setRoute(emptyRoute.name, true);
                
                appRoot.isLoadingLevel = true;
                
                
                var chapterNumber = savegame.chapter;
				
                if ( chapterNumber !== -1 && randomBackgroundChapter !== chapterNumber ) {
                    randomBackgroundChapter = chapterNumber + 1;
                    wallpaper.updateBackgroundImage();
                }
                devConsole.state = "closed";
				
                
                
                loadSaveTimer.savename = savegame.savename;
                loadSaveTimer.start();
            }

            onLoadMapRequest: {
                footer.levelName = mapname;
				
                
                setRoute(emptyRoute.name, true);
                
                appRoot.isLoadingLevel = true;
                
                
                var chapterNumber = Number((filename.match(/c(\d+)m/m) || [])[1] || "-1");
				
                BlackMesaEngine.executeClientCommandUnrestricted("echo " + chapterNumber);
                
                if ( chapterNumber !== -1 && randomBackgroundChapter !== chapterNumber ) {
                    randomBackgroundChapter = chapterNumber + 1;
                    wallpaper.updateBackgroundImage();
                }
				devConsole.state = "closed";
				
                loadLevelTimer.filename = filename;
                loadLevelTimer.start();
            }

            onSaveGameRequest: {
                // TODO: A little hack, but this one is related to proper state management,
                // so it should be refactored and implemented carefully. ( e.g. Because of UI
                // transition is not very fast we have a bug with game save screenshot, the main
                // menu overlay is saved on save game thumbnail...
                
                appRoot.isSaving = true;
                appRoot.opacity = 0.0;
                BlackMesaUtils.saveGame(filename, function() {
                    appRoot.isSaving = false;
                });
            }
        }
    }
    
    Timer {
        id: isLoadingCheck
        interval: 100
        repeat: false
        running: false
        triggeredOnStart: false
        
        onTriggered: {
            if ( shouldCancelLoading ) {
                isSubMenuOpenedFunction(false);
                router.setRoute(mainMenuIndexRoute.name, false);
                isLoadingLevel = false;
            }
        }
    }
    
    Timer {
        id: loadSaveTimer
        interval: 100
        repeat: false
        running: false
        triggeredOnStart: false
        
        property var savename
        
        onTriggered: {
            BlackMesaUtils.loadGame(savename);
            isLoadingCheck.start();
        }
    }
    
    Timer {
        id: loadLevelTimer
        interval: 50
        repeat: false
        running: false
        triggeredOnStart: false

        property var filename
        
        onTriggered: {
            BlackMesaUtils.loadMap(filename);
            isLoadingCheck.start();
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

           if ( InputBindingsManager.isBinding ) {
                InputBindingsManager.handleBindingResponse({
                    key: buttonCodeString,
                    code: keyButtonCode
               });
           }
        }

        onGameUIActived: {
            BlackMesaEngine.grabInputForGameUI();

            isInGame = BlackMesaEngine.isInGame() && !_isInitialLoad && !BlackMesaEngine.isLevelMainMenuBackground() && !isLoadingLevel
			
			isIndexHints = true;

            if (_isInitialLoad) {
                wallpaper.updateBackgroundImage();
                
				//just in case, set this to 1
				BlackMesaEngine.setConsoleVariableAsInt("mat_unlock_gfx_highend_unsupported", 1 );
                //DISABLING HUD POST-FX FOR OUR BARNEY
                //BlackMesaEngine.setConsoleVariableAsString("hud_post", "0");
            }

            // if UI activated after an error flag raised, this means the loading failed - so we go back to the server list.
            if ( loadingErrorFlag ) {
                loadingErrorFlag = false; // reset the flag
                router.setRoute(mainMenuIndexRoute.name);
            } else if ( !isLoadingLevel && (_isInitialLoad || appRoot.opacity === 0) ) {
            
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

                router.setRoute(mainMenuIndexRoute.name);
            }
            
            //This is really fucked up workaround for bs_c1m0c to bs_c2m0a loading transition
            //Screen should be black, and have no text other than 'LOADING...' in the center
            if ( BlackMesaEngine.getLevelNameShort() !== "bs_c1m0c" || ( ( BlackMesaEngine.getLevelNameShort() === "bs_c1m0c" ) && !isLoadingLevel ) ) {
                appRoot.opacity = 1.0;
                appRoot.forceActiveFocus();
            } else {
                appRoot.opacity = 0.0;
            }


            if ( BlackMesaEngine.getMaxClients() < 2 && !BlackMesaEngine.isLevelMainMenuBackground() && BlackMesaEngine.isInGame() ) {
                BlackMesaEngine.executeClientCommandUnrestricted("setpause nomsg");
            }

            // We need to reparse ui elements after user in game and go to menu
            BlackMesaUtils.clearTraversalTree();
            BlackMesaUtils.parseTraversalTree(appRoot);
            BlackMesaUtils.traversalDepth = 2;
            BlackMesaUtils.updateCurrentUISelection();
        }

        onGameUIHidden: {
            didLoadLevel = false;
            devConsole.state = "closed";
            appRoot.opacity = 0.0;
            // if the UI is being hidden because we just loaded a level, then
            // immediately transition to empty (loading screen cut).
            // otherwise, animate to empty (ui fade out because the user exited it)
            router.setRoute(emptyRoute.name, true);
            BlackMesaEngine.releaseInputFromGameUI();

            if (BlackMesaEngine.getMaxClients() < 2 && !BlackMesaEngine.isLevelMainMenuBackground() && BlackMesaEngine.isInGame() ) {
                BlackMesaEngine.executeClientCommandUnrestricted("unpause nomsg");
            }
        }

        onLevelLoadingStarted: {
            shouldCancelLoading = false;
            
            BlackMesaEngine.executeClientCommandUnrestricted("unpause nomsg");
            // this is false whenever the Qt loading screen is not supposed to show during the load
            // (defer to in-game HUD "LOADING" modal)
            var shouldUpdateProgressBar = showProgressDialog || BlackMesaEngine.isLevelMainMenuBackground() || BlackMesaEngine.getLevelNameShort().length === 0;
            
				devConsole.state = "closed";
            
            //TODO: this is not good. don't cross event handlers...
            //      this is the reason that nasty if/else in the actived handler is there.
            if (shouldUpdateProgressBar && appRoot.visible) {
                BlackMesaEngine.gameUIActived();
            }

                wallpaper.updateBackgroundImage();

                BlackMesaEngine.setShouldUpdateProgressBar(shouldUpdateProgressBar);
                BlackMesaEngine.releaseInputFromGameUI();

                isInGame = false
                isLoadingLevel = true
                wallpaper.showImage = true
                
                
                wallpaper.showExtras = false
                
                autoBackgroundMusicTimer.stop();
                router.setRoute(emptyRoute.name, true);
        }

        onLevelLoadingFinished: {
            var isLevelMainMenuBackground, currentLevelName;

            _isInitialLoad = false;
            isLoadingLevel = false;
            didLoadLevel = true;
            isLevelMainMenuBackground = BlackMesaEngine.isLevelMainMenuBackground();
            isInGame = !_isInitialLoad && !isLevelMainMenuBackground;
            wallpaper.showImage = false;
            wallpaper.showExtras = true;
            appRoot.loadPercent = 0;
            footer.levelName = "";

            currentLevelName = BlackMesaEngine.getLevelName();
            isInMultiplayerMode = BlackMesaEngine.isInGame() && BlackMesaEngine.isInMultiplayerMode();

			devConsole.state = "opened";
                
            // if there was an error, raise the error flag.
            // note that the "isError" variable name comes from BlackMesaUIInstance.cpp
            if ( isError === true ) {
                // fill the error string.  note that the "failureReason" variable name comes from BlackMesaUIInstance.cpp
                levelLoadingFinished_FailureReason = failureReason;
                
                BlackMesaEngine.executeClientCommandUnrestricted("echo " + levelLoadingFinished_FailureReason );
                
                // show the error message in an Alert box.
                //alertLoadFailed.show();
                loadingErrorFlag = true;
                didLoadLevel = false;
                isInGame = false;
                
            } else if (isLevelMainMenuBackground) {
                Sound.startMusic();
                router.setRoute(mainMenuIndexRoute.name);
                wallpaper.updateBackgroundImage();
                BlackMesaEngine.grabInputForGameUI();

                // Initial setup for ui navigation
                // generating ui tree here
                BlackMesaUtils.clearTraversalTree();
                BlackMesaUtils.parseTraversalTree(appRoot);
            } else {
                didLoadLevel = false;
                isInGame = false;
                router.setRoute(mainMenuIndexRoute.name);
                wallpaper.updateBackgroundImage();
            }
        }

        onDisconnectedFromServer: {
			if ( !isLoadingLevel && !BlackMesaEngine.isLevelMainMenuBackground() ) {
				isInGame = false;
				router.setRoute(emptyRoute.name, true);
				router.setRoute(mainMenuIndexRoute.name);
			}
        }

        onUpdateProgressValue: {
            appRoot.loadPercent = progressValue;
        }
        
		onNavigationSourceChanged: function(type) {
			if ( isControllerUsed !== type ) {
				isControllerUsed = type;
				hintsIconTypeChange();
			}
        }
    }
    
    

    Timer {
        id: autoBackgroundMusicTimer
        interval: 750
        repeat: false
        running: true
        triggeredOnStart: false

        // TODO: again, ...bitfucking
        onTriggered: {
            _isInitialLoad = false;
            isLoadingLevel = false;
            wallpaper.showExtras = true;
            router.setRoute(mainMenuIndexRoute.name);
            wallpaper.updateBackgroundImage();
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
                text: BlackMesaEngine.getLocalizedString("#GameUI_OK")
                callback: function() {
                    levelLoadingFinished_FailureReason = ""; // reset variable
                    alertLoadFailed.hide();
                }
                onClicked: {
                    levelLoadingFinished_FailureReason = ""; // reset variable
                    alertLoadFailed.hide();
                }
            }
        }
    }
}
