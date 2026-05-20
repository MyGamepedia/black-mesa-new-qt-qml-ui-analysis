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

    OptionsList { id: gameOptions
        title: L10n.strings.headers.gameOptions
        visibleRows: 7

        anchors.centerIn: parent
        anchors.verticalCenterOffset: Math.ceil(20 * Theme.heightScale)

        readonly property QtObject groups: QtObject {
            function mp_multiplayer_character_model_group() {
                var characterModel = gameOptions.models.mp_multiplayer_character_model.value;
                var skins = findSkinsForCurrentSelectedModel(characterModel);

                gameOptions.models.mp_multiplayer_character_skin.options = generateModelSkinsSelectData(characterModel, skins);
                gameOptions.models.mp_multiplayer_character_skin.value = "0";

                if (skins < 2) {
                    gameOptions.models.mp_multiplayer_character_skin.disabled = true;
                } else {
                    gameOptions.models.mp_multiplayer_character_skin.disabled = false;
                }

                setCurrentMultiplayerModel(characterModel, gameOptions.models.mp_multiplayer_character_skin.value);
            }
            function mp_multiplayer_character_skin_group() {
                setCurrentMultiplayerModel(gameOptions.models.mp_multiplayer_character_model.value, gameOptions.models.mp_multiplayer_character_skin.value);
            }
        }

        onRequestSettingsChange: {
            setValue(model, value);
        }

        model: ListModel { id: gameOptionsModel
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

                append({
                    label: labels.game_difficulty,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_difficulty",
                    cvar: "skill",
                    options: [
                        { label: values.difficultyEasy, value: "1" },
                        { label: values.difficultyNormal, value: "2" },
                        { label: values.difficultyHard, value: "3" }
                    ]
                });

                append({
                    label: labels.game_alwaysRun,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_alwaysRun",
                    cvar: "sv_always_run",
                    options: [
                        { label: values.no, value: "0" },
                        { label: values.yes, value: "1" }
                    ]
                });

                append({
                    label: labels.game_viewRoll,
                    type: "slider",
                    valueType: "real",
                    value: "",
                    key: "game_viewRoll",
                    cvar: "cl_view_roll",
                    minValue: 0.0,
                    maxValue: 3.5,
                    precision: 1,
                    formatter: 'decimal',
                    stepValue: 0.1
                });

                append({
                    label: labels.game_weaponSwitch,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_fastWeapon",
                    cvar: "hud_fastswitch",
                    options: [
                        { label: values.no, value: "0" },
                        { label: values.yes, value: "1" }
                    ]
                });

                append({
                    label: labels.game_AutoWeaponSwitch,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_AutoWeaponSwitch",
                    cvar: "cl_weapon_autoswitch",
                    options: [
                        { label: values.no, value: "0" },
                        { label: values.yes, value: "1" }
                    ]
                });

                append({
                    label: BlackMesaEngine.getLocalizedString("#BlackMesaUI_Options_Game_IronSightClassic"),
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_classicIronSight",
                    cvar: "cl_ironsight_classic",
                    options: [
                        { label: values.no, value: "0" },
                        { label: values.yes, value: "1" }
                    ]
                });

                append({
                    label: labels.game_autoCrouchJump,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_autoCrouch",
                    cvar: "cl_auto_crouch_jump",
                    options: [
                         { label: values.no, value: "0" },
                         { label: values.yes, value: "1" }
                    ]
                });

                append({
                    label: labels.game_toggleCrouch,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_toggleCrouch",
                    cvar: "cl_toggle_duck",
                    options: [
                         { label: values.no, value: "0" },
                         { label: values.yes, value: "1" }
                    ]
                });

                append({
                    label: labels.game_announcer,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "game_announcer",
                    cvar: "bm_killstreaks_voice_pack_file",
                    options: [
                        { label: values.announcerMarine, value: BlackMesaEngine.getConsoleVariableAsString("bm_marine_announcer") },
                        { label: values.announcerScientist, value: BlackMesaEngine.getConsoleVariableAsString("bm_scientist_announcer") }
                    ]
                });

                append({
                    label: labels.game_devConsole,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_devConsole",
                    cvar: "con_enable",
                    options: [
                         { label: values.no, value: "0" },
                         { label: values.yes, value: "1" }
                    ]
                });


				append({
					label: labels.game_autoAim,
                    type: "select",
                    valueType: "int",
					value: "",
					key: "game_autoAim",
                    cvar: "sk_autoaim_enabled",
                    options: [
                        { label: values.no, value: "0" },
                        { label: values.yes, value: "1" }
                    ]
				});

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
