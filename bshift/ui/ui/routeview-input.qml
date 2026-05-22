import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

RouteView {
    OptionsList { id: mouseOptions

		titleNameText: L10n.strings.menus.input
        isLessRows: false

        anchors.centerIn: parent

        onRequestSettingsChange: {
            setValue(model, value);
        }

            readonly property QtObject getComplex: QtObject {
                function controller_rumble() {
                    var setting = BlackMesaEngine.getConsoleVariableAsInt("cl_rumblescale");
                    return (setting).toString();
                }
                function controller_lookHorizontalSensitivity() {
                    var setting = BlackMesaEngine.getConsoleVariableAsFloat("in_joy_look_yaw_sensitivity");
                    return (setting).toString();
                }
                function controller_lookVerticalSensitivity() {
                    var setting = BlackMesaEngine.getConsoleVariableAsFloat("in_joy_look_pitch_sensitivity");
                    return (setting).toString();
                }
                function controller_gyroHorizontalSensitivity() {
                    var setting = BlackMesaEngine.getConsoleVariableAsFloat("in_gyro_look_yaw_sensitivity");
                    return (setting).toString();
                }
                function controller_gyroVerticalSensitivity() {
                    var setting = BlackMesaEngine.getConsoleVariableAsFloat("in_gyro_look_pitch_sensitivity");
                    return (setting).toString();
                }
            }

            readonly property QtObject setComplex: QtObject {
                function controller_rumble(value) {
                    BlackMesaEngine.setConsoleVariableAsInt("cl_rumblescale", Number(value));
                }
                function controller_lookHorizontalSensitivity(value) {
                    BlackMesaEngine.setConsoleVariableAsFloat("in_joy_look_yaw_sensitivity", Number(value));
                }
                function controller_lookVerticalSensitivity(value) {
                    BlackMesaEngine.setConsoleVariableAsFloat("in_joy_look_pitch_sensitivity", Number(value));
                }
                function controller_gyroHorizontalSensitivity(value) {
                    BlackMesaEngine.setConsoleVariableAsFloat("in_gyro_look_yaw_sensitivity", Number(value));
                }
                function controller_gyroVerticalSensitivity(value) {
                    BlackMesaEngine.setConsoleVariableAsFloat("in_gyro_look_pitch_sensitivity", Number(value));
                }
            }
			
        model: ListModel { id: mouseModel
            Component.onCompleted: {
                var labels = L10n.strings.options.labels,
                    values = L10n.strings.options.values;

                append({
                    label: L10n.strings.headers.mouseOptions,
                    type:  "separator"
                });
                
                append({
                        label: labels.mouse_invert,
                        type: "select",
                        valueType: "int",
                        value: "",
                        key: "mouse_invert",
                        cvar: "m_pitch",
                        options: [
                            { label: values.off, value: "0.022" },
                            { label: values.on, value: "-0.022" }
                        ]
                });

                append({
                        label: labels.mouse_raw,
                        type: "select",
                        valueType: "int",
                        value: "",
                        key: "mouse_raw",
                        cvar: "m_rawinput",
                        options: [
                            { label: values.off, value: "0" },
                            { label: values.on, value: "1" }
                        ]
                });

                append({
                        label: labels.mouse_accelerationswitch,
                        type: "select",
                        valueType: "int",
                        value: "",
                        key: "mouse_accelerationswitch",
                        cvar: "m_customaccel",
                        options: [
                            { label: values.off, value: "0" },
                            { label: values.on, value: "3" }
                        ]
                });

                append({
                        label: labels.mouse_sensitivity,
                        type: "slider",
                        valueType: "real",
                        value: "",
                        key: "mouse_sensitivity",
                        cvar: "sensitivity",
                        minValue: 0.1,
                        maxValue: 6.0,
                        precision: 1,
                        formatter: "decimal",
                        stepValue: 0.1
                });

                append({
                        label: labels.mouse_acceleration,
                        type: "slider",
                        valueType: "real",
                        value: "",
                        key: "mouse_acceleration",
                        cvar: "m_customaccel_exponent",
                        minValue: 1.0,
                        maxValue: 1.4,
                        precision: 2,
                        formatter: "decimal",
                        stepValue: 0.01
                });

                    append({
                        label: labels.mouse_zoomAcceleration,
                        type: "slider",
                        valueType: "real",
                        value: "",
                        key: "mouse_zoomAcceleration",
                        cvar: "zoom_sensitivity_ratio",
                        minValue: 0,
                        maxValue: 2.0,
                        precision: 2,
                        formatter: "decimal",
                        stepValue: 0.05
                    });
                
                // ----------------------------------------------
                
                append({
                    label: L10n.strings.headers.controllerOptions,
                    type:  "separator"
                });
                    
                    // Joystick rumble 
                    append({
                        label: labels.controller_rumble,
                        type: "select",
                        valueType: "int",
                        value: "",
                        key: "controller_rumble",
                        cvar: "cl_rumblescale",
                        options: [
                            { label: values.off, value: "0" },
                            { label: values.on, value: "1" }
                        ]
                    });
                
                    // Joystick pitch-reverse ( vertical axis )
                append({
                        label: labels.controller_invert,
                        type: "select",
                        valueType: "int",
                        value: "",
                        key: "controller_invert",
                        cvar: "joy_inverty",
                        options: [
                            { label: values.no, value: "0" },
                            { label: values.yes, value: "1" }
                        ]
                });
                    append({
                        label: labels.controller_horizontalSensitivity,
                        type: "slider",
                        valueType: "real",
                        value: "",
                        key: "controller_lookHorizontalSensitivity",
                        cvar: "in_joy_look_yaw_sensitivity",
                        minValue: 0.0,
                        maxValue: 2.0,
                        precision: 1,
                        formatter: "decimal",
                        stepValue: 0.1
                    });

                    append({
                        label: labels.controller_verticalSensitivity,
                        type: "slider",
                        valueType: "real",
                        value: "",
                        key: "controller_lookVerticalSensitivity",
                        cvar: "in_joy_look_pitch_sensitivity",
                        minValue: 0.0,
                        maxValue: 2.0,
                        precision: 1,
                        formatter: "decimal",
                        stepValue: 0.1
                    });
					
					
                    append({
                        label: labels.controller_gyroHorizontalSensitivity,
                        type: "slider",
                        valueType: "real",
                        value: "",
                        key: "controller_gyroHorizontalSensitivity",
                        cvar: "in_gyro_look_yaw_sensitivity",
                        minValue: 0.0,
                        maxValue: 2.0,
                        precision: 1,
                        formatter: "decimal",
                        stepValue: 0.1
                    });

                    append({
                        label: labels.controller_gyroVerticalSensitivity,
                        type: "slider",
                        valueType: "real",
                        value: "",
                        key: "controller_gyroVerticalSensitivity",
                        cvar: "in_gyro_look_pitch_sensitivity",
                        minValue: 0.0,
                        maxValue: 2.0,
                        precision: 1,
                        formatter: "decimal",
                        stepValue: 0.1
                    });
					
                append({
                    label: labels.game_uiIcons,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "game_bsUIIcons",
                    cvar: "hud_draw_fixed_reticle",
                    options: [
                        { label: "Xbox", value: "0" },
                        { label: "Dualshock 4", value: "1" },
                        { label: "Dualsense", value: "2" },
                        { label: "Joy-Con", value: "3" }
                    ]
                });
            }
        }

        Item {
            id: footerGraphicDescription
            height: Math.ceil(69 * Theme.heightScale)		// OptionsList Footer Height

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

			property bool isButtonVisible: false

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
