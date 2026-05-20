import QtQuick 2.9
import CrowbarCollective 1.0

CarouselItem {
    property int chapterNumber: 0

    property int verticalSpacing: Math.ceil(2 * Theme.heightScale)
    property int chapterNameFontSize: Math.ceil(24 * Theme.widthScale)
    property int numberFontSize: Math.ceil(15 * Theme.heightScale)

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
            font.pixelSize: numberFontSize
            font.family: Theme.fonts.light
            color: Theme.colors.text
        }
    }
}
