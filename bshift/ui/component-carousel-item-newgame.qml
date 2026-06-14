import QtQuick 2.9
import CrowbarCollective 1.0

CarouselItem {
    property int chapterNumber: 0

    property int verticalSpacing: 0
    property int chapterNameFontSize: Math.ceil(34 * Theme.heightScale)
    property int numberFontSize: Math.ceil(22 * Theme.heightScale)
    property int numberLeftMargin: Math.ceil(1 * Theme.widthScale)

    property string type: BlackMesaEngine.getLocalizedString("#GameUI_Chapter")

    textComponent: Column {
        spacing: verticalSpacing

        Text { id: chapterNameText
            text: chapterName
            font.pixelSize: chapterNameFontSize
            font.family: Theme.fonts.regular
            color: Theme.colors.headerText
        }

        Text { id: chapterNumberText
            text: type + " " + chapterNumber.toString()
            anchors.left: parent.left
            anchors.leftMargin: numberLeftMargin
            font.pixelSize: numberFontSize
            font.family: Theme.fonts.light
            color: Theme.colors.text
        }
    }
}
