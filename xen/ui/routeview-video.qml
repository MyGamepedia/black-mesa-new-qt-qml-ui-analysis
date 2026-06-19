import QtQuick 2.9
import CrowbarCollective 1.0

RouteView { id: videoOptionsView
    property string blockingRouteName

    function onRouteWillChange(newRouteName) {
        if (!blockingRouteName && videoOptions.hasPendingChanges) {
            blockingRouteName = newRouteName;
            confirmAlert.show();
            return true;
        }
    }

    OptionsList { id: videoOptions
        title: L10n.strings.headers.videoOptions
        batchUpdates: true
        visibleRows: 8

        anchors.centerIn: parent
        anchors.verticalCenterOffset: Math.ceil(20 * Theme.heightScale)

        property variant qualitySettings

        Component.onCompleted: {
            qualitySettings = {
                "0": {
                    video_antialiasing: "0",
                    video_modelDetail: "2",
                    video_textureDetail: "2",
                    video_shaderDetail: "1",
                    video_filtering: "bilinear",
                    video_motionBlur: "0",
                    video_waterDetail: "simple",
                    video_shadowDetail: "0",
                    video_csmQuality: "0",
                    video_dynamicShadowQuality: "1",
                    video_dynamicLightsQuality: "0",
                    video_godRays: "0",
                    video_lensFlare: "0",
                    video_chromaticAberration: "0",
                    //video_hudPostProcess: "0",
                    video_radioactiveNoise: "0"
                },
                "1": {
                    video_antialiasing: "0",
                    video_modelDetail: "2",
                    video_textureDetail: "2",
                    video_shaderDetail: "1",
                    video_filtering: "bilinear",
                    video_motionBlur: "0",
                    video_waterDetail: "simple",
                    video_shadowDetail: "0",
                    video_csmQuality: "1",
                    video_dynamicShadowQuality: "2",
                    video_dynamicLightsQuality: "1",
                    video_godRays: "0",
                    video_lensFlare: "0",
                    video_chromaticAberration: "0",
                    //video_hudPostProcess: "0",
                    video_radioactiveNoise: "0"
                },
                "2": {
                    video_antialiasing: "1",
                    video_modelDetail: "1",
                    video_textureDetail: "1",
                    video_shaderDetail: "1",
                    video_filtering: "trilinear",
                    video_motionBlur: "0",
                    video_waterDetail: "world",
                    video_shadowDetail: "1",
                    video_csmQuality: "2",
                    video_dynamicShadowQuality: "3",
                    video_dynamicLightsQuality: "2",
                    video_godRays: "0",
                    video_lensFlare: "0",
                    video_chromaticAberration: "0",
                    //video_hudPostProcess: "0",
                    video_radioactiveNoise: "0"
                },
                "3": {
                    video_antialiasing: "1",
                    video_modelDetail: "0",
                    video_textureDetail: "0",
                    video_shaderDetail: "0",
                    video_filtering: "4",
                    video_motionBlur: "1",
                    video_waterDetail: "all",
                    video_shadowDetail: "2",
                    video_csmQuality: "2",
                    video_dynamicShadowQuality: "4",
                    video_dynamicLightsQuality: "3",
                    video_godRays: "1",
                    video_lensFlare: "1",
                    video_chromaticAberration: "1",
                    //video_hudPostProcess: "1",
                    video_radioactiveNoise: "1"
                }
            };

            var value = BlackMesaEngine.getConsoleVariableAsInt("mat_easymenu_quality_level");
            setAdvancedSettingsState(qualitySettings[value]);
        }

        onSettingsReset: {
            var value = BlackMesaEngine.getConsoleVariableAsInt("mat_easymenu_quality_level");
            setAdvancedSettingsState(qualitySettings[value]);
        }

        onRequestSettingsChange: {
            if (model.key === models.video_quality.key) {
                setValue(models.video_quality, model.value);
                setAdvancedSettingsState(qualitySettings[models.video_quality.value]);
            }
        }

        function setAdvancedSettingsState(settings) {
            var advancedKeys = Object.keys(qualitySettings["0"]),
                isCustom = models.video_quality.value === "4";

            advancedKeys.forEach(function (key) {
                models[key].disabled = !isCustom;

                if (settings && !isCustom) {
                    setValue(models[key], settings[key]);
                }
            });
        }

        readonly property QtObject groups: QtObject {
            function displayMode() {
                var split = videoOptions.models.video_resolution.value.split('x'),
                    width = split[0],
                    height = split[1],
                    windowed = videoOptions.models.video_displayMode.value;

                BlackMesaEngine.executeClientCommandUnrestricted([
                    'mat_setvideomode', width, height, windowed, 0
                ].join(' '));
            }
        }

        readonly property QtObject setComplex: QtObject {
            function video_filtering(value) {
                var trilinear, aniso;

                if (Number(value) > 1) {
                    aniso = value;
                    trilinear = 0;
                } else {
                    if (value === "trilinear") {
                        aniso = 1;
                        trilinear = 1;
                    } else {
                        aniso = 1;
                        trilinear = 0;
                    }
                }

                BlackMesaEngine.setConsoleVariableAsInt("mat_trilinear", trilinear);
                BlackMesaEngine.setConsoleVariableAsInt("mat_forceaniso", aniso);
            }

            function video_waterDetail(value) {
                var expensive, entities;

                switch (value) {
                    case "simple": expensive = 0; entities = 0; break;
                    case "world": expensive = 1; entities = 0; break;
                    case "all": expensive = 1; entities = 1; break;
                    default: console.warn("setComplex unknown waterDetail value:", value);
                }

                BlackMesaEngine.setConsoleVariableAsInt("r_waterforceexpensive", expensive);
                BlackMesaEngine.setConsoleVariableAsInt("r_waterforcereflectentities", entities);
            }

            function video_shadowDetail(value) {
                var flashlight, shadowrtt;

                switch (value) {
                    case "0": flashlight = 0; shadowrtt = 0; break;
                    case "1": flashlight = 1; shadowrtt = 0; break;
                    case "2": flashlight = 1; shadowrtt = 1; break;
                    default: console.warn("setComplex unknown shadowDetail value:", value);
                }

                BlackMesaEngine.setConsoleVariableAsInt("r_shadowrendertotexture", shadowrtt);
                BlackMesaEngine.setConsoleVariableAsInt("r_flashlightdepthtexture", flashlight);
            }

            function video_dynamicShadowQuality(value) {
                var active, quality, res, filter,
                    unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported");

                if (!unlocked && Number(value) > 5) {
                    value = "5";
                }

                switch (value) {
                    case "0": active = 0; quality = 0; res = 3; filter = 0; break;
                    case "1": active = 666; quality = 1; res = 3; filter = 0; break;
                    case "2": active = 666; quality = 2; res = 2; filter = 0; break;
                    case "3": active = 666; quality = 3; res = 1; filter = 1; break;
                    case "4": active = 666; quality = 4; res = 0; filter = 1; break;
                    case "5": active = 666; quality = 5; res = 0; filter = 2; break;
                    case "6": active = 666; quality = 6; res = 0; filter = 3; break;
                    default: console.warn("setComplex unknown dynamicShadowQuality value:", value);
                }

                BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_active", active);
                BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_quality", quality);
                BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_res", res);
                BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_filter_quality", filter);
            }

            function video_dynamicLightsQuality(value) {
                var unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported");

                if (!unlocked && Number(value) > 4) {
                    value = "4";
                }

                BlackMesaEngine.setConsoleVariableAsInt("nr_lights_quality", value);
            }

            function video_csmQuality(value) {
                var unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported"),
                    enabled = 1, quality = Number(value);

                if (value === "disabled") {
                    enabled = 0;
                    quality = 0;
                } else if (!unlocked && quality > 2) {
                    quality = 2;
                }

                BlackMesaEngine.setConsoleVariableAsInt("cl_csm_enabled", enabled);
                BlackMesaEngine.setConsoleVariableAsInt("cl_csm_qualitymode", quality);
            }
        }

        readonly property QtObject getComplex: QtObject {
            function video_filtering() {
                var aniso = BlackMesaEngine.getConsoleVariableAsInt("mat_forceaniso"),
                    trilinear = BlackMesaEngine.getConsoleVariableAsInt("mat_trilinear");

                if (aniso > 1) {
                    return aniso.toString();
                } else if (trilinear === 1) {
                    return "trilinear";
                } else {
                    return "bilinear";
                }
            }

            function video_waterDetail() {
                var expensive = BlackMesaEngine.getConsoleVariableAsInt("r_waterforceexpensive"),
                    entities = BlackMesaEngine.getConsoleVariableAsInt("r_waterforcereflectentities");

                if (expensive && entities) {
                    return "all";
                } else if (expensive) {
                    return "world";
                } else {
                    return "simple";
                }
            }

            function video_shadowDetail() {
                var shadowrtt = BlackMesaEngine.getConsoleVariableAsInt("r_shadowrendertotexture"),
                    flashlight = BlackMesaEngine.getConsoleVariableAsInt("r_flashlightdepthtexture");

                if (flashlight && shadowrtt) {
                    return "2"; // high
                } else if (shadowrtt) {
                    return "1"; // medium
                } else {
                    return "0"; // low
                }
            }

            function video_resolution() {
                return Theme.rootWidth + "x" + Theme.rootHeight;
            }

            function video_displayMode() {
                return BlackMesaEngine.isWindowedMode() ? "1" : "0";
            }

            // the following getters will also set in the event the read value is invalid.
            // this is terrible and hacky, but it's easier than adding error states and
            // avenues for the user to fix the errors into the ui that they will probably
            // only ever get to if they are fucking around with the console.
            // Warranty void if console opened.
            function video_dynamicLightsQuality() {
                var quality = BlackMesaEngine.getConsoleVariableAsInt("nr_lights_quality"),
                    unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported");

                // settings above "Ultra" are only allowed if unlocked
                if (!unlocked && quality > 4) {
                    quality = 4;
                    BlackMesaEngine.setConsoleVariableAsInt("nr_lights_quality", quality);
                }

                return quality.toString();
            }

            function video_dynamicShadowQuality() {
                var quality = BlackMesaEngine.getConsoleVariableAsInt("nr_shadow_quality"),
                    enabled = BlackMesaEngine.getConsoleVariableAsInt("nr_shadow_active") === 666,
                    unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported");

                if (!enabled) {
                    return "0";
                // settings above "Ultra" are only allowed if unlocked
                } else if (!unlocked && quality > 5) {
                    quality = 5;
                    BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_quality", quality);
                }

                return quality.toString();
            }

            function video_csmQuality() {
                var enabled = BlackMesaEngine.getConsoleVariableAsBoolean("cl_csm_enabled"),
                    quality = BlackMesaEngine.getConsoleVariableAsInt("cl_csm_qualitymode"),
                    unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported");

                if (!enabled) {
                    return "disabled";
                } else if (!unlocked && quality > 2) {
                    quality = 2;
                    BlackMesaEngine.setConsoleVariableAsInt("cl_csm_qualitymode", quality);
                }

                return quality.toString();
            }
        }

        model: ListModel { id: videoOptionsModel
            Component.onCompleted: {
                var unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported"),
                    labels = L10n.strings.options.labels,
                    values = L10n.strings.options.values;

                var resolutions = [];
                BlackMesaEngine.listVideoModes().forEach(function (obj) {
                    if (obj.width >= 800 && obj.height >= 600) {
                        resolutions.push({
                            label: obj.width + " x " + obj.height,
                            value: obj.width + "x" + obj.height
                        });
                    }
                });

                append({
                    label: labels.video_resolution,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_resolution",
                    group: "displayMode",
                    options: resolutions
                });

                append({
                    label: labels.video_displayMode,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_displayMode",
                    group: "displayMode",
                    options: [
                        { label: values.displayModeFullscreen, value: "0" },
                        { label: values.displayModeWindowed, value: "1" }
                    ]
                });

                append({
                    label: labels.video_fov,
                    type: "slider",
                    valueType: "real",
                    value: "",
                    key: "video_fov",
                    cvar: "fov_desired",
                    minValue: 75.0,
                    maxValue: 90.0,
                    precision: 0,
                    formatter: 'whole'
                });

                append({
                    label: labels.video_vsync,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_vsync",
                    cvar: "mat_vsync",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.on, value: "1" }
                    ]
                });

                append({
                    label: labels.video_quality,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_quality",
                    cvar: "mat_easymenu_quality_level",
                    options: [
                        { label: values.qualityPotato, value: "0" },
                        { label: values.qualityLow, value: "1" },
                        { label: values.qualityMedium, value: "2" },
                        { label: values.qualityHigh, value: "3" },
                        { label: values.qualityCustom, value: "4" }
                    ]
                });

                append({
                    disabled: false,
                    label: labels.video_antialiasing,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_antialiasing",
                    cvar: "mat_fxaa_enabled",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.on, value: "1" }
                    ]
                });

                append({
                    disabled: false,
                    label: labels.video_modelDetail,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_modelDetail",
                    cvar: "r_rootlod",
                    options: [
                        { label: values.qualityLow, value: "2" },
                        { label: values.qualityMedium, value: "1" },
                        { label: values.qualityHigh, value: "0" }
                    ]
                });

                append({
                    disabled: false,
                    label: labels.video_textureDetail,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_textureDetail",
                    cvar: "mat_picmip",
                    options: [
                        { label: values.qualityLow, value: "2" },
                        { label: values.qualityMedium, value: "1" },
                        { label: values.qualityHigh, value: "0" },
                        { label: values.qualityUltra, value: "-1" }
                    ]
                });

                append({
                    disabled: false,
                    label: labels.video_shaderDetail,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_shaderDetail",
                    cvar: "mat_reducefillrate",
                    options: [
                        { label: values.qualityLow, value: "1" },
                        { label: values.qualityHigh, value: "0" }
                    ]
                });

                append({
                    disabled: false,
                    label: labels.video_filtering,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_filtering",
                    options: [
                        { label: values.filteringBilinear, value: "bilinear" },
                        { label: values.filteringTrilinear, value: "trilinear" },
                        { label: values.filteringAnisotropic2x, value: "2" },
                        { label: values.filteringAnisotropic4x, value: "4" },
                        { label: values.filteringAnisotropic8x, value: "8" },
                        { label: values.filteringAnisotropic16x, value: "16" }
                    ]
                });

                append({
                    disabled: false,
                    label: labels.video_motionBlur,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_motionBlur",
                    cvar: "mat_motion_blur_enabled",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.on, value: "1" }
                    ]
                });

                append({
                    disabled: false,
                    label: labels.video_waterDetail,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_waterDetail",
                    options: [
                        { label: values.waterSimpleReflections, value: "simple" },
                        { label: values.waterReflectWorld, value: "world" },
                        { label: values.waterReflectAll, value: "all" }
                    ]
                });

                append({
                    disabled: false,
                    label: labels.video_shadowDetail,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_shadowDetail",
                    options: [
                        { label: values.qualityLow, value: "0" },
                        { label: values.qualityMedium, value: "1" },
                        { label: values.qualityHigh, value: "2" }
                    ]
                });

                // CSM Quality
                var csmOptions = [
                        { label: values.off, value: "disabled" },
                        { label: values.qualityPotato, value: "0" },
                        { label: values.qualityLow, value: "1" },
                        { label: values.qualityMedium, value: "2" }
                    ];

                if (unlocked) {
                    csmOptions.push({ label: values.qualityHigh, value: "3" });
                    csmOptions.push({ label: values.qualityUltra, value: "4" });
                    csmOptions.push({ label: values.qualityInsane, value: "5" });
                }

                append({
                    disabled: false,
                    label: labels.video_csmQuality,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_csmQuality",
                    options: csmOptions
                });

                // Dynamic Shadow Quality
                var shadowOptions = [
                        { label: values.off, value: "0" },
                        { label: values.qualityPotato, value: "1" },
                        { label: values.qualityLow, value: "2" },
                        { label: values.qualityMedium, value: "3" },
                        { label: values.qualityHigh, value: "4" },
                        { label: values.qualityUltra, value: "5" }
                    ];

                if (unlocked) {
                    shadowOptions.push({ label: values.qualityInsane, value: "6" });
                }

                append({
                    disabled: false,
                    label: labels.video_dynamicShadowQuality,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_dynamicShadowQuality",
                    options: shadowOptions
                });

                // Dynamic Lights Quality
                var lightsOptions = [
                        { label: values.qualityPotato, value: "0" },
                        { label: values.qualityLow, value: "1" },
                        { label: values.qualityMedium, value: "2" },
                        { label: values.qualityHigh, value: "3" },
                        { label: values.qualityUltra, value: "4" }
                    ];

                if (unlocked) {
                    lightsOptions.push({ label: values.qualityInsane, value: "5" });
                    lightsOptions.push({ label: values.qualityInsane2, value: "6" });
                }

                append({
                    disabled: false,
                    label: labels.video_dynamicLightsQuality,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_dynamicLightsQuality",
                    options: lightsOptions
                });

                append({
                    disabled: false,
                    label: labels.video_godRays,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_godRays",
                    cvar: "np_gr_quality",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.on, value: "1" }
                    ]
                });

                append({
                    disabled: false,
                    label: labels.video_lensFlare,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_lensFlare",
                    cvar: "bms_lf_enabled",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.on, value: "1" }
                    ]
                });

                append({
                    disabled: false,
                    label: labels.video_chromaticAberration,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_chromaticAberration",
                    cvar: "mat_chromatic_damage_enable",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.on, value: "1" }
                    ]
                });

                append({
                    disabled: false,
                    label: labels.video_radioactiveNoise,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_radioactiveNoise",
                    cvar: "mat_geiger_noise_enable",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.on, value: "1" }
                    ]
                });

                /*
                append({
                    disabled: false,
                    label: labels.video_hudPostProcess,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_hudPostProcess",
                    cvar: "hud_postprocess",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.on, value: "1" }
                    ]
                });
                */
            }
        }
    }

    Alert { id: confirmAlert
        titleText: L10n.strings.headers.unsavedWarning
        messageText: L10n.strings.modalMessages.unsavedWarning

        buttons: VisualItemModel { id: buttons
            CTAButton {
                text: L10n.strings.buttons.apply
                onClicked: {
                    videoOptions.flushPendingChanges();
                    videoOptionsView.routeRequest(blockingRouteName);
                }
            }

            WarningButton {
                text: L10n.strings.buttons.discard
                onClicked: {
                    videoOptionsView.routeRequest(blockingRouteName);
                }
            }

            DefaultButton {
                text: L10n.strings.buttons.cancel
                onClicked: {
                    blockingRouteName = "";
                    confirmAlert.hide();
                }
            }
        }
    }
}
