import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

RouteView { id: bindingsView
    property int headerMargin: Math.ceil(35 * Theme.widthScale)
    property int headerFontSize: Math.ceil(32 * Theme.heightScale)
    property int headerHeight: Math.ceil(85 * Theme.widthScale)
    property int buttonMargin: Math.ceil(17 * Theme.widthScale)
    property int rowHeight: Math.ceil(85 * Theme.heightScale)
    property int pageWidth: Math.ceil(1500 * Theme.widthScale)
    property int pageHeight: visibleRows * rowHeight + headerHeight * 2
    property int categoryWidth: Math.ceil(pageWidth * 0.28)
    property int categoryLabelFontSize: Math.ceil(28 * Theme.heightScale)
    property int categoryLabelFocusShapeWidth: Math.ceil(15 * Theme.widthScale)

    property int visibleRows: 7
    property variant categories
    property variant currentModel

    function onRouteWillChange(newRouteName) {
        InputBindingsManager.clearSelection();
    }

    Item {
        height: pageHeight
        width: pageWidth

        anchors.centerIn: parent
        anchors.verticalCenterOffset: Math.ceil(20 * Theme.heightScale)

        Item { id: header
            anchors.topMargin: 1
            anchors.leftMargin: 1
            anchors.rightMargin: 1

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
                text: L10n.strings.headers.bindings
                leftPadding: headerMargin
            }
        }

        Rectangle { id: body
            anchors.leftMargin: 1
            anchors.rightMargin: 1

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: header.bottom

            height: rowHeight * visibleRows
            color: Theme.colors.skrim
            opacity: Theme.opacity.modal

            ListModel { id: categoriesModel
                Component.onCompleted: {
                    var labels = L10n.strings.options.labels,
                        buttons = L10n.strings.buttons;

                    categories = {
                        movement: {
                            label: labels.binding_movement,
                            type: "binding",
                            rank: 0,
                            action: "nav",
                            category: "movement",
                            qmlFile: "component-binding-movement.qml"
                        },
                        combat: {
                            label: labels.binding_combat,
                            rank: 1,
                            type: "binding",
                            action: "nav",
                            category: "combat",
                            qmlFile: "component-binding-combat.qml"
                        },
                        misc: {
                            label: labels.binding_misc,
                            type: "binding",
                            rank: 2,
                            action: "nav",
                            category: "misc",
                            qmlFile: "component-binding-misc.qml"
                        },
                        weapons: {
                            label: labels.binding_weapons,
                            type: "binding",
                            rank: 3,
                            action: "nav",
                            category: "weapons",
                            qmlFile: "component-binding-weapons.qml"
                        },
                        multiplayer: {
                            label: labels.binding_multiplayer,
                            type: "binding",
                            rank: 4,
                            action: "nav",
                            category: "multiplayer",
                            qmlFile: "component-binding-multiplayer.qml"
                        }
                    }


                    Object.keys(categories).sort(function (first, second) {
                        return categories[first].rank < categories[second].rank ? -1 : 1;
                    }).forEach(function (key) {
                        append(categories[key]);
                    });

                    append({ label: buttons.resetAllDefaults, action: "reset" });
                    outlet.setCategory(categories.movement, true);
                }
            }

            ListView { id: categoriesList
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left

                width: categoryWidth
                interactive: false

                model: categoriesModel

                delegate: MouseArea {
                    readonly property string type: "sub-nav"
                    objectName: action != "reset" ? "ui:tab" : "ui:btn:action[cancel]"
                    hoverEnabled: true
                    propagateComposedEvents: true
                    scrollGestureEnabled: false

                    height: rowHeight
                    width: categoryWidth

                    property bool selected: currentModel && currentModel.category === model.category

                    onSelectedChanged: {
                        if (selected) {
                            state = "selected"
                        } else {
                            state = containsMouse ? "focused" : "blurred"
                        }
                    }

                    Component.onCompleted: {
                        state = selected ? "selected" : "blurred"
                    }

                    state: "blurred"

                    Rectangle { id: focusShape
                        color: Theme.colors.highlight
                        opacity: 0.75
                        anchors.left: parent.left
                        anchors.top: parent.top
                    }

                    Text { id: labelText
                        text: model.label
                        font.family: Theme.fonts.bold
                        font.pixelSize: categoryLabelFontSize
                        font.capitalization: Font.AllUppercase
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: headerMargin
                    }

                    states: [
                        State {
                            name: "blurred"
                            PropertyChanges {
                                target: focusShape
                                height: parent.height
                                width: 0
                            }
                            PropertyChanges {
                                target: labelText
                                color: Theme.colors.buttonText
                            }
                        },
                        State {
                            name: "focused"
                            PropertyChanges {
                                target: focusShape
                                height: parent.height
                                width: parent.width
                            }
                            PropertyChanges {
                                target: labelText
                                color: Theme.colors.buttonText
                            }
                            StateChangeScript {
                                script: {
                                    Sound.playEffect(Theme.sounds.buttonFocused);
                                }
                            }
                        },
                        State {
                            name: "selected"
                            PropertyChanges {
                                target: focusShape
                                height: parent.height
                                width: categoryLabelFocusShapeWidth
                            }
                            PropertyChanges {
                                target: labelText
                                color: Theme.colors.highlight
                            }
                            StateChangeScript {
                                script: {
                                    Sound.playEffect(Theme.sounds.buttonClicked);
                                }
                            }
                        }
                    ]

                    property var callback: function() {
                        if (state !== "selected") {
                            switch (model.action) {
                                case "nav":
                                    outlet.setCategory(model);
                                    state = "selected";
                                    break;
                                case "reset":
                                    resetDefaultsAlert.show();
                                    break;
                                default:
                                    console.error("UNRECOGNIZED ACTION");
                            }
                        } else {
                            mouse.accepted = true
                        }
                    }

                    onEntered: {
                        if (state !== "selected") {
                            state = "focused"
                        }
                    }

                    onExited: {
                        if (state !== "selected") {
                            state = "blurred"
                        }
                    }

                    onClicked: callback();

                    transitions: [
                        Transition {
                            from: "blurred"
                            to: "focused"

                            ParallelAnimation {
                                ColorAnimation {
                                    target: labelText
                                    duration: 250
                                    easing.type: Easing.OutQuint
                                }

                                NumberAnimation {
                                    target: focusShape
                                    property: "width"
                                    duration: 250
                                    easing.type: Easing.OutQuint
                                }
                            }
                        },
                        Transition {
                            from: "focused"
                            to: "blurred"

                            ParallelAnimation {
                                ColorAnimation {
                                    target: labelText
                                    duration: 250
                                    easing.type: Easing.OutQuint
                                }

                                NumberAnimation {
                                    target: focusShape
                                    property: "width"
                                    duration: 250
                                    easing.type: Easing.OutQuint
                                }
                            }
                        },
                        Transition {
                            from: "focused"
                            to: "selected"

                            ParallelAnimation {
                                ColorAnimation {
                                    target: labelText
                                    duration: 150
                                    easing.type: Easing.OutQuint
                                }

                                NumberAnimation {
                                    target: focusShape
                                    property: "width"
                                    duration: 150
                                    easing.type: Easing.OutQuint
                                }
                            }
                        },
                        Transition {
                            from: "selected"
                            to: "blurred"

                            ParallelAnimation {
                                NumberAnimation {
                                    target: focusShape
                                    property: "width"
                                    duration: 100
                                }

                                ColorAnimation {
                                    target: labelText
                                    duration: 100
                                }
                            }
                        }

                    ]
                }
            }

            Rectangle { id: border
                width: 3
                anchors.left: categoriesList.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                color: Theme.colors.modalBackground
                opacity: Theme.opacity.modal
            }

            StackView { id: outlet
                clip: true

                anchors.left: border.right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.top: parent.top

                function setCategory(model, skipTransition) {
                    var transition = skipTransition ? StackView.Immediate : StackView.Transition;

                    if (currentModel && currentModel.rank > model.rank) {
                        replaceExit = categoryTransitions.down.exit;
                        replaceEnter = categoryTransitions.down.enter;
                    } else {
                        replaceExit = categoryTransitions.up.exit;
                        replaceEnter = categoryTransitions.up.enter;
                    }

                    InputBindingsManager.clearSelection();
                    currentModel = model;
                    outlet.replace(model.qmlFile, { opacity: skipTransition ? 1.0 : 0.0 }, transition);
                }

                readonly property QtObject categoryTransitions: QtObject {
                    readonly property QtObject up: QtObject {
                        readonly property Transition enter: upEnterTransition
                        readonly property Transition exit: upExitTransition
                    }

                    readonly property QtObject down: QtObject {
                        readonly property Transition enter: downEnterTransition
                        readonly property Transition exit: downExitTransition
                    }
                }

                Transition { id: upEnterTransition
                    ParallelAnimation {
                        NumberAnimation {
                            property: "y"
                            from: 300
                            to: 0
                            duration: 600
                            easing.type: Easing.InOutQuint
                        }
                        SequentialAnimation {
                            ScriptAction { script: BlackMesaUtils.clearUIElementsData(); }
                            PauseAnimation {
                                duration: 300
                            }
                            NumberAnimation {
                                property: "opacity"
                                from: 0.0
                                to: 1.0
                                duration: 300
                            }
                            ScriptAction { script: {
                                BlackMesaUtils.traverseUIElements(appRoot);
                                BlackMesaUtils.afterTraverseCallback();
                            }}
                        }
                    }
                }

                Transition { id: upExitTransition
                    ParallelAnimation {
                        NumberAnimation {
                            property: "y"
                            from: 0
                            to: -300
                            duration: 600
                            easing.type: Easing.InOutQuint
                        }
                        NumberAnimation {
                            property: "opacity"
                            from: 1.0
                            to: 0.0
                            duration: 300
                        }
                    }
                }

                Transition { id: downEnterTransition
                    ParallelAnimation {
                        NumberAnimation {
                            property: "y"
                            from: -300
                            to: 0
                            duration: 600
                            easing.type: Easing.InOutQuint
                        }
                        SequentialAnimation {
                            ScriptAction { script: BlackMesaUtils.clearUIElementsData(); }
                            PauseAnimation {
                                duration: 300
                            }
                            NumberAnimation {
                                property: "opacity"
                                from: 0.0
                                to: 1.0
                                duration: 300
                            }
                            ScriptAction { script: {
                                BlackMesaUtils.traverseUIElements(appRoot);
                                BlackMesaUtils.afterTraverseCallback();
                            }}
                        }
                    }
                }

                Transition { id: downExitTransition
                    ParallelAnimation {
                        NumberAnimation {
                            property: "y"
                            from: 0
                            to: 300
                            duration: 600
                            easing.type: Easing.InOutQuint
                        }
                        NumberAnimation {
                            property: "opacity"
                            from: 1.0
                            to: 0.0
                            duration: 300
                        }
                    }
                }
            }
        }

        Item { id: footer
            anchors.bottomMargin: 1
            anchors.leftMargin: 1
            anchors.rightMargin: 1

            anchors.top: body.bottom
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

                Text {
                    color: Theme.colors.highlight
                    font.family: Theme.fonts.bold
                    font.pixelSize: Math.ceil(24 * Theme.heightScale)
                    font.capitalization: Font.AllUppercase
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: buttonMargin

                    visible: InputBindingsManager.isBinding

                    text: L10n.strings.modalMessages.bindingInstructions
                }

                CTAButton { id: editBindingButton
                    objectName: "ui:btn:action[apply]"
                    disabled: !InputBindingsManager.isSelected
                    visible: !InputBindingsManager.isBinding
                    text: L10n.strings.buttons.editBinding
                    onClicked: {
                        InputBindingsManager.startBindingRequest();
                    }
                }

                WarningButton { id: clearBindingButton
                    objectName: "ui:btn:action[discard]"
                    disabled: !InputBindingsManager.isSelected
                    visible: !InputBindingsManager.isBinding
                    text: L10n.strings.buttons.clearBinding
                    onClicked: {
                        InputBindingsManager.clearSelectedBinding();
                    }
                }
            }
        }
    }

    Alert { id: resetDefaultsAlert
        titleText: L10n.strings.headers.resetAllDefaultsWarning
        messageText: L10n.strings.modalMessages.resetAllDefaultsWarning

        buttons: VisualItemModel {
            WarningButton {
                objectName: "ui:btn:action[apply]"
                text: L10n.strings.buttons.resetAllDefaults
                onClicked: {
                    resetDefaultsAlert.hide();
                    InputBindingsManager.restoreDefaultBindings();
                }
            }

            DefaultButton {
                objectName: "ui:btn:action[cancel]"
                text: L10n.strings.buttons.cancel
                onClicked: {
                    resetDefaultsAlert.hide();
                }
            }
        }
    }

    Alert { id: confirmBindingOverwriteAlert
        titleText: L10n.strings.headers.confirmBindingOverwrite

        buttons: VisualItemModel {
            CTAButton {
                objectName: "ui:btn:action[apply]"
                text: L10n.strings.buttons.confirm
                onClicked: {
                    InputBindingsManager.conflictCfg.confirm();
                }
            }

            DefaultButton {
                objectName: "ui:btn:action[cancel]"
                text: L10n.strings.buttons.cancel
                onClicked: {
                    InputBindingsManager.conflictCfg.cancel();
                }
            }
        }
    }

    Connections {
        target: InputBindingsManager

        onConflictsChanged: {
            var message,
                cfg,
                conflicts = InputBindingsManager.conflicts;

            if (conflicts) {
                message = L10n.strings.modalMessages.confirmBindingOverwrite;
                cfg = InputBindingsManager.conflictCfg;

                message = message.replace('{0}',
                    ['<span style="color: ', Theme.colors.highlight, '">', cfg.key.toUpperCase(), '</span>'].join('')
                );
                message = message.replace('{1}',
                    ['<span style="color: ', Theme.colors.highlight, '">', conflicts, '</span>'].join('')
                );

                confirmBindingOverwriteAlert.messageText = message;
                confirmBindingOverwriteAlert.show();
            } else {
                confirmBindingOverwriteAlert.hide();
            }
        }
    }
}
