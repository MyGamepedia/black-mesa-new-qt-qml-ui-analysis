import QtQuick 2.9
import CrowbarCollective 1.0

RouteView { id: videoOptionsView

    property int costFontSize: Math.ceil(22 * Theme.widthScale)
    property int headMargin: Math.ceil(15 * Theme.heightScale)
    property int headAdd: Math.ceil(6 * Theme.heightScale)

    property bool headerWarningVisibility: false

    property var advancedQualityKeys: ([
        'video_antialiasing',
        'video_modelDetail',
        'video_textureDetail',
        'video_filtering',
        'video_motionBlur',
        'video_waterDetail',
        'video_csmQuality',
        'video_csmMemory',
        'video_dynamicShadowQuality',
        'video_dynamicShadowMemory',
        'video_dynamicShadowSoftness',
        'video_dynamicLightsQuality',
        'video_godRays',
        'video_lensFlare',
        'video_chromaticAberration',
        'video_mdlDetailFx',
        'video_radioactiveNoise'
    ])

    OptionsList { id: videoOptions
	
		titleNameText: L10n.strings.menus.video
        batchUpdates: true
		
        anchors.centerIn: parent

        property variant qualitySettings


        // Count the number of parameters with the Warning flag
        function updateHeaderWarningVisibility() {
            var nbWarning = 0;
            for (var i = 0; i < model.count; i++) { // for each video's parameters
                var iModel = model.get(i);
                if ( iModel.type === "select" ) { // if this is a "select" parameters
                    for (var j = 0; j < iModel.options.count; j++) { // for each options of this parameter
                        if (iModel.value === iModel.options.get(j).value) { // find the selected option
                            if (iModel.options.get(j).warning) { // if this is a "Warning" option, increment.
                                nbWarning = nbWarning+1;
                            }
                        }
                    }
                }
            }
            headerWarningVisibility = nbWarning === 0 ? false : true;
        }



        Component.onCompleted: {
            qualitySettings = {
                "0": { // POTATO
                    video_antialiasing: "0",
                    video_modelDetail: "2",
                    video_textureDetail: "2",
                    video_filtering: "bilinear",
                    video_motionBlur: "0", // OFF
                    video_waterDetail: "simple",
                    video_csmQuality: "disabled", // Disabled
                    video_csmMemory: "0", // Low
                    video_dynamicShadowQuality: "0", // OFF
                    video_dynamicShadowMemory: "2", // Potato
                    video_dynamicShadowSoftness: "0", // Low
                    video_dynamicLightsQuality: "1", // Potato
                    video_godRays: "0",
                    video_lensFlare: "0",
                    video_chromaticAberration: "0",
                    video_mdlDetailFx: "0",
                    video_radioactiveNoise: "0"
                },
                "1": { // LOW
                    video_antialiasing: "0",
                    video_modelDetail: "2",
                    video_textureDetail: "2",
                    video_filtering: "bilinear",
                    video_motionBlur: "1", // ON
                    video_waterDetail: "simple",
                    video_csmQuality: "1", // Low
                    video_csmMemory: "0", // Medium
                    video_dynamicShadowQuality: "2", // Low
                    video_dynamicShadowMemory: "2", // Low
                    video_dynamicShadowSoftness: "0", // Low
                    video_dynamicLightsQuality: "1", // Low
                    video_godRays: "0",
                    video_lensFlare: "0",
                    video_chromaticAberration: "0",
                    video_mdlDetailFx: "0",
                    video_radioactiveNoise: "0"
                },
                "2": { // MEDIUM
                    video_antialiasing: "1",
                    video_modelDetail: "1", // High
                    video_textureDetail: "1", // Ultra
                    video_filtering: "trilinear",
                    video_motionBlur: "1", // ON
                    video_waterDetail: "world",
                    video_csmQuality: "1", // Medium
                    video_csmMemory: "1", // High
                    video_dynamicShadowQuality: "3", // Medium
                    video_dynamicShadowMemory: "1", // Medium
                    video_dynamicShadowSoftness: "1", // Medium
                    video_dynamicLightsQuality: "2", // Medium
                    video_godRays: "1",
                    video_lensFlare: "0",
                    video_chromaticAberration: "0",
                    video_mdlDetailFx: "1",
                    video_radioactiveNoise: "0"
                },
                "3": { // HIGH
                    video_antialiasing: "1",
                    video_modelDetail: "0", // High
                    video_textureDetail: "0", // Ultra
                    video_filtering: "4",
                    video_motionBlur: "1", // ON
                    video_waterDetail: "all",
                    video_csmQuality: "2", // Medium
                    video_csmMemory: "2", // High
                    video_dynamicShadowQuality: "4", // High
                    video_dynamicShadowMemory: "0", // High
                    video_dynamicShadowSoftness: "2", // High
                    video_dynamicLightsQuality: "3", // High
                    video_godRays: "2",
                    video_lensFlare: "1",
                    video_chromaticAberration: "1",
                    video_mdlDetailFx: "1",
                    video_radioactiveNoise: "1"
                },
                "4": { // Ultra
                    video_antialiasing: "1",
                    video_modelDetail: "0", // High
                    video_textureDetail: "-1", // Ultra
                    video_filtering: "16",
                    video_motionBlur: "1", // ON
                    video_waterDetail: "all",
                    video_csmQuality: "3", // Medium    OUT OF 4
                    video_csmMemory: "2", // High
                    video_dynamicShadowQuality: "4", // High
                    video_dynamicShadowMemory: "0", // High
                    video_dynamicShadowSoftness: "2", // High
                    video_dynamicLightsQuality: "4", // High        OUT OF 5
                    video_godRays: "2",
                    video_lensFlare: "1",
                    video_chromaticAberration: "1",
                    video_mdlDetailFx: "1",
                    video_radioactiveNoise: "1"
                }
            };
        }

        onSettingsReset: {
            var value = BlackMesaEngine.getConsoleVariableAsInt("mat_easymenu_quality_level");
            setAdvancedSettingsState(qualitySettings[value]);
        }

        onRequestSettingsChange: {
            if (model.key === models.video_quality.key) {
                setValue(models.video_quality, model.value);
                setAdvancedSettingsState(qualitySettings[models.video_quality.value]);
            } else if (model.key in qualitySettings[0]) {
                // set overall quality to 'custom', because one of the dependency settings was
                // just manually set
                setValue(models.video_quality, '5');
            }
            updateHeaderWarningVisibility(); //better to update the Warning count after each setting change
        }

        function setAdvancedSettingsState(settings) {
            var isCustom = models.video_quality.value === "5";

            advancedQualityKeys.forEach(function (key) {

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
                    windowMode = videoOptions.models.video_displayMode.value;

                // update the width/height variables as soon as possible and force the page to reload.
                // if we don't do that, menu will not be scaled correctly after a resize.
                appRoot.width = width;
                appRoot.height = height;
                Theme.widthScale = appRoot.width / 1920.0;
                Theme.heightScale = appRoot.height / 1080.0;

                videoOptions.reloadPageAfterApplyChanges = true;

                BlackMesaEngine.executeClientCommandUnrestricted([
                    'mat_setvideomode', width, height,
                     windowMode === "1" || windowMode === "2" ? 1 : 0,  // windowed
                     windowMode === "2" ? 1 : 0  // borderless
                ].join(' '));
            }
        }

        readonly property QtObject setComplex: QtObject {
		
            function video_gamma(value) {
				var setting = 2.6 - value;
                BlackMesaEngine.setConsoleVariableAsFloat( "mat_monitorgamma", Number(setting) );
            }
		
		
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
                    case "world": expensive = 0; entities = 1; break;
                    case "all": expensive = 1; entities = 1; break;
                    default: console.warn("setComplex unknown waterDetail value:", value);
                }

                BlackMesaEngine.setConsoleVariableAsInt("r_waterforceexpensive", expensive);
                BlackMesaEngine.setConsoleVariableAsInt("r_waterforcereflectentities", entities);
            }


            function video_dynamicShadowQuality(value) {
                var active, quality, maxpass;

                switch (value) {
                    case "0": active = 0; quality = 0; maxpass = 0;  break; // OFF
                    case "1": active = 666; quality = 1; maxpass = 10;  break; // Potato
                    case "2": active = 666; quality = 2; maxpass = 12;  break; // Low
                    case "3": active = 666; quality = 3; maxpass = 16;  break; // Medium
                    case "4": active = 666; quality = 4; maxpass = 24;  break; // High
                    default: console.warn("setComplex unknown dynamicShadowQuality value:", value);
                }

                BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_active", active);
                BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_quality", quality);
                BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_max_passes_per_frame", maxpass);

            }


            function video_dynamicShadowMemory(value) {
                var quality = Number(value);

                BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_res", quality);
            }

            function video_dynamicShadowSoftness(value) {
                var quality = Number(value);
                BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_filter_quality", quality);
            }


            function video_dynamicLightsQuality(value) {
                BlackMesaEngine.setConsoleVariableAsInt("nr_lights_quality", value);
            }




            function video_godRays(value) {
                if ( value === "0" ) {
                    BlackMesaEngine.setConsoleVariableAsInt("np_gr_quality", 0);
                }
                else if ( value === "1" ) {
                    BlackMesaEngine.setConsoleVariableAsInt("np_gr_quality", 1);
                    BlackMesaEngine.setConsoleVariableAsInt("np_gr_quality_sample_count", 3);
                    BlackMesaEngine.setConsoleVariableAsInt("np_gr_quality_pass_count", 1);
                }
                else if ( value === "2" ) {
                    BlackMesaEngine.setConsoleVariableAsInt("np_gr_quality", 2);
                    BlackMesaEngine.setConsoleVariableAsInt("np_gr_quality_sample_count", 3);
                    BlackMesaEngine.setConsoleVariableAsInt("np_gr_quality_pass_count", 1);
                }
            }



            function video_csmQuality(value) {
                var enabled = 1, quality = Number(value);

                if (value === "disabled") {
                    enabled = 0;
                    quality = 0;
                // if we are not in Unlock mode, force CSM quality to be not higher than Medium :
                }

                BlackMesaEngine.setConsoleVariableAsInt("cl_csm_enabled", enabled);
                BlackMesaEngine.setConsoleVariableAsInt("cl_csm_qualitymode", quality);
            }

            function video_csmMemory(value) {
                var quality = Number(value);
                BlackMesaEngine.setConsoleVariableAsInt("cl_csm_memoryusage", quality);
            }
        }

        readonly property QtObject getComplex: QtObject {
		
            function video_gamma(value) {
                var setting = 2.6 - BlackMesaEngine.getConsoleVariableAsFloat("mat_monitorgamma");

                return (setting).toString();
            }
		
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

            function video_resolution() {
                return Theme.rootWidth + "x" + Theme.rootHeight;
            }

            function video_displayMode() {
                var wndMode = BlackMesaEngine.isWindowedMode();
                var noBorder = BlackMesaEngine.isWindowedBorderlessMode();
                if ( !wndMode ) {
                    return "0";
                }
                if ( wndMode && !noBorder ) {
                    return "1";
                }
                if ( wndMode && noBorder ) {
                    return "2";
                }
            }

            function video_dynamicLightsQuality() {
                var quality = BlackMesaEngine.getConsoleVariableAsInt("nr_lights_quality");

                return quality.toString();
            }

            function video_dynamicShadowQuality() {
                var quality = BlackMesaEngine.getConsoleVariableAsInt("nr_shadow_quality"),
                    enabled = BlackMesaEngine.getConsoleVariableAsInt("nr_shadow_active") === 666;

                if (!enabled) {
                    return "0";
                }

                return quality.toString();
            }

            function video_dynamicShadowMemory() {
                var quality = BlackMesaEngine.getConsoleVariableAsInt("nr_shadow_res");

                return quality.toString();
            }

            function video_dynamicShadowSoftness() {
                var quality = BlackMesaEngine.getConsoleVariableAsInt("nr_shadow_filter_quality");
				
                return quality.toString();
            }

            function video_csmQuality() {
                var enabled = BlackMesaEngine.getConsoleVariableAsBoolean("cl_csm_enabled"),
                    quality = BlackMesaEngine.getConsoleVariableAsInt("cl_csm_qualitymode");

                if (!enabled) {
                    return "disabled";
                }

                return quality.toString();
            }


            function video_godRays() {
                var gr_quality = BlackMesaEngine.getConsoleVariableAsInt("np_gr_quality");
                if ( gr_quality === 0 ) {
                    return "0";
                } else if ( gr_quality === 1 ) {
                    BlackMesaEngine.setConsoleVariableAsInt("np_gr_quality_sample_count", 3);
                    BlackMesaEngine.setConsoleVariableAsInt("np_gr_quality_pass_count", 1);
                    return "1";
                }
                else {
                    BlackMesaEngine.setConsoleVariableAsInt("np_gr_quality_sample_count", 3);
                    BlackMesaEngine.setConsoleVariableAsInt("np_gr_quality_pass_count", 1);
                    return "2";
                }
                return "0";
            }


            function video_csmMemory() {
                var quality = BlackMesaEngine.getConsoleVariableAsInt("cl_csm_memoryusage");
                return quality.toString();
            }
        }

        model: ListModel { id: videoOptionsModel
            Component.onCompleted: {
                var labels = L10n.strings.options.labels,
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
                        { label: values.displayModeWindowed, value: "1" },
                        { label: values.displayModeBorderless, value: "2" }
                    ]
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
                    label: labels.video_fov,
                    type: "slider",
                    valueType: "real",
                    value: "",
                    key: "video_fov",
                    cvar: "fov_desired",
                    minValue: 75.0,
                    maxValue: 105.0,
                    precision: 0,
                    formatter: 'whole',
                    stepValue: 1.0
                });

                // Gamma ( Brightness )
                append({
                    label: labels.video_gamma,
                    type: "slider",
                    valueType: "real",
                    value: "",
                    key: "video_gamma",
                    minValue: 0,
                    maxValue: 1,
                    precision: 2,
                    formatter: 'decimal',
                    stepValue: 0.01
                });

                // Overall Quality
                append({
                    label: labels.video_quality,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_quality",
                    cvar: "mat_easymenu_quality_level",
                    options: [
                        { label: values.qualityCustom, value: "5" },
                        { label: values.qualityPotato, value: "0" },
                        { label: values.qualityLow, value: "1" },
                        { label: values.qualityMedium, value: "2" },
                        { label: values.qualityHigh, value: "3" },
                        { label: values.qualityUltra, value: "4" }
                    ]
                });

                append({
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

                append({
                    label: labels.video_bloodenable,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_mdlDetailFx",
                    cvar: "cl_mdldetailfx_enable",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.on, value: "1" }
                    ]
                });

                append({
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

                // ---- Advanced Settings separator ----
                append({
                    label: L10n.strings.headers.advancedSettings,
                    type:  "separator"
                });
				
                append({
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

                // Texture Detail
                append({
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

                // Filtering
                append({
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

                // Water Reflections
                append({
                    label: labels.video_waterDetail,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_waterDetail",
                    options: [
                        { label: values.qualityLow, value: "simple" },
                        { label: values.qualityHigh, value: "world" },
                        { label: values.qualityUltra, value: "all", warning: 1  }
                    ]
                });

                // CSM Quality
                var csmOptions = [];
                csmOptions.push({ label: values.off, value: "disabled" });
                csmOptions.push({ label: values.qualityLow, value: "1" });
                csmOptions.push({ label: values.qualityHigh, value: "2" });
                csmOptions.push({ label: values.qualityUltra, value: "3" });
                csmOptions.push({ label: values.qualityInsane, value: "4", warning: 1 });
                append({
                    label: labels.video_csmQuality,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_csmQuality",
                    options: csmOptions
                });

                // CSM Memory Usage
                var csmMemoryUsage = [];
                csmMemoryUsage.push({ label: values.qualityLow, value: "0" });
                csmMemoryUsage.push({ label: values.qualityMedium, value: "1" });
                csmMemoryUsage.push({ label: values.qualityHigh, value: "2" });
                append({
                    label: labels.video_csmMemory,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_csmMemory",
                    options: csmMemoryUsage
                });


                // Dynamic Shadow Quality
                var shadowOptions = [];
                shadowOptions.push({ label: values.off, value: "0" });
                shadowOptions.push({ label: values.qualityLow, value: "2" });
                shadowOptions.push({ label: values.qualityMedium, value: "3" });
                shadowOptions.push({ label: values.qualityHigh, value: "4" });
                append({
                    label: labels.video_dynamicShadowQuality,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_dynamicShadowQuality",
                    options: shadowOptions
                });


                // Dynamic Shadow Memory
                var shadowOptionsMemory = [];
                shadowOptionsMemory.push({ label: values.qualityLow, value: "2" });
                shadowOptionsMemory.push({ label: values.qualityMedium, value: "1" });
                shadowOptionsMemory.push({ label: values.qualityHigh, value: "0" });
                append({
                    label: labels.video_dynamicShadowMemory,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_dynamicShadowMemory",
                    options: shadowOptionsMemory
                });

                // Dynamic Shadow Softness
                var shadowOptionsSoftness = [];
                shadowOptionsSoftness.push({ label: values.qualityLow, value: "0" });
                shadowOptionsSoftness.push({ label: values.qualityMedium, value: "1" });
                shadowOptionsSoftness.push({ label: values.qualityHigh, value: "2" });
                append({
                    label: labels.video_dynamicShadowSoftness,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_dynamicShadowSoftness",
                    options: shadowOptionsSoftness
                });



                // Dynamic Lights Quality
                var lightsOptions = [];
                lightsOptions.push({ label: values.qualityLow, value: "1" });
                lightsOptions.push({ label: values.qualityMedium, value: "2" });
                lightsOptions.push({ label: values.qualityHigh, value: "3" });
                lightsOptions.push({ label: values.qualityUltra, value: "4" });
                lightsOptions.push({ label: values.qualityInsane, value: "5", warning: 1 });
                append({
                    label: labels.video_dynamicLightsQuality,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_dynamicLightsQuality",
                    options: lightsOptions
                });

                // God Rays
                append({
                    label: labels.video_godRays,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_godRays",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.qualityLow, value: "1" },
                        { label: values.qualityHigh, value: "2" }
                    ]
                });

            }
        }


        Item {
            id: headerTextBody
			
			clip: true
			
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            width: parent.width
            height: Math.ceil(116 * Theme.heightScale)		// OptionsList Footer Height
			
			property int warningFontSize: Math.ceil(24 * Theme.heightScale)
			property int warningMargin: Math.ceil(73 * Theme.widthScale)
			
			/*
			Text {
				id: warningHeaderText
				visible: headerWarningVisibility
				text: L10n.strings.options.labels.video_warningHeader
				
				anchors.left: parent.left
                anchors.leftMargin: headerTextBody.warningMargin
                anchors.bottom: parent.bottom
                anchors.bottomMargin: Math.ceil(2 * Theme.heightScale)
				
				color: Theme.colors.buttonText
                font.pixelSize: headerTextBody.warningFontSize
                font.family: Theme.fonts.regular
                font.bold: true
			}
			*/
		}



        Item {
            id: footerGraphicDescription
            height: Math.ceil(183 * Theme.heightScale)		// OptionsList Footer Height

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

			property string hintOneButton: appRoot.hintLRIcon
			property color hintOneColor: Theme.colors.text
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
					hintButtonText: appRoot.isLeftMenuFocused ? appRoot.hintSelectIcon : footerGraphicDescription.hintOneButton
					hintTextText: appRoot.isLeftMenuFocused ? L10n.strings.hints.hintselect : L10n.strings.hints.hintchange
					hintButtonColor: appRoot.isLeftMenuFocused ? appRoot.hintSelectColor : footerGraphicDescription.hintOneColor
					
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
				footerGraphicDescription.hintOneButton = appRoot.hintLRIcon;
				footerGraphicDescription.hintOneColor = Theme.colors.text;
				footerGraphicDescription.isButtonVisible = true;
			
			} else if ( modelSelected === "checkbox" ) {
				footerGraphicDescription.hintOneButton = appRoot.hintSelectIcon;
				footerGraphicDescription.hintOneColor = appRoot.hintSelectColor;
				footerGraphicDescription.isButtonVisible = true;
				
			} else if ( modelSelected === "separator" ) {
				footerGraphicDescription.isButtonVisible = false;
			} 
			
        }
    }
}
