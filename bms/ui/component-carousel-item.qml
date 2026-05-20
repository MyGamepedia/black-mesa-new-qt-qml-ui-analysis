import QtQuick 2.9
import CrowbarCollective 1.0

Item { id: carouselItem
    objectName: "ui:carousel-item"
    property bool isLocked: false
    property string focusedSoundPath: Theme.sounds.buttonFocused

    // data-based properties that should really be on some data object
    property string chapterName: "DEFAULT CHAPTER NAME"
    property string thumbnailUrl: "image://game/ui/images/background-reception.png"
    property string buttonText: "DEFAULT BUTTON TEXT"
    property string buttonTextSecondary: "DEFAULT BUTTON TEXT"
    property string buttonType: "cta"

    property bool secondaryButtonVisible: false

    property Component textComponent

    signal selected()
    signal selectedWithDoubleClick()

    signal selectedSecondary()

    width: itemWidth
    height: itemHeight

    anchors.verticalCenter: parent.verticalCenter

    property int itemWidth: Math.ceil(400 * Theme.widthScale)
    property int itemHeight: Math.ceil(400 * Theme.heightScale)
    property int thumbnailBorderSize: Math.ceil(2 * Theme.heightScale)
    property int verticalSpacing: Math.ceil(10 * Theme.heightScale)
    property int thumbnailBottomMargin: Math.ceil(5 * Theme.heightScale)
    property int thumbnailHeight: Math.ceil(214 * Theme.heightScale)
    property int thumbnailWidth: Math.ceil(380 * Theme.widthScale)

    Rectangle { id: background
        anchors.fill: parent
        border.width: 1
        border.color: Theme.colors.highlight
        color: Theme.colors.modalBackground
    }

    Item {
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.rightMargin: verticalSpacing
        anchors.leftMargin: verticalSpacing
        anchors.topMargin: verticalSpacing

        // Thumbnail
        Item { id: thumbnailContainer
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            height: Math.floor(width * 0.56)
            anchors.bottomMargin: thumbnailBottomMargin

            Rectangle {
                color: "#40000000"
                border.color: Theme.colors.modalBackground
                border.width: thumbnailBorderSize
                anchors.fill: parent
            }

            Image { id: thumbnail
                cache: false
                anchors.fill: parent
                anchors.margins: thumbnailBorderSize
                source: carouselItem.thumbnailUrl
                fillMode: Image.PreserveAspectCrop

                opacity: 0.0
                asynchronous: true

                onStatusChanged: if (status === Image.Ready) opacity = 1.0

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 250
                    }
                }
            }

            Rectangle { id: thumbnailSkrim
                anchors.fill: parent
                color: Theme.colors.modalBackground
                opacity: 0.5
            }

            Image { id: lockImage
                height: Math.ceil(sourceSize.height * Theme.heightScale)
                width: Math.ceil(sourceSize.width * Theme.heightScale)

                visible: isLocked
                anchors.centerIn: parent
                source: "image://game/ui/images/lock.png"

                opacity: 0.0
                asynchronous: true

                onStatusChanged: if (status === Image.Ready) opacity = 1.0

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 250
                    }
                }
            }
        }

        Loader { id: textComponentLoader
            visible: !isLocked
            anchors.top: thumbnailContainer.bottom
            anchors.topMargin: verticalSpacing

            sourceComponent: textComponent
            onLoaded: mouseArea.state = "blurred"
        }
    }

    MouseArea { id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        scrollGestureEnabled: false
        enabled: !isLocked && state !== "initializing"
        propagateComposedEvents: true
        state: "initializing"

        states: [
            State {
                name: "initializing"
                PropertyChanges { target: background; opacity: 0 }
                PropertyChanges { target: textComponentLoader; opacity: 0 }
                PropertyChanges { target: loader; opacity: 0 }
                PropertyChanges { target: loaderSecondary; opacity: 0 }
                PropertyChanges { target: thumbnailSkrim; opacity: 0 }
            },
            State {
                name: "blurred"
                when: !carouselItem.activeFocus //&& !loader.item.activeFocus && !loaderSecondary.item.activeFocus
                PropertyChanges { target: background; opacity: 0 }
                PropertyChanges { target: loader; opacity: 0 }
                PropertyChanges { target: loaderSecondary; opacity: 0 }
                PropertyChanges { target: textComponentLoader; opacity: 1 }
                PropertyChanges { target: textComponentLoader.item; opacity: 0.70 }
                PropertyChanges { target: thumbnailSkrim; opacity: 0.7 }
            },
            State {
                name: "focused"
                when: carouselItem.activeFocus// || loader.item.activeFocus || loaderSecondary.item.activeFocus
                PropertyChanges { target: background; opacity: 0.90 }
                PropertyChanges { target: loader; opacity: 1 }
                PropertyChanges { target: loaderSecondary; opacity: 1 }
                PropertyChanges { target: textComponentLoader; opacity: 1}
                PropertyChanges { target: textComponentLoader.item; opacity: 1 }
                PropertyChanges { target: thumbnailSkrim; opacity: 0 }
                StateChangeScript {
                    script: { Sound.playEffect(carouselItem.focusedSoundPath); }
                }
            }
        ]

        onEntered: {
            state = "focused"
        }

        onExited: {
            state = "blurred"
        }

        onDoubleClicked: {
            carouselItem.selectedWithDoubleClick();
        }

        Loader { id: loader
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: verticalSpacing
            anchors.bottomMargin: verticalSpacing

            Component.onCompleted: {
                loader.setSource("button-" + buttonType + ".qml")
            }

            onLoaded: {
                item.text = carouselItem.buttonText;
                item.clicked.connect(function () { carouselItem.selected(); });
            }
        }

        Loader { id: loaderSecondary
            anchors.bottom: parent.bottom
            anchors.left: loader.right
            anchors.leftMargin: verticalSpacing
            anchors.bottomMargin: verticalSpacing

            visible: carouselItem.secondaryButtonVisible

            Component.onCompleted: {
                loaderSecondary.setSource("button-" + buttonType + ".qml")
            }

            onLoaded: {
                item.text = carouselItem.buttonTextSecondary;
                item.clicked.connect(function () { carouselItem.selectedSecondary(); });
            }
        }
    }
}
