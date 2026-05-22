import QtQuick 2.9
import CrowbarCollective 1.0

RouteView { id: videoOptionsView
    property string blockingRouteName

    property int costFontSize: Math.ceil(16 * Theme.widthScale)

    property bool headerWarningVisibility: false

    function onRouteWillChange(newRouteName) {
        if (!blockingRouteName && videoOptions.hasPendingChanges) {
            blockingRouteName = newRouteName;
            confirmAlert.show();
            return true;
        }
    }

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
        'video_radioactiveNoise',
        'video_unlockHighendUnsupported'
        //'video_unlockPotato'
    ])

    OptionsList { id: videoOptions
        title: L10n.strings.headers.videoOptions
        batchUpdates: true
        visibleRows: 8

        anchors.centerIn: parent
        anchors.verticalCenterOffset: Math.ceil(20 * Theme.heightScale)

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
            //console.log("updateHeaderWarningVisibility ---> nbWarning = " + nbWarning.toString());
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
                    video_csmQuality: "0", // Disabled
                    video_csmMemory: "0", // Low
                    video_dynamicShadowQuality: "0", // OFF
                    video_dynamicShadowMemory: "3", // Potato
                    video_dynamicShadowSoftness: "0", // Low
                    video_dynamicLightsQuality: "0", // Potato
                    video_godRays: "0",
                    video_lensFlare: "0",
                    video_chromaticAberration: "0",
                    video_radioactiveNoise: "0",
                    video_unlockHighendUnsupported: "false"
                    //video_unlockPotato: "true"
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
                    video_radioactiveNoise: "0",
                    video_unlockHighendUnsupported: "false"
                    //video_unlockPotato: "false"
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
                    video_radioactiveNoise: "0",
                    video_unlockHighendUnsupported: "false"
                    //video_unlockPotato: "false"
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
                    video_radioactiveNoise: "1",
                    video_unlockHighendUnsupported: "false"
                    //video_unlockPotato: "false"
                },
                "4": { // Ultra
                    video_antialiasing: "1",
                    video_modelDetail: "0", // High
                    video_textureDetail: "-1", // Ultra
                    video_filtering: "4",
                    video_motionBlur: "1", // ON
                    video_waterDetail: "all",
                    video_csmQuality: "3", // Medium
                    video_csmMemory: "2", // High
                    video_dynamicShadowQuality: "4", // High
                    video_dynamicShadowMemory: "0", // High
                    video_dynamicShadowSoftness: "2", // High
                    video_dynamicLightsQuality: "4", // High
                    video_godRays: "2",
                    video_lensFlare: "1",
                    video_chromaticAberration: "1",
                    video_radioactiveNoise: "1",
                    video_unlockHighendUnsupported: "false"
                    //video_unlockPotato: "false"
                }
            };


            //line commented-out : don't set state during the initialization of the Video Option tab,
            //                     otherwise, as soon as we open the tab, we have to Apply/Discard changes even we we modified nothing.
            //var value = BlackMesaEngine.getConsoleVariableAsInt("mat_easymenu_quality_level");
            //setAdvancedSettingsState(qualitySettings[value]);

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
            updateHeaderWarningVisibility(); // better to update the Warning count after each setting change
        }

        function setAdvancedSettingsState(settings) {
            var isCustom = models.video_quality.value === "5";

            advancedQualityKeys.forEach(function (key) {
                //models[key].disabled = !isCustom;

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


            function video_dynamicShadowQuality(value) {
                var active, quality, maxpass,
                    unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported");
                var unlockedPotato = true; //BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_potato");

                // maximum for customer version :  4:High
                if (!unlocked && Number(value) > 4) {
                    value = "4";
                }

                // can't set potato if not enabled
                if (!unlockedPotato && Number(value) === 1) {
                    value = "2"; // 2=Low
                }

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
                var unlockedPotato = true; //BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_potato");
                var quality = Number(value);

                if (!unlockedPotato && quality === 3) {
                    quality = "2"; // 2=Low
                }

                BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_res", quality);
            }

            function video_dynamicShadowSoftness(value) {
                var quality = Number(value);
                var unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported");
                if (!unlocked && quality > 2) { // no more than 'High' in locked mode.
                    quality = "2";
                }
                BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_filter_quality", quality);
            }


            function video_dynamicLightsQuality(value) {
                var unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported");
                var unlockedPotato = true; //BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_potato");

                var lightsQuality,
                    newFourWayBlendingMinimalMode,
                    newFourWayBlendingFastNormals,
                    temporaryMinimalModeOverride,
                    temporaryFastNormalsOverride;

                if (!unlocked && Number(value) > 4) {
                    value = "4";
                }

                if (!unlockedPotato && Number(value) === 0) {
                    value = "1"; // 1=Low
                }

                BlackMesaEngine.setConsoleVariableAsInt("nr_lights_quality", value);

                lightsQuality = BlackMesaEngine.getConsoleVariableAsInt("nr_lights_quality");

                newFourWayBlendingMinimalMode = 0;
                newFourWayBlendingFastNormals = 1;

                if (lightsQuality < 3) {
                    newFourWayBlendingMinimalMode = 2;
                }

                /*
                if (lightsQuality === 6) {
                    newFourWayBlendingFastNormals = 0;
                }
                */

                temporaryMinimalModeOverride = BlackMesaEngine.getConsoleVariableAsInt("r_4way_minimal_mode_override");
                temporaryFastNormalsOverride = BlackMesaEngine.getConsoleVariableAsInt("r_4way_use_fast_normals_override");

                newFourWayBlendingMinimalMode = (temporaryMinimalModeOverride === -1) ? newFourWayBlendingMinimalMode : temporaryMinimalModeOverride;
                newFourWayBlendingFastNormals = (temporaryFastNormalsOverride === -1) ? newFourWayBlendingFastNormals : temporaryFastNormalsOverride;

                BlackMesaEngine.setConsoleVariableAsInt("r_4way_minimal_mode", newFourWayBlendingMinimalMode);
                BlackMesaEngine.setConsoleVariableAsInt("r_4way_use_fast_normals", newFourWayBlendingFastNormals);
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
                var unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported"),
                    enabled = 1, quality = Number(value);
                var unlockedPotato = true; //BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_potato");

                if (value === "disabled") {
                    enabled = 0;
                    quality = 0;
                // if we are not in Unlock mode, force CSM quality to be not higher than Medium :
                }

                if (!unlocked && quality > 2) {
                    quality = 2;
                }

                //don't set potato if not unlocked
                if (!unlockedPotato && quality === 0) {
                    quality = 1; // 1=Low
                }

                BlackMesaEngine.setConsoleVariableAsInt("cl_csm_enabled", enabled);
                BlackMesaEngine.setConsoleVariableAsInt("cl_csm_qualitymode", quality);
            }

            function video_csmMemory(value) {
                var quality = Number(value);
                BlackMesaEngine.setConsoleVariableAsInt("cl_csm_memoryusage", quality);
            }

            function video_unlockHighendUnsupported(value) {
                BlackMesaEngine.setConsoleVariableAsInt("mat_unlock_gfx_highend_unsupported", value === "true" ? 1 : 0);
                videoOptions.reloadPageAfterApplyChanges = true; // each time  mat_unlock_gfx_highend_unsupported  is changed, we need to reload the page in order to rebuild the options
            }

            //function video_unlockPotato(value) {
            //    BlackMesaEngine.setConsoleVariableAsInt("mat_unlock_gfx_potato", value === "true" ? 1 : 0);
            //    videoOptions.reloadPageAfterApplyChanges = true;
            //}
			
			//mygamepedia: this toggles hd pack 
			function video_hdPack(value) {  
				if (value === "1") {  
					BlackMesaEngine.executeClientCommandUnrestricted(  
						'sv_game_hd 1; con_logfile game_hd.txt; echo "If this file exists on disk HD content will be loaded."; con_logfile "";'  
					);  
				} else {  
					BlackMesaEngine.executeClientCommandUnrestricted('sv_game_hd 0; remove_game_hd');  
				}
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

            // the following getters will also set in the event the read value is invalid.
            // this is terrible and hacky, but it's easier than adding error states and
            // avenues for the user to fix the errors into the ui that they will probably
            // only ever get to if they are fucking around with the console.
            // Warranty void if console opened.
            function video_dynamicLightsQuality() {
                var quality = BlackMesaEngine.getConsoleVariableAsInt("nr_lights_quality"),
                    unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported");
                var unlockedPotato = true; //BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_potato");

                // settings above "VeryHigh" are only allowed if unlocked
                if (!unlocked && quality > 4) {
                    quality = 4;
                    BlackMesaEngine.setConsoleVariableAsInt("nr_lights_quality", quality);
                }

                // settings Potato is only allowed if unlocked potato.
                if (!unlockedPotato && quality === 0) {
                    quality = 1;
                    BlackMesaEngine.setConsoleVariableAsInt("nr_lights_quality", quality);
                }

                return quality.toString();
            }

            function video_dynamicShadowQuality() {
                var quality = BlackMesaEngine.getConsoleVariableAsInt("nr_shadow_quality"),
                    enabled = BlackMesaEngine.getConsoleVariableAsInt("nr_shadow_active") === 666,
                    unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported");
                var unlockedPotato = true; //BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_potato");

                if (!enabled) {
                    return "0";
                // settings above "High" are only allowed if unlocked
                }

                if (!unlocked && quality > 4) {
                    quality = 4;
                    BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_quality", quality);
                }

                // settings Potato is only allowed if unlocked potato.
                if (!unlockedPotato && quality === 1) {
                    quality = 2; // 2=Low
                    BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_quality", quality);
                }

                return quality.toString();
            }

            function video_dynamicShadowMemory() {
                var quality = BlackMesaEngine.getConsoleVariableAsInt("nr_shadow_res");
                var unlockedPotato = true; //BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_potato");

                // settings Potato is only allowed if unlocked potato.
                if (!unlockedPotato && quality === 3) {
                    quality = 2; // 2=Low
                    BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_res", quality);
                }

                return quality.toString();
            }

            function video_dynamicShadowSoftness() {
                var quality = BlackMesaEngine.getConsoleVariableAsInt("nr_shadow_filter_quality");
                var unlocked = BlackMesaEngine.getConsoleVariableAsInt("mat_unlock_gfx_highend_unsupported");
                if (!unlocked && quality > 2) { // no more than 'High' in locked mode.
                    quality = 2;
                    BlackMesaEngine.setConsoleVariableAsInt("nr_shadow_filter_quality", quality);
                }
                return quality.toString();
            }

            function video_csmQuality() {
                var enabled = BlackMesaEngine.getConsoleVariableAsBoolean("cl_csm_enabled"),
                    quality = BlackMesaEngine.getConsoleVariableAsInt("cl_csm_qualitymode"),
                    unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported");
                var unlockedPotato = true; //BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_potato");

                if (!enabled) {
                    return "disabled";
                // if we are not in Unlock mode, force CSM quality to be not higher than Medium :
                }

                if (!unlocked && quality > 2) {
                    quality = 2;
                    BlackMesaEngine.setConsoleVariableAsInt("cl_csm_qualitymode", quality);
                }

                // settings Potato is only allowed if unlocked potato.
                if (!unlockedPotato && quality === 0) {
                    quality = 1;
                    BlackMesaEngine.setConsoleVariableAsInt("cl_csm_qualitymode", quality);
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

            function video_unlockHighendUnsupported() {
                var originalValue = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported");
                return originalValue.toString(); // returns string "true" or "false"
            }

            //function video_unlockPotato() {
            //    var originalValue = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_potato");
            //    return originalValue.toString(); // returns string "true" or "false"
            //}
			
			//mygamepedia: hd pack state
			function video_hdPack() {  
				return BlackMesaEngine.getConsoleVariableAsInt("sv_game_hd").toString();  
			}

        }

        model: ListModel { id: videoOptionsModel
            Component.onCompleted: {
                var unlocked = BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_highend_unsupported"),
                    unlockedPotato = true, //BlackMesaEngine.getConsoleVariableAsBoolean("mat_unlock_gfx_potato"),
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
                    options: resolutions,
                    description_main: labels.video_desc_help_RESOLUTION
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
                    ],
                    description_main: labels.video_desc_help_DISPLAYMODE
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
                    formatter: 'whole',
                    stepValue: 1.0,
                    description_main: labels.video_desc_help_FIELDOFVIEW
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
                    ],
                    description_main: labels.video_desc_help_VERTICALSYNC
                });

                append({
                    //disabled: false,
                    label: labels.video_lensFlare,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_lensFlare",
                    cvar: "bms_lf_enabled",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.on, value: "1" }
                    ],
                    description_main: labels.video_desc_help_LENSFLARE
                });

                append({
                    //disabled: false,
                    label: labels.video_chromaticAberration,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_chromaticAberration",
                    cvar: "mat_chromatic_damage_enable",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.on, value: "1" }
                    ],
                    description_main: labels.video_desc_help_CHROMATICABBREVIATION
                });

                append({
                    //disabled: false,
                    label: labels.video_radioactiveNoise,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_radioactiveNoise",
                    cvar: "mat_geiger_noise_enable",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.on, value: "1" }
                    ],
                    description_main: labels.video_desc_help_RADIOACTIVENOISESHADER
                });

                // HUD Post process
                append({
                    //disabled: false,
                    label: labels.video_hudPostProcess,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_hudPostProcess",
                    cvar: "hud_post",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.on, value: "1" }
                    ],
                    description_main: labels.video_desc_help_HUDPOSTPROCESS
                });
				
				//MyGamepedia: HD PACK
				append({  
					label: labels.video_hdPack,  
					type: "select",  
					valueType: "int",  
					value: "",  
					key: "video_hdPack",  
					options: [  
						{ label: values.off, value: "0" },  
						{ label: values.on,  value: "1" }  
					],  
					description_main: labels.video_desc_help_HDPACK
				});

                append({
                    //disabled: false,
                    label: labels.video_motionBlur,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "video_motionBlur",
                    cvar: "mat_motion_blur_enabled",
                    options: [
                        { label: values.off, value: "0" },
                        { label: values.on, value: "1" }
                    ],
                    description_main: labels.video_desc_help_MOTIONBLUR
                });

                // Overall Quality
                var overallQualityOptions = [];
                if ( unlockedPotato ) {
                    overallQualityOptions.push({ label: values.qualityPotato, value: "0" });
                }
                overallQualityOptions.push({ label: values.qualityLow, value: "1" });
                overallQualityOptions.push({ label: values.qualityMedium, value: "2" });
                overallQualityOptions.push({ label: values.qualityHigh, value: "3" });
                overallQualityOptions.push({ label: values.qualityUltra, value: "4" });
                overallQualityOptions.push({ label: values.qualityCustom, value: "5" });
                append({
                    label: labels.video_quality,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_quality",
                    cvar: "mat_easymenu_quality_level",
                    options: overallQualityOptions,
                    description_main: labels.video_desc_help_OVERALLQUALITY
                });

                // ---- Advanced Settings separator ----
                append({
                    label: L10n.strings.headers.advancedSettings,
                    type:  "separator"
                });

                // Checkbox: Unlock Potato
                //append({
                //    label: labels.video_unlockPotato,
                //    type: "checkbox",
                //    valueType: "bool",
                //    key: "video_unlockPotato",
                //    description_main: labels.video_desc_help_UNLOCKPOTATO
                //});

                append({
                    //disabled: false,
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
                    //disabled: false,
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
                    ],
                    description_main: labels.video_desc_help_MODELDETAIL,
                    usage_cpu: labels.video_desc_usage_none,
                    usage_gpu: labels.video_desc_usage_moderate,
                    usage_ram: labels.video_desc_usage_moderate
                });

                // Texture Detail
                append({
                    //disabled: false,
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
                    ],
                    description_main: labels.video_desc_help_TEXTUREDETAIL,
                    usage_cpu: labels.video_desc_usage_none,
                    usage_gpu: labels.video_desc_usage_minor,
                    usage_ram: labels.video_desc_usage_moderate
                });

                // Filtering
                append({
                    //disabled: false,
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
                    ],
                    description_main: labels.video_desc_help_FILTERING,
                    usage_cpu: labels.video_desc_usage_none,
                    usage_gpu: labels.video_desc_usage_minor,
                    usage_ram: labels.video_desc_usage_minor
                });

                // Water Reflections
                append({
                    //disabled: false,
                    label: labels.video_waterDetail,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_waterDetail",
                    options: [
                        { label: values.qualityLow, value: "simple" },
                        { label: values.qualityMedium, value: "world" },
                        { label: values.qualityHigh, value: "all", warning: 1  }
                    ],
                    description_main: labels.video_desc_help_WATERREFLECTIONS,
                    usage_cpu: labels.video_desc_usage_major,
                    usage_gpu: labels.video_desc_usage_major,
                    usage_ram: labels.video_desc_usage_minor
                });

                // CSM Quality
                var csmOptions = [];
                csmOptions.push({ label: values.off, value: "disabled" });
                if ( unlockedPotato ) {
                    csmOptions.push({ label: values.qualityPotato, value: "0" });
                }
                csmOptions.push({ label: values.qualityLow, value: "1" });
                csmOptions.push({ label: values.qualityHigh, value: "2" });
                csmOptions.push({ label: values.qualityUltra, value: "3" });
                if (unlocked) {
                    csmOptions.push({ label: values.qualityInsane, value: "4", warning: 1 });
                }
                append({
                    //disabled: false,
                    label: labels.video_csmQuality,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_csmQuality",
                    options: csmOptions,
                    description_main: labels.video_desc_help_CSMQUALITY,
                    usage_cpu: labels.video_desc_usage_major,
                    usage_gpu: labels.video_desc_usage_major,
                    usage_ram: labels.video_desc_usage_major
                });

                // CSM Memory Usage
                var csmMemoryUsage = [];
                csmMemoryUsage.push({ label: values.qualityLow, value: "0" });
                csmMemoryUsage.push({ label: values.qualityMedium, value: "1" });
                csmMemoryUsage.push({ label: values.qualityHigh, value: "2" });
                append({
                    //disabled: false,
                    label: labels.video_csmMemory,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_csmMemory",
                    options: csmMemoryUsage,
                    description_main: labels.video_desc_help_CSMMEMORYUSAGE,
                    usage_cpu: labels.video_desc_usage_none,
                    usage_gpu: labels.video_desc_usage_minor,
                    usage_ram: labels.video_desc_usage_major
                });


                // Dynamic Shadow Quality
                var shadowOptions = [];
                shadowOptions.push({ label: values.off, value: "0" });
                if ( unlockedPotato ) {
                    shadowOptions.push({ label: values.qualityPotato, value: "1" });
                }
                shadowOptions.push({ label: values.qualityLow, value: "2" });
                shadowOptions.push({ label: values.qualityMedium, value: "3" });
                shadowOptions.push({ label: values.qualityHigh, value: "4" });
                append({
                    //disabled: false,
                    label: labels.video_dynamicShadowQuality,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_dynamicShadowQuality",
                    options: shadowOptions,
                    description_main: labels.video_desc_help_DYNAMICSHADOWSQUALITY,
                    usage_cpu: labels.video_desc_usage_major,
                    usage_gpu: labels.video_desc_usage_moderate,
                    usage_ram: labels.video_desc_usage_major
                });


                // Dynamic Shadow Memory
                var shadowOptionsMemory = [];
                if ( unlockedPotato ) {
                    shadowOptionsMemory.push({ label: values.qualityPotato, value: "3" });
                }
                shadowOptionsMemory.push({ label: values.qualityLow, value: "2" });
                shadowOptionsMemory.push({ label: values.qualityMedium, value: "1" });
                shadowOptionsMemory.push({ label: values.qualityHigh, value: "0" });
                append({
                    //disabled: false,
                    label: labels.video_dynamicShadowMemory,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_dynamicShadowMemory",
                    options: shadowOptionsMemory,
                    description_main: labels.video_desc_help_DYNAMICSHADOWSMEMORY,
                    usage_cpu: labels.video_desc_usage_none,
                    usage_gpu: labels.video_desc_usage_minor,
                    usage_ram: labels.video_desc_usage_major
                });

                // Dynamic Shadow Softness
                var shadowOptionsSoftness = [];
                shadowOptionsSoftness.push({ label: values.qualityLow, value: "0" });
                shadowOptionsSoftness.push({ label: values.qualityMedium, value: "1" });
                shadowOptionsSoftness.push({ label: values.qualityHigh, value: "2" });
                append({
                    //disabled: false,
                    label: labels.video_dynamicShadowSoftness,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_dynamicShadowSoftness",
                    options: shadowOptionsSoftness,
                    description_main: labels.video_desc_help_DYNAMICSHADOWFILTERING,
                    usage_cpu: labels.video_desc_usage_none,
                    usage_gpu: labels.video_desc_usage_moderate,
                    usage_ram: labels.video_desc_usage_minor
                });



                // Dynamic Lights Quality
                var lightsOptions = [];
                if ( unlockedPotato ) {
                    lightsOptions.push({ label: values.qualityPotato, value: "0" });
                }
                lightsOptions.push({ label: values.qualityLow, value: "1" });
                lightsOptions.push({ label: values.qualityMedium, value: "2" });
                lightsOptions.push({ label: values.qualityHigh, value: "3" });
                lightsOptions.push({ label: values.qualityUltra, value: "4", warning: 1 });
                if (unlocked) {
                    lightsOptions.push({ label: values.qualityInsane, value: "5", warning: 1 });
                    //lightsOptions.push({ label: values.qualityInsane2, value: "6", warning: 1 }); // USED ONLY FOR DEBUG!
                }
                append({
                    //disabled: false,
                    label: labels.video_dynamicLightsQuality,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "video_dynamicLightsQuality",
                    options: lightsOptions,
                    description_main: labels.video_desc_help_DYNAMICLIGHTSQUALITY,
                    usage_cpu: labels.video_desc_usage_major,
                    usage_gpu: labels.video_desc_usage_major,
                    usage_ram: labels.video_desc_usage_major
                });

                // God Rays
                append({
                    //disabled: false,
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

                // Gamma ( Brightness )
                append({
                    label: labels.video_gamma,
                    type: "slider",
                    valueType: "real",
                    value: "",
                    key: "video_gamma",
                    cvar: "mat_monitorgamma",
                    minValue: 1.6,
                    maxValue: 2.6,
                    precision: 1,
                    formatter: 'decimal',
                    stepValue: 0.1,
                    description_main: labels.video_desc_help_GAMMA
                });

                // Checkbox: Unlock Highend Unsupported
                append({
                    label: labels.video_unlockHighendUnsupported,
                    type: "checkbox",
                    valueType: "bool",
                    key: "video_unlockHighendUnsupported",
                    description_main: labels.video_desc_help_UNLOCKHIGHENDUNSUPPORTED
                });

            }
        }



    Item { id: footerGraphicDescription

            anchors.bottomMargin: 1
            anchors.rightMargin: Math.ceil(600 * Theme.widthScale)

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            width: parent.width
            height: Math.ceil(85 * Theme.widthScale)

            Text { id: footerGraphicDescriptionText_desc
                anchors.margins: Math.ceil(5 * Theme.widthScale)
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.colors.buttonText
                font.family: Theme.fonts.bold
                font.pixelSize: costFontSize
                text: ""
                anchors.leftMargin: Math.ceil(25 * Theme.widthScale)
                anchors.left: parent.left
                wrapMode: Text.WordWrap
                width:  Math.ceil( ( 0.0446  * appRoot.width +  564.285 ) * (Theme.widthScale) )   // for wrapping, we need to specify 'width'   -   I tested from 800x600 to 4K.  this is scaling correctly with those numbers
            }

            Text { id: footerGraphicDescriptionText_cost_CPU
                anchors.margins: Math.ceil(5 * Theme.widthScale)
                anchors.top: parent.top
                color: Theme.colors.buttonText
                font.family: Theme.fonts.bold
                font.pixelSize: costFontSize
                text: ""
                horizontalAlignment: Text.AlignLeft
                anchors.left: footerGraphicDescriptionText_desc.right
                anchors.leftMargin: Math.ceil(5 * Theme.widthScale)
            }

            Text { id: footerGraphicDescriptionText_cost_GPU
                anchors.margins: Math.ceil(5 * Theme.widthScale)
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.colors.buttonText
                font.family: Theme.fonts.bold
                font.pixelSize: costFontSize
                text: ""
                anchors.left: footerGraphicDescriptionText_desc.right
                anchors.leftMargin: Math.ceil(5 * Theme.widthScale)
            }

            Text { id: footerGraphicDescriptionText_cost_RAM
                anchors.margins: Math.ceil(5 * Theme.widthScale)
                anchors.bottom : parent.bottom
                color: Theme.colors.buttonText
                font.family: Theme.fonts.bold
                font.pixelSize: costFontSize
                text: ""
                horizontalAlignment: Text.AlignLeft
                anchors.left: footerGraphicDescriptionText_desc.right
                anchors.leftMargin: Math.ceil(5 * Theme.widthScale)
            }

            Text { id: footerGraphicDescriptionText_cost_CPU_value
                anchors.margins: Math.ceil(5 * Theme.widthScale)
                anchors.top: parent.top
                color: Theme.colors.highlight
                font.family: Theme.fonts.bold
                font.pixelSize: costFontSize
                text: ""
                anchors.left: footerGraphicDescriptionText_cost_RAM.right
                anchors.leftMargin: Math.ceil(5 * Theme.widthScale)
            }

            Text { id: footerGraphicDescriptionText_cost_GPU_value
                anchors.margins: Math.ceil(5 * Theme.widthScale)
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.colors.highlight
                font.family: Theme.fonts.bold
                font.pixelSize: costFontSize
                text: ""
                anchors.left: footerGraphicDescriptionText_cost_RAM.right
                anchors.leftMargin: Math.ceil(5 * Theme.widthScale)
            }

            Text { id: footerGraphicDescriptionText_cost_RAM_value
                anchors.margins: Math.ceil(5 * Theme.widthScale)
                anchors.bottom : parent.bottom
                color: Theme.colors.highlight
                font.family: Theme.fonts.bold
                font.pixelSize: costFontSize
                text: ""
                anchors.left: footerGraphicDescriptionText_cost_RAM.right
                anchors.leftMargin: Math.ceil(5 * Theme.widthScale)
            }

        }

        function onSelectionChanged(modelSelected) {
            footerGraphicDescriptionText_desc.text           = modelSelected.description_main ? modelSelected.description_main : "";
            footerGraphicDescriptionText_cost_GPU_value.text = modelSelected.usage_gpu        ? modelSelected.usage_gpu        : "";
            footerGraphicDescriptionText_cost_CPU_value.text = modelSelected.usage_cpu        ? modelSelected.usage_cpu        : "";
            footerGraphicDescriptionText_cost_RAM_value.text = modelSelected.usage_ram        ? modelSelected.usage_ram        : "";
            footerGraphicDescriptionText_cost_GPU.text       = modelSelected.usage_gpu        ? L10n.strings.options.labels.video_desc_usage_gpu : "";
            footerGraphicDescriptionText_cost_CPU.text       = modelSelected.usage_cpu        ? L10n.strings.options.labels.video_desc_usage_cpu : "";
            footerGraphicDescriptionText_cost_RAM.text       = modelSelected.usage_ram        ? L10n.strings.options.labels.video_desc_usage_ram : "";

            var colorMap = ([]);
            colorMap[L10n.strings.options.labels.video_desc_usage_major] = "#FF4D2D"; // red
            colorMap[L10n.strings.options.labels.video_desc_usage_moderate] = "#FFD53E"; // yellow
            colorMap[L10n.strings.options.labels.video_desc_usage_minor] = "#55E835"; // green
            colorMap[L10n.strings.options.labels.video_desc_usage_none] = "white";
            colorMap[""] = "#000000";

            footerGraphicDescriptionText_cost_GPU_value.color = colorMap[footerGraphicDescriptionText_cost_GPU_value.text];
            footerGraphicDescriptionText_cost_CPU_value.color = colorMap[footerGraphicDescriptionText_cost_CPU_value.text];
            footerGraphicDescriptionText_cost_RAM_value.color = colorMap[footerGraphicDescriptionText_cost_RAM_value.text];

        }



        Image { id: warningHeaderSign
            visible: headerWarningVisibility
            source: "image://game/ui/images/warning.png"
            height: Math.ceil(40 * Theme.heightScale)
            width: Math.ceil(40 * Theme.heightScale)
            anchors.right: parent.right
            anchors.top: parent.top
            fillMode: Image.Stretch
            anchors.topMargin: Math.ceil(20 * Theme.heightScale)
            anchors.rightMargin: Math.ceil(55 * Theme.heightScale)
        }
        Text { id: warningHeaderText
            visible: headerWarningVisibility
            text: L10n.strings.options.labels.video_warningHeader
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: Math.ceil(30 * Theme.heightScale)
            anchors.rightMargin: Math.ceil(100 * Theme.heightScale)
            color: Theme.colors.buttonText
            font.family: Theme.fonts.bold
            font.pixelSize: Math.ceil(16 * Theme.heightScale)
        }


    }

    Alert { id: confirmAlert
        titleText: L10n.strings.headers.unsavedWarning
        messageText: L10n.strings.modalMessages.unsavedWarning

        buttons: VisualItemModel { id: buttons
            CTAButton {
                objectName: "ui:btn:action[apply]"
                text: L10n.strings.buttons.apply
                onClicked: {
                    videoOptions.flushPendingChanges();
                    videoOptionsView.routeRequest(blockingRouteName);
                    // Reload game after video settings change
					BlackMesaEngine.executeClientCommandUnrestricted("savereloadaftersettingschange");
                }
            }

            WarningButton {
                objectName: "ui:btn:action[discard]"
                text: L10n.strings.buttons.discard
                onClicked: {
                    videoOptionsView.routeRequest(blockingRouteName);
                }
            }

            DefaultButton {
                objectName: "ui:btn:action[cancel]"
                text: L10n.strings.buttons.cancel
                onClicked: {
                    blockingRouteName = "";
                    confirmAlert.hide();
                }
            }
        }
    }
}
