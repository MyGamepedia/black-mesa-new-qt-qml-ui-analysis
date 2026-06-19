import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

RouteView {
    OptionsList { id: gameOptions
        title: L10n.strings.headers.gameOptions
        visibleRows: 7

        anchors.centerIn: parent
        anchors.verticalCenterOffset: Math.ceil(20 * Theme.heightScale)

        onRequestSettingsChange: {
            setValue(model, value);
        }

        model: ListModel { id: gameOptionsModel
            Component.onCompleted: {
                var labels = L10n.strings.options.labels,
                    values = L10n.strings.options.values;

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
                    label: labels.game_weaponLag,
                    type: "slider",
                    valueType: "real",
                    value: "",
                    key: "game_weaponLag",
                    cvar: "cl_viewmodel_lag",
                    minValue: 0.0,
                    maxValue: 3.0,
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
                        { label: values.yes, value: "1" },
                        { label: BlackMesaEngine.getLocalizedString("#BlackMesaUI_ControlsMenu_Controller"), value: "2" }
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
                    label: BlackMesaEngine.getLocalizedString("#BlackMesaUI_Options_Game_IronSightSticky"),
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_stickyIronSight",
                    cvar: "cl_ironsight_sticky",
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
                    label: labels.game_drawHUD,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_drawHUD",
                    cvar: "cl_drawhud",
                    options: [
                        { label: values.no, value: "0" },
                        { label: values.yes, value: "1" }
                    ]
                });

                append({
                    label: labels.game_houndeyeTinnitus,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_houndeyeTinnitus",
                    cvar: "sv_houndeye_tinnitus",
                    options: [
                        { label: values.no, value: "0" },
                        { label: values.yes, value: "1" }
                    ]
                });

                append({
                    label: labels.game_trainUnits,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_trainUnits",
                    cvar: "cl_tram_units",
                    options: [
                        { label: values.trainMetric, value: "1" },
                        { label: values.trainFreedom, value: "2" }
                    ]
                });

                append({
                    label: labels.game_hitSounds,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_hitSounds",
                    cvar: "cl_hitsounds",
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
                        { label: values.announcerScientist, value: BlackMesaEngine.getConsoleVariableAsString("bm_scientist_announcer") },
                        { label: values.announcerMarine, value: BlackMesaEngine.getConsoleVariableAsString("bm_marine_announcer") }
                    ]
                });

                append({
                    label: labels.game_announcerState,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_announcerState",
                    cvar: "bm_announcer",
                    options: [
                        { label: values.no, value: "0" },
                        { label: values.announcerSelf, value: "1" },
                        { label: values.announcerOn, value: "2" }
                    ]
                });

                append({
                    label: labels.game_download,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "game_download",
                    cvar: "cl_downloadfilter",
                    options: [
                        { label: values.downloadNone, value: "none" },
                        { label: values.downloadMaps, value: "mapsonly" },
                        { label: values.downloadNoSounds, value: "nosounds" },
                        { label: values.downloadAll, value: "all" }
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

                // ----------------------------------------------
            }
        }
    }
}
