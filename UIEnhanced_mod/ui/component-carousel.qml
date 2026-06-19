import QtQuick 2.9
import CrowbarCollective 1.0

Item { id: carousel
    anchors.fill: parent

    property ListModel levels
    property Component itemComponent

    property int buttonTopMargin: Math.ceil(11 * Theme.heightScale)
    property int buttonHorizontalMargin: Math.ceil(25 * Theme.widthScale)
    property int maskHeight: Math.ceil(400 * Theme.heightScale)
    property int maskPadding: Math.ceil(100 * Theme.widthScale) * 2
    property int maskWidth: parent.width - maskPadding
    property int itemHeight: Math.ceil(400 * Theme.heightScale)
    property int itemWidth: Math.ceil(400 * Theme.widthScale)
    property int itemSpacing: Math.ceil(8 * Theme.widthScale)

    property bool showRight: false
    property bool showLeft: false
    property int visibleCount: Math.floor(maskWidth / (itemWidth + itemSpacing))

    /**
    *   Provides pagination change of slider
    */
    function changePagination(type) {
        if ( paginateAnimSeq.running === false ) {
            var count = itemsList.count,
                currX = itemsList.contentX,
                itemW = carousel.itemWidth,
                leftIndex = Math.floor(currX / itemW);

            // going left logic
            if (type === -1) {
                var newIndex = leftIndex - visibleCount >= 0 ? leftIndex - visibleCount : 0,
                newX;

                itemsList.positionViewAtIndex(newIndex, ListView.Beginning);
                itemsList.currentIndex = newIndex;
                newX = itemsList.contentX;

                paginateAnim.from = currX;
                paginateAnim.to = newX;
                paginateAnimSeq.running = true;
                showRight = count - (newIndex + visibleCount) > 0

                if (newIndex === 0) {
                    showLeft = false;
                }
            }

            // going right logic
            if (type === 1) {
                var rightIndex = leftIndex + visibleCount - 1,
                clippedRightCount = count - (visibleCount + leftIndex),
                newIndex = clippedRightCount - visibleCount >= 0 ? rightIndex + visibleCount : count - 1,
                newX;

                itemsList.positionViewAtIndex(newIndex, ListView.End);
                itemsList.currentIndex = newIndex;
                newX = itemsList.contentX;

                paginateAnim.from = currX;
                paginateAnim.to = newX;
                paginateAnimSeq.running = true;
                showLeft = newIndex - visibleCount >= 0;

                if (newIndex === count - 1) {
                    showRight = false;
                }
            }
        }
    }

    CarouselButton {
        enabled: showLeft
        opacity: showLeft ? 1.0 : 0.0
        direction: "left"

        anchors.topMargin: buttonTopMargin
        anchors.leftMargin: buttonHorizontalMargin
        anchors.top: mask.top
        anchors.right: mask.left

        onClicked: changePagination(-1)

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
            property int limit: visibleCount
            property int offset: 0
            property int page: limit * offset

            clip: true
            cacheBuffer: 8000
            interactive: false

            height: parent.height
            width: parent.width - itemSpacing
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            orientation: ListView.Horizontal
            spacing: itemSpacing

            model: carousel.levels
            delegate: itemComponent

            Component.onCompleted: {
                showRight = count > 4;
            }
        }

        SequentialAnimation { id: paginateAnimSeq
            NumberAnimation { id: paginateAnim
                target: itemsList
                property: "contentX"
                duration: 100  // the lower is this number, the faster will be the carousel translation animation
                easing.type: Easing.InOutQuint
            }
            ScriptAction {
               script: {
                   BlackMesaUtils.parseTraversalTree(appRoot);
                   BlackMesaUtils.traversalDepth = 2;
                   BlackMesaUtils.updateCurrentUISelection();
               }
            }
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

        onClicked: changePagination(1)

        Behavior on opacity {
            NumberAnimation { duration: 150 }
        }
    }
}
