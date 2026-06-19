import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

RouteView {
    property var availableMultiplayerModels: ([])

    /**
     * Generates values for multiplayer model select box.
     */
    function generateModelSelectData () {
        return availableMultiplayerModels.map(function(item) {
            return { label: L10n.getString(item.name), value: item.model }
        })
    }

    /**
    * Returns count of available skins for current model
    */
    function findSkinsForCurrentSelectedModel(model) {
        return BlackMesaEngine.getCurrentMultiplayerModelSkins(model);
    }

    function generateModelSkinsSelectData(model, skinCount) {
        var skins = [];

        for (var i = 0; i < skinCount; ++i) {
            skins.push({ label: L10n.getString("#"+model+"_Skin"+(i)), value: Number(i).toString() });
        }

        return skins;
    }

    function setCurrentMultiplayerModel(model, skin) {
        try {
            BlackMesaEngine.setCurrentMultiplayerModel(model, skin);
        } catch (e) {
            //BlackMesaEngine.printConsoleMessage("#AFE4AA", e);
        }
    }

    OptionsList { id: characterOptions
        title: L10n.strings.headers.characterOptions
        visibleRows: 7

        anchors.centerIn: parent
        anchors.verticalCenterOffset: Math.ceil(20 * Theme.heightScale)

        readonly property QtObject groups: QtObject {
            function mp_multiplayer_character_model_group() {
                var characterModel = characterOptions.models.mp_multiplayer_character_model.value;
                var skins = findSkinsForCurrentSelectedModel(characterModel);

                characterOptions.models.mp_multiplayer_character_skin.options = generateModelSkinsSelectData(characterModel, skins);
                characterOptions.models.mp_multiplayer_character_skin.value = "0";

                if (skins < 2) {
                    characterOptions.models.mp_multiplayer_character_skin.disabled = true;
                } else {
                    characterOptions.models.mp_multiplayer_character_skin.disabled = false;
                }

                setCurrentMultiplayerModel(characterModel, characterOptions.models.mp_multiplayer_character_skin.value);
            }
            function mp_multiplayer_character_skin_group() {
                setCurrentMultiplayerModel(characterOptions.models.mp_multiplayer_character_model.value, characterOptions.models.mp_multiplayer_character_skin.value);
            }
        }

        onRequestSettingsChange: {
            setValue(model, value);
        }

        model: ListModel { id: characterOptionsModel
            Component.onCompleted: {
                var labels = L10n.strings.options.labels,
                    values = L10n.strings.options.values,
                    currentMultiplayerModel,
                    currentMultiplayerModelSkins;

                try {
                    availableMultiplayerModels = BlackMesaEngine.getAvailableMultiplayerModels();
                    // Call UI proxy to get current selected multiplayer character
                    //availableMultiplayerModels = BlackMesaEngine.getAvailableMultiplayerModels();
                    currentMultiplayerModel = BlackMesaEngine.getCurrentMultiplayerModel();
                    currentMultiplayerModelSkins = generateModelSkinsSelectData(currentMultiplayerModel.model, findSkinsForCurrentSelectedModel(currentMultiplayerModel.model));
                } catch (e) {
                    // Here should be proper global error handling,
                    // but we don't have that...
                }

                // MP Models selector
                append({
                    label: labels.game_multiplayermodel,
                    type: "select",
                    valueType: "string",
                    value: currentMultiplayerModel.model,
                    key: "mp_multiplayer_character_model",
                    group: "mp_multiplayer_character_model_group",
                    options: generateModelSelectData()
                });

                append({
                    disabled: false,
                    label: labels.game_multiplayerskin,
                    type: "select",
                    valueType: "int",
                    value: "0", // Current selected multiplayer model
                    key: "mp_multiplayer_character_skin",
                    group: "mp_multiplayer_character_skin_group",
                    options: currentMultiplayerModelSkins
                });

                // ----------------------------------------------
            }
        }
    }
}
