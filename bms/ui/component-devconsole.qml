import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

Item { id: container
    anchors.left: parent.left
    anchors.right: parent.right

    height: parent.height * 0.375

    opacity: 0.0
    visible: opacity > 0.0009765625
    clip: true

    enabled: visible
    state: "closed"

    ListModel { id: outputModel
        dynamicRoles: false

        ListElement {
            // can't come from theme because of ListElement rescrictions
            elementColor: "gold"
            elementText: "Black Mesa Console Initialized"
        }

        onCountChanged: {
            if (container.state === "opened") {
                outputView.positionViewAtEnd();
            }
        }
    }

    Rectangle { id: background
        anchors.fill: parent
        color: Theme.devConsole.colors.background
    }

    ListView { id: outputView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: commandField.top

        clip: true

        model: outputModel

        interactive: true
        boundsBehavior: Flickable.StopAtBounds
        ScrollBar.vertical: VerticalScrollBar {}

        delegate: TextField { id: delegateRoot
            padding: 0

            width: parent.width
            height: contentHeight

            text: elementText
            readOnly: true
            wrapMode: TextInput.Wrap

            font.family: Theme.fonts.devConsole
            font.pixelSize: Math.ceil(16 * Theme.heightScale)

            color: elementColor

            background: Item {
                anchors.fill: parent
            }

        }
    }

    TextField { id: commandField
        QtObject { id: history
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

                commandField.clear();

                if (entryIndex < entries.length) {
                    commandField.text = entries[entryIndex];
                }
            }
        }

        QtObject {
            id: autocomplete

            property var autocompleteList: []
            property int storedAutocompleteIndex: -1

            property string storedSearchString: ""
            property string storedSearchStringPrefix: ""
        }

        anchors.left: parent.left
        anchors.right: parent.right

        anchors.bottom: parent.bottom

        color: Theme.devConsole.colors.inputText

        selectionColor: Theme.devConsole.colors.inputText
        selectedTextColor: Theme.devConsole.colors.background

        font.family: Theme.fonts.devConsole
        font.pixelSize: Math.ceil(16 * Theme.heightScale)

        selectByMouse: true

        placeholderText: BlackMesaEngine.getLocalizedString("#BlackMesaUI_Console_Hint")

        background: Item {
            anchors.fill: parent
        }

        onAccepted: {
            if (text.toLowerCase().trim() !== "clear") {
                BlackMesaEngine.printConsoleMessage(Theme.devConsole.colors.message, "> " + text + "\n");
            }

            BlackMesaEngine.executeClientCommandUnrestricted(text);

            history.entries.push(text);
            history.entries = history.entries;
        }

        Keys.onUpPressed: history.entryIndex--
        Keys.onDownPressed: history.entryIndex++

        Keys.onPressed: {
            if (event.key === Qt.Key_unknown) {
                return;
            }

            if (event.key !== Qt.Key_Tab) {
                autocomplete.storedAutocompleteIndex = -1;
            }
        }

        Keys.onTabPressed: {
            var inputString, searchString, whiteSpaceIndexOf, consoleHelpString;

            event.accepted = true;

            if (length === 0) {
                return;
            }

            inputString = text.replace(/\s+/g, " ");

            if (autocomplete.storedAutocompleteIndex < 0) {
                whiteSpaceIndexOf = inputString.indexOf(" ");

                if (whiteSpaceIndexOf !== -1) {
                    autocomplete.storedSearchStringPrefix = inputString.substring(0, whiteSpaceIndexOf + 1);
                    autocomplete.storedSearchString = inputString.substring(whiteSpaceIndexOf + 1, inputString.length);

                    autocomplete.autocompleteList = BlackMesaEngine.listConsoleSuggestions(autocomplete.storedSearchStringPrefix, autocomplete.storedSearchString);
                } else {
                    autocomplete.storedSearchStringPrefix = ""
                    autocomplete.storedSearchString = inputString;

                    autocomplete.autocompleteList = BlackMesaEngine.listConsoleAutocompleteEntries(autocomplete.storedSearchString);
                }

                BlackMesaEngine.printConsoleMessage(Theme.devConsole.colors.message, "] " + inputString + "\n");

                if (autocomplete.autocompleteList.length === 0) {
                    return;
                }

                autocomplete.storedAutocompleteIndex = 0;

                consoleHelpString = autocomplete.autocompleteList.reduce(function (accumulator, currentValue) {
                    return accumulator + "\t" + currentValue + "\n";
                }, "");

                BlackMesaEngine.printConsoleMessage(Theme.devConsole.colors.message, consoleHelpString);
            }

            searchString = autocomplete.storedSearchStringPrefix + autocomplete.storedSearchString;

            text = autocomplete.storedSearchStringPrefix + autocomplete.autocompleteList[autocomplete.storedAutocompleteIndex];
            select(searchString.length, text.length);

            autocomplete.storedAutocompleteIndex++;

            if (autocomplete.storedAutocompleteIndex >= autocomplete.autocompleteList.length) {
                autocomplete.storedAutocompleteIndex = 0;
            }
        }
    }

    states: [
        State {
            name: "closed"
            PropertyChanges {
                target: container
                y: -container.height
                opacity: 0.0
            }
        },
        State {
            name: "opened"
            PropertyChanges {
                target: container
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
                    duration: 50
                    easing.type: Easing.OutQuint
                }
                ScriptAction {
                    script: {
                        BlackMesaUtils.disableUINavigation = true;
                        outputView.positionViewAtEnd();
                        commandField.forceActiveFocus();
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
                        commandField.focus = false;
                        appRoot.forceActiveFocus();
                    }
                }
                NumberAnimation {
                    properties: "y, opacity"
                    duration: 50
                    easing.type: Easing.OutQuint
                }
                ScriptAction {
                    script: {
                        BlackMesaUtils.disableUINavigation = false;
                    }
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

                outputModel.append({
                    elementColor: messageEntry.color.toString(),
                    elementText: messageEntry.text
                });
            }
        }

        onGameConsoleCleared: {
            outputModel.clear();
        }

        onGameConsoleActived: {
            container.state = "opened";
        }

        onGameConsoleHidden: {
            container.state = "closed";
        }
    }
}
