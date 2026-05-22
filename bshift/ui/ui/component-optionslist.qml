import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

Rectangle {
    id: optionsView
    signal requestSettingsChange(var model, var value)
    signal settingsReset()

    property ListModel model
    property variant models

    // if TRUE the page is reloaded after user click on "Apply Changes" button
    property bool reloadPageAfterApplyChanges: false

    property string titleNameText: "Unset"
    property int visibleRows: 13
	property bool isLessRows: false
    property bool batchUpdates: false
    property bool footerVisible: false
    property bool hasPendingChanges: false

    property variant _groupDebounce
    property variant _pendingSettings
    property variant _originalSettings

    property int listVerticalMargins: Math.ceil(24 * Theme.heightScale)
    property int optionHeight: Math.ceil(56 * Theme.heightScale)
    property int buttonMargin: Math.ceil(35 * Theme.widthScale)
    property int buttonTopMargin: Math.ceil(10 * Theme.heightScale)
    property int buttonFooterMargin: Math.ceil(4 * Theme.heightScale)
    property int headerHeight: optionHeight * 2 + buttonTopMargin * 3
    property int leftAllMargin: Math.ceil(50 * Theme.widthScale)
    property int rightAllMargin: Math.ceil(16 * Theme.widthScale)
    property int listPaddingBottom: Math.ceil(15 * Theme.heightScale)
    property int optlistcut: Math.ceil(15 * Theme.heightScale)
    property int listHeight: !batchUpdates ? Math.floor(895 * Theme.heightScale) : Math.floor(782 * Theme.heightScale)
	
    property color bsOuterColor: Theme.colors.bssecondaryhighlight

    property bool scrowbActive: optionsList.height + optionsList.bottomMargin + optionsList.topMargin + 2 < optionsList.contentHeight
    
    height: parent.height
    width: parent.width
    color: "transparent"

    function getEngineSetting(key) {
        var model = models[key];

        if (model.cvar) {
            var result = BlackMesaEngine.getConsoleVariableAsString(model.cvar);
            return result;
        } else {
            if (getComplex && getComplex[key]) {
                return getComplex[key]();
            }

            if ( model.type !== "separator" ) { // don't display Warning message for "separator" : they are expected to not have getter
                console.warn("no complex getter defined for", key, "( type =", model.type, ")");
            }
        }
    }

    function setEngineSetting(key, value) {
        var model = models[key];

        if (model.cvar) {
            BlackMesaEngine.setConsoleVariableAsString(model.cvar, value)
        } else if (model.group) {
            if (!groups || !groups[model.group]) {
                console.warn("no group setter defined for", key, model.group);
                return false;
            }

            if (!_groupDebounce[model.group]) {
                groups[model.group]();
                _groupDebounce[model.group] = true; // mark this as processed, so when the other group
                                                    // members are processed, they don't reprocesses it
            }
        } else {
            if (setComplex && setComplex[key]) {
                setComplex[key](value);
            } else {
                console.warn("no complex setter defined for", key);
                return false;
            }
        }

        return true;
    }

    function _setValueImmediate(key, value) {
        if (setEngineSetting(key, value)) {
            models[key].value = value;

            _originalSettings[key] = value;
            delete _pendingSettings[key];
            BlackMesaEngine.executeClientCommandUnrestricted('mat_savechanges');
        } else {
            console.error("setEngineSetting failed!", key, value);
        }
    }

    function _queueChange(model, value) {
        var key = model.key;

        if (value === _originalSettings[key]) {
            delete _pendingSettings[key];
            hasPendingChanges = Object.keys(_pendingSettings).length !== 0
        } else {
            _pendingSettings[key] = value;
            hasPendingChanges = true;
        }

        model.value = value;
    }

    function setValue(model, value) {
        _groupDebounce = {};
        if (batchUpdates) {
            _queueChange(model, value);
        } else {
            _setValueImmediate(model.key, value);
			
			var checkThisOut = BlackMesaEngine.getConsoleVariableAsInt("hud_draw_fixed_reticle");
			
			if (appRoot.iconsType !== checkThisOut ){
				appRoot.iconsType = checkThisOut;
				appRoot.hintsIconTypeChange();
			}
        }
    }

    function flushPendingChanges() {
        Object.keys(_pendingSettings).forEach(function (key) {
            _setValueImmediate(key, _pendingSettings[key]);
        });

        BlackMesaEngine.executeClientCommandUnrestricted('mat_savechanges');
        hasPendingChanges = false;

        // TODO: Hack!!! Because we need to reload game after video settings change,
        // when we press "Apply" button, optionlist component does not provide functionality 
        // to call custom callback from specific route ( in our case it's video settings page )
        // we should check route for "video" page and then reload game.
        if (router.currentRoute.name.toString() === "video") {
            BlackMesaEngine.executeClientCommandUnrestricted("savereloadaftersettingschange");
        }
    }

    function clearPendingChanges() {
        Object.keys(_pendingSettings).forEach(function (key) {
            delete _pendingSettings[key];
            models[key].value = _originalSettings[key].value;
        });

        hasPendingChanges = false;
        settingsReset();
    }

    function refreshModelValues() {
        Object.keys(models).forEach(function (key) {
            var model = models[key];

            model.value = getEngineSetting(key);
            _originalSettings[key] = model.value;
        });
    }

    Component.onCompleted: {
        _originalSettings = {};
        _pendingSettings = {};
        models = {};

        for (var i = 0; i < model.count; i++) {
            models[model.get(i).key] = model.get(i);
        }

        refreshModelValues();
    }

    onRequestSettingsChange: {
        setValue(model, value);
    }

    Item {
		id: optListBody
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
		anchors.topMargin: Math.ceil(116 * Theme.heightScale)
        anchors.leftMargin: leftAllMargin
        anchors.rightMargin: rightAllMargin
        
        height: listHeight

        Rectangle {
            visible: scrowbActive
            width: Math.floor(2 * Theme.heightScale)
            height: parent.height
            opacity: 0.8
            
            anchors.right: parent.right
            anchors.rightMargin: Math.floor(6 * Theme.heightScale)
            anchors.verticalCenter: parent.verticalCenter
            
            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.2; color: optionsView.bsOuterColor }
                GradientStop { position: 0.8; color: optionsView.bsOuterColor }
                GradientStop { position: 1; color: "transparent" }
            }
        }

        ListView { id: optionsList
            clip: true
            anchors.fill: optListBody
            model: optionsView.model
            interactive: true
            boundsBehavior: Flickable.StopAtBounds
            cacheBuffer: 5000
            keyNavigationEnabled: false
            keyNavigationWraps: false
            spacing: buttonTopMargin
			
			header: Rectangle {
					  width: optionsList.width
					  height: optionsView.listVerticalMargins
					  color: "transparent"
			}
			
			footer: Rectangle {
					  width: optionsList.width
					  height: !isLessRows ? optionsView.listVerticalMargins : 0
					  color: "transparent"
			}

            ScrollBar.vertical: VerticalScrollBar {
                visible: scrowbActive
            }

            delegate: Loader {
                id: loader
                width: optionsList.width
                height: optionHeight

                Component.onCompleted: {
                    loader.setSource('component-optionslist-row.qml', { model: model, inputWidth: parent.width / 2 - (Theme.widthScale * 300) });
                    loader.item.requestSettingsChange.connect(requestSettingsChange);
                }
            }
        }
        
    }


	
	
    Item {
        id: header

        anchors.topMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.rightMargin: 0

        anchors.top: parent.top
		anchors.bottom: optListBody.top
        anchors.left: parent.left
        anchors.right: parent.right

        width: parent.width - Math.ceil(6 * Theme.heightScale)

			
        Item {
            id: headerTextBody
			
            anchors.top: parent.top
			anchors.topMargin: Math.ceil(-1 * Theme.heightScale)
            anchors.left: parent.left
            anchors.right: parent.right
			anchors.rightMargin: Math.ceil(-1 * Theme.heightScale)

            width: parent.width
            height: Math.ceil(85 * Theme.heightScale)		// OptionsList Footer Height
			
			property int titleNameFontSize: Math.ceil(60 * Theme.heightScale)
			property int titleMargin: Math.ceil(46 * Theme.widthScale)
			property int warningFontSize: Math.ceil(24 * Theme.heightScale)
			property int warningMargin: Math.ceil(73 * Theme.widthScale)
			
					Rectangle {
						id: titleBGSec
						rotation: -90
						
						opacity: 0.9
						
						anchors.centerIn: parent
						height: parent.width
						width: parent.height - Math.ceil(30 * Theme.heightScale)
						anchors.verticalCenterOffset: Math.ceil(24 * Theme.heightScale)
									
						gradient: Gradient {
							GradientStop { position: 0.3; color:  "transparent" }
							GradientStop { position: 0.7; color: Theme.colors.highlight }
						}
					}
					
					Rectangle {
						id: titleBGFirst
						rotation: -90
						
						opacity: 0.9
						
						anchors.centerIn: parent
						height: parent.width
						width: parent.height
									
						gradient: Gradient {
							GradientStop { position: 0.1; color:  "transparent" }
							GradientStop { position: 0.6; color: Theme.colors.subMenuHintPrimary }
						}
					}
            
            Text { id: titleText
                anchors.right: parent.right
                anchors.rightMargin: headerTextBody.titleMargin
				anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: Math.ceil(-3 * Theme.heightScale)
                text: titleNameText
                font.capitalization: Font.MixedCase
                font.pixelSize: headerTextBody.titleNameFontSize
                font.family: Theme.fonts.regular
                font.bold: true
                color: Theme.colors.buttonText
            }
		}
	}



    Item {
        id: footer
        visible: footerVisible || batchUpdates

		anchors.top: optListBody.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
		
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: Math.ceil(6 * Theme.heightScale)
        anchors.rightMargin: 0

        width: parent.width - Math.ceil(6 * Theme.heightScale)

		Column {
			anchors.top: parent.top
			anchors.topMargin: Math.ceil(13 * Theme.heightScale)
			anchors.left: parent.left
			anchors.leftMargin: ( parent.width - saveButton.width ) / 2
			
			
            spacing: buttonFooterMargin
			visible: batchUpdates
			
            CTAButton {
                id: saveButton
                objectName: "ui--navigation:button:level_2"
                disabled: !hasPendingChanges
                text: L10n.strings.buttons.applyChanges
                callback: function() {
                    flushPendingChanges();
                    if ( reloadPageAfterApplyChanges ) { // if reload page is needed ...
						indexOptions.reloadVideoPage();
                    }
                }
                onClicked: {
                    flushPendingChanges();
                    if ( reloadPageAfterApplyChanges ) { // if reload page is needed ...
						indexOptions.reloadVideoPage();
                    }
                }
            }

            WarningButton {
                id: discardButton
                objectName: "ui--navigation:button:level_2"
                disabled: !hasPendingChanges
                text: L10n.strings.buttons.discardChanges
                callback: function() {
                    indexOptions.reloadVideoPage();
                }
                onClicked: {
                    indexOptions.reloadVideoPage();
                }
            }
            
            
        }
    }//footer end
    
    
}
