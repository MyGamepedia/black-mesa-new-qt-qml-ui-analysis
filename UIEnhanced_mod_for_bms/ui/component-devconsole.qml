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

    property string egg: ""

	function checkForEggs() {
		switch (commandField.text.toLowerCase().trim()) {
			case "pala": egg = "činka"; break;
			case "pizza": egg = "it's a lie"; break;
			case "beer": egg = "no beer"; break;
			case "bread": egg = "man"; break;
			case "coinflip" : egg = flipCoin(); break;
			case "rps" : egg = fistInt(); break;
			case "argemia": egg = "
                                ....'',,;,,''....          ..                   ..,:codxxxxxdl; \n
                          .;clodxk0000KKXXKKK0kkxoc:;:llc,.        ...     .,:oxk0KK0000000000K \n
                     -;cox000000kk00000000000000000000000kdc'......   .,cox0KK0000kk00000000000 \n
                .':lx0000KKK00000KXK000000k0000000000000000K0kl.  .;ld00K0000000000000000000000 \n
cc,;,.        .;d0KK00k0KXKK00k0XX0000k000000KKKK00000000000k000k0KK000k00000000000000000000000 \n
od..;cc:.     ,0NK00000KNX00K00XN00000000000KXXKK00KNX00kk000000NWNK000000000000000000kk0000000 \n
.xl.  .;clccldx0KK00000KXK0000XNKkk00KK0000xddol:'.;lodxk00000000KXNXK0000000kkk0000000kxod0XKO \n
 'xl.    .:x0K000000K0xlcloccckKl',;::::ld:...          ..,:x00k00000KXXK000000kdoc:;'...cx000k \n
  .xo.      'l0K00001'.  .',. ..      .:c'..                l00k000000KXNNNkc,'.      .l0K00000 \n
   .dx'       .c0N0'       ..         .,............        ;0K00000xoc;;ll'        'o0K0000000 \n
    .okc.......l0kl::ccldxk0kxdc.  .,c:;:lk0XXXXXXK00d;    .kNK0xl;'.            .;xKK000000000 \n
      ,kk:...,k0dlx0xocldkkk0NKd,  .col::ldk0000kkkkxd:',ld0X0o;.:.............:o0XX00000000000 \n
      .:k0d,'xXo',::;'..   .;c. ..   .''''',;:;;'.....;xKXX0l'.           .';o0KK00000000000000 \n
       ;odo''0x.,00c....   .,;.      ....  ,xK0d;   .lKXKKd........  .;ldk0KKK00000000000000000 \n
         .;;lKd,lKk:,,,;:clloooc:;,,,,,;:cccc:'.   'xK0K0:.          .':cox0K000000000000000000 \n
            ;0c  .,::::;;'.    .',;;;;;,,..       ,0K0Kk'      ......''';:l0X000000000000000000 \n
            .kk.                                 '0XK0l.      .;xdc;,,,,d0000000000000000000000 \n
             'kd.                                c0kl.       .:x00ko.   lK0k0000000000000000000 \n
              .ld:'.                             ...     ..,cx00000Nd   ,0K00000000000000000000 \n
                .,;;,;'.                           ..,::cx00000K0k0Nd.   lX0k000000000000000000 \n
                     ';:::;.                 ..,;:ccc:,,o00dc';0K0XK,    .dX0000000000000000000 \n
                   ..'...';cl:.          .':::cc:'.  .,lo:'   .dNX0;      .kX000000000000000000 \n
               'clcc;;::cl:;0Nd'....,:cod00l;;,,,;;::;'.      .dNk         .kX00000000000000000 \n
             ;dxo:'..  .,l0WWMWXK00XNMMMMMKo:,...cl:ccl:.     :kc.          .dK0000000000000000 \n
       ..,;:okd:;;,,:lx000XWMWMMW00MMMMMW0:     .:.   'coo:.  '.              ;0K00k00000000000 \n
    .:cc:;,..     ;ox00kocd0k0NO:.dWMMN0c.     .:;       'oxl.                 '0X0k000kk000000 \n
  .lkl.         ;dd,.'.   .,xNk.  :00o,       'll. ...     .lko.                'xKK000kk000000 \n
  ;Xo          c0o.       .oWK,    ..         ;kl.   ..      ,00'                .;odo;.'dK0000 \n
"; break;
			default: egg = "";
		}
	}

    function flipCoin() {
        var face = Math.floor(Math.random() * 500);

        if (face === 7) { return "Edge."; }
        else if (face % 2 === 0) { return "Heads."; }
        else { return "Tails."; }
    }
    function fistInt() {
        var hand = Math.floor(Math.random() * 3);

        if (hand === 1) { return "Paper."; }
        else if (hand === 2) { return "Scissors."; }
        else { return "Rock."; }
    }

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
            selectByMouse: true
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

            checkForEggs();
            if (!egg) {
                BlackMesaEngine.executeClientCommandUnrestricted(text);
            }
            else {
                BlackMesaEngine.printConsoleMessage(Theme.colors.navigationHighlight, "< " + egg);
            }

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
