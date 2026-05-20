pragma Singleton

import QtQuick 2.9
import CrowbarCollective 1.0

QtObject {
    property var discordLink: "https://discord.gg/crowbarcollective";
    property var globalTimer: Timer {}

    // Used when user open console
    property bool disableUINavigation: false;

    // Delay function implementation ( Qt does not have own setTimeout func like in Javascript )
    function setTimeout(cb, delay) {
        globalTimer.interval = delay;
        globalTimer.repeat = false;
        globalTimer.triggered.connect(cb);
        globalTimer.triggered.connect(function release () {
            globalTimer.triggered.disconnect(cb); // This is important
            globalTimer.triggered.disconnect(release); // This is important as well
        });
        globalTimer.start();
    }
    // ----------------------------
    // Saved games
    // ----------------------------
    property var savedGameNameRegex: /^(autosave|quick)\d*$/;

    function getSaveGames() {
        var data = (BlackMesaEngine.listSaveEntries() || []).sort(function (a, b) {
                return new Date(b.dateCreated) - new Date(a.dateCreated);
            }).map(function (save) {
                var type = "manual",
                    match = save.name.match(/^(autosave|quick)\d*$/);

                if (match) {
                    type = match[1];
                }

                return {
                    savename: save.name,
                    chapter: Number((save.chapter.match(/Chapter(\d+)?/m) || [])[1] || "-1"),
                    chapterName: L10n.getString(save.chapter.replace("#bms_", "#QTUI_Maps_")),
                    type: type,
                    dateCreated: new Date(save.dateCreated),
                    thumbnail: save.thumbnailUrl
                };
            });

        return data;
    }

    function saveGame(filename, callback) {
        var lastManualSave,
            saveNumber,
            padding = "";

        if (typeof filename !== "string" || !filename.length) {
            lastManualSave = getSaveGames().find(function (save) {
                return save.savename.indexOf("bms-") === 0;
            });

            saveNumber = 0;
            if (lastManualSave) {
                saveNumber = Number((lastManualSave.savename.match(/bms-(\d+)?/m) || [])[1] || "-1");
                saveNumber++;
            }

            switch (saveNumber.toString().length) {
                case 1: padding = "00"; break;
                case 2: padding = "0"; break;
            }

            filename = "bms-" + padding + saveNumber.toString();
        }

        BlackMesaEngine.executeClientCommandUnrestricted("gameui_hide;save " + filename);
        // Game saved, restore state of ui
        callback();
    }

    function loadGame(filename) {
        BlackMesaEngine.executeClientCommandUnrestricted("disconnect;wait;wait;sv_cheats 0; maxplayers 1; load " + filename);
    }

    function loadMap(filename) {
        BlackMesaEngine.executeClientCommandUnrestricted("disconnect;wait;wait;sv_cheats 0; maxplayers 1; map " + filename);
    }


    /**
     * UI Navigation handling:
     *
     *  The code below works is:
     *
     *      1. Clicks on a new tab (or sub tab) that changes the elements on screen.
     *
     *      2. clearUIElementsData() is called to clean out state that exists here.
     *
     *      3. traverseUIElements() is called from the root which runs a bunch of
     *         regular expressions to parse navigation relevant UI elements.
     */
    property var uiStackViewRegex: new RegExp(/^QQuickStackView.*$/);
    property var stackViewReference: null;

    property var currentElement: null;
    property var previousElement: null;
    property var isTraversalBlocked: false;

    // Tabs variables
    property var tabs: [];

    property int tabsMainStartIndex: -1;
    property int tabsSubStartIndex: -1;
    property int tabsSubNavStartIndex: -1;

    property int tabsMainIndex: -1;
    property int tabsSubIndex: -1;
    property int tabsSubNavIndex: -1;

    // This is number of main menu tabs
    // TODO: Need to find way to get model of main tabs and retrieve count from model
    // for future purposes if we will add/remove main tabs
    property int mainTabsCount: 5

    // Three types of actions - apply, cancel, discard
    property var uiBtnRegex: new RegExp(/^ui:btn:action\[(.*)\]$/);
    property var actionButtons: ({
        APPLY: [],
        CANCEL: [],
        DISCARD: [],
        QUIT: [],
        BACK: []
    });

    // Option list items properties
    property var uiOptionItemRegex: new RegExp(/^ui:option-item\[(.+)\]$/);
    property var optionItems: [];
    property int optionItemIndex: 0;

    // Clears ui elements state
    function clearUIElementsData() {
        isTraversalBlocked = true;
        stackViewReference = null;
        tabs = [];

        tabsSubStartIndex = -1;
        tabsSubNavStartIndex = -1;

        optionItems = [];
        optionItemIndex = -1;

        actionButtons.CANCEL = null;
        actionButtons.APPLY = null;
        actionButtons.DISCARD = null;
    }

    /**
     * Uses a bunch of regular expressions to parse the current screen
     * for navigation relevant items.
     */
    function traverseUIElements(root) {
        var items = root.children;

        // This one critical, because StackView is holding
        // more than one screen in children elements ( ui routes )
        // this cause parsing of elements that not exist on current 
        // selected route. So we use currentItem instead, that holds only
        // current selected route in stack, so ui items match only that route.
        if (uiStackViewRegex.exec(root)) {
            items = root.currentItem.children;
            stackViewReference = root;
        }

        const tabItem = root.objectName && root.objectName === "ui:tab";
        const buttonItem = root.objectName && uiBtnRegex.exec(root.objectName);
        const optionItem = root.objectName && root.objectName === "ui:option-item";
        const carouselItem = root.objectName && root.objectName === "ui:carousel-item";

        // Process tab ( menu tabs ) items
        if (tabItem && !root.disabled) {
            // Exclude steamworkshop browse tab from actions
            // because it cause unfocus and we can not close steam ui from controller.
            // TODO: Find solution for that
            if (root.actionRoute !== "browse") {
                tabs.push(root);
            }
        } else if (buttonItem && root.visible) {
            // Process button items
            const type = buttonItem[1];

            if ( type === "cancel" ) {
                actionButtons.CANCEL = root;
            }

            if ( type === "apply" ) {
                actionButtons.APPLY = root;
            }

            if ( type === "discard" ) {
                actionButtons.DISCARD = root;
            }

            if( type === "quit" ) {
                actionButtons.QUIT = root;
            }

            if( type === "back" ) {
                actionButtons.BACK = root;
            }
        } else if (optionItem) {
            // Process option list items
            optionItems.push(root);
        } else if (carouselItem) {
            // Process carousel items of new game, load game,
            // save game menus and workshop menu items
            optionItems.push(root);
        }

        if (items && items.length) {
            for (var i = 0; i < items.length; ++i) {
                traverseUIElements(items[i]);
            }
        }
    }

    /**
     * Called after the current screen is parsed for navigation relevant items.
     */
    function afterTraverseCallback() {
        try {
            if (tabs.length) {
                tabs.reduce(function(acc, item, index) {
                    if (item.type === "sub" && tabsSubStartIndex === -1) {
                        tabsSubStartIndex = index;
                    }
                    if (item.type === "sub-nav" && tabsSubNavStartIndex === -1) {
                        tabsSubNavStartIndex = index;
                    }
                }, []);

                // Check if we have sub tabs navigation
                if (tabsSubStartIndex !== -1 && currentElement && currentElement.objectName === "ui:tab" && currentElement.type === "main") {
                    tabsSubIndex = tabsSubStartIndex;
                }

                // Check if we have sub-nav tabs navigation ( inside specific route )
                if (tabsSubNavStartIndex !== -1 && currentElement && currentElement.objectName === "ui:tab" && currentElement.type === "sub") {
                    tabsSubNavIndex = tabsSubNavStartIndex;
                }
            }

            if (optionItems.length) {
                if ( optionItems[0].objectName === "ui:carousel-item" || optionItems[0].objectName === "ui:option-item" ) {
                    if (optionItemIndex == -1 || optionItems[optionItemIndex])
                        optionItemIndex = 0;

                    currentElement = optionItems[optionItemIndex];
                    updateCurrentUISelection();
                }
            }
        } catch (error) {
            // TODO: Handle errors here
        }
        
        isTraversalBlocked = false;
    }

    function processOptionSelection(sign) {
        if (sign)
            optionItemIndex++;
        else
            optionItemIndex--;

        if (optionItemIndex < 0) {
            optionItemIndex = optionItems.length - 1;
        }

        if (optionItemIndex > optionItems.length - 1) {
            optionItemIndex = 0;
        }

        if (optionItems[optionItemIndex].state === "disabled") {
            processOptionSelection(sign);
        }

        currentElement = optionItems[optionItemIndex];
    }

    function processCarouselItemSelection(sign) {
        var previousIndex = optionItemIndex;
        if (sign) {
            if (optionItemIndex < optionItems.length - 1)
                optionItemIndex++;
        } else {
            if (optionItemIndex > 0)
                optionItemIndex--;
        }

        const carouselContainer = optionItems[optionItemIndex].parent.parent;
        const totalItems = carouselContainer.model.count; 
        const visibleCount = carouselContainer.parent.parent.visibleCount;

        // Handle pagination of carousel
        if (!sign && ( (previousIndex % 4) < (optionItemIndex % 4) )) {
            // left carousel arrow
            const leftCarouselArrow = carouselContainer.parent.parent.children[0];
            const isLeftPaginationEnabled = leftCarouselArrow.enabled;
            if (isLeftPaginationEnabled) {
                leftCarouselArrow.clicked(null);
            }
        }

        if (sign && ( (previousIndex % 4) > (optionItemIndex % 4) )) {
            // right carousel arrow
            const rightCarouselArrow = carouselContainer.parent.parent.children[2];
            const isRightPaginationEnabled = rightCarouselArrow.enabled;
            if (isRightPaginationEnabled) {
                rightCarouselArrow.clicked(null);
            }
        }

        currentElement = optionItems[optionItemIndex];
    }

    function processTabsNavigation(sign) {
        try {
            const totalTabs = tabs.length;
            var currentSelectedTab = null;

            if (tabsMainStartIndex == -1) {
                tabsMainStartIndex = 0;
                tabsMainIndex = 0;
            }

            if (tabsMainIndex > mainTabsCount - 1) {
                tabsMainIndex = 0;
            }

            if (tabsMainIndex < 0) {
                tabsMainIndex = mainTabsCount - 1;
            }

            currentSelectedTab = tabs[tabsMainIndex];

            // Check if we have tabs for sub menu
            if (tabsSubStartIndex !== -1 && tabs[tabsSubIndex]) {
                currentSelectedTab = tabs[tabsSubIndex];
            }

            // Check if we have tabs inside our route view
            if (tabsSubNavStartIndex != -1 && tabs[tabsSubNavIndex]) {
                currentSelectedTab = tabs[tabsSubNavIndex];
            }

            // Process tab index increment / decrement logic
            if (currentSelectedTab) {
                switch (currentSelectedTab.type) {
                    case "main": {
                        // If we don't have sub tabs we will have current element and prev element as main tab,
                        // so we need to check manually if it not goes out of boundaries and suits our conditions
                        if (previousElement && previousElement.objectName === "ui:tab" && previousElement.type === "main")
                            sign ? tabsMainIndex != (mainTabsCount - 1) && tabsMainIndex++ : tabsMainIndex != 0 && tabsMainIndex--;
                        break;
                    }
                    case "sub": {
                        sign ? tabsSubIndex++ : tabsSubIndex--;
                        break;
                    }
                    case "sub-nav": {
                        sign ? tabsSubNavIndex++ : tabsSubNavIndex--;
                        break;
                    }
                }
            }

            // Process sub tabs navigation
            if (currentSelectedTab && currentSelectedTab.type === "sub") {
                // Check if we pass first available sub tab
                if ( tabsSubIndex < tabsSubStartIndex ) {
                    tabsMainIndex--;
                    tabsSubStartIndex = -1;
                    tabsSubNavStartIndex = -1;
                    processTabsNavigation(0);
                    return;
                }

                // Check if we pass last available sub tab
                if (
                    tabsSubNavStartIndex == -1 && tabsSubIndex > (totalTabs - 1) ||
                    tabsSubNavStartIndex !== -1 && tabsSubIndex > tabsSubNavStartIndex - 1
                ) {
                    tabsMainIndex++;
                    tabsSubStartIndex = -1;
                    tabsSubNavStartIndex = -1;
                    processTabsNavigation(1);
                    return;
                }

                currentElement = tabs[tabsSubIndex];
                return;
            }

            // Process sub-nav tabs ( third level of tabs )
            if (currentSelectedTab && currentSelectedTab.type === "sub-nav") {
                if (tabsSubNavIndex < tabsSubNavStartIndex) {
                    processTabsNavigation(0);
                    return;
                }

                if (tabsSubNavIndex > (totalTabs - 1)) {
                    processTabsNavigation(1);
                    return;
                }

                currentElement = tabs[tabsSubNavIndex];
                return;
            }

            currentElement = tabs[tabsMainIndex];
        } catch (error) {
            // TODO: Handle tabs navigation error
        }
    }

    /**
     * Called by Keys.onPressed in main.qml.
     */
    function navigationUIHandle(event) {
        if (isTraversalBlocked)
            return;

        /**
         * Handle navigation input here. Note: the ordering we check things
         * in matters! This function centralizes all navigation logic. So
         * higher priority items recieve input first. Priority is in descending
         * order.
         */
        switch (event.key) {
            /* TODO: Because source engine don't fire ESC key event
             * we can not see it in QT so need to figure out how to make it work.
             */
            case Qt.Key_Escape: {
                break;
            }

            case Qt.Key_Enter: {
                if (currentElement && currentElement.objectName === "ui:option-item" && currentElement.type === "join") {
                    currentElement.doubleClicked(null);
                    currentElement = null;
                    return;
                }

                // If we on carousel item -> process apply button
                if (currentElement && currentElement.objectName === "ui:carousel-item") {
                    currentElement.selected();
                    currentElement = null;
                    return;
                }

                // If we on binding cell -> process binding logic.
                if (currentElement && currentElement.type === "binding") {
                    currentElement.children[1].clicked(event);
                    return;
                }

                // Otherwise: consider this a generic 'apply' button press.
                if (actionButtons.APPLY) {
                    actionButtons.APPLY.clicked(null);
                    return;
                }

                break;
            }
            case Qt.Key_Backspace: {
                const bIsInGame = BlackMesaEngine.isInGame() &&
                                !BlackMesaEngine.isLevelMainMenuBackground();

                /* Priority 0: If we are running around in game and someone hits backspace
                 * (or 'b' on the controller), close the game ui. If we don't handle this
                 * here, we will instead, disconnect which is probably not what players
                 * want when they want to go 'back' to the game.
                 */
                if(bIsInGame) {
                    BlackMesaEngine.executeClientCommand('gameui_hide');
                    return;
                }

                /* Priority 1: If we have an active 'DISCARD' button on the screen,
                 * then pass navigation off to that.
                 */
                if (actionButtons.DISCARD && !actionButtons.DISCARD.disabled) {
                    actionButtons.DISCARD.clicked(null);
                    return;
                }

                /* Priority 2: If we have an active 'CANCEL' button on the screen,
                 * then pass navigation off to that.
                 */
                if (actionButtons.CANCEL && !actionButtons.CANCEL.disabled) {
                    actionButtons.CANCEL.clicked(null);
                    return;
                }

                /* Priority 3: If we have an active 'BACK' button on the screen,
                 * then pass navigation off to that.
                 */
                if (actionButtons.BACK && !actionButtons.BACK.disabled) {
                    actionButtons.BACK.clicked(null);
                    return;
                }

                break;
            }
            // ----------------------------------
            // Navigate tabs ( left / right )
            case Qt.Key_A: {
                processTabsNavigation(0);
                break;
            }
            case Qt.Key_D: {
                processTabsNavigation(1);
                break;
            }
            // ----------------------------------
            // Navigate option lists ( up / down )
            case Qt.Key_Up: {
                processOptionSelection(0)
                break;
            }
            case Qt.Key_Down: {
                processOptionSelection(1)
                break;
            }
            // ----------------------------------
            // Change options in option lists
            case Qt.Key_Left: {
                if (currentElement.type && currentElement.type === "join") {
                    return;
                }

                if (currentElement.type && currentElement.type === "select") {
                    currentElement.children[0].visible && currentElement.children[0].clicked(null);
                    break;
                }

                if (currentElement.type && currentElement.type === "slider") {
                    var currentValue = parseFloat(currentElement.model.value);
                    var minValue = parseFloat(currentElement.model.minValue);

                    if (currentValue > minValue) {
                        var valueDiff = currentValue - currentElement.model.stepValue;
                        currentElement.requestSettingsChange(currentElement.model, valueDiff.toString());
                    }
                    break;
                }

                if (currentElement.type && currentElement.type === "map") {
                    currentElement.children[0].children[0].clicked(null);
                    break;
                }

                if (currentElement.type && currentElement.type === "checkbox") {
                    currentElement.children[0].children[0].clicked(null);
                    break;
                }

                processCarouselItemSelection(0);

                break;
            }
            case Qt.Key_Right: {
                if (currentElement.type && currentElement.type === "join") {
                    return;
                }

                if (currentElement.type && currentElement.type === "select") {
                    currentElement.children[3].visible && currentElement.children[3].clicked(null);
                    break;
                }

                if (currentElement.type && currentElement.type === "slider") {
                    var currentValue = parseFloat(currentElement.model.value);
                    var maxValue = parseFloat(currentElement.model.maxValue);

                    if (currentValue < maxValue) {
                        var valueDiff = currentValue + currentElement.model.stepValue;
                        currentElement.requestSettingsChange(currentElement.model, valueDiff.toString());
                    }
                    break;
                }

                if (currentElement.type && currentElement.type === "map") {
                    currentElement.children[2].children[0].clicked(null);
                    break;
                }

                if (currentElement.type && currentElement.type === "checkbox") {
                    currentElement.children[0].children[0].clicked(null);
                    break;
                }

                processCarouselItemSelection(1);

                break;
            }
            // ----------------------------------
        }

        updateCurrentUISelection();
    }

    function updateCurrentUISelection() {
        try {
            if (disableUINavigation)
                return;

            if (previousElement && previousElement.objectName === "ui:option-item") {
                if (previousElement.type === "binding") {
                    previousElement.children[1].state = "blurred"; 
                } else if (currentElement.type === "join") {
                    previousElement.state = "blurred";
                } else {
                    previousElement.parent.parent.state = "blurred";
                }
            }

            if (previousElement && previousElement.objectName === "ui:carousel-item") {
                previousElement.children[2].state = "blurred";
            }

            if (currentElement && currentElement.objectName === "ui:option-item") {
                if (currentElement.type === "binding") {
                    currentElement.children[1].state = "focused"; 

                    if (/ListView/.test(currentElement.parent.parent.parent.parent.parent.parent.parent.parent)) {
                        currentElement.parent.parent.parent.parent.parent.parent.parent.parent.positionViewAtIndex(optionItemIndex, ListView.Visible);
                    }
                } else if (currentElement.type === "join") {
                    currentElement.state = "focused";

                    if (/GridView/.test(currentElement.parent.parent)) {
                        currentElement.parent.parent.positionViewAtIndex(optionItemIndex, GridView.Center);
                    }
                } else {
                    currentElement.parent.parent.state = "focused";

                    if (/ListView/.test(currentElement.parent.parent.parent.parent.parent)) {
                        currentElement.parent.parent.parent.parent.parent.positionViewAtIndex(optionItemIndex, ListView.Center);
                    }
                }
            }

            if (currentElement.objectName && currentElement.objectName === "ui:tab") {
                currentElement.clicked(null);
            }

            if (currentElement.objectName && currentElement.objectName === "ui:carousel-item") {
                currentElement.children[2].state = "focused";
            }

            previousElement = currentElement;
        } catch (error) {
            // TODO: Handle errors here
        }
    }
}
