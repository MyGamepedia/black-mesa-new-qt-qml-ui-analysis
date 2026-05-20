import QtQuick 2.9
import CrowbarCollective 1.0

RouteView {
    Item { id: container
        //height: inputOptions.height + Math.ceil(20 * Theme.heightScale) + controllerOptions.height
        height: inputOptions.height + Math.ceil(20 * Theme.heightScale)
        width: inputOptions.width
        anchors.centerIn: parent
        anchors.verticalCenterOffset: Math.ceil(20 * Theme.heightScale)

        OptionsList { id: inputOptions
            title: L10n.strings.headers.inputOptions
            visibleRows: 6
            anchors.top: container.top
            anchors.verticalCenterOffset: 0

            readonly property QtObject getComplex: QtObject {
                function controller_horizontalSensitivity() {
                    var setting = BlackMesaEngine.getConsoleVariableAsFloat("in_look_yaw_sensitivity");
                    return (-setting).toString();
                }
            }

            readonly property QtObject setComplex: QtObject {
                function controller_horizontalSensitivity(value) {
                    BlackMesaEngine.setConsoleVariableAsFloat("in_look_yaw_sensitivity", -Number(value));
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
                        precision: 2,
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
                        stepValue: 0.1
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
                        stepValue: 0.1
                    });

                    append({
                        label: L10n.strings.headers.controllerOptions,
                        type:  "separator"
                    });
                    
                    // Joystick rumble effect
                    /*append({
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
                    });*/

                    // Joystick pitch-reverse ( vertical axis )
                    /*append({
                        label: labels.controller_invert,
                        type: "select",
                        valueType: "int",
                        value: "",
                        key: "controller_invert",
                        cvar: "joy_inverty",
                        options: [
                            { label: values.off, value: "0" },
                            { label: values.on, value: "1" }
                        ]
                    });*/
                    
                    /// Controller inputs

                    // Controller look vertical sensitivity
                    append({
                        label: labels.controller_lookVerticalSensitivity,
                        type: "slider",
                        valueType: "real",
                        value: "",
                        key: "controller_lookVerticalSensitivity",
                        cvar: "in_joy_look_pitch_sensitivity",
                        minValue: 0.0,
                        maxValue: 2.0,
                        precision: 2,
                        formatter: "decimal",
                        stepValue: 0.010000
                    });

                    // Controller look horizontal sensitivity
                    append({
                        label: labels.controller_lookHorizontalSensitivity,
                        type: "slider",
                        valueType: "real",
                        value: "",
                        key: "controller_lookHorizontalSensitivity",
                        cvar: "in_joy_look_yaw_sensitivity",
                        minValue: 0.0,
                        maxValue: 2.0,
                        precision: 2,
                        formatter: "decimal",
                        stepValue: 0.010000
                    });
                    
                    // Controller gyro vertical sensitivity
                    append({
                        label: labels.controller_gyroVerticalSensitivity,
                        type: "slider",
                        valueType: "real",
                        value: "",
                        key: "controller_gyroVerticalSensitivity",
                        cvar: "in_gyro_look_pitch_sensitivity",
                        minValue: 0.0,
                        maxValue: 2.0,
                        precision: 2,
                        formatter: "decimal",
                        stepValue: 0.010000
                    });

                    // Controller gyro horizontal sensitivity
                    append({
                        label: labels.controller_gyroHorizontalSensitivity,
                        type: "slider",
                        valueType: "real",
                        value: "",
                        key: "controller_gyroHorizontalSensitivity",
                        cvar: "in_gyro_look_yaw_sensitivity",
                        minValue: 0.0,
                        maxValue: 2.0,
                        precision: 2,
                        formatter: "decimal",
                        stepValue: 0.010000
                    });
                }
            }
        }

        /*
        OptionsList { id: controllerOptions
            title: L10n.strings.headers.controllerOptions
            visibleRows: 4
            anchors.bottom: container.bottom
            anchors.verticalCenterOffset: 0

            Component.onCompleted: {
                setControllerState();
            }

            onSettingsReset: {
                setControllerState();
            }

            onRequestSettingsChange: {
                if (model.key === models.controller_enabled.key) {
                    setControllerState();
                }
            }

            function setControllerState() {
                var disabled = models.controller_enabled.value === "0";

                models.controller_invert.disabled = disabled;
                models.controller_horizontalSensitivity.disabled = disabled;
                models.controller_verticalSensitivity.disabled = disabled;
            }

            // hack so we don't have to make slider components support ghost values
            readonly property QtObject getComplex: QtObject {
                function controller_horizontalSensitivity() {
                    var setting = BlackMesaEngine.getConsoleVariableAsFloat("joy_yawsensitivity");

                    return (-setting).toString();
                }
            }

            readonly property QtObject setComplex: QtObject {
                function controller_horizontalSensitivity(value) {
                    BlackMesaEngine.setConsoleVariableAsFloat("joy_yawsensitivity", -value);
                }
            }

            model: ListModel { id: controllerModel
                Component.onCompleted: {
                    var labels = L10n.strings.options.labels,
                    values = L10n.strings.options.values;

                    append({
                        label: labels.controller_enabled,
                        type: "select",
                        valueType: "int",
                        value: "",
                        key: "controller_enabled",
                        cvar: "joystick",
                        options: [
                            { label: values.no, value: "0" },
                            { label: values.yes, value: "1" }
                        ]
                    });

                    append({
                        disabled: false,
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
                        disabled: false,
                        label: labels.controller_horizontalSensitivity,
                        type: "slider",
                        valueType: "int",
                        value: "",
                        key: "controller_horizontalSensitivity",
                        // horizontalSensitivity is complex because the values are negative.
                        // slider components can't do that well yet.
                        minValue: 0.5,
                        maxValue: 7.0,
                        precision: 1,
                        formatter: 'decimal',
                        stepValue: 0.001
                    });

                    append({
                        disabled: false,
                        label: labels.controller_verticalSensitivity,
                        type: "slider",
                        valueType: "int",
                        value: "",
                        key: "controller_verticalSensitivity",
                        cvar: "joy_pitchsensitivity",
                        minValue: 0.5,
                        maxValue: 7.0,
                        precision: 1,
                        formatter: 'decimal',
                        stepValue: 0.001
                    });
                }
            }
        }
        */
    }
}
