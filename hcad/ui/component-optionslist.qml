import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

Rectangle { id: optionsView
    signal requestSettingsChange(var model, var value)
    signal settingsReset()

    property string title: "<unbound title>"
    property ListModel model
    property variant models

    // if TRUE the page is reloaded after user click on "Apply Changes" button
    property bool reloadPageAfterApplyChanges: false

    property int visibleRows: 3
    property bool batchUpdates: false
    property bool hasPendingChanges: false

    property variant _groupDebounce
    property variant _pendingSettings
    property variant _originalSettings

    property int optionHeight: Math.ceil(75 * Theme.heightScale)
    property int headerHeight: Math.ceil(85 * Theme.widthScale)
    property int buttonMargin: Math.ceil(17 * Theme.widthScale)
    property int headerMargin: Math.ceil(35 * Theme.widthScale)
    property int headerFontSize: Math.ceil(32 * Theme.heightScale)
    property int listPaddingBottom: Math.ceil(15 * Theme.heightScale)
    property int listPaddingBottomBatch: Math.ceil(25 * Theme.heightScale)

    height: headerHeight * (batchUpdates ? 2 : 1) + (visibleRows * optionHeight) + (batchUpdates ? listPaddingBottomBatch : listPaddingBottom)
    width: Math.ceil(1500 * Theme.widthScale)
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
            models[key].value = _originalSettings[key];
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

    Item { id: header
        anchors.topMargin: 0
        anchors.leftMargin: 0
        anchors.rightMargin: 0

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        width: parent.width
        height: headerHeight

        Rectangle {
            anchors.fill: parent
            color: Theme.colors.modalBackground
            opacity: Theme.opacity.modal
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            color: Theme.colors.highlight
            font.family: Theme.fonts.bold
            font.pixelSize: headerFontSize
            font.capitalization: Font.AllUppercase
            text: title
            leftPadding: headerMargin
        }
    }

    Rectangle {
        anchors.bottomMargin: batchUpdates ? 0 : 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: header.bottom
        anchors.bottom: batchUpdates ? footer.top : parent.bottom

        color: Theme.colors.skrim
        opacity: Theme.opacity.modal

        ListView { id: optionsList
            clip: true
            anchors.fill: parent
            model: optionsView.model
            // TODO: interactive should be true for supporting mouse scroll,
            // when it set to false mouse wheel will not work
            interactive: true
            boundsBehavior: Flickable.StopAtBounds
            cacheBuffer: 5000
            keyNavigationEnabled: false
            keyNavigationWraps: false

            ScrollBar.vertical: VerticalScrollBar {
                visible: optionsList.height + optionsList.bottomMargin + optionsList.topMargin + 2 < optionsList.contentHeight
            }

            delegate: Loader { id: loader
                width: optionsList.width
                height: optionHeight

                Component.onCompleted: {
                    loader.setSource('component-optionslist-row.qml', { model: model, inputWidth: parent.width / 2 - (Theme.widthScale * 300) });
                    loader.item.requestSettingsChange.connect(requestSettingsChange);
                }
            }
        }
    }

    Item { id: footer
        visible: batchUpdates

        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.rightMargin: 0

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        width: parent.width
        height: headerHeight

        Rectangle {
            anchors.fill: parent
            color: Theme.colors.modalBackground
            opacity: Theme.opacity.modal
        }

        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: buttonMargin
            spacing: 5

            WarningButton { id: discardButton
                objectName: "ui:btn:action[discard]"
                disabled: !hasPendingChanges
                text: L10n.strings.buttons.discardChanges
                onClicked: {
                    clearPendingChanges();
                }
            }

            CTAButton { id: saveButton
                objectName: "ui:btn:action[apply]"
                disabled: !hasPendingChanges
                text: L10n.strings.buttons.applyChanges
                onClicked: {
                    flushPendingChanges();
                    if ( reloadPageAfterApplyChanges ) { // if reload page is needed ...
                        router.setRoute(router.currentRoute.name.toString(), false, true);
                        reloadPageAfterApplyChanges = true;
                    }
                }
            }
        }
    }
}
