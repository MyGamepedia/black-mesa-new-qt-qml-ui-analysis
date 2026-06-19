import QtQuick 2.9
import CrowbarCollective 1.0

RouteView { id: saveGame
    property variant selectedModel

    Carousel { id: saveGameCarousel
        itemComponent: CarouselLoadGameItem {
            buttonText: model.buttonText
            thumbnailUrl: model.thumbnailUrl
            chapterName: model.chapterName
            date: Theme.getDateTimeString(model.date)
            saveType: model.saveType
            buttonType: model.buttonType
            onSelected: {
                if (model.savename) {
                    selectedModel = model;
                    confirmOverwriteAlert.show(model);
                } else {
                    saveGame.saveGameRequest(null);
                }
            }

            // same action than onSelected
            onSelectedWithDoubleClick: {
                if (model.savename) {
                    selectedModel = model;
                    confirmOverwriteAlert.show(model);
                } else {
                    saveGame.saveGameRequest(null);
                }
            }

            secondaryButtonVisible: !!model.savename
            buttonTextSecondary: BlackMesaEngine.getLocalizedString("#GameUI_Delete")

            onSelectedSecondary: {
                saveGame.selectedModel = model
                confirmDeleteAlert.show()
            }
        }

        levels: ListModel {
            Component.onCompleted: {
                var data = BlackMesaUtils.getSaveGames(),
                    overwriteButtonText = L10n.strings.buttons.overwriteSave,
                    createSaveButtonText = L10n.strings.buttons.createSave,
                    newSaveText = L10n.strings.labels.newSave

                append({
                    date: null,
                    saveType: "",
                    savename: "",
                    chapterName: newSaveText,
                    thumbnailUrl: "image://game/ui/images/newSaveThumbnail.png",
                    buttonText: createSaveButtonText,
                    buttonType: "cta"
                });

                data.forEach(function (save) {
                    if (!save.savename.match(/^(autosave|quick)\d*$/)) {
                        append({
                            savename: save.savename,
                            chapterName: save.chapterName,
                            date: save.dateCreated,
                            thumbnailUrl: save.thumbnail,
                            saveType: save.type,
                            buttonText: overwriteButtonText,
                            buttonType: "warning"
                        });
                    }
                });
            }
        }
    }

    Alert { id: confirmOverwriteAlert
        titleText: L10n.strings.headers.overwriteSaveConfirmation
        messageText: L10n.strings.modalMessages.overwriteSaveConfirmation
        buttons: VisualItemModel { id: overwriteButtons
            WarningButton {
                objectName: "ui:btn:action[apply]"
                text: L10n.strings.buttons.overwriteSave
                onClicked: {
                    saveGame.saveGameRequest(selectedModel.savename);
                    selectedModel = null;
                }
            }

            DefaultButton {
                objectName: "ui:btn:action[cancel]"
                text: L10n.strings.buttons.cancel
                onClicked: {
                    confirmOverwriteAlert.hide();
                }
            }
        }
    }

    Alert { id: confirmDeleteAlert
        titleText: L10n.strings.headers.deleteSaveConfirmation
        messageText: L10n.strings.modalMessages.deleteSaveConfirmation
        buttons: VisualItemModel { id: deleteButtons
            WarningButton {
                objectName: "ui:btn:action[apply]"
                text: L10n.strings.buttons.deleteSave
                onClicked: {
                    if (BlackMesaEngine.removeSaveEntry(selectedModel.savename)) {
                        saveGameCarousel.levels.clear()
                        saveGameCarousel.levels.Component.completed()
                    }

                    selectedModel = null;
                    confirmDeleteAlert.hide()
                }
            }

            DefaultButton {
                objectName: "ui:btn:action[cancel]"
                text: L10n.strings.buttons.cancel
                onClicked: {
                    confirmDeleteAlert.hide();
                }
            }
        }
    }
}
