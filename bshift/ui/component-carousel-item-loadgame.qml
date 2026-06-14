import QtQuick 2.9
import CrowbarCollective 1.0

CarouselSavesItem {
    property string saveType
    property string date

    property int verticalSpacing: Math.ceil(2 * Theme.heightScale)
    property int chapterNameFontSize: Math.ceil(34 * Theme.heightScale)
    property int dateFontSize: Math.ceil(18 * Theme.heightScale)
    property int numberLeftMargin: Math.ceil(1 * Theme.widthScale)

    textComponent: Column {
        spacing: verticalSpacing

        Text { id: chapterNameLabel
            text: chapterName
            font.pixelSize: chapterNameFontSize
            font.family: Theme.fonts.regular
            color: Theme.colors.headerText
        }

        Text { id: dateText
            text: date
            anchors.left: parent.left
            anchors.leftMargin: numberLeftMargin
            font.pixelSize: dateFontSize
            font.family: Theme.fonts.regular
			font.capitalization: Font.Capitalize
            color: Theme.colors.text
        }

        Text { id: saveTypeText
            text: {
                var labels = {
                        autosave: L10n.strings.labels.autoSave,
                        quick: L10n.strings.labels.quickSave,
                        manual: L10n.strings.labels.manualSave
                    };

                return labels[saveType] || "";
            }
            anchors.left: parent.left
            anchors.leftMargin: numberLeftMargin
            font.capitalization: Font.AllUppercase
            font.pixelSize: dateFontSize
            font.family: Theme.fonts.regular
            font.bold: saveType === "manual" ? true : false
            color: Theme.colors.text
        }
    }
}
