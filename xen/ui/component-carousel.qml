import QtQuick 2.9

Item { id: carousel
    anchors.fill: parent

    property ListModel levels
    property Component itemComponent

    property int buttonTopMargin: Math.ceil(11 * Theme.heightScale)
    property int buttonHorizontalMargin: Math.ceil(25 * Theme.widthScale)
    property int maskHeight: Math.ceil(385 * Theme.heightScale)
    property int maskWidth: parent.width - maskPadding
    property int maskPadding: Math.ceil(100 * Theme.widthScale) * 2
    property int itemHeight: Math.ceil(385 * Theme.heightScale)
    property int itemWidth: Math.ceil(400 * Theme.heightScale)
    property int itemSpacing: Math.ceil(5 * Theme.widthScale)

    property bool showRight: false
    property bool showLeft: false
    property int visibleCount: Math.floor(maskWidth / (itemWidth + itemSpacing))

    CarouselButton {
        enabled: showLeft
        opacity: showLeft ? 1.0 : 0.0
        direction: "left"

        anchors.topMargin: buttonTopMargin
        anchors.leftMargin: buttonHorizontalMargin
        anchors.top: mask.top
        anchors.right: mask.left

        onClicked: {
            var count = itemsList.count,
                currX = itemsList.contentX,
                itemW = carousel.itemWidth,
                leftIndex = Math.floor(currX / itemW),
                newIndex = leftIndex - visibleCount >= 0 ? leftIndex - visibleCount : 0,
                newX;

            itemsList.positionViewAtIndex(newIndex, ListView.Beginning);
            newX = itemsList.contentX;

            paginateAnim.from = currX;
            paginateAnim.to = newX;
            paginateAnim.running = true;
            showRight = count - (newIndex + visibleCount) > 0

            if (newIndex === 0) {
                showLeft = false;
            }
        }

        Behavior on opacity {
            NumberAnimation { duration: 150 }
        }
    }

    Item { id: mask
        anchors.centerIn: parent
        clip: true
        height: maskHeight
        width: visibleCount * (itemWidth + itemSpacing)

        ListView { id: itemsList
            interactive: false

            height: itemHeight
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            orientation: Qt.Horizontal
            spacing: itemSpacing

            model: carousel.levels
            delegate: itemComponent

            Component.onCompleted: {
                showRight = count > 4;
            }
        }

        NumberAnimation { id: paginateAnim
            target: itemsList
            property: "contentX"
            duration: 600
            easing.type: Easing.InOutQuint
        }
    }

    CarouselButton {
        enabled: showRight
        opacity: showRight ? 1.0 : 0.0
        direction: "right"

        anchors.topMargin: buttonTopMargin
        anchors.rightMargin: buttonHorizontalMargin
        anchors.top: mask.top
        anchors.left: mask.right

        onClicked: {
            var count = itemsList.count,
                currX = itemsList.contentX,
                itemW = carousel.itemWidth,
                leftIndex = Math.floor(currX / itemW),
                rightIndex = leftIndex + visibleCount - 1,
                clippedRightCount = count - (visibleCount + leftIndex),
                newIndex = clippedRightCount - visibleCount >= 0 ? rightIndex + visibleCount : count - 1,
                newX;

            itemsList.positionViewAtIndex(newIndex, ListView.End);
            newX = itemsList.contentX;

            paginateAnim.from = currX;
            paginateAnim.to = newX;
            paginateAnim.running = true;
            showLeft = newIndex - visibleCount > 0;

            if (newIndex === count - 1) {
                showRight = false;
            }
        }

        Behavior on opacity {
            NumberAnimation { duration: 150 }
        }
    }
}
