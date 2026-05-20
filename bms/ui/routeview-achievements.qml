import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

RouteView {
    property int total
    property int completed

    property int pageWidth: Math.ceil(1500 * Theme.widthScale)
    property int pageHeight: cellH * Math.floor(Math.ceil(750 * Theme.heightScale) / cellH)
    property int headerHeight: Math.ceil(30 * Theme.widthScale)
    property int cellW: Math.ceil(750 * Theme.widthScale)
    property int cellH: Math.ceil(150 * Theme.widthScale)

    Item {
        anchors.centerIn: parent
        width: pageWidth
        height: pageHeight

        Item { id: header
            anchors.bottom: grid.top
            anchors.bottomMargin: Math.ceil(10 * Theme.heightScale)
            width: parent.width - Math.ceil(20 * Theme.widthScale)
            height: headerHeight

            Text { id: headerText
                anchors.left: parent.left
                anchors.leftMargin: Math.ceil(10 * Theme.widthScale)
                text: BlackMesaEngine.getLocalizedString("#BlackMesaUI_Achievements_OverallProgress")
                font.family: Theme.fonts.bold
                color: Theme.colors.headerText
                font.pixelSize: Math.ceil(24 * Theme.widthScale)
                font.capitalization: Font.AllUppercase
            }

            Rectangle {
                anchors.left: headerText.right
                anchors.right: headerFraction.left
                anchors.leftMargin: Math.ceil(20 * Theme.widthScale)
                anchors.rightMargin: Math.ceil(20 * Theme.widthScale)
                height: parent.height

                color: 'transparent'
                border.color: Theme.colors.dimmedSlider
                border.width: 2

                Rectangle {
                    width: parent.width * (completed / total)
                    color: Theme.colors.highlight
                    anchors.left: parent.left
                    height: parent.height
                }
            }

            Text { id: headerFraction
                anchors.right: parent.right
                anchors.rightMargin: Math.ceil(10 * Theme.widthScale)
                horizontalAlignment: Text.AlignRight
                text: [
                    '<font color="', Theme.colors.highlight, '">',
                        completed,
                    '</font>',
                    '<font color="', Theme.colors.headerText, '">',
                        " / ", total,
                    '</font>'
                ].join('')
                font.family: Theme.fonts.bold
                font.pixelSize: Math.ceil(24 * Theme.widthScale)
            }
        }

        GridView { id: grid
            clip: true
            anchors.fill: parent
            anchors.rightMargin: -Math.ceil(20 * Theme.widthScale)
            cellWidth: cellW
            cellHeight: cellH

            interactive: true
            boundsBehavior: Flickable.StopAtBounds

            ScrollBar.vertical: VerticalScrollBar {
                visible: true
            }

            delegate: MouseArea {
                width: cellW
                height: cellH

                state: count === total ? 'focused' : 'locked'

                states: [
                    State {
                        name: "locked"
                        PropertyChanges { target: background; border.width: 0; color: "#A6000000" }
                        PropertyChanges { target: image; border.width: 0 }
                        PropertyChanges { target: achievementDescription; color: Theme.colors.dimmedText }
                        PropertyChanges { target: achievementName; color: Theme.colors.dimmedText }
                        PropertyChanges { target: progressText; color: Theme.colors.dimmedText }
                    },
                    State {
                        name: "blurred"
                        PropertyChanges { target: background; border.width: 0; color: "#F2000000" }
                        PropertyChanges { target: image; border.width: 1 }
                        PropertyChanges { target: achievementDescription; color: Theme.colors.headerText }
                        PropertyChanges { target: achievementName; color: Theme.colors.headerText }
                        PropertyChanges { target: progressText; color: Theme.colors.headerText }
                    },
                    State {
                        name: "focused"
                        PropertyChanges { target: background; border.width: 2; color: "#F2000000" }
                        PropertyChanges { target: image; border.width: 1 }
                        PropertyChanges { target: achievementDescription; color: Theme.colors.headerText }
                        PropertyChanges { target: achievementName; color: Theme.colors.highlight }
                        PropertyChanges { target: progressText; color: Theme.colors.highlight }
                    }
                ]

                Rectangle { id: background
                    anchors.centerIn: parent
                    height: Math.ceil(130 * Theme.widthScale)
                    width: Math.ceil(730 * Theme.widthScale)
                    border.color: Theme.colors.highlight

                    Rectangle { id: image
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.topMargin: Math.ceil(5 * Theme.widthScale)
                        anchors.leftMargin: Math.ceil(5 * Theme.widthScale)

                        height: Math.ceil(120 * Theme.widthScale)
                        width: Math.ceil(120 * Theme.widthScale)
                        color: 'black'

                        Image { id: achievementThumbnailImage
                            source: thumbnailPath
                            height: image.height
                            width: image.width
                            fillMode: Image.Stretch
                            anchors.centerIn: parent
                        }

                    }

                    Rectangle {
                        anchors.top: parent.top
                        anchors.left: image.right
                        anchors.leftMargin: Math.ceil(5 * Theme.widthScale)
                        anchors.topMargin: Math.ceil(5 * Theme.widthScale)
                        width: Math.ceil(450 * Theme.widthScale)
                        height: Math.ceil(120 * Theme.widthScale)
                        color: 'transparent'

                        Rectangle { id: progressBar
                            visible: count !== total
                            height: parent.height
                            width: parent.width * (count / total)
                            anchors.left: parent.left
                            anchors.top: parent.top
                            color: "#A6000000"
                        }

                        Text { id: achievementName
                            anchors.top: parent.top
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.topMargin: Math.ceil(15 * Theme.widthScale)
                            anchors.leftMargin: Math.ceil(15 * Theme.widthScale)
                            anchors.rightMargin: Math.ceil(15 * Theme.widthScale)
                            text: name
                            font.capitalization: Font.AllUppercase
                            font.pixelSize: Math.ceil(26 * Theme.widthScale)
                            font.family: Theme.fonts.bold
                        }

                        Text { id: achievementDescription
                            anchors.top: achievementName.bottom
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            width: parent.width - anchors.leftMargin * 2
                            anchors.topMargin: Math.ceil(5 * Theme.widthScale)
                            anchors.bottomMargin: Math.ceil(15 * Theme.widthScale)
                            anchors.leftMargin: Math.ceil(15 * Theme.widthScale)
                            text: description
                            font.family: Theme.fonts.regular
                            wrapMode: Text.WordWrap
                            font.pixelSize: Math.ceil(16 * Theme.widthScale)
                        }
                    }

                    Item {
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.topMargin: Math.ceil(5 * Theme.widthScale)
                        anchors.rightMargin: Math.ceil(5 * Theme.widthScale)

                        width: Math.ceil(140 * Theme.widthScale)
                        height: Math.ceil(120 * Theme.widthScale)

                        Rectangle {
                            visible: total > 1 && count !== total
                            anchors.fill: parent
                            color: "#A6000000"
                        }

                        Text { id: progressText
                            visible: total > 1
                            text: count + " / " + total
                            font.family: Theme.fonts.bold
                            font.pixelSize: Math.ceil(28 * Theme.widthScale)
                            anchors.centerIn: parent
                        }
                    }
                }
            }

            model: ListModel { id: achievementsModel
                Component.onCompleted: {


                    var achievements = BlackMesaEngine.listAchievementEntries().map(function (entry) {
                        return {
                            thumbnailPath: !entry.isAchieved ? entry.imageSourceLocked : entry.imageSourceUnlocked,
                            name: BlackMesaEngine.getLocalizedString(entry.name),
                            description: BlackMesaEngine.getLocalizedString(entry.description),
                            hidden: !entry.isAchieved && entry.shouldHideUntilAchieved,
                            count: entry.count,
                            total: entry.goal
                        };
                    });


                    completed = 0;
                    var hiddenCount = 0;
                    total = achievements.length;

                    achievements.forEach(function (a) {
                        if (a.hidden && a.count !== a.total) {
                            hiddenCount++;
                        }

                        if (a.count === a.total) {
                            completed++;
                        }

                        if (!a.hidden || (a.hidden && a.count === a.total)) {
                            append(a);
                        }
                    });

                    if (hiddenCount > 0) {
                        append({
                            image: "",
                            name: BlackMesaEngine.getLocalizedString("#BlackMesaUI_Achievements_Hidden").arg(hiddenCount),
                            description: BlackMesaEngine.getLocalizedString("#BlackMesaUI_Achievements_HiddenDescription").arg(hiddenCount),
                            hidden: false,
                            count: 0,
                            total: 1
                        });
                    }
                }
            }
        }
    }
}
