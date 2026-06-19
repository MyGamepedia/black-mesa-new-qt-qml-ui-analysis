import QtQuick 2.9

CarouselItem {
    property int chapterNumber: 0

    property int verticalSpacing: Math.ceil(2 * Theme.heightScale)
    property int chapterNameFontSize: Math.ceil(26 * Theme.heightScale)
    property int numberFontSize: Math.ceil(15 * Theme.heightScale)

    textComponent: Column {
        spacing: verticalSpacing

        Text { id: chapterNameText
            text: chapterName
            font.pixelSize: chapterNameFontSize
            font.family: Theme.fonts.regular
            color: Theme.colors.headerText
        }

        Text { id: chapterNumberText
            text: "Chapter " + chapterNumber
            font.pixelSize: numberFontSize
            font.family: Theme.fonts.light
            color: Theme.colors.text
        }
    }
}
