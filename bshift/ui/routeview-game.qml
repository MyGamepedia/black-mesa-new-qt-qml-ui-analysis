import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

RouteView {
    OptionsList { id: gameOptions

		titleNameText: L10n.strings.menus.game
		footerVisible: true
        isLessRows: true

        anchors.centerIn: parent

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
					label: labels.game_autoAim,
					type: "slider",
					valueType: "real",
					value: "",
					key: "game_autoAim",
					cvar: "bms_autoaim_scale",
					minValue: 0.0,
					maxValue: 8.0,
					precision: "1",
					formatter: "decimal",
					replaceMinByOff: "1",
					stepValue: 1.0
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
                    precision: 2,
                    formatter: 'decimal',
                    stepValue: 0.01
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
                    label: labels.game_ingamehudenable,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_drawHud",
                    cvar: "cl_drawhud",
                    options: [
                         { label: values.off, value: "0" },
                         { label: values.on, value: "1" }
                    ]
                });

                append({
                    label: labels.game_viewmodelenable,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_drawViewModel",
                    cvar: "r_drawviewmodel",
                    options: [
                         { label: values.off, value: "0" },
                         { label: values.on, value: "1" }
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

        Item {
            id: footerGraphicDescription
            height: Math.ceil(69 * Theme.heightScale)		// OptionsList Footer Height

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

			property bool isButtonVisible: true

			Item {
				id: hintBGBase
				anchors.bottom: footerGraphicDescription.bottom
				anchors.left: footerGraphicDescription.left
				anchors.right: footerGraphicDescription.right
				
				height: 0
				width: footerGraphicDescription.width

				Rectangle {
					id: hintsBGSec
					height: hintBGBase.width + Math.ceil(2 * Theme.widthScale)
					width: Math.ceil(30 * Theme.heightScale)
					anchors.centerIn: hintBGBase
					anchors.verticalCenterOffset: Math.ceil(-20 * Theme.heightScale)
					
					rotation: -90
					opacity: Theme.opacity.bsRightPanel
					
					gradient: Gradient {
						GradientStop { position: 0.3; color:  "transparent" }
						GradientStop { position: 0.7; color: Theme.colors.highlight }
					}
				}
				
				Rectangle {
					id: hintsBG
					height: hintBGBase.width + Math.ceil(2 * Theme.widthScale)
					width: Math.ceil(39 * Theme.heightScale)
					anchors.centerIn: hintBGBase
					anchors.verticalCenterOffset: Math.ceil(-34 * Theme.heightScale)
					
					rotation: -90
					opacity: 0.9
					
					gradient: Gradient {
						GradientStop { position: 0.1; color:  "transparent" }
						GradientStop { position: 0.6; color: Theme.colors.subMenuHintPrimary }
					}
				}
			}
			
			Row {
				anchors.bottom: parent.bottom
				anchors.right: footerGraphicDescription.right
				anchors.rightMargin: Math.ceil(30 * Theme.widthScale)
				anchors.bottomMargin: Math.ceil(-10 * Theme.heightScale)

				Hint {
					id: hint1
					hintButtonText: appRoot.isLeftMenuFocused ? appRoot.hintSelectIcon : appRoot.hintLRIcon
					hintTextText: appRoot.isLeftMenuFocused ? L10n.strings.hints.hintselect : L10n.strings.hints.hintchange
					hintButtonColor: appRoot.isLeftMenuFocused ? appRoot.hintSelectColor : Theme.colors.text
					
					isHintVisible: appRoot.isLeftMenuFocused || footerGraphicDescription.isButtonVisible
				}
				Hint {
					id: hint2
					hintButtonText: appRoot.hintBackIcon
					hintTextText: L10n.strings.hints.hintback
					hintButtonColor: appRoot.hintBackColor
				}
				Hint {
					id: hint3
					hintButtonText: appRoot.hintCloseIcon
					hintTextText: L10n.strings.hints.hintclosemenu
					
					isHintVisible: appRoot.isInGame
				}
			}

        }

//This could be used for menu navigation hints
		
        function onSelectionChanged(modelSelected) {
			
			if ( modelSelected === "select" || modelSelected === "slider" ) {
				footerGraphicDescription.isButtonVisible = true;
			} else {
				footerGraphicDescription.isButtonVisible = false;
			}
			
        }
		
    }
}
