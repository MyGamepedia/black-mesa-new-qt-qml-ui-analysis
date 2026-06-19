pragma Singleton

import QtQuick 2.9
import CrowbarCollective 1.0

QtObject {
    // Used to determine keyboard/joystick or mouse used in menu
    property var traverse_level_0: 0;
    property var traverse_level_1: 1;
    property var traverse_level_2: 2;
    property var traverse_level_3: 3;

    property var currentFocusedItem: null;
    property var traversalDepth: 0;
    property var indexIterator: -1;
    // Used to store ui item index when traversal depth is changed.
    //For example when you navigate from main menu item to sub-menu item
    property var lastTraversalDepthIndex: ({ 0: 0, 1: 0, 2: 0, 3: 0 });
    // Used for determine depth level of ui elements traverce
    // 0 - main menu depth
    // 1 - submenu depth
    // 2 - all rest elements placed on current route view
    property var navigationTree: ({ 0: [], 1: [], 2: [], 3: [] });

    property var uiButtonRegex: /ui\-\-navigation\:button\:.*/g;
    property var uiCarouselRegex: /ui\-\-navigation\:carousel\:.*/g;
    property var uiOptionItemRegex: /ui\-\-navigation\:option\-item\:.*/g;
    property var uiTraverseRegex: /^ui\-\-navigation\:(.*)\:level_(\d)$/g;
    property var uiBindingOptionRegex: /ui\-\-navigation\:binding\:.*/g;
    property var uiBindingCellRegex: /ui\-\-navigation\:binding\-cell\:.*/g;

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

    function isButtonItem() {
        return new RegExp(uiButtonRegex).exec(currentFocusedItem.objectName) !== null;
    }

    function isCarouselItem() {
        return new RegExp(uiCarouselRegex).exec(currentFocusedItem.objectName) !== null;
    }

    function isOptionItem() {
        return new RegExp(uiOptionItemRegex).exec(currentFocusedItem.objectName) !== null;
    }

    function isBindingOption() {
        return new RegExp(uiBindingOptionRegex).exec(currentFocusedItem.objectName) !== null;
    }

    function isBindingCell() {
        return new RegExp(uiBindingCellRegex).exec(currentFocusedItem.objectName) !== null;
    }

    /**
      * Clears traverse tree elements from navigation.
      *
      * @param - levels - array of traverse levels to clear.
      * If not provided all levels are cleared.
      */
    function clearTraversalTree(levels) {
        var levelsToClear = [0, 1, 2, 3];

        if (levels && levels.length) {
            levelsToClear = levels;
        }

        for (var i = 0; i < levelsToClear.length; ++i) {
            navigationTree[levelsToClear[i]] = [];
        }

        currentFocusedItem = null;
        indexIterator = 0;
    }


    // Used for get check is carousel item visible or not. 
    function isAABB(p1, p2) {
        return (p1.x_1 >= p2.x_1 && p1.x_1 <= p2.x_2) || (p1.x_2 >= p2.x_1 && p1.x_2 <= p2.x_2);
    }
    /**
      *
      */
    property var regexGroups: null;
    property var level: 0;
    property var currentItem: null;
    function parseTraversalTree(root) {
        if (root.children && root.children.length) {
                var items = root.children;

                for (var i = 0; i < items.length; ++i) {
                    currentItem = items[i];

                    regexGroups = new RegExp(uiTraverseRegex).exec(currentItem.objectName);

                    // Check if current iterable item is visible and not disabled.
                    if (currentItem.visible) {
                        var isListView = new RegExp(/^QQuickListView.*$/g).exec(currentItem) !== null;
                        if (isListView && currentItem.objectName === "ui--navigation:carousel-container") {
                            var len = currentItem.contentItem.visibleChildren.length;
                            var w = [];
                            for (var j = 0; j < len; ++j) {
                                var item = currentItem.contentItem.visibleChildren[j];
                                if (typeof item !== 'undefined' && new RegExp(uiCarouselRegex).exec(item.objectName) !== null) {
                                    var p1 = { x_1: item.x, x_2: item.x+item.width };
                                    var p2 = { x_1: currentItem.contentX, x_2: currentItem.contentX+currentItem.width };

                                    if (isAABB(p1, p2)) {
                                        w.push(item);
                                    }
                                }
                            }

                            w = w.sort(function(a, b) { return a.x - b.x })
                            // TODO: For now ui has only carousels on level #2 of ui depth, so use that constant
                            navigationTree[traverse_level_2] = navigationTree[traverse_level_2].concat(w);
                        } else {
                            // Find out if our current ui item match naming criteria
                            if (regexGroups !== null) {
                                // Find out what depth level of ui is used by element
                                level = regexGroups[2];
                                navigationTree[level].push(currentItem);
                            }
                        }
                    }

                    parseTraversalTree(currentItem)
                }
        }
    }

    property var tempCarouselIndex: 0;
    function processCarouselLogic(type) {
        var carouselContainter = currentFocusedItem.parent.parent;
        var maxItems = carouselContainter.limit - 1;

        // To right
        if ( type === 1) {
            var isEndOfSlides = (carouselContainter.count - (carouselContainter.currentIndex + tempCarouselIndex) + 1) < 0;
            if (isEndOfSlides) {
                return;
            }

            ++tempCarouselIndex;
            traverseForward();
            updateCurrentUISelection();

            if (tempCarouselIndex > maxItems) {
                clearTraversalTree([2]);
                tempCarouselIndex = 0;
                indexIterator = 0;
                carouselContainter.parent.parent.changePagination(type);
            }
        }

        if ( type === -1 ) {
            var isEndOfSlides = carouselContainter.currentIndex === 0 && tempCarouselIndex < 1;
            if (isEndOfSlides) {
                return;
            }

            --tempCarouselIndex;
            traverseBackward();
            updateCurrentUISelection();

            if (tempCarouselIndex < 0) {
                clearTraversalTree([2]);
                tempCarouselIndex = maxItems;
                indexIterator = maxItems;
                carouselContainter.parent.parent.changePagination(type);
            }
        }

        return;
    }

    /**
      * Used to navigate trough ui elements
      * -----------------------------------
      * Up & Down used to switch between depth of ui traversal i.e. levels of depth (0, 1, 2, 3)
      * level_0 - Main menu and footer ui elements ( mostly buttons )
      * level_1 - Main menu submenu ui elements ( buttons, but they dynamically changing while user change main menu sections )
      * level_2 - Current screen section ui elements ( current router view ) i.e. rows, sliders, select boxes, text inputs, 
      * level_3 - Used for alert boxes and information boxes ( for quit or apply buttons )
      */
    function navigationUIHandle(event) {
        // Go back trough navigation depth
        if (event.key === Qt.Key_Escape) {
            changeTraversalDepth(true);
            updateCurrentUISelection();
            return;
        }

        // Handle Enter key on ui elements
        // this one provides functionality to press buttons
        if (event.key === Qt.Key_Enter) {
            if (isButtonItem() || isCarouselItem() || isBindingOption()) {
                currentFocusedItem.callback();
            }

            if (isBindingCell()) {
                currentFocusedItem.children[currentFocusedItem.children.length - 1].callback();
            }


            return;
        }

        if (event.key === Qt.Key_Up) {
            // TODO: Temporary disable navigation for up/down because
            // of issue with ListView component.
            if (isBindingCell()) {
                return;
            }

            if (isOptionItem() || isBindingOption()) {
                traverseBackward();
            } else {
                changeTraversalDepth(true);
            }

            updateCurrentUISelection();
            return;
        }

        if (event.key === Qt.Key_Down) {
            // TODO: Temporary disable navigation for up/down because
            // of issue with ListView component.
            if (isBindingCell()) {
                return;
            }

            if (isOptionItem() || isBindingOption()) {
                traverseForward();
            } else {
                changeTraversalDepth(false);
            }
            
            updateCurrentUISelection();
            return;
        }


        /**
          * Provides navigation to left-right on ui elements
          * used on main menu / submenu also elements that positioned horizontally
          */
        if (event.key === Qt.Key_Left) {
            if (isOptionItem())
                return;

            if (isCarouselItem()) {
                processCarouselLogic(-1);
                return;
            }

            if (isBindingOption()) {
                return;
            }

            traverseBackward();
            updateCurrentUISelection();

            return;
        }

        if (event.key === Qt.Key_Right) {
            if (isOptionItem())
                return;

            if (isCarouselItem()) {
                processCarouselLogic(1);
                return;
            }

            if (isBindingOption()) {
                changeTraversalDepth(false);
                updateCurrentUISelection();
                return;
            }

            traverseForward();
            updateCurrentUISelection();

            return;
        }
    }

    /**
      * Provides functionality for changing depth of ui traversal.
      * @reversed - boolean. When true - will go up by 1 level, when false - go down by 1 level.
      */
    function changeTraversalDepth(reversed) {
        //BlackMesaEngine.printConsoleMessage("yellow", "Current depth: "+traversalDepth+" current index: "+indexIterator+"\n");
        //lastTraversalDepthIndex[traversalDepth] = indexIterator;

        if (reversed) {
            if (traversalDepth > 0) {
                --traversalDepth;
            }
        } else {
            if (traversalDepth < 3) {
                ++traversalDepth;
            }
        }

        if (!navigationTree[traversalDepth].length) {
            changeTraversalDepth(reversed);
        }

        indexIterator = 0;//lastTraversalDepthIndex[traversalDepth];

        if (!navigationTree[traversalDepth][indexIterator].visible) {
            traverseForward();
        }
    }
    /**
      * We move left/right on menus or up/down on screens with lists
      * for example on options for audio or video screens.
      */
    function traverseForward() {
        ++indexIterator;
        var navigationItems = navigationTree[traversalDepth];

        if (indexIterator > navigationItems.length - 1) {
            indexIterator = 0;
        }

        if (!navigationItems[indexIterator].visible || navigationItems[indexIterator].disabled) {
            traverseForward();
        }

        //lastTraversalDepthIndex[traversalDepth] = indexIterator;
    }

    function traverseBackward() {
        --indexIterator;

        var navigationItems = navigationTree[traversalDepth];

        if (indexIterator < 0) {
            indexIterator = navigationTree[traversalDepth].length - 1;
        }

        if (!navigationItems[indexIterator].visible || navigationItems[indexIterator].disabled) {
            traverseBackward();
        }

        //lastTraversalDepthIndex[traversalDepth] = indexIterator;
    }

    function updateCurrentUISelection() {
        // Prevents deselection of button if already active ( when you navigate trough menu items )
        if (currentFocusedItem !== null && !currentFocusedItem.selected && !currentFocusedItem.disabled) {
            if (isButtonItem() || isBindingCell()) {
                // TODO: Hack, but no other options for now, the state of button is stored in
                // latest child item of button ( MouseArea ), should be reworked
                currentFocusedItem.children[currentFocusedItem.children.length - 1].state = "blurred";
            }
            if (isBindingOption()) {
                currentFocusedItem.state = "blurred";
            }
        }

        // Selects a new focused item
        currentFocusedItem = navigationTree[traversalDepth][indexIterator];

        if (isOptionItem()) {
            currentFocusedItem.parent.parent.parent.parent.parent.positionViewAtIndex(indexIterator, ListView.Center);
        }

        if (!currentFocusedItem.selected && !currentFocusedItem.disabled) {
            if (isButtonItem() || isBindingCell()) {
                // TODO: Hack, but no other options for now, the state of button is stored in
                // latest child item of button ( MouseArea ), should be reworked
                currentFocusedItem.children[currentFocusedItem.children.length - 1].state = "focused";
            }

            if (isBindingOption()) {
                currentFocusedItem.state = "focused";
            }
        }

        // Apply focus to new selected item
        currentFocusedItem.forceActiveFocus();
    }
}
