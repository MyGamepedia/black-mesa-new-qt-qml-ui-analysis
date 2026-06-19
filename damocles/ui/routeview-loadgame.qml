import QtQuick 2.9
import CrowbarCollective 1.0

RouteView { id: loadGame
    property variant selectedModel

    Carousel { id: loadGameCarousel
        itemComponent: CarouselLoadGameItem {
            buttonText: model.buttonText
            thumbnailUrl: model.thumbnailUrl
            chapterName: model.chapterName
            date: Theme.getDateTimeString(model.date)
            saveType: model.saveType
            onSelected:                loadGame.loadGameRequest(model)
            onSelectedWithDoubleClick: loadGame.loadGameRequest(model)

            secondaryButtonVisible: true
            buttonTextSecondary: BlackMesaEngine.getLocalizedString("#GameUI_Delete")

            onSelectedSecondary: {
                loadGame.selectedModel = model
                confirmDeleteAlert.show()
            }
        }

        Component.onCompleted: {
            BlackMesaUtils.getSaveGames().forEach(function (save) {
                levels.append({
                    savename: save.savename,
                    chapter: save.chapter,
                    chapterName: save.chapterName,
                    date: save.dateCreated,
                    thumbnailUrl: save.thumbnail,
                    saveType: save.type,
                    buttonText: L10n.strings.buttons.resume
                });
            });
        }

        levels: ListModel {}
    }

    Alert { id: confirmDeleteAlert
        titleText: L10n.strings.headers.deleteSaveConfirmation
        messageText: L10n.strings.modalMessages.deleteSaveConfirmation
        buttons: VisualItemModel { id: deleteButtons
            WarningButton {
                objectName: "ui--navigation:button:level_3"
                text: L10n.strings.buttons.deleteSave
                callback: function() {
                    if (BlackMesaEngine.removeSaveEntry(selectedModel.savename)) {
                        loadGameCarousel.levels.clear()
                        loadGameCarousel.levels.Component.completed()
                    }

                    selectedModel = null;
                    confirmDeleteAlert.hide()
                }
                onClicked: {
                    if (BlackMesaEngine.removeSaveEntry(selectedModel.savename)) {
                        loadGameCarousel.levels.clear()
                        loadGameCarousel.levels.Component.completed()
                    }

                    selectedModel = null;
                    confirmDeleteAlert.hide()
                }
            }

            DefaultButton {
                objectName: "ui--navigation:button:level_3"
                text: L10n.strings.buttons.cancel
                callback: function() {
                    confirmDeleteAlert.hide();
                }
                onClicked: {
                    confirmDeleteAlert.hide();
                }
            }
        }
    }
}
