import QtQuick 2.9
import CrowbarCollective 1.0

RouteView {
    id: newGame
    Carousel {
        id: newGameCarousel

        property var campaignEntries: BlackMesaEngine.listCampaignEntries().filter(function (campaign) { return campaign.isOfficial })
        property var currentlySelectedCampaign: null

        // property int officialChaptersUnlockedCount: BlackMesaEngine.getConsoleVariableAsInt("sv_unlockedchapters")

        Component.onCompleted: {
            campaignEntries.forEach(function (item) {
                item.levelName = ""
                levels.append(item)
            })

            if (levels.count === 1) {
                currentlySelectedCampaign = campaignEntries[0]
            }
        }

        onCurrentlySelectedCampaignChanged: {
            if (!currentlySelectedCampaign) {
                return
            }

            levels.clear()

            currentlySelectedCampaign.chapters.forEach(function (item) {
                levels.append(item)
            })

            showLeft = false
            showRight = levels.count > 4

            if (levels.count === 1) {
                newGame.loadMapRequest(
                            currentlySelectedCampaign.chapters[0].levelName,
                            BlackMesaEngine.getLocalizedString(
                                currentlySelectedCampaign.chapters[0].title))
            }
        }

        Component {
            id: campaignDelegate
            CarouselNewGameItem {
                property string localizedTitle: BlackMesaEngine.getLocalizedString(model.title)

                buttonText: L10n.strings.buttons.startGame

                isLocked: false

                thumbnailUrl: model.imageSource
                chapterName: localizedTitle
                chapterNumber: (index + 1)

                onSelected: newGameCarousel.currentlySelectedCampaign = newGameCarousel.campaignEntries[index]
                onSelectedWithDoubleClick: selected()

                type: BlackMesaEngine.getLocalizedString("#GameUI_NewGame")
            }
        }

        Component {
            id: chapterDelegate
            CarouselNewGameItem {
                property string localizedTitle: BlackMesaEngine.getLocalizedString(model.title)

                buttonText: L10n.strings.buttons.startGame

                // isLocked: (index + 1) > newGameCarousel.officialChaptersUnlockedCount && newGameCarousel.currentlySelectedCampaign.isOfficial
                isLocked: false

                thumbnailUrl: model.imageSource
                chapterName: localizedTitle
                chapterNumber: (index + 1)

                onSelected: newGame.loadMapRequest(model.levelName, localizedTitle)
                onSelectedWithDoubleClick: selected()

                type: BlackMesaEngine.getLocalizedString("#GameUI_Chapter")
            }
        }

        itemComponent: currentlySelectedCampaign !== null ? chapterDelegate : campaignDelegate

        levels: ListModel {}
    }
}
