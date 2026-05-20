import QtQuick 2.9
import CrowbarCollective 1.0

MouseArea { id: alert
    property bool skrim: true
    property alias titleText: headerText.text
    property alias messageText: bodyText.text
    property VisualItemModel buttons

    property int modalWidth: Math.ceil(700 * Theme.heightScale)
    property int modalHeight: Math.ceil(215 * Theme.heightScale)
    property int spacing: Math.ceil(25 * Theme.heightScale)
    property int headerHeight: Math.ceil(65 * Theme.heightScale)
    property int padding: Math.ceil(25 * Theme.widthScale)
    property int headerFontSize: Math.ceil(18 * Theme.heightScale)
    property int buttonSpacing: Math.ceil(5 * Theme.widthScale)

    anchors.fill: parent
    hoverEnabled: true
    visible: false

    function show() {
        state = "visible";
    }

    function hide() {
        state = "hidden";
    }

    onClicked: {
        mouse.accepted = true;
    }

    onEntered: { /* do nothing but intercept and halt event propagation */ }
    onExited: { /* do nothing but intercept and halt event propagation */ }

    state: "hidden"
    states: [
        State {
            name: "hidden"
            PropertyChanges { target: skrimRect; opacity: 0; }
            PropertyChanges { target: modal; opacity: 0 }
            PropertyChanges { target: alert; enabled: false; visible: false; hoverEnabled: false }
        },
        State {
            name: "visible"
            PropertyChanges { target: skrimRect; opacity: Theme.opacity.modalSkrim }
            PropertyChanges { target: modal; opacity: Theme.opacity.modal }
            PropertyChanges { target: alert; enabled: true; visible: true; hoverEnabled: true }
        }
    ]

    Rectangle { id: skrimRect
        visible: skrim
        anchors.fill: parent
        color: Theme.colors.skrim
    }

    Item { id: modal
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 30000

        width: modalWidth
        height: modalHeight

        Rectangle { id: background
            anchors.fill: parent
            color: Theme.colors.modalBackground
            opacity: Theme.opacity.modal
        }

        Item { id: header
            width: parent.width
            height: alert.headerHeight

            Rectangle {
                anchors.fill: parent
                color: Theme.colors.highlight
                opacity: Theme.opacity.modalHeader
            }

            Text { id: headerText
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.colors.headerText
                font.family: Theme.fonts.bold
                font.pixelSize: alert.headerFontSize
                font.capitalization: Font.AllUppercase
                leftPadding: alert.padding
            }
        }

        Text { id: bodyText
            anchors.topMargin: alert.padding
            anchors.top: header.bottom
            leftPadding: alert.padding
            font.family: Theme.fonts.light
            font.pixelSize: alert.headerFontSize
            textFormat: Text.RichText
            color: Theme.colors.text
        }

        ListView {
            width: parent.width
            height: headerHeight
            anchors.top: bodyText.bottom
            anchors.topMargin: alert.padding
            anchors.rightMargin: alert.padding
            anchors.right: parent.right
            layoutDirection: Qt.RightToLeft

            orientation: Qt.Horizontal
            spacing: alert.buttonSpacing

            interactive: false;
            cacheBuffer: 0;

            model: buttons
        }
    }

    transitions: [
        Transition {
            from: "hidden"
            to: "visible"

            ParallelAnimation {
                NumberAnimation {
                    target: skrimRect
                    property: "opacity"
                    duration: 600
                }

                NumberAnimation {
                    target: modal
                    property: "anchors.verticalCenterOffset"
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
                        target: modal
                        property: "opacity"
                        from: 0.0
                        to: 1.0
                        duration: 300
                    }
                    PauseAnimation {
                        duration: 150
                    }
                    ScriptAction {
                        script: {
                            BlackMesaUtils.traverseUIElements(alert);
                            BlackMesaUtils.afterTraverseCallback();
                        }
                    }
                }
            }
        },
        Transition {
            SequentialAnimation {
                ScriptAction { script: BlackMesaUtils.clearUIElementsData(); }
                ParallelAnimation {
                    NumberAnimation {
                        target: skrimRect
                        property: "opacity"
                        duration: 600
                    }
                    NumberAnimation {
                        target: modal
                        property: "anchors.verticalCenterOffset"
                        from: 0
                        to: 300
                        duration: 600
                        easing.type: Easing.InOutQuint
                    }
                    NumberAnimation {
                        target: modal
                        property: "opacity"
                        from: 1.0
                        to: 0.0
                        duration: 300
                    }
                }
                NumberAnimation {
                    target: modal
                    property: "anchors.verticalCenterOffset"
                    from: 300
                    to: 30000
                    duration: 1
                }
                ScriptAction {
                    script: {
                        BlackMesaUtils.traverseUIElements(appRoot);
                        BlackMesaUtils.afterTraverseCallback();
                        appRoot.forceActiveFocus();
                    }
                }
            }
        }
    ]
}
