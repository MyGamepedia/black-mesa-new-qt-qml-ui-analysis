import QtQuick 2.9
import CrowbarCollective 1.0

CarouselItem {
    property string saveType
    property string date

    property int verticalSpacing: Math.ceil(2 * Theme.heightScale)
    property int chapterNameFontSize: Math.ceil(26 * Theme.widthScale)
    property int dateFontSize: Math.ceil(16 * Theme.heightScale)

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
            font.pixelSize: dateFontSize
            font.family: Theme.fonts.regular
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
            font.capitalization: Font.AllUppercase
            font.pixelSize: dateFontSize
            font.family: saveType === "manual" ? Theme.fonts.bold : Theme.fonts.regular
            color: saveType === "auto" ? Theme.colors.dimmedText : Theme.colors.text
        }
    }
}
