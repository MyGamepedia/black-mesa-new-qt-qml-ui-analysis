pragma Singleton

import QtQuick 2.9
import CrowbarCollective 1.0

QtObject {
    // Used to determine keyboard/joystick or mouse used in menu
	// ^LIES!!! Controller simply emulates keyboard keys!
    property var globalTimer: Timer {}
	
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
	
    property var traverse_level_1: 1;
    property var traverse_level_2: 2;
    property var traverse_level_3: 3;
    property var traverse_level_4: 4;

    property var currentFocusedItem: null;
    property var traversalDepth: 2;
    property var indexIterator: -1;
	property int addedIndx;
    // Used when user open console
    property bool disableUINavigation: false;
    // Used to store ui item index when traversal depth is changed.
    //For example when you navigate from main menu item to sub-menu item
    property var lastTraversalDepthIndex: ({ 1: 0, 2: 0, 3: 0, 4: 0 });
    // Used for determine depth level of ui elements traverce
    // 1 - Left menu depth when submenu is opened
    // 2 - main selection (autohighlights on menu open)
	// 3 - secondary main selection (bindings second row etc.)
	// 4 - alerts
    property var navigationTree: ({ 1: [], 2: [], 3: [], 4: [] });

    property var uiBSButtonRegex: /ui\-\-navigation\:bsbutton\:.*/g;
    property var uiBSTabRegex: /ui\-\-navigation\:bstab\:.*/g;
    property var uiButtonRegex: /ui\-\-navigation\:button\:.*/g;
    property var uiCarouselRegex: /ui\-\-navigation\:carousel\:.*/g;
    property var uiOptionItemRegex: /ui\-\-navigation\:option\-item\:.*/g;
    property var uiOtherItemRegex: /ui\-\-navigation\:other\-item\:.*/g;
    property var uiTraverseRegex: /^ui\-\-navigation\:(.*)\:level_(\d)$/g;
    property var uiBindingCellLeftRegex: /ui\-\-navigation\:binding\-cellleft\:.*/g;
    property var uiBindingCellRightRegex: /ui\-\-navigation\:binding\-cellright\:.*/g;

    // ----------------------------
    // Saved games
    // ----------------------------
    property var savedGameNameRegex: /^(autosave|quick)\d*$/;
	
    function getChapterTitle(chapterName) {
        var chapterNumber = Number((chapterName.match(/c(\d+)m/m) || [])[1] || "-1")
        return L10n.getString("#bshift_Chapter"+(chapterNumber+1)+"_Title")
    }
    
       function getKeyIcon(key) {
            if ( key !== "\\") {
				//Turkish workaround fix for "question." instead of [A]
				if (key === "a" ) {
					return "A"
				} else {
					return key ? L10n.getString("#"+ key) : key
				}
			}
            else {
                return key
			}
        }

    function getSaveGames() {
        var data = (BlackMesaEngine.listSaveEntries() || []).sort(function (a, b) {
                return new Date(b.dateCreated) - new Date(a.dateCreated);
            }).map(function (save) {
                var type = "manual",
                    match = save.name.match(/^(autosave|quick)\d*$/);

                if (match) {
                    type = match[1];
                }

                var chapterNumber = Number((save.chapter.match(/c(\d+)m/m) || [])[1] || "-1")
		
                return {
                    savename: save.name,
                    chapter: chapterNumber,
                    chapterName: getChapterTitle(save.chapter),
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
                return save.savename.indexOf("bs-") === 0;
            });

            saveNumber = 0;
            if (lastManualSave) {
                saveNumber = Number((lastManualSave.savename.match(/bs-(\d+)?/m) || [])[1] || "-1");
                saveNumber++;
            }

            switch (saveNumber.toString().length) {
                case 1: padding = "00"; break;
                case 2: padding = "0"; break;
            }

            filename = "bs-" + padding + saveNumber.toString();
        }

        var drawhud = BlackMesaEngine.getConsoleVariableAsString("cl_drawhud");
        var drawvm = BlackMesaEngine.getConsoleVariableAsString("r_drawviewmodel");
        BlackMesaEngine.executeClientCommandUnrestricted("gameui_hide;cl_drawhud 0;r_drawviewmodel 0;wait;wait;wait;wait;save " + filename + ";cl_drawhud " + Number(drawhud) + ";r_drawviewmodel " + Number(drawvm));
        // Game saved, restore state of ui
        callback();
    }

    function loadGame(filename) {
        BlackMesaEngine.executeClientCommandUnrestricted("wait;wait;disconnect;wait;wait;sv_cheats 0; maxplayers 1; load " + filename);
    }

    function loadMap(filename) {
        BlackMesaEngine.executeClientCommandUnrestricted("wait;wait;disconnect;wait;wait;sv_cheats 0; maxplayers 1; map " + filename);
    }

    function isBSButtonItem() {
        return new RegExp(uiBSButtonRegex).exec(currentFocusedItem.objectName) !== null;
    }

    function isBSTabItem() {
        return new RegExp(uiBSTabRegex).exec(currentFocusedItem.objectName) !== null;
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
	
    function isOtherItem() {
        return new RegExp(uiOtherItemRegex).exec(currentFocusedItem.objectName) !== null;
    }

    function isBindingCellLeft() {
        return new RegExp(uiBindingCellLeftRegex).exec(currentFocusedItem.objectName) !== null;
    }

    function isBindingCellRight() {
        return new RegExp(uiBindingCellRightRegex).exec(currentFocusedItem.objectName) !== null;
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
						
						if (regexGroups !== null) {
                            // Find out if our current ui item match naming criteria
                                // Find out what depth level of ui is used by element
                                level = regexGroups[2];
                                navigationTree[level].push(currentItem);
                        }
						
						
                    }

                    parseTraversalTree(currentItem)
                }
        }
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
        //LIST OF CONTROLLER/KEYBOARD KEYCODES  needed for BMQTUI
        //
        //	33554431	-	Key_unknown	(Including Escape in bm)								(and every last button has this code)
        //
        //	16777221	-	Enter (A Button)						(Already bound to keyboard Enter key)
        //	16777216	-	Key_Escape (B Button)					(Already bound to keyboard Escape key)

        //	16777235	-	Key_Up (Up Button)						(Already bound to keyboard navigation keys)
        //	16777237	-	Key_Down (Down Button)					(Already bound to keyboard navigation keys)
        //	16777234	-	Key_Left (Left Button)					(Already bound to keyboard navigation keys)
        //	16777236	-	Key_Right (Right Button)				(Already bound to keyboard navigation keys)
        //
		
        // Handle Enter key on ui elements
        // this one provides functionality to press buttons
        if (event.key === Qt.Key_Enter) {
		
            if ( traversalDepth === 4 ) {
                Sound.playEffect("sndclick");
                currentFocusedItem.callback();
                indexIterator = 0;
                processCarouselLogic();
                traversalDepth = 2;
                lastTraversalDepthIndex[traversalDepth] = indexIterator;
                updateCurrentUISelection();
                return;
            }
		
            if ( isBSButtonItem() ) {
                Sound.playEffect("sndclick");
                lastTraversalDepthIndex[traversalDepth] = indexIterator;
                currentFocusedItem.callback();
                return;
            }
            
            if ( isButtonItem() ) {
                Sound.playEffect("sndclick");
                currentFocusedItem.callback();
                indexIterator = 0;
                updateCurrentUISelection();
                return;
            }
            
            
            if ( isBSTabItem() ) {
                currentFocusedItem.callback();
                updateCurrentUISelection();
                return;
            }
            
            if ( isCarouselItem() ) {
                currentFocusedItem.callback();
                return;
            }
            
            if (isBindingCellLeft() || isBindingCellRight()) {
			
                Sound.playEffect("sndclick");
                lastTraversalDepthIndex[traversalDepth] = indexIterator;
                currentFocusedItem.children[currentFocusedItem.children.length - 1].callback();
                return;
            }
			
			
            updateCurrentUISelection();
            return;
        }

        if (event.key === Qt.Key_Up) {
            // TODO: Temporary disable navigation for up/down because
            // of issue with ListView component.
            if ( isBindingCellLeft() || isBindingCellRight() ) {
                return;
            }
            
            if ( isButtonItem() || isBSButtonItem() || isBSTabItem()  || isOptionItem() || isOtherItem() || isCarouselItem() ) {
			
                if ( isOptionItem() || isOtherItem() ) {
					addedIndx = -1;
					
					if (isOtherItem() && currentFocusedItem.linkDisabled ) {
						currentFocusedItem.linkDisabled = false;
					}
                } else if ( isCarouselItem() ) {
					addedIndx = -1;
				}
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
            if ( isBindingCellLeft() || isBindingCellRight() ) {
                return;
            }

            if ( isButtonItem() || isBSButtonItem() || isBSTabItem()  || isOptionItem() || isOtherItem() || isCarouselItem() ) {
			
                if ( isOptionItem() || isOtherItem() ) {
					addedIndx = 1;
					
					if (isOtherItem() && currentFocusedItem.linkDisabled ) {
						currentFocusedItem.linkDisabled = false;
					}
                } else if ( isCarouselItem() ) {
					addedIndx = 1;
				}
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
        if ( event.key === Qt.Key_Left ) {
        
            if ( traversalDepth === 4 ) {
                return;
            }
			
            if (isCarouselItem()) {
                --traversalDepth;
                indexIterator = 0;
                updateCurrentUISelection();
                return;
            }
            
            if ( isButtonItem() || isOtherItem() ){
                --traversalDepth;
                indexIterator = 0;
                updateCurrentUISelection();
                return;
            }
            
            if ( isBSButtonItem() || isBSTabItem()  || isOptionItem() )
                return;

            
            if ( isBindingCellLeft() ) {
                if (currentFocusedItem.children[currentFocusedItem.children.length - 1].state !== 'selected') {
                    --traversalDepth;
                    indexIterator = 0;
                    updateCurrentUISelection();
                    return;
                }
            }
            
            if ( isBindingCellRight() ) {
                if (currentFocusedItem.children[currentFocusedItem.children.length - 1].state !== 'selected') {
                    --traversalDepth;
                    updateCurrentUISelection();
                    return;
                }
            }
            
            return;
        }

        if ( event.key === Qt.Key_Right ) {
		
            if ( traversalDepth === 4 || currentFocusedItem.parent.parent.parent.rank === -1 ) {
                return;
            }
        
			
            if ( isBSButtonItem() || isBSTabItem() ) {
                indexIterator = 0;
                ++traversalDepth;
                updateCurrentUISelection();
                return;
            }
            
            if ( isButtonItem() || isCarouselItem() || isOptionItem() || isOtherItem() )
                return;


            if ( isBindingCellLeft() ) {
                if (currentFocusedItem.children[currentFocusedItem.children.length - 1].state !== 'selected' ) {
                    ++traversalDepth;
                    updateCurrentUISelection();
                    return;
                } else {
                    InputBindingsManager.clearSelectedBinding();
                    updateCurrentUISelection();
                    return;
                }
            }
            
            if ( isBindingCellRight() ) {
                if (currentFocusedItem.children[currentFocusedItem.children.length - 1].state !== 'selected') {
                    --traversalDepth;
                    updateCurrentUISelection();
                    return;
                } else {
                    InputBindingsManager.clearSelectedBinding();
                    updateCurrentUISelection();
                    return;
                }
            }
            
            return;
        }
		
		
		
        if (event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace) {
        
                if (  traversalDepth === 1 ) {
                    return;
                }
				
            if ( traversalDepth === 4 ) {
                return;
            }
				
        
            if ( isBSButtonItem() || isBSTabItem() ) {
                return;
            }
			
            if ( traversalDepth === 2 || traversalDepth === 3 )
            {
            
                if ( ( isBindingCellLeft() || isBindingCellRight() ) && InputBindingsManager.isSelected ) {
					InputBindingsManager.clearSelection();
					lastTraversalDepthIndex[traversalDepth] = indexIterator;
					updateCurrentUISelection();
                    return;
                }
                
                
                if ( isBindingCellRight() && !InputBindingsManager.isSelected ) {
                    traversalDepth -= 2;
                } else {
                    changeTraversalDepth(true);
                }
                
                indexIterator = 0;
            }
			
            updateCurrentUISelection();
            
            return;
        }
		
    }

    /**
      * Provides functionality for changing depth of ui traversal.
      * @reversed - boolean. When true - will go up by 1 level, when false - go down by 1 level.
      */
    function changeTraversalDepth(reversed) {
        if (traversalDepth >= 4)
            return;

        if (reversed) {
            if (traversalDepth > 1) {
                --traversalDepth;
            }
        } else {
            if (traversalDepth < 3) {
                if ( navigationTree[traversalDepth + 1].length ) {
                    lastTraversalDepthIndex[traversalDepth] = indexIterator;
                    ++traversalDepth;
                } else {
                    lastTraversalDepthIndex[traversalDepth] = indexIterator;
                    ++traversalDepth;
                }
            } else {
                return;
            }
        }
        
        if(!navigationTree[traversalDepth].length) {
            changeTraversalDepth(reversed);
        }

        if ( reversed ) {
            indexIterator = lastTraversalDepthIndex[traversalDepth];
        } else {
            indexIterator = 0;
        }

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

        if ( !navigationItems[indexIterator].visible || navigationItems[indexIterator].disabled ) {
            traverseForward();
        }

    }

    function traverseBackward() {
        --indexIterator;

        var navigationItems = navigationTree[traversalDepth];

        if (indexIterator < 0) {
            indexIterator = navigationTree[traversalDepth].length - 1;
        }

        if ( !navigationItems[indexIterator].visible || navigationItems[indexIterator].disabled ) {
            traverseBackward();
        }

    }

    function updateCurrentUISelection() {
        if (disableUINavigation)
            return;
        // Prevents deselection of button if already active ( when you navigate trough menu items )
        if (currentFocusedItem !== null && !currentFocusedItem.selected && !currentFocusedItem.disabled) {
            if (isBSButtonItem() || isBSTabItem() || isButtonItem() || isBindingCellLeft() || isBindingCellRight()) {
                // TODO: Hack, but no other options for now, the state of button is stored in
                // latest child item of button ( MouseArea ), should be reworked
                currentFocusedItem.children[currentFocusedItem.children.length - 1].state = "blurred";
            }
        }
		
        // Selects a new focused item
        currentFocusedItem = navigationTree[traversalDepth][indexIterator];
		
		var isFinalOption = 1;
		
		if (navigationTree[traversalDepth][navigationTree[traversalDepth].length - 1].objectName !== "ui--navigation:option-item:level_2" )
		{
			isFinalOption = 3;
		}
		
        if ( isOptionItem() ) {
			if ( indexIterator === 0 || indexIterator === navigationTree[traversalDepth].length - isFinalOption ) {
				currentFocusedItem.parent.parent.parent.parent.parent.positionViewAtIndex(indexIterator, ListView.Center );
			} else {
				currentFocusedItem.parent.parent.parent.parent.parent.positionViewAtIndex( indexIterator + addedIndx, ListView.Contain );
			}
			
            Sound.playEffect("sndfocus");
        }
		
        if ( isOtherItem() ) {
			if ( indexIterator === 0 || indexIterator === navigationTree[traversalDepth].length - 1 ) {
				currentFocusedItem.parent.parent.parent.positionViewAtIndex(indexIterator, ListView.Center );
			} else {
				currentFocusedItem.parent.parent.parent.positionViewAtIndex( indexIterator + addedIndx, ListView.Contain );
			}
        }
		
        if ( isCarouselItem() ) {
			if ( indexIterator === 0 || indexIterator === navigationTree[traversalDepth].length - 1 ) {
				currentFocusedItem.parent.parent.positionViewAtIndex(indexIterator, ListView.Center );
			} else {
				currentFocusedItem.parent.parent.positionViewAtIndex( indexIterator + addedIndx, ListView.Contain );
			}
        }

        if (!currentFocusedItem.selected && !currentFocusedItem.disabled) {
            if (isBSButtonItem() || isBSTabItem() || isButtonItem() || isBindingCellLeft() || isBindingCellRight()) {
                // TODO: Hack, but no other options for now, the state of button is stored in
                // latest child item of button ( MouseArea ), should be reworked
                currentFocusedItem.children[currentFocusedItem.children.length - 1].state = "focused";
            }
			
        }
		
        if ( isButtonItem() ) {
            Sound.playEffect("sndfocus");
        }
        
        if (isBindingCellLeft() || isBindingCellRight()) {
			if ( indexIterator === 0 || indexIterator === navigationTree[traversalDepth].length - 1 ) {
				currentFocusedItem.parent.parent.parent.parent.parent.parent.parent.parent.positionViewAtIndex(indexIterator, ListView.Center );
			} else {
				currentFocusedItem.parent.parent.parent.parent.parent.parent.parent.parent.positionViewAtIndex( indexIterator + addedIndx, ListView.Contain );
			}
        }

        // Apply focus to new selected item
        currentFocusedItem.forceActiveFocus();
		
    }
}
