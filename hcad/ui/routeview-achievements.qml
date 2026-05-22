import QtQuick 2.9
import CrowbarCollective 1.0

RouteView { id: audioOptionsView
    property string blockingRouteName
    property var rtlLanguages: [
        "arabic","aramaic", "azeri", "dhivehi",
        "maldivian", "hebrew", "kurdish", "sorani",
        "persian", "farsi", "urdu"
    ]

    function onRouteWillChange(newRouteName) {
        if (!blockingRouteName && audioOptions.hasPendingChanges) {
            blockingRouteName = newRouteName;
            confirmAlert.show();
            return true;
        }
    }

    OptionsList { id: audioOptions
        title: L10n.strings.headers.audioOptions
        batchUpdates: true
        visibleRows: 7

        anchors.centerIn: parent
        anchors.verticalCenterOffset: Math.ceil(20 * Theme.heightScale)

        Component.onCompleted: {
            setLanguageState();
        }

        onRequestSettingsChange: {
            if (model.key === models.audio_captioning.key) {
                setLanguageState();
            } else if (model.key === models.audio_musicVolume.key) {
                Sound.ambientVolume = model.value;
            }
        }

        onSettingsReset: {
            setLanguageState();
        }

        function setLanguageState() {
            models.audio_captioningLang.disabled = models.audio_captioning.value === "0"
        }

        readonly property QtObject getComplex: QtObject {
            function audio_captioning() {
                var cc = BlackMesaEngine.getConsoleVariableAsInt("closecaption"),
                    subs = BlackMesaEngine.getConsoleVariableAsInt("cc_subtitles");

                return cc ? (subs ? "2" : "1") : "0";
            }

            function audio_quality() {
                var quality = "low";

                if (!BlackMesaEngine.getConsoleVariableAsBoolean("dsp_slow_cpu")) {
                    quality = "medium";
                }
                if (BlackMesaEngine.getConsoleVariableAsBoolean("snd_pitchquality")) {
                    quality = "high";
                }

                return quality;
            }

            function audio_captioningLang() {
                return BlackMesaEngine.getConsoleVariableAsString("cc_lang");
            }
        }

        readonly property QtObject setComplex: QtObject {
            function audio_captioning(value) {
                var cc, subs;

                switch (value) {
                    case "0": cc = 0; subs = 1; break;
                    case "1": cc = 1; subs = 0; break;
                    case "2": cc = 1; subs = 1; break;
                }

                BlackMesaEngine.setConsoleVariableAsInt("closecaption", cc);
                BlackMesaEngine.setConsoleVariableAsInt("cc_subtitles", subs);
            }

            function audio_quality(value) {
                var dsp, pitch;

                switch (value) {
                    case "low": dsp = 1; pitch = 0; break;
                    case "medium": dsp = 0; pitch = 0; break;
                    case "high": dsp = 0; pitch = 1; break;
                }

                BlackMesaEngine.setConsoleVariableAsInt("dsp_slow_cpu", dsp);
                BlackMesaEngine.setConsoleVariableAsInt("snd_pitchquality", pitch);
            }

            function audio_captioningLang(value) {
                BlackMesaEngine.setConsoleVariableAsString("cc_lang", value);

                if (audioOptionsView.rtlLanguages.indexOf(value) == 0) {
                    BlackMesaEngine.setConsoleVariableAsInt("cc_rightaligned", 1);
                } else {
                    BlackMesaEngine.setConsoleVariableAsInt("cc_rightaligned", 0);
                }
            }
        }

        model: ListModel { id: audioOptionsModel
            Component.onCompleted: {
                var labels = L10n.strings.options.labels,
                    values = L10n.strings.options.values;

                append({
                    label: labels.audio_gameVolume,
                    type: "slider",
                    valueType: "real",
                    value: "",
                    key: "audio_gameVolume",
                    cvar: "volume",
                    minValue: 0.0,
                    maxValue: 1.0,
                    precision: 2,
                    formatter: 'percent',
                    stepValue: 0.05 // for Audio : increment step to 5 units
                });

                append({
                    label: labels.audio_fxvolume,
                    type: "slider",
                    valueType: "real",
                    value: "",
                    key: "audio_fxvolume",
                    cvar: "snd_fxvolume",
                    minValue: 0.0,
                    maxValue: 1.0,
                    precision: 2,
                    formatter: 'percent',
                    stepValue: 0.05 // for Audio : increment step to 5 units
                });

                append({
                    label: labels.audio_musicVolume,
                    type: "slider",
                    valueType: "real",
                    value: "",
                    key: "audio_musicVolume",
                    cvar: "le_light_Range",
                    minValue: 0.0,
                    maxValue: 20000.0,
                    precision: 2,
                    formatter: 'percent',
                    stepValue: 0.05 // for Audio : increment step to 5 units
                });

                append({
                    label: labels.audio_speakerConfig,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "audio_speakerConfig",
                    cvar: "snd_surround_speakers",
                    options: [
                        { label: values.speakersHeadphones, value: "0" },
                        { label: values.speakers2, value: "2" },
                        { label: values.speakers4, value: "4" },
                        { label: values.speakers51, value: "5" },
                        { label: values.speakers71, value: "7" }
                    ]
                });

                append({
                    label: labels.audio_quality,
                    type: "select",
                    valueType: "string",
                    value: "",
                    key: "audio_quality",
                    options: [
                        { label: values.qualityLow, value: "low" },
                        { label: values.qualityMedium, value: "medium" },
                        { label: values.qualityHigh, value: "high" }
                    ]
                });

                append({
                    label: labels.audio_captioning,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "audio_captioning",
                    options: [
                        { label: values.captioningNo, value: "0" },
                        { label: values.captioningClosedCaptions, value: "1" },
                        { label: values.captioningSubtitles, value: "2" }
                    ]
                });

                append({
                    disabled: false,
                    label: labels.audio_captioningLang,
                    type: "select",
                    valueType: "int",
                    value: "",
                    key: "audio_captioningLang",
                    options: [
                        { label: values.langArabic, value: "arabic" },
                        { label: values.langChineseSimplified, value: "schinese" },
                        { label: values.langChineseTraditional, value: "tchinese" },
                        { label: values.langCroatian, value: "croatian" },
                        { label: values.langCzech, value: "czech" },
                        { label: values.langDanish, value: "danish" },
                        { label: values.langDutch, value: "dutch" },
                        { label: values.langEnglish, value: "english" },
                        { label: values.langFinnish, value: "finnish" },
                        { label: values.langFrench, value: "french" },
                        { label: values.langGeorgian, value: "georgian" },
                        { label: values.langGerman, value: "german" },
                        { label: values.langGreek, value: "greek" },
                        { label: values.langHungarian, value: "hungarian" },
                        { label: values.langIndonesian, value: "indonesian" },
                        { label: values.langItalian, value: "italian" },
                        { label: values.langJapanese, value: "japanese" },
                        { label: values.langKorean, value: "korean" },
                        { label: values.langLithuanian, value: "lithuanian" },
                        { label: values.langNorwegian, value: "norwegian" },
                        { label: values.langPolish, value: "polish" },
                        { label: values.langPortuguese, value: "portuguese" },
                        { label: values.langPortugueseBrazilian, value: "brazilian" },
                        { label: values.langRomanian, value: "romanian" },
                        { label: values.langRussian, value: "russian" },
                        { label: values.langSpanish, value: "spanish" },
                        { label: values.langSpanishMexico, value: "mspanish" },
                        { label: values.langSwedish, value: "swedish" },
                        { label: values.langTurkish, value: "turkish" },
                        { label: values.langUkrainian, value: "ukrainian" },
                        { label: values.langVietnamese, value: "vietnamese" },
                    ]
                });
            }
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
                    audioOptions.flushPendingChanges();
                    audioOptionsView.routeRequest(blockingRouteName);
                }
            }

            WarningButton {
                objectName: "ui:btn:action[discard]"
                text: L10n.strings.buttons.discard
                onClicked: {
                    audioOptionsView.routeRequest(blockingRouteName);
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
