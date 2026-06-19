pragma Singleton

import QtQuick 2.9
import CrowbarCollective 1.0

QtObject {
    function getSaveGames() {
        var data = (BlackMesaEngine.listSaveEntries() || []).sort(function (a, b) {
                return new Date(b.dateCreated) - new Date(a.dateCreated);
            }).map(function (save) {
                var type = "manual",
                    match = save.name.match(/^(auto|quick)\d*$/);

                if (match) {
                    type = match[1];
                }

                return {
                    savename: save.name,
                    chapter: Number((save.chapter.match(/Chapter(\d+)?/m) || [])[1] || "-1"),
                    chapterName: L10n.getString(save.chapter.replace("#bms_", "#QTUI_Maps_")),
                    type: type,
                    dateCreated: new Date(save.dateCreated),
                    thumbnail: save.thumbnailUrl
                };
            });

        return data;
    }

    function saveGame(filename) {
        var lastManualSave,
            saveNumber,
            padding = "";

        if (typeof filename !== "string" || !filename.length) {
            lastManualSave = getSaveGames().find(function (save) {
                return save.savename.indexOf("bms-") === 0;
            });

            saveNumber = 0;
            if (lastManualSave) {
                saveNumber = Number((filename.match(/bms-(\d+)?/m) || [])[1] || "-1");
                saveNumber = saveNumber++;
            }

            switch (saveNumber.toString().length) {
                case 1: padding = "00"; break;
                case 2: padding = "0"; break;
            }

            filename = "bms-" + padding + saveNumber.toString();
        }

        BlackMesaEngine.executeClientCommandUnrestricted("save " + filename + "; gameui_hide");
    }

    function loadGame(filename) {
        BlackMesaEngine.executeClientCommandUnrestricted("disconnect; maxplayers 1; load " + filename);
    }

    function loadMap(filename) {
        BlackMesaEngine.executeClientCommandUnrestricted("disconnect; maxplayers 1; map " + filename);
    }
}
