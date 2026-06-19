import QtQuick 2.9
import CrowbarCollective 1.0

RouteView {
    OptionsList { id: gameOptions
        title: L10n.strings.headers.gameOptions
        visibleRows: 7

        anchors.centerIn: parent
        anchors.verticalCenterOffset: Math.ceil(20 * Theme.heightScale)

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
                    precision: "1",
                    formatter: 'decimal'
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
            }
        }
    }
}
