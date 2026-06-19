import QtQuick 2.9
import CrowbarCollective 1.0

RouteView { id: loadGame
    Carousel { id: loadGameCarousel
        itemComponent: CarouselLoadGameItem {
            buttonText: model.buttonText
            thumbnailUrl: model.thumbnailUrl
            chapterName: model.chapterName
            date: Theme.getDateTimeString(model.date)
            saveType: model.saveType
            onSelected: loadGame.loadGameRequest(model)
        }

        levels: ListModel {
            Component.onCompleted: {
                BlackMesaUtils.getSaveGames().forEach(function (save) {
                    append({
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
        }
    }
}
