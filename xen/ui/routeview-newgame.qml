import QtQuick 2.9
import CrowbarCollective 1.0

RouteView { id: newGame
    Carousel { id: newGameCarousel
        property int unlockedCount: 0

        Component.onCompleted: {
            newGameCarousel.unlockedCount = BlackMesaEngine.getConsoleVariableAsInt("sv_unlockedchapters");
        }

        itemComponent: CarouselNewGameItem {
            buttonText: model.buttonText
            isLocked: model.chapterNumber > newGameCarousel.unlockedCount
            thumbnailUrl: model.thumbnailUrl
            chapterName: model.chapterName
            chapterNumber: model.chapterNumber

            onSelected: newGame.loadMapRequest(model.map, model.chapterName);
        }

        levels: ListModel {
            Component.onCompleted: {
                var names = L10n.strings.maps,
                    buttonText = L10n.strings.buttons.startGame

                append({
                    chapterName: names.chapter1,
                    chapterNumber: 1,
                    map: "xen_c4a1",
                    thumbnailUrl: "image://game/ui/campaign/images/chapter1.png",
                    buttonText: buttonText
                });

                append({
                    chapterName: names.chapter2,
                    chapterNumber: 2,
                    map: "xen_c4a2",
                    thumbnailUrl: "image://game/ui/campaign/images/chapter2.png",
                    buttonText: buttonText
                });

                append({
                    chapterName: names.chapter3,
                    chapterNumber: 3,
                    map: "xen_c4a1a",
                    thumbnailUrl: "image://game/ui/campaign/images/chapter3.png",
                    buttonText: buttonText
                });

                append({
                    chapterName: names.chapter4,
                    chapterNumber: 4,
                    map: "xen_c4a3",
                    thumbnailUrl: "image://game/ui/campaign/images/chapter4.png",
                    buttonText: buttonText
                });
            }
        }
    }
}
