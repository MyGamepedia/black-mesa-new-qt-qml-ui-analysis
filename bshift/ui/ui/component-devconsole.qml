import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

Item { id: container
    property bool isWidescreen: appRoot.width / appRoot.height >= 1.586
	
    property int rightpanelWidth: isWidescreen ? Math.ceil(1200 * Theme.widthScale) :  Math.ceil(1300 * Theme.widthScale)
    property int leftAllMargin: Math.ceil(50 * Theme.widthScale)
    property int rightAllMargin: Math.ceil(16 * Theme.widthScale)
	
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.right: parent.right

    width: rightpanelWidth + Math.ceil(6 * Theme.heightScale)

	
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

	Rectangle {
		id: lightBackDrop
		opacity: Theme.opacity.bsSecondary
        anchors.fill: parent

		color: Theme.colors.bssecondaryhighlight
	}
	
	Item {
		id: background
        anchors.fill: parent

		Rectangle {
			id: rectBG
			opacity: Theme.opacity.bsRightPanel
			rotation: -90
			height: background.width
			width: background.height
			anchors.centerIn: background
			anchors.horizontalCenterOffset: Math.ceil(6 * Theme.heightScale)

			gradient: Gradient {
				GradientStop { position: 0; color: Theme.colors.skrim }
				GradientStop { position: 1; color:  Theme.colors.bsMenuBackDropRight }
			}
		}
	}
	
    Item {
		id: consoleListBody
        anchors.bottom: contBGfooter.top
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
		anchors.topMargin: Math.ceil(116 * Theme.heightScale)
        anchors.leftMargin: leftAllMargin
        anchors.rightMargin: rightAllMargin

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
                GradientStop { position: 0.2; color: Theme.colors.bssecondaryhighlight }
                GradientStop { position: 0.8; color: Theme.colors.bssecondaryhighlight }
                GradientStop { position: 1; color: "transparent" }
            }
        }

		ListView { id: outputView
			anchors.fill: parent
			
			clip: true

			model: outputModel

			interactive: true
			boundsBehavior: Flickable.StopAtBounds
			ScrollBar.vertical: VerticalScrollBar {}

			header: Rectangle {
					  width: outputView.width
					  height: Math.ceil(19 * Theme.heightScale)
					  color: "transparent"
			}
			
			footer: Rectangle {
					  width: otherList.width
					  height: Math.ceil(19 * Theme.heightScale)
					  color: "transparent"
			}

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
	}
					Item {
					id: contBG
					
					anchors.top: parent.top
					anchors.right: parent.right
					width: rightpanelWidth
					height: Math.ceil(116 * Theme.heightScale)
					
						Rectangle {
							id: headerBGrect
							opacity: Theme.opacity.bsOptionsFooter
							
							anchors.centerIn: contBG
							
							rotation: -90
							
							height: contBG.width
							width: contBG.height
							
							gradient: Gradient {
								GradientStop { position: 0; color: Theme.colors.skrim }
								GradientStop { position: 1; color:  Theme.colors.bsMenuBackDropRight }
							}
						}
						
					Item {
						id: headerTextBody
						
						anchors.top: parent.top
						anchors.topMargin: Math.ceil(-1 * Theme.heightScale)
						anchors.left: parent.left
						anchors.right: parent.right
						anchors.rightMargin: Math.ceil(-1 * Theme.heightScale)

						width: parent.width
						height: Math.ceil(85 * Theme.heightScale)
						
						property int titleNameFontSize: Math.ceil(60 * Theme.heightScale)
						property int titleMargin: Math.ceil(46 * Theme.widthScale)
						
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
							text: L10n.strings.options.labels.game_devConsole
							font.capitalization: Font.MixedCase
							font.pixelSize: headerTextBody.titleNameFontSize
							font.family: Theme.fonts.regular
							font.bold: true
							color: Theme.colors.buttonText
						}
					}
				}
			
			
				Item {
					id: contBGfooter
					
					clip: true
					
					anchors.bottom: parent.bottom
					anchors.right: parent.right
					width: rightpanelWidth
					height: Math.floor(69 * Theme.heightScale) + commandField.height
					
						Rectangle {
							id: footerBGrect
							opacity: Theme.opacity.bsOptionsFooter
							
							anchors.centerIn: contBGfooter
							
							rotation: -90
							
							height: contBGfooter.width
							width: contBGfooter.height
							
							gradient: Gradient {
								GradientStop { position: 0; color: Theme.colors.skrim }
								GradientStop { position: 1; color:  Theme.colors.bsMenuBackDropRight }
							}
						}
				}
	
        Item {
            id: footerGraphicDescription
            height: Math.ceil(69 * Theme.heightScale)		// OptionsList Footer Height

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

			property bool isButtonVisible: true

			Item {
				id: hintBGBase
				anchors.bottom: footerGraphicDescription.bottom
				anchors.left: footerGraphicDescription.left
				anchors.right: footerGraphicDescription.right
				
				height: 0
				width: footerGraphicDescription.width

				Rectangle {
					id: hintsBGSec
					height: hintBGBase.width + Math.ceil(2 * Theme.widthScale)
					width: Math.ceil(30 * Theme.heightScale)
					anchors.centerIn: hintBGBase
					anchors.verticalCenterOffset: Math.ceil(-20 * Theme.heightScale)
					
					rotation: -90
					opacity: Theme.opacity.bsRightPanel
					
					gradient: Gradient {
						GradientStop { position: 0.3; color:  "transparent" }
						GradientStop { position: 0.7; color: Theme.colors.highlight }
					}
				}
				
				Rectangle {
					id: hintsBG
					height: hintBGBase.width + Math.ceil(2 * Theme.widthScale)
					width: Math.ceil(39 * Theme.heightScale)
					anchors.centerIn: hintBGBase
					anchors.verticalCenterOffset: Math.ceil(-34 * Theme.heightScale)
					
					rotation: -90
					opacity: 0.9
					
					gradient: Gradient {
						GradientStop { position: 0.1; color:  "transparent" }
						GradientStop { position: 0.6; color: Theme.colors.subMenuHintPrimary }
					}
				}
			}
			
			Row {
				anchors.bottom: parent.bottom
				anchors.right: footerGraphicDescription.right
				anchors.rightMargin: Math.ceil(30 * Theme.widthScale)
				anchors.bottomMargin: Math.ceil(-10 * Theme.heightScale)

				Hint {
					id: hint1
					hintButtonText: "a"
					hintTextText: L10n.strings.hints.hintConsoleEnter
					
					isHintVisible: commandField.text
				}
				Hint {
					id: hint2
					hintButtonText: "."
					hintTextText: L10n.strings.hints.hintConsoleErase
					
					isHintVisible: commandField.text
				}
				Hint {
					id: hint3
					hintButtonText: "©"
					hintTextText: L10n.strings.hints.hintConsoleAutofill
					
					isHintVisible: commandField.text
				}
				Hint {
					id: hint4
					hintButtonText: "`"
					hintTextText: L10n.strings.hints.hintConsoleClose
				}
				Hint {
					id: hint5
					hintButtonText: "y"
					hintTextText: L10n.strings.hints.hintclosemenu
					
					isHintVisible: appRoot.isInGame
				}
			}

        }
		
		
    Rectangle { id: border
        anchors.centerIn: commandField

        rotation: -90
        
        width: commandField.height
        height: commandField.width
        
        color: "transparent"
        
        Rectangle { id: bottomShape
            anchors.top: parent.top
            anchors.left: parent.left
			anchors.leftMargin: Math.floor(4 * Theme.heightScale)
            
            width: Math.floor(2 * Theme.heightScale)
            height: parent.height
            
            opacity: Theme.opacity.bsSecondary
            
            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.1; color: Theme.colors.bssecondaryhighlight }
                GradientStop { position: 0.3; color: Theme.colors.bssecondaryhighlight }
                GradientStop { position: 1; color: "transparent" }
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

        anchors.top: contBGfooter.top
		anchors.topMargin: Math.ceil(8 * Theme.heightScale)
		
        anchors.leftMargin: Math.ceil(30 * Theme.widthScale)
        anchors.rightMargin: Math.ceil(30 * Theme.widthScale)

        color: Theme.devConsole.colors.inputText

        selectionColor: Theme.devConsole.colors.inputText
        selectedTextColor: Theme.devConsole.colors.background

        font.family: Theme.fonts.devConsole
        font.pixelSize: Math.ceil(18 * Theme.heightScale)
		
		height: Math.ceil(40 * Theme.heightScale)

        selectByMouse: true

        placeholderText: L10n.strings.hints.hintPlaceholderConsoleText

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
	
	
	
	
				Item {
					id: headLineBody
					
					anchors.top: parent.top
					anchors.topMargin: contBG.height - Math.ceil( 6 * Theme.heightScale)
					anchors.right: parent.right
					width: rightpanelWidth
					height: Math.ceil(12 * Theme.heightScale)
					
							Rectangle {
								id: headerLine
								opacity: Theme.opacity.bsSecondary
								
								rotation: -90
								
								anchors.centerIn: headLineBody
								
								height: headLineBody.width
								width: headLineBody.height
								
								gradient: Gradient {
									GradientStop { position: 0; color: "transparent" }
									GradientStop { position: 0.85; color: Theme.colors.bssecondaryhighlight }
								}
							}
			
				}
				
				Item {
					id: footLineBody
					
					anchors.bottom: parent.bottom
					anchors.bottomMargin: contBGfooter.height - Math.ceil( 6 * Theme.heightScale)
					anchors.right: parent.right
					width: rightpanelWidth
					height: Math.ceil(12 * Theme.heightScale)
					
							Rectangle {
								id: footerLine
								opacity: Theme.opacity.bsSecondary
								
								rotation: -90
								
								anchors.centerIn: footLineBody
								
								height: footLineBody.width
								width: footLineBody.height
								
								gradient: Gradient {
									GradientStop { position: 0; color: "transparent" }
									GradientStop { position: 0.85; color: Theme.colors.bssecondaryhighlight }
								}
							}
				}
	
	
	

    states: [
        State {
            name: "closed"
            PropertyChanges {
                target: container
				anchors.rightMargin: 0 - container.width
                opacity: 0.0
            }
        },
        State {
            name: "opened"
            PropertyChanges {
                target: container
				anchors.rightMargin: 0
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
                    properties: "anchors.rightMargin, opacity"
                    duration: 100
                    easing.type: Easing.OutQuint
                }
                ScriptAction {
                    script: {
                        BlackMesaUtils.disableUINavigation = true;
                        outputView.positionViewAtEnd();
                        commandField.forceActiveFocus();
						appRoot.isConsoleOpened = true;
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
						appRoot.isConsoleOpened = false;
                    }
                }
                NumberAnimation {
                    properties: "anchors.rightMargin"
                    duration: 100
                    easing.type: Easing.OutQuint
                }
                NumberAnimation {
                    properties: "opacity"
                    duration: 50
                    easing.type: Easing.OutQuint
                }
                ScriptAction {
                    script: {
                        BlackMesaUtils.disableUINavigation = false;
                        BlackMesaUtils.updateCurrentUISelection();
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
