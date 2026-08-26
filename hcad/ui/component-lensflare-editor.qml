import QtQuick 2.9  
import QtQuick.Controls 2.2  
//import QtQuick.Dialogs 1.2  
import CrowbarCollective 1.0  
  
Item { id: editorRoot  
    anchors.right: parent.right  
    width: parent.width * 0.275
    height: parent.height * 0.57
	z: 2
  
    opacity: 0.0  
    visible: opacity > 0.0009765625  
    clip: true  
    enabled: visible  
    state: "closed"  
  
    // ── Static data ──────────────────────────────────────────────────────────  
    readonly property var styleNames: [
        "Normal (0)", "Flicker A (1)", "Slow, strong pulse (2)",
        "Candle A (3)", "Fast strobe (4)", "Gentle pulse (5)",
        "Flicker B (6)", "Candle B (7)", "Candle C (8)",
        "Slow strobe (9)", "Fluorescent flicker (10)",
        "Slow pulse, noblack (11)", "Underwater (12)"
    ]
    readonly property var functionOptions: ["DISK", "BOW", "DISKH", "RAY"]  
    //readonly property var functionParamCount: ({ "DISK": 3, "BOW": 1, "DISKH": 4, "RAY": 2 })  
  
    // ── Mutable state ─────────────────────────────────────────────────────────  
    property bool   isLoading:       false
	property bool componentReady:	 false
    property int    functionIndex:   0  
    property string currentFunction: functionOptions[functionIndex]
    property int    flareType:       0  
    property color  currentColor:    Qt.rgba(1, 1, 1, 1)  
	property real   hue:            0.0  
	property real   saturation:     0.0  
	property real   hsv_value:      1.0  
	property bool   _updatingColor: false
    property int    currentStyle:    0  
    property string currentAngleZ:    "0" // preserved without a visible Z field
	property bool ownedUI: false
	//show grid and left side glow?
	property bool _savedShowExtras: false
	property int flareIndex: -1
	property int flareUpdateCount: 0
  
	property bool flaresReady: false

    // ── Flare element clipboard ───────────────────────────────────────────────
    property bool   flareClipboardValid:     false
    property string flareClipboardFunction:  ""
    property string flareClipboardParams:    ""
    property string flareClipboardSizes:     ""
    property string flareClipboardIntensity: ""
    property string flareClipboardColor:     ""
    property string flareClipboardTexture:   ""
    //onFunctionIndexChanged: { currentFunction = functionOptions[functionIndex]; }  
  
    // ── Public API ────────────────────────────────────────────────────────────  
	function show() {  
		// MUST be first — this makes suppressAnimations = true before any opacity changes  
		appRoot.isLensFlareEditorOpen = true;  
	  
		_savedShowExtras = wallpaper.showExtras;  
		wallpaper.showExtras = false;           // now instant, Behavior is disabled  
	  
		if (!appRoot.visible) {  
			ownedUI = true;  
			appRoot.visible = true;             // UI appears with skrim/extras already at 0  
			BlackMesaEngine.grabInputForGameUI();  
		}  
		state = "opened";  
		if (BlackMesaEngine.getMaxClients() < 2  
				&& !BlackMesaEngine.isLevelMainMenuBackground()  
				&& BlackMesaEngine.isInGame()) {  
			BlackMesaEngine.executeClientCommandUnrestricted("unpause nomsg");  
		}
		flaresOverlay.beginFlareUpdate();
		flareIndexSyncTimer.restart();
	}  
	  
	function hide() {
		flareUpdateTimer.stop();
		flareIndexSyncTimer.stop();
		flareUpdateCount = 0;
		flaresReady = false;
		flaresModel.clear();
		state = "closed";  
		appRoot.isLensFlareEditorOpen = false;  
		wallpaper.showExtras = _savedShowExtras;  
		if (ownedUI) {  
			ownedUI = false;  
			appRoot.visible = false;  
			BlackMesaEngine.releaseInputFromGameUI();  
		}  
	}
		
	Component.onCompleted: {  
		componentReady = true;  
	}
  
    // Removes only insignificant zeroes at the end of the fractional part.
    // Examples: "3.000000" -> "3", "3.140000" -> "3.14", "-0.000" -> "0".
    function compactFloatText(value, fallback) {
        var result = (value === undefined || value === null)
                ? ""
                : value.toString().trim();

        if (result.length === 0)
            result = fallback;

        var exponentPos = result.indexOf("e");
        if (exponentPos < 0)
            exponentPos = result.indexOf("E");

        // Source ConVars normally return fixed-point strings. Leave an
        // exponent untouched rather than damaging its exponent zeroes.
        if (exponentPos < 0) {
            var dotPos = result.indexOf(".");

            if (dotPos >= 0) {
                while (result.length > dotPos + 1
                        && result.charAt(result.length - 1) === "0") {
                    result = result.substring(0, result.length - 1);
                }

                if (result.charAt(result.length - 1) === ".")
                    result = result.substring(0, result.length - 1);
            }
        }

        if (result === "-0" || result === "+0")
            result = "0";
        else if (result.charAt(0) === "+")
            result = result.substring(1);

        return result;
    }

    function normalizedFlareNumber(value) {
        var valueText = (value === undefined || value === null)
                ? ""
                : value.toString().trim();

        if (!/^[+-]?\d+$/.test(valueText))
            return 1;

        var number = parseInt(valueText, 10);
        return (number >= 1 && number <= 20) ? number : 1;
    }

    function setFlareNumber(value) {
        if (!componentReady)
            return;

        var number = normalizedFlareNumber(value);
        numField.text = number.toString();
        BlackMesaEngine.setConsoleVariableAsInt(
            "sv_hcad_mle_flare_num", number);
        copyTimer.restart();
    }

    function selectFlareFunction(index) {
        if (isLoading || !componentReady
                || index < 0 || index >= functionOptions.length) {
            return;
        }

        functionIndex = index;
        BlackMesaEngine.setConsoleVariableAsString(
            "sv_hcad_mle_flare_function", functionOptions[index]);
    }
    function applyTexture(textureName) {
        if (isLoading || !componentReady)
            return;

        // DISK is also the visual fallback for an empty function. Materialize
        // that selection before changing the texture so the final recreation
        // receives a real function and its three parameters.
        if (functionIndex === 0) {
            BlackMesaEngine.setConsoleVariableAsString(
                "sv_hcad_mle_flare_parameters",
                compactFloatText(param1Field.text, "1") + " "
                + compactFloatText(param2Field.text, "10") + " "
                + compactFloatText(param3Field.text, "10"));
            BlackMesaEngine.setConsoleVariableAsString(
                "sv_hcad_mle_flare_function", "DISK");
        }

        BlackMesaEngine.setConsoleVariableAsString(
            "sv_hcad_mle_flare_texture", textureName);
    }

    function texturePreviewSource(textureName) {
        var path = textureName === undefined || textureName === null
                ? "" : textureName.toString().trim();

        if (path.length === 0)
            return "";

        path = path.replace(/\\/g, "/");
        while (path.charAt(0) === "/")
            path = path.substring(1);

        if (path.indexOf("image://game/") === 0)
            return path;

        if (path.indexOf("materials/") !== 0)
            path = "materials/" + path;

        if (path.toLowerCase().substring(path.length - 4) !== ".vtf")
            path += ".vtf";

        return "image://game/" + path;
    }

    function moveTextCursor(field, direction, event) {
        var position;

        if (field.selectionStart !== field.selectionEnd) {
            position = direction < 0
                    ? Math.min(field.selectionStart, field.selectionEnd)
                    : Math.max(field.selectionStart, field.selectionEnd);
        } else {
            position = field.cursorPosition + direction;
        }

        position = Math.max(0, Math.min(field.text.length, position));
        field.deselect();
        field.cursorPosition = position;
        event.accepted = true;
    }

    // ── Convar helpers ────────────────────────────────────────────────────────  
    function applyParams() {  
        if (isLoading || !componentReady) return; 
        BlackMesaEngine.setConsoleVariableAsString("sv_hcad_mle_flare_parameters",  
            param1Field.text + " " + param2Field.text + " " +  
            param3Field.text + " " + param4Field.text);  
    }  
    function applySizes() {  
        if (isLoading || !componentReady) return;
        BlackMesaEngine.setConsoleVariableAsString("sv_hcad_mle_flare_sizes",  
            size1Field.text + " " + size2Field.text + " " + size3Field.text);  
    }  
    function applyIntensity() {  
        if (isLoading || !componentReady) return;
        BlackMesaEngine.setConsoleVariableAsString("sv_hcad_mle_flare_intensity",  
            int1Field.text + " " + int2Field.text + " " + int3Field.text);  
    }  
	function applyAngles() {  
		if (isLoading || !componentReady) return;  
		BlackMesaEngine.setConsoleVariableAsString("sv_hcad_mle_flare_angles",  
			ang1Field.text + " " + currentAngleZ + " " + ang3Field.text);
	} 
  
    function copyCurrentFlareElement() {
        flareClipboardFunction = currentFunction;

        flareClipboardParams =
                compactFloatText(param1Field.text, "1") + " "
                + compactFloatText(param2Field.text, "10") + " "
                + compactFloatText(param3Field.text, "10") + " "
                + compactFloatText(param4Field.text, "0");

        flareClipboardSizes =
                compactFloatText(size1Field.text, "1") + " "
                + compactFloatText(size2Field.text, "1") + " "
                + compactFloatText(size3Field.text, "1");

        flareClipboardIntensity =
                compactFloatText(int1Field.text, "1") + " "
                + compactFloatText(int2Field.text, "1") + " "
                + compactFloatText(int3Field.text, "1");

        var r = parseInt(colorRField.text);
        var g = parseInt(colorGField.text);
        var b = parseInt(colorBField.text);

        if (isNaN(r)) r = 0;
        if (isNaN(g)) g = 0;
        if (isNaN(b)) b = 0;

        flareClipboardColor = r + " " + g + " " + b;
        flareClipboardTexture = textureField.text;
        flareClipboardValid = true;
    }

    function pasteCopiedFlareElement() {
        if (!flareClipboardValid || flareIndex < 0)
            return;

        var pp = flareClipboardParams.split(" ");
        var sp = flareClipboardSizes.split(" ");
        var ip = flareClipboardIntensity.split(" ");
        var cp = flareClipboardColor.split(" ");

        isLoading = true;

        var copiedFunctionIndex =
                functionOptions.indexOf(flareClipboardFunction);

        if (copiedFunctionIndex < 0)
            copiedFunctionIndex = 0;

        functionIndex = copiedFunctionIndex;

        param1Field.text = compactFloatText(pp[0], "1");
        param2Field.text = compactFloatText(pp[1], "10");
        param3Field.text = compactFloatText(pp[2], "10");
        param4Field.text = compactFloatText(pp[3], "0");

        size1Field.text = compactFloatText(sp[0], "1");
        size2Field.text = compactFloatText(sp[1], "1");
        size3Field.text = compactFloatText(sp[2], "1");

        int1Field.text = compactFloatText(ip[0], "1");
        int2Field.text = compactFloatText(ip[1], "1");
        int3Field.text = compactFloatText(ip[2], "1");

        var r = parseInt(cp[0]);
        var g = parseInt(cp[1]);
        var b = parseInt(cp[2]);

        if (isNaN(r)) r = 0;
        if (isNaN(g)) g = 0;
        if (isNaN(b)) b = 0;

        colorRField.text = r.toString();
        colorGField.text = g.toString();
        colorBField.text = b.toString();
        currentColor = Qt.rgba(r / 255.0, g / 255.0, b / 255.0, 1.0);
        syncHSVFromRGB(r, g, b);

        textureField.text = flareClipboardTexture;

        isLoading = false;

        // Apply only values managed by the element clipboard.
        BlackMesaEngine.setConsoleVariableAsString(
            "sv_hcad_mle_flare_function", flareClipboardFunction);
        BlackMesaEngine.setConsoleVariableAsString(
            "sv_hcad_mle_flare_parameters", flareClipboardParams);
        BlackMesaEngine.setConsoleVariableAsString(
            "sv_hcad_mle_flare_sizes", flareClipboardSizes);
        BlackMesaEngine.setConsoleVariableAsString(
            "sv_hcad_mle_flare_intensity", flareClipboardIntensity);
        BlackMesaEngine.setConsoleVariableAsString(
            "sv_hcad_mle_flare_color", flareClipboardColor);
        BlackMesaEngine.setConsoleVariableAsString(
            "sv_hcad_mle_flare_texture", flareClipboardTexture);
    }

    function syncFlareIndexFromCvar() {
        var newIndex = BlackMesaEngine.getConsoleVariableAsInt(
            "sv_hcad_mle_flare_index"
        );

        if (newIndex === editorRoot.flareIndex)
            return;

        var oldIndex = editorRoot.flareIndex;
        var typedIndex = parseInt(indexField.text);

        editorRoot.flareIndex = newIndex;

        // Do not overwrite a number that the user is currently typing.
        // A focused but unchanged field is still safe to refresh.
        if (!indexField.activeFocus
                || isNaN(typedIndex)
                || typedIndex === oldIndex) {
            indexField.text = newIndex.toString();
        }

        // Recreating an env_lensflare can assign it a different entity index.
        // The overlay is a snapshot, so rebuild it before the old selected
        // entry can turn into a clickable ghost circle.
        if (editorRoot.state === "opened")
            flaresOverlay.beginFlareUpdate();
    }

    function loadAllFromCvars() {  
		isLoading = true;  
		var idxStr = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_flare_index");  
		indexField.text = idxStr;  
		flareIndex = parseInt(idxStr);   
  
        // num  
        var n = BlackMesaEngine.getConsoleVariableAsInt("sv_hcad_mle_flare_num");  
        if (n < 1 || n > 20) n = 1;
        numField.text = n.toString();  
  
        // color  
        //var cp = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_flare_color").split(" ");  
        //if (cp.length >= 3)  
        //    currentColor = Qt.rgba(parseInt(cp[0])/255.0, parseInt(cp[1])/255.0, parseInt(cp[2])/255.0, 1.0);
		
		var cp = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_flare_color").split(" ");  
		if (cp.length >= 3) {  
			var cr = parseInt(cp[0]) || 0;  
			var cg = parseInt(cp[1]) || 0;  
			var cb = parseInt(cp[2]) || 0;  
			colorRField.text = cr;  
			colorGField.text = cg;  
			colorBField.text = cb;  
			currentColor = Qt.rgba(cr / 255.0, cg / 255.0, cb / 255.0, 1.0);  
			syncHSVFromRGB(cr, cg, cb);   // ← add this line  
		}
  
        // function  
        var fi = functionOptions.indexOf(BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_flare_function"));  
        functionIndex = (fi >= 0) ? fi : 0;  
  
        // parameters  
        var pp = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_flare_parameters").split(" ");  
        param1Field.text = compactFloatText(pp[0], "1");  
        param2Field.text = compactFloatText(pp[1], "10");  
        param3Field.text = compactFloatText(pp[2], "10");  
        param4Field.text = compactFloatText(pp[3], "0");  
  
        // sizes  
        var sp = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_flare_sizes").split(" ");  
        size1Field.text = compactFloatText(sp[0], "1");  
        size2Field.text = compactFloatText(sp[1], "1");  
        size3Field.text = compactFloatText(sp[2], "1");  
  
        // intensity  
        var ip = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_flare_intensity").split(" ");  
        int1Field.text = compactFloatText(ip[0], "1");  
        int2Field.text = compactFloatText(ip[1], "1");  
        int3Field.text = compactFloatText(ip[2], "1");  
  
        // texture  
        textureField.text = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_flare_texture");  
  
        // type  
        flareType = BlackMesaEngine.getConsoleVariableAsInt("sv_hcad_mle_flare_type");  
  
        // attenuation  
        attenuationField.text = compactFloatText(BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_flare_attenuation"), "0");  
  
        // style  
        var st = BlackMesaEngine.getConsoleVariableAsInt("sv_hcad_mle_flare_style");  
        if (st < 0) st = 0; if (st > 12) st = 12;  
        currentStyle = st;  
  
        // glow proxy size  
        gpzField.text = compactFloatText(BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_flare_gpz"), "2");  
  
        // angles  
        var ap = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_flare_angles").split(" ");  
        ang1Field.text = compactFloatText(ap[0], "0");  
        currentAngleZ = compactFloatText(ap[1], "0");
        ang3Field.text = compactFloatText(ap[2], "0");  
  
        isLoading = false;  
    }
	
	function applyColor() {  
		if (isLoading || !componentReady || _updatingColor) return;  
		var r = parseInt(colorRField.text) || 0;  
		var g = parseInt(colorGField.text) || 0;  
		var b = parseInt(colorBField.text) || 0;  
		currentColor = Qt.rgba(r / 255.0, g / 255.0, b / 255.0, 1.0);  
		_updatingColor = true;  
		syncHSVFromRGB(r, g, b);  
		_updatingColor = false;  
		BlackMesaEngine.setConsoleVariableAsString("sv_hcad_mle_flare_color",  
			r + " " + g + " " + b);  
	}
	
	function getParamCount(fn) {  
		if (fn === "DISK")  return 3;  
		if (fn === "BOW")   return 1;  
		if (fn === "DISKH") return 4;  
		return 2; // RAY  
	}
  
    // ── Color dialog (declared at root level to avoid Row layout issues) ──────  
    //ColorDialog { id: colorDialog  
    //    title: "Lens Flare Color"  
    //    color: editorRoot.currentColor  
    //    showAlphaChannel: false  
    //    onCurrentColorChanged: {  
    //        if (editorRoot.isLoading) return;  
    //        editorRoot.currentColor = currentColor;  
    //        var r = Math.round(currentColor.r * 255);  
    //        var g = Math.round(currentColor.g * 255);  
    //        var b = Math.round(currentColor.b * 255);  
    //        BlackMesaEngine.setConsoleVariableAsString("sv_hcad_mle_flare_color", r + " " + g + " " + b);  
    //    }  
    //}
	
	function updateHue(y) {  
		hue = Math.max(0.0, Math.min(0.9999, y / hueSliderItem.height));  
		syncColorFromHSV();  
	}  
	  
	function updateSV(x, y) {  
		saturation = Math.max(0.0, Math.min(1.0, x / colorPanelItem.width));  
		hsv_value  = Math.max(0.0, Math.min(1.0, 1.0 - y / colorPanelItem.height));  
		syncColorFromHSV();  
	}  
	  
	function syncColorFromHSV() {  
		if (!componentReady) return;  
		var c = Qt.hsva(hue, saturation, hsv_value, 1.0);  
		currentColor = c;  
		var r = Math.round(c.r * 255);  
		var g = Math.round(c.g * 255);  
		var b = Math.round(c.b * 255);  
		_updatingColor = true;  
		colorRField.text = r;  
		colorGField.text = g;  
		colorBField.text = b;  
		_updatingColor = false;  
		BlackMesaEngine.setConsoleVariableAsString("sv_hcad_mle_flare_color",  
			r + " " + g + " " + b);  
	}  
	  
	function syncHSVFromRGB(r, g, b) {  
		var rf = r / 255.0, gf = g / 255.0, bf = b / 255.0;  
		var mx = Math.max(rf, gf, bf);  
		var mn = Math.min(rf, gf, bf);  
		var d  = mx - mn;  
		hsv_value  = mx;  
		saturation = (mx === 0.0) ? 0.0 : (d / mx);  
		if (d === 0.0) {  
			hue = 0.0;  
		} else if (mx === rf) {  
			hue = (((gf - bf) / d) % 6) / 6.0;  
			if (hue < 0) hue += 1.0;  
		} else if (mx === gf) {  
			hue = ((bf - rf) / d + 2.0) / 6.0;  
		} else {  
			hue = ((rf - gf) / d + 4.0) / 6.0;  
		}  
	}
  
    // ── Copy delay timer ──────────────────────────────────────────────────────  
    Timer { id: copyTimer  
        interval: 150; repeat: false  
        onTriggered: editorRoot.loadAllFromCvars()  
    }  
  
    // ── Background ────────────────────────────────────────────────────────────  
    Rectangle {  
        anchors.fill: parent  
        color: Theme.devConsole.colors.background  
    }  
  
    // ── Header bar ────────────────────────────────────────────────────────────  
    Rectangle { id: editorHeader  
        anchors.left: parent.left  
        anchors.right: parent.right  
        anchors.top: parent.top  
        height: Math.ceil(30 * Theme.heightScale)  
        color: Theme.colors.highlight  
        opacity: 0.9  
  
        Text {  
            anchors.left: parent.left  
            anchors.leftMargin: Math.ceil(8 * Theme.widthScale)  
            anchors.verticalCenter: parent.verticalCenter  
            text: "LENS FLARE EDITOR"  
            color: Theme.colors.text  
            font.family: Theme.fonts.bold  
            font.pixelSize: Math.ceil(13 * Theme.heightScale)  
            font.capitalization: Font.AllUppercase  
        }  
  
        Rectangle { id: exportVmfButton
            anchors.right: exitButton.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: Math.ceil(150 * Theme.widthScale)
            color: exportVmfMouse.containsMouse
                   ? Theme.colors.text
                   : Theme.colors.modalBackground

            Text {
                anchors.centerIn: parent
                text: "EXPORT TO VMF"
                color: exportVmfMouse.containsMouse
                       ? Theme.colors.modalBackground
                       : Theme.colors.text
                font.family: Theme.fonts.bold
                font.pixelSize: Math.ceil(12 * Theme.heightScale)
                font.capitalization: Font.AllUppercase
            }

            MouseArea {
                id: exportVmfMouse
                anchors.fill: parent
                hoverEnabled: true
                enabled: editorRoot.flareIndex > 0

                onClicked: {
                    BlackMesaEngine.executeClientCommandUnrestricted(
                        "sv_hcad_mle_flare_savetovmf "
                        + editorRoot.flareIndex
                    );
                }
            }
        }

        Rectangle { id: exitButton  
            anchors.right: parent.right  
            anchors.top: parent.top  
            anchors.bottom: parent.bottom  
            width: Math.ceil(70 * Theme.widthScale)  
            color: exitMouse.containsMouse ? "#e03030" : Theme.colors.warning  
  
            Text {  
                anchors.centerIn: parent  
                text: "EXIT"  
                color: Theme.colors.text  
                font.family: Theme.fonts.bold  
                font.pixelSize: Math.ceil(12 * Theme.heightScale)  
                font.capitalization: Font.AllUppercase  
            }  
  
            MouseArea { id: exitMouse  
                anchors.fill: parent  
                hoverEnabled: true  
                onClicked: editorRoot.hide()  
            }  
        }  
    }  
  
    // ── Scrollable content ────────────────────────────────────────────────────  
    Flickable { id: contentArea  
        anchors.left: parent.left  
        anchors.right: parent.right  
        anchors.rightMargin: Math.ceil(16 * Theme.widthScale)
        anchors.top: editorHeader.bottom  
        anchors.bottom: parent.bottom  
        anchors.topMargin: Math.ceil(2 * Theme.heightScale)  
  
        contentWidth: width  
        contentHeight: mainColumn.implicitHeight + Math.ceil(8 * Theme.heightScale)  
        clip: true  
        contentY: 0
        interactive: false
        boundsBehavior: Flickable.StopAtBounds  
  
        Column { id: mainColumn  
            x: Math.ceil(6 * Theme.widthScale)  
            width: parent.width - Math.ceil(12 * Theme.widthScale)  
            spacing: Math.ceil(3 * Theme.heightScale)  
            topPadding: Math.ceil(4 * Theme.heightScale)  
  
            // Shared sizing shortcuts  
            property int lw: Math.ceil(150 * Theme.widthScale)  // label width  
            property int fh: Math.ceil(24 * Theme.heightScale)  // row height  
            property int fs: Math.ceil(12 * Theme.heightScale)  // font size  
            property int fw: Math.ceil(70 * Theme.widthScale)   // field width  
            property int rw: Math.ceil(5 * Theme.widthScale)    // row spacing
            property int colorFieldWidth: Math.max(1, fw * 3
                - Math.ceil(120 * Theme.widthScale)
                - Math.ceil(16 * Theme.widthScale)
                - Math.ceil(14 * Theme.widthScale)
                - Math.ceil(3 * Theme.widthScale))
            property int aw: Math.ceil(20 * Theme.widthScale)   // arrow width
  
            // ── Flare Index ───────────────────────────────────────────────────  
            Row {  
                spacing: Math.ceil(5 * Theme.widthScale); height: mainColumn.fh  
                Text {  
                    width: mainColumn.lw; height: parent.height  
                    text: "Flare Index:"; color: Theme.colors.text  
                    font.family: Theme.fonts.regular; font.pixelSize: mainColumn.fs  
                    verticalAlignment: Text.AlignVCenter  
                }  
                TextField { id: indexField  
                    width: mainColumn.fw; height: parent.height  
                    text: "-1"; color: Theme.colors.text  
                    font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs  
                    background: Rectangle { color: Theme.colors.modalBackground }  
                    validator: IntValidator { bottom: -2147483648; top: 2147483647 }  
                    selectByMouse: true  
                    Keys.priority: Keys.BeforeItem
                    Keys.onLeftPressed: editorRoot.moveTextCursor(indexField, -1, event)
                    Keys.onRightPressed: editorRoot.moveTextCursor(indexField, 1, event)
					onAccepted: {  
						var idx = parseInt(text);  
						if (isNaN(idx)) return;  
						editorRoot.flareIndex = idx;                          // ← add this  
						BlackMesaEngine.executeClientCommandUnrestricted("sv_hcad_mle_flare_index " + idx);  
						if (idx !== -1) {  
							BlackMesaEngine.executeClientCommandUnrestricted("sv_hcad_mle_flare_copy " + idx);  
							copyTimer.restart();  
						}  
					}  
				} 
				Text {    
					height: parent.height; text: "(press Enter)"    
					color: Theme.colors.dimmedText; font.family: Theme.fonts.regular    
					font.pixelSize: Math.ceil(10 * Theme.heightScale)    
					verticalAlignment: Text.AlignVCenter    
				}
            }

			Item {  
				id: lockableContent  
				width: parent.width  
				height: childrenRect.height  
				enabled: editorRoot.flareIndex !== -1  
				opacity: enabled ? 1.0 : 0.3  
			  
				Column {  
					width: parent.width  
					spacing: mainColumn.spacing  			
  
					// ── Flare Num ─────────────────────────────────────────────────────  
					Row {  
						spacing: Math.ceil(5 * Theme.widthScale); height: mainColumn.fh  
						Text {  
							width: mainColumn.lw; height: parent.height  
							text: "Flare Num (1-20):"; color: Theme.colors.text  
							font.family: Theme.fonts.regular; font.pixelSize: mainColumn.fs  
							verticalAlignment: Text.AlignVCenter  
						}  
						Rectangle {  
							width: mainColumn.aw; height: parent.height  
							color: numDecMouse.containsMouse ? Theme.colors.highlight : Theme.colors.modalBackground  
							Text { anchors.centerIn: parent; text: "<"; color: Theme.colors.text  
								font.family: Theme.fonts.bold; font.pixelSize: mainColumn.fs }  
							MouseArea { id: numDecMouse; anchors.fill: parent; hoverEnabled: true  
								onClicked: {  
									var current = editorRoot.normalizedFlareNumber(numField.text);
									editorRoot.setFlareNumber(current > 1 ? current - 1 : 1);
								}  
							}  
						}  
						TextField { id: numField  
							width: mainColumn.fw; height: parent.height  
							text: "1"  
							color: Theme.colors.text  
							font.family: Theme.fonts.devConsole  
							font.pixelSize: mainColumn.fs  
							background: Rectangle { color: Theme.colors.modalBackground }  
							selectByMouse: true  
							Keys.priority: Keys.BeforeItem
							Keys.onLeftPressed: editorRoot.moveTextCursor(numField, -1, event)
							Keys.onRightPressed: editorRoot.moveTextCursor(numField, 1, event)
							onAccepted: editorRoot.setFlareNumber(text)
						}
						Rectangle {  
							width: mainColumn.aw; height: parent.height  
							color: numIncMouse.containsMouse ? Theme.colors.highlight : Theme.colors.modalBackground  
							Text { anchors.centerIn: parent; text: ">"; color: Theme.colors.text  
								font.family: Theme.fonts.bold; font.pixelSize: mainColumn.fs }  
							MouseArea { id: numIncMouse; anchors.fill: parent; hoverEnabled: true  
								onClicked: {  
									var current = editorRoot.normalizedFlareNumber(numField.text);
									editorRoot.setFlareNumber(current >= 1
										? Math.min(20, current + 1) : 1);
								}  
							}  
						}  
                        Rectangle {
                            width: Math.ceil(55 * Theme.widthScale)
                            height: parent.height
                            color: flareCopyMouse.containsMouse
                                   ? Theme.colors.highlight
                                   : Theme.colors.modalBackground
                            border.color: Theme.colors.dimmedText
                            border.width: 1

                            Text {
                                anchors.centerIn: parent
                                text: "COPY"
                                color: Theme.colors.text
                                font.family: Theme.fonts.bold
                                font.pixelSize: mainColumn.fs
                            }

                            MouseArea {
                                id: flareCopyMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: editorRoot.copyCurrentFlareElement()
                            }
                        }

                        Rectangle {
                            width: Math.ceil(55 * Theme.widthScale)
                            height: parent.height
                            enabled: editorRoot.flareClipboardValid
                            opacity: enabled ? 1.0 : 0.3
                            color: enabled && flarePasteMouse.containsMouse
                                   ? Theme.colors.highlight
                                   : Theme.colors.modalBackground
                            border.color: Theme.colors.dimmedText
                            border.width: 1

                            Text {
                                anchors.centerIn: parent
                                text: "PASTE"
                                color: Theme.colors.text
                                font.family: Theme.fonts.bold
                                font.pixelSize: mainColumn.fs
                            }

                            MouseArea {
                                id: flarePasteMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                enabled: editorRoot.flareClipboardValid
                                onClicked: editorRoot.pasteCopiedFlareElement()
                            }
                        }
					}  
		  
					// ── Color picker ──────────────────────────────────────────────────────────  
					Row {  
						spacing: Math.ceil(5 * Theme.widthScale)  
						height: Math.ceil(120 * Theme.heightScale)  
					  
						// Label  
						Text {  
							width: mainColumn.lw; height: parent.height  
							text: "Color:"  
							color: Theme.colors.text  
							font.family: Theme.fonts.regular  
							font.pixelSize: mainColumn.fs  
							verticalAlignment: Text.AlignVCenter  
						}  
					  
						// 2D saturation/value panel  
						Item { id: colorPanelItem  
							width:  Math.ceil(120 * Theme.widthScale)  
							height: Math.ceil(120 * Theme.heightScale)  
							clip: true  
					  
							// Pure hue background  
							Rectangle {  
								anchors.fill: parent  
								color: Qt.hsva(editorRoot.hue, 1, 1, 1)  
							}  
					  
							// White → transparent (horizontal) — achieved by rotating a vertical gradient  
							Rectangle {  
								width:  colorPanelItem.height  
								height: colorPanelItem.width  
								rotation: -90  
								transformOrigin: Item.TopLeft  
								x: 0; y: colorPanelItem.height  
								gradient: Gradient {  
									GradientStop { position: 0.0; color: "white" }  
									GradientStop { position: 1.0; color: "transparent" }  
								}  
							}  
					  
							// Transparent → black (vertical)  
							Rectangle {  
								anchors.fill: parent  
								gradient: Gradient {  
									GradientStop { position: 0.0; color: "transparent" }  
									GradientStop { position: 1.0; color: "black" }  
								}  
							}  
					  
							// Cursor circle  
							Rectangle {  
								x: editorRoot.saturation * colorPanelItem.width  - width  / 2  
								y: (1.0 - editorRoot.hsv_value) * colorPanelItem.height - height / 2  
								width:  Math.ceil(10 * Theme.widthScale)  
								height: width  
								radius: width / 2  
								color: "transparent"  
								border.color: "white"  
								border.width: 2  
								z: 1  
							}  
					  
							MouseArea {  
								anchors.fill: parent  
								onPressed:        editorRoot.updateSV(mouse.x, mouse.y)  
								onPositionChanged: if (pressed) editorRoot.updateSV(mouse.x, mouse.y)  
							}  
						}  
					  
						// Hue slider (vertical, right of panel)  
						Item { id: hueSliderItem  
							width:  Math.ceil(16 * Theme.widthScale)  
							height: colorPanelItem.height  
					  
							Rectangle {  
								anchors.fill: parent  
								gradient: Gradient {  
									GradientStop { position: 0.0;    color: "#ff0000" }  
									GradientStop { position: 0.1667; color: "#ffff00" }  
									GradientStop { position: 0.3333; color: "#00ff00" }  
									GradientStop { position: 0.5;    color: "#00ffff" }  
									GradientStop { position: 0.6667; color: "#0000ff" }  
									GradientStop { position: 0.8333; color: "#ff00ff" }  
									GradientStop { position: 1.0;    color: "#ff0000" }  
								}  
							}  
					  
							// Cursor line  
							Rectangle {  
								x: 0  
								y: editorRoot.hue * hueSliderItem.height - height / 2  
								width:  parent.width  
								height: Math.ceil(3 * Theme.heightScale)  
								color: "white"  
								z: 1  
							}  
					  
							MouseArea {  
								anchors.fill: parent  
								onPressed:        editorRoot.updateHue(mouse.y)  
								onPositionChanged: if (pressed) editorRoot.updateHue(mouse.y)  
							}  
						}  
					  
						// Color preview + RGB text fields  
						Column {  
							spacing: Math.ceil(4 * Theme.heightScale)  
							anchors.verticalCenter: parent.verticalCenter  
					  
                            Row {
                                spacing: Math.ceil(3 * Theme.widthScale)
                                Text {
                                    width: Math.ceil(14 * Theme.widthScale)
                                    height: mainColumn.fh
                                    text: ""
                                }
                                Rectangle {
                                    width: mainColumn.colorFieldWidth
                                    height: mainColumn.fh
                                    color: editorRoot.currentColor
                                    border.color: Theme.colors.dimmedText
                                    border.width: 1
                                }
                            }
					  
							Row { spacing: Math.ceil(3 * Theme.widthScale)  
								Text { text: "R:"; width: Math.ceil(14 * Theme.widthScale); height: mainColumn.fh  
									   color: Theme.colors.text; font.family: Theme.fonts.regular  
									   font.pixelSize: mainColumn.fs; verticalAlignment: Text.AlignVCenter }  
								TextField { id: colorRField  
									width: mainColumn.colorFieldWidth; height: mainColumn.fh; text: "255"
									color: Theme.colors.text; font.family: Theme.fonts.devConsole  
									font.pixelSize: mainColumn.fs  
									background: Rectangle { color: Theme.colors.modalBackground }  
									validator: IntValidator { bottom: 0; top: 255 }  
									selectByMouse: true  
									Keys.priority: Keys.BeforeItem
									Keys.onLeftPressed: editorRoot.moveTextCursor(colorRField, -1, event)
									Keys.onRightPressed: editorRoot.moveTextCursor(colorRField, 1, event)
									onTextChanged: editorRoot.applyColor()  
								}  
							}  
					  
							Row { spacing: Math.ceil(3 * Theme.widthScale)  
								Text { text: "G:"; width: Math.ceil(14 * Theme.widthScale); height: mainColumn.fh  
									   color: Theme.colors.text; font.family: Theme.fonts.regular  
									   font.pixelSize: mainColumn.fs; verticalAlignment: Text.AlignVCenter }  
								TextField { id: colorGField  
									width: mainColumn.colorFieldWidth; height: mainColumn.fh; text: "255"
									color: Theme.colors.text; font.family: Theme.fonts.devConsole  
									font.pixelSize: mainColumn.fs  
									background: Rectangle { color: Theme.colors.modalBackground }  
									validator: IntValidator { bottom: 0; top: 255 }  
									selectByMouse: true  
									Keys.priority: Keys.BeforeItem
									Keys.onLeftPressed: editorRoot.moveTextCursor(colorGField, -1, event)
									Keys.onRightPressed: editorRoot.moveTextCursor(colorGField, 1, event)
									onTextChanged: editorRoot.applyColor()  
								}  
							}  
					  
							Row { spacing: Math.ceil(3 * Theme.widthScale)  
								Text { text: "B:"; width: Math.ceil(14 * Theme.widthScale); height: mainColumn.fh  
									   color: Theme.colors.text; font.family: Theme.fonts.regular  
									   font.pixelSize: mainColumn.fs; verticalAlignment: Text.AlignVCenter }  
								TextField { id: colorBField  
									width: mainColumn.colorFieldWidth; height: mainColumn.fh; text: "255"
									color: Theme.colors.text; font.family: Theme.fonts.devConsole  
									font.pixelSize: mainColumn.fs  
									background: Rectangle { color: Theme.colors.modalBackground }  
									validator: IntValidator { bottom: 0; top: 255 }  
									selectByMouse: true  
									Keys.priority: Keys.BeforeItem
									Keys.onLeftPressed: editorRoot.moveTextCursor(colorBField, -1, event)
									Keys.onRightPressed: editorRoot.moveTextCursor(colorBField, 1, event)
									onTextChanged: editorRoot.applyColor()  
								}  
							}  
						}  
					}
					  
                    // ── Function ──────────────────────────────────────────────────────
                    Row {
                        spacing: Math.ceil(5 * Theme.widthScale); height: mainColumn.fh
                        Text {
                            width: mainColumn.lw; height: parent.height
                            text: "Function:"; color: Theme.colors.text
                            font.family: Theme.fonts.regular; font.pixelSize: mainColumn.fs
                            verticalAlignment: Text.AlignVCenter
                        }
                        Repeater {
                            model: editorRoot.functionOptions

                            delegate: Rectangle {
                                id: functionButton
                                property int optionIndex: index
                                property string optionName: modelData

                                width: Math.ceil(70 * Theme.widthScale)
                                height: mainColumn.fh
                                color: editorRoot.functionIndex === optionIndex
                                       ? Theme.colors.highlight
                                       : Theme.colors.modalBackground
                                border.color: editorRoot.functionIndex === optionIndex
                                              ? Theme.colors.highlight
                                              : Theme.colors.dimmedText
                                border.width: 1

                                Text {
                                    anchors.centerIn: parent
                                    text: functionButton.optionName
                                    color: Theme.colors.text
                                    font.family: Theme.fonts.bold
                                    font.pixelSize: mainColumn.fs
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: editorRoot.selectFlareFunction(
                                        functionButton.optionIndex)
                                }
                            }
                        }
                    }

                    // ── Parameters ────────────────────────────────────────────────────
					Row {  
						spacing: Math.ceil(5 * Theme.widthScale); height: mainColumn.fh  
						Text {  
							width: mainColumn.lw; height: parent.height  
							text: "Parameters:"; color: Theme.colors.text  
							font.family: Theme.fonts.regular; font.pixelSize: mainColumn.fs  
							verticalAlignment: Text.AlignVCenter  
						}  
						TextField { id: param1Field  
							width: mainColumn.fw; height: parent.height; text: "1.0"; color: Theme.colors.text  
							font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs  
							background: Rectangle { color: Theme.colors.modalBackground }  
							validator: DoubleValidator {
                                locale: "C"
                                notation: DoubleValidator.StandardNotation
                            }
							selectByMouse: true  
							Keys.priority: Keys.BeforeItem
							Keys.onLeftPressed: editorRoot.moveTextCursor(param1Field, -1, event)
							Keys.onRightPressed: editorRoot.moveTextCursor(param1Field, 1, event)
							onEditingFinished: text = editorRoot.compactFloatText(text, "1")  
							onTextChanged: editorRoot.applyParams()  
						}  
						TextField { id: param2Field  
							width: mainColumn.fw; height: parent.height; text: "10"; color: Theme.colors.text  
							//enabled: editorRoot.functionParamCount[editorRoot.currentFunction] >= 2
							enabled: editorRoot.getParamCount(editorRoot.currentFunction) >= 2
							opacity: enabled ? 1.0 : 0.3  
							font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs  
							background: Rectangle { color: param2Field.enabled ? Theme.colors.modalBackground : "#111111" } 
							validator: DoubleValidator {
                                locale: "C"
                                notation: DoubleValidator.StandardNotation
                            }
							selectByMouse: true  
							Keys.priority: Keys.BeforeItem
							Keys.onLeftPressed: editorRoot.moveTextCursor(param2Field, -1, event)
							Keys.onRightPressed: editorRoot.moveTextCursor(param2Field, 1, event)
							onEditingFinished: text = editorRoot.compactFloatText(text, "10")  
							onTextChanged: editorRoot.applyParams()  
						}  
						TextField { id: param3Field  
							width: mainColumn.fw; height: parent.height; text: "10"; color: Theme.colors.text  
							//enabled: editorRoot.functionParamCount[editorRoot.currentFunction] >= 3  
							enabled: editorRoot.getParamCount(editorRoot.currentFunction) >= 3  
							opacity: enabled ? 1.0 : 0.3  
							font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs  
							background: Rectangle { color: param3Field.enabled ? Theme.colors.modalBackground : "#111111" } 
							validator: DoubleValidator {
                                locale: "C"
                                notation: DoubleValidator.StandardNotation
                            }
							selectByMouse: true  
							Keys.priority: Keys.BeforeItem
							Keys.onLeftPressed: editorRoot.moveTextCursor(param3Field, -1, event)
							Keys.onRightPressed: editorRoot.moveTextCursor(param3Field, 1, event)
							onEditingFinished: text = editorRoot.compactFloatText(text, "10")  
							onTextChanged: editorRoot.applyParams()  
						}  
						TextField { id: param4Field  
							width: mainColumn.fw; height: parent.height; text: "0"; color: Theme.colors.text  
							//enabled: editorRoot.functionParamCount[editorRoot.currentFunction] >= 4  
							enabled: editorRoot.getParamCount(editorRoot.currentFunction) >= 4  
							opacity: enabled ? 1.0 : 0.3  
							font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs  
							background: Rectangle { color: param4Field.enabled ? Theme.colors.modalBackground : "#111111" }
							validator: DoubleValidator {
                                locale: "C"
                                notation: DoubleValidator.StandardNotation
                            }
							selectByMouse: true  
							Keys.priority: Keys.BeforeItem
							Keys.onLeftPressed: editorRoot.moveTextCursor(param4Field, -1, event)
							Keys.onRightPressed: editorRoot.moveTextCursor(param4Field, 1, event)
							onEditingFinished: text = editorRoot.compactFloatText(text, "0")  
							onTextChanged: editorRoot.applyParams()  
						}  
					}  
		  
					// ── Sizes ─────────────────────────────────────────────────────────  
					Row {  
						spacing: Math.ceil(5 * Theme.widthScale); height: mainColumn.fh  
						Text {  
							width: mainColumn.lw; height: parent.height  
							text: "Sizes:"; color: Theme.colors.text  
							font.family: Theme.fonts.regular; font.pixelSize: mainColumn.fs  
							verticalAlignment: Text.AlignVCenter  
						}  
						TextField { id: size1Field  
							width: mainColumn.fw; height: parent.height; text: "1.0"; color: Theme.colors.text  
							font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs  
							background: Rectangle { color: Theme.colors.modalBackground }  
							validator: DoubleValidator {
                                locale: "C"
                                notation: DoubleValidator.StandardNotation
                            }
							selectByMouse: true  
							Keys.priority: Keys.BeforeItem
							Keys.onLeftPressed: editorRoot.moveTextCursor(size1Field, -1, event)
							Keys.onRightPressed: editorRoot.moveTextCursor(size1Field, 1, event)
							onEditingFinished: text = editorRoot.compactFloatText(text, "1")  
							onTextChanged: editorRoot.applySizes()  
						}  
						TextField { id: size2Field  
							width: mainColumn.fw; height: parent.height; text: "1.0"; color: Theme.colors.text  
							font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs  
							background: Rectangle { color: Theme.colors.modalBackground }  
							validator: DoubleValidator {
                                locale: "C"
                                notation: DoubleValidator.StandardNotation
                            }
							selectByMouse: true  
							Keys.priority: Keys.BeforeItem
							Keys.onLeftPressed: editorRoot.moveTextCursor(size2Field, -1, event)
							Keys.onRightPressed: editorRoot.moveTextCursor(size2Field, 1, event)
							onEditingFinished: text = editorRoot.compactFloatText(text, "1")  
							onTextChanged: editorRoot.applySizes()  
						}  
						TextField { id: size3Field  
							width: mainColumn.fw; height: parent.height; text: "1.0"; color: Theme.colors.text  
							font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs  
							background: Rectangle { color: Theme.colors.modalBackground }  
							validator: DoubleValidator {
                                locale: "C"
                                notation: DoubleValidator.StandardNotation
                            }
							selectByMouse: true  
							Keys.priority: Keys.BeforeItem
							Keys.onLeftPressed: editorRoot.moveTextCursor(size3Field, -1, event)
							Keys.onRightPressed: editorRoot.moveTextCursor(size3Field, 1, event)
							onEditingFinished: text = editorRoot.compactFloatText(text, "1")  
							onTextChanged: editorRoot.applySizes()  
						}  
					}  
		  
					// ── Intensity ─────────────────────────────────────────────────────  
					Row {  
						spacing: Math.ceil(5 * Theme.widthScale); height: mainColumn.fh  
						Text {  
							width: mainColumn.lw; height: parent.height  
							text: "Intensity:"; color: Theme.colors.text  
							font.family: Theme.fonts.regular; font.pixelSize: mainColumn.fs  
							verticalAlignment: Text.AlignVCenter  
						}  
						TextField { id: int1Field  
							width: mainColumn.fw; height: parent.height; text: "1.0"; color: Theme.colors.text  
							font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs  
							background: Rectangle { color: Theme.colors.modalBackground }  
							validator: DoubleValidator {
                                locale: "C"
                                notation: DoubleValidator.StandardNotation
                            }
							selectByMouse: true  
							Keys.priority: Keys.BeforeItem
							Keys.onLeftPressed: editorRoot.moveTextCursor(int1Field, -1, event)
							Keys.onRightPressed: editorRoot.moveTextCursor(int1Field, 1, event)
							onEditingFinished: text = editorRoot.compactFloatText(text, "1")  
							onTextChanged: editorRoot.applyIntensity()  
						}  
						TextField { id: int2Field  
							width: mainColumn.fw; height: parent.height; text: "1.0"; color: Theme.colors.text  
							font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs  
							background: Rectangle { color: Theme.colors.modalBackground }  
							validator: DoubleValidator {
                                locale: "C"
                                notation: DoubleValidator.StandardNotation
                            }
							selectByMouse: true  
							Keys.priority: Keys.BeforeItem
							Keys.onLeftPressed: editorRoot.moveTextCursor(int2Field, -1, event)
							Keys.onRightPressed: editorRoot.moveTextCursor(int2Field, 1, event)
							onEditingFinished: text = editorRoot.compactFloatText(text, "1")  
							onTextChanged: editorRoot.applyIntensity()  
						}  
						TextField { id: int3Field  
							width: mainColumn.fw; height: parent.height; text: "1.0"; color: Theme.colors.text  
							font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs  
							background: Rectangle { color: Theme.colors.modalBackground }  
							validator: DoubleValidator {
                                locale: "C"
                                notation: DoubleValidator.StandardNotation
                            }
							selectByMouse: true  
							Keys.priority: Keys.BeforeItem
							Keys.onLeftPressed: editorRoot.moveTextCursor(int3Field, -1, event)
							Keys.onRightPressed: editorRoot.moveTextCursor(int3Field, 1, event)
							onEditingFinished: text = editorRoot.compactFloatText(text, "1")  
							onTextChanged: editorRoot.applyIntensity()  
						}  
					}  
		  
                    // ── Texture ───────────────────────────────────────────────────────
                    Row {
                        spacing: mainColumn.rw; height: mainColumn.fh
                        Text {
                            width: mainColumn.lw; height: parent.height
                            text: "Texture:"; color: Theme.colors.text
                            font.family: Theme.fonts.regular; font.pixelSize: mainColumn.fs
                            verticalAlignment: Text.AlignVCenter
                        }

                        // The text field and clear button are flush. Their combined
                        // right edge matches the DISKH function button.
                        Row {
                            spacing: 0
                            width: mainColumn.fw * 3 + mainColumn.rw * 2
                            height: parent.height

                            TextField {
                                id: textureField
                                width: parent.width - clearTextureButton.width
                                height: parent.height
                                text: ""; color: Theme.colors.text
                                font.family: Theme.fonts.devConsole
                                font.pixelSize: mainColumn.fs
                                background: Rectangle {
                                    color: Theme.colors.modalBackground
                                }
                                selectByMouse: true
                                Keys.priority: Keys.BeforeItem
                                Keys.onLeftPressed: editorRoot.moveTextCursor(textureField, -1, event)
                                Keys.onRightPressed: editorRoot.moveTextCursor(textureField, 1, event)
                                onAccepted: editorRoot.applyTexture(text)
                            }

                            Rectangle {
                                id: clearTextureButton
                                width: Math.ceil(26 * Theme.widthScale)
                                height: parent.height
                                color: clearTextureMouse.containsMouse
                                       ? "#e03030" : "#9c2020"
                                border.color: "#ff5a5a"
                                border.width: 1
                                Text {
                                    anchors.centerIn: parent
                                    text: "X"
                                    color: "#ffffff"
                                    font.family: Theme.fonts.bold
                                    font.pixelSize: mainColumn.fs
                                }
                                MouseArea {
                                    id: clearTextureMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        textureField.text = "";
                                        editorRoot.applyTexture("");
                                    }
                                }
                            }
                        }

                        Rectangle {
                            width: mainColumn.fw; height: parent.height
                            color: browseMouse.containsMouse
                                   ? Theme.colors.highlight
                                   : Theme.colors.modalBackground
                            border.color: Theme.colors.dimmedText
                            border.width: 1
                            Text {
                                anchors.centerIn: parent; text: "Browse..."
                                color: Theme.colors.text
                                font.family: Theme.fonts.regular
                                font.pixelSize: mainColumn.fs
                            }
                            MouseArea {
                                id: browseMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: textureBrowserOverlay.open()
                            }
                        }
                    }

                    // ── Texture preview ────────────────────────────────────────────────
                    Row {
                        spacing: mainColumn.rw
                        height: Math.ceil(120 * Theme.heightScale)

                        Text {
                            width: mainColumn.lw; height: parent.height
                            text: "Texture Preview:"
                            color: Theme.colors.text
                            font.family: Theme.fonts.regular
                            font.pixelSize: mainColumn.fs
                            verticalAlignment: Text.AlignVCenter
                        }

                        Rectangle {
                            id: texturePreviewPanel
                            width: Math.ceil(120 * Theme.widthScale)
                            height: Math.ceil(120 * Theme.heightScale)
                            color: Theme.colors.modalBackground
                            border.color: Theme.colors.dimmedText
                            border.width: 1

                            Image {
                                id: texturePreviewImage
                                anchors.fill: parent
                                anchors.margins: Math.ceil(2 * Theme.widthScale)
                                source: editorRoot.texturePreviewSource(textureField.text)
                                fillMode: Image.PreserveAspectFit
                                asynchronous: true
                                cache: false
                            }

                            Text {
                                anchors.fill: parent
                                anchors.margins: Math.ceil(5 * Theme.widthScale)
                                visible: textureField.text.trim().length === 0
                                         || texturePreviewImage.status === Image.Error
                                text: textureField.text.trim().length === 0
                                      ? "NO TEXTURE" : "PREVIEW UNAVAILABLE"
                                color: Theme.colors.dimmedText
                                font.family: Theme.fonts.regular
                                font.pixelSize: Math.ceil(9 * Theme.heightScale)
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                            }
                        }
                    }

                    // ── Type ──────────────────────────────────────────────────────────
					Row {  
						spacing: Math.ceil(5 * Theme.widthScale); height: mainColumn.fh  
						Text {  
							width: mainColumn.lw; height: parent.height  
							text: "Type:"; color: Theme.colors.text  
							font.family: Theme.fonts.regular; font.pixelSize: mainColumn.fs  
							verticalAlignment: Text.AlignVCenter  
						}  
						Rectangle {  
							width: Math.ceil(70 * Theme.widthScale); height: parent.height  
							color: editorRoot.flareType === 0 ? Theme.colors.highlight : Theme.colors.modalBackground  
							border.color: editorRoot.flareType === 0 ? Theme.colors.highlight : Theme.colors.dimmedText  
							border.width: 1  
							Text { anchors.centerIn: parent; text: "NORMAL"; color: Theme.colors.text  
								font.family: Theme.fonts.bold; font.pixelSize: mainColumn.fs }  
							MouseArea { anchors.fill: parent  
								onClicked: {  
									editorRoot.flareType = 0;  
									BlackMesaEngine.setConsoleVariableAsInt("sv_hcad_mle_flare_type", 0);  
								}  
							}  
						}  
						Rectangle {  
							width: Math.ceil(70 * Theme.widthScale); height: parent.height  
							color: editorRoot.flareType === 1 ? Theme.colors.highlight : Theme.colors.modalBackground  
							border.color: editorRoot.flareType === 1 ? Theme.colors.highlight : Theme.colors.dimmedText  
							border.width: 1  
							Text { anchors.centerIn: parent; text: "SUN"; color: Theme.colors.text  
								font.family: Theme.fonts.bold; font.pixelSize: mainColumn.fs }  
							MouseArea { anchors.fill: parent  
								onClicked: {  
									editorRoot.flareType = 1;  
									BlackMesaEngine.setConsoleVariableAsInt("sv_hcad_mle_flare_type", 1);  
								}  
							}  
						}  
					}  
		  
					// ── Attenuation ───────────────────────────────────────────────────  
					Row {  
						spacing: Math.ceil(5 * Theme.widthScale); height: mainColumn.fh  
						Text {  
							width: mainColumn.lw; height: parent.height  
							text: "Attenuation:"; color: Theme.colors.text  
							font.family: Theme.fonts.regular; font.pixelSize: mainColumn.fs  
							verticalAlignment: Text.AlignVCenter  
						}  
						TextField { id: attenuationField  
							width: mainColumn.fw; height: parent.height; text: "0"; color: Theme.colors.text  
							font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs  
							background: Rectangle { color: Theme.colors.modalBackground }  
							validator: DoubleValidator {
                                locale: "C"
                                notation: DoubleValidator.StandardNotation
                            }
							selectByMouse: true  
							Keys.priority: Keys.BeforeItem
							Keys.onLeftPressed: editorRoot.moveTextCursor(attenuationField, -1, event)
							Keys.onRightPressed: editorRoot.moveTextCursor(attenuationField, 1, event)
							onEditingFinished: text = editorRoot.compactFloatText(text, "0")  
							onTextChanged: {  
								if (!editorRoot.isLoading)  
									BlackMesaEngine.setConsoleVariableAsString("sv_hcad_mle_flare_attenuation", text);  
							}  
						}  
					}  
		  
                    // ── Style ─────────────────────────────────────────────────────────
                    Row {
                        spacing: Math.ceil(5 * Theme.widthScale); height: mainColumn.fh
                        Text {
                            width: mainColumn.lw; height: parent.height
                            text: "Style:"; color: Theme.colors.text
                            font.family: Theme.fonts.regular; font.pixelSize: mainColumn.fs
                            verticalAlignment: Text.AlignVCenter
                        }
                        ComboBox {
                            id: styleCombo
                            width: mainColumn.fw * 2
                                   + Math.ceil(5 * Theme.widthScale)
                            height: parent.height
                            model: editorRoot.styleNames
                            currentIndex: editorRoot.currentStyle
                            leftPadding: Math.ceil(6 * Theme.widthScale)
                            rightPadding: Math.ceil(20 * Theme.widthScale)

                            contentItem: Text {
                                text: styleCombo.displayText
                                color: Theme.colors.text
                                font.family: Theme.fonts.regular
                                font.pixelSize: Math.ceil(10 * Theme.heightScale)
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight
                            }

                            indicator: Text {
                                anchors.right: parent.right
                                anchors.rightMargin: Math.ceil(6 * Theme.widthScale)
                                anchors.verticalCenter: parent.verticalCenter
                                text: "▼"
                                color: Theme.colors.text
                                font.family: Theme.fonts.regular
                                font.pixelSize: Math.ceil(9 * Theme.heightScale)
                            }

                            background: Rectangle {
                                color: styleCombo.pressed
                                       ? Theme.colors.highlight
                                       : Theme.colors.modalBackground
                                border.color: Theme.colors.dimmedText
                                border.width: 1
                            }

                            popup: Popup {
                                y: styleCombo.height
                                width: styleCombo.width
                                height: editorRoot.styleNames.length
                                        * mainColumn.fh + padding * 2
                                padding: 1

                                contentItem: ListView {
                                    id: styleList
                                    clip: true
                                    verticalLayoutDirection: ListView.TopToBottom
                                    implicitWidth: styleCombo.width - 2
                                    implicitHeight: contentHeight
                                    model: editorRoot.styleNames

                                    delegate: Rectangle {
                                        id: styleOption
                                        width: styleList.width
                                        height: mainColumn.fh
                                        color: styleOptionMouse.containsMouse
                                               || index === editorRoot.currentStyle
                                               ? Theme.colors.highlight
                                               : Theme.colors.modalBackground
                                        border.color: Theme.colors.dimmedText
                                        border.width: 1

                                        Text {
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            anchors.top: parent.top
                                            anchors.bottom: parent.bottom
                                            anchors.leftMargin: Math.ceil(
                                                5 * Theme.widthScale)
                                            anchors.rightMargin: Math.ceil(
                                                3 * Theme.widthScale)
                                            text: editorRoot.styleNames[index]
                                            color: Theme.colors.text
                                            font.family: Theme.fonts.regular
                                            font.pixelSize: Math.ceil(
                                                10 * Theme.heightScale)
                                            verticalAlignment: Text.AlignVCenter
                                            elide: Text.ElideRight
                                        }

                                        MouseArea {
                                            id: styleOptionMouse
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            onClicked: {
                                                editorRoot.currentStyle = index;
                                                BlackMesaEngine.setConsoleVariableAsInt(
                                                    "sv_hcad_mle_flare_style", index);
                                                styleCombo.popup.close();
                                            }
                                        }
                                    }
                                }

                                background: Rectangle {
                                    color: Theme.colors.modalBackground
                                    border.color: Theme.colors.dimmedText
                                    border.width: 1
                                }
                            }

                            onActivated: {
                                editorRoot.currentStyle = index;
                                BlackMesaEngine.setConsoleVariableAsInt(
                                    "sv_hcad_mle_flare_style", index);
                            }
                        }
                    }

					// ── Glow Proxy Size ───────────────────────────────────────────────  
					Row {  
						spacing: Math.ceil(5 * Theme.widthScale); height: mainColumn.fh  
						Text {  
							width: mainColumn.lw; height: parent.height  
							text: "Glow Proxy Size:"; color: Theme.colors.text  
							font.family: Theme.fonts.regular; font.pixelSize: mainColumn.fs  
							verticalAlignment: Text.AlignVCenter  
						}  
						TextField { id: gpzField  
							width: mainColumn.fw; height: parent.height; text: "2.0"; color: Theme.colors.text  
							font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs  
							background: Rectangle { color: Theme.colors.modalBackground }  
							validator: DoubleValidator {
                                locale: "C"
                                notation: DoubleValidator.StandardNotation
                            }
							selectByMouse: true  
							Keys.priority: Keys.BeforeItem
							Keys.onLeftPressed: editorRoot.moveTextCursor(gpzField, -1, event)
							Keys.onRightPressed: editorRoot.moveTextCursor(gpzField, 1, event)
							onEditingFinished: text = editorRoot.compactFloatText(text, "2")  
							onTextChanged: {  
								if (!editorRoot.isLoading)  
									BlackMesaEngine.setConsoleVariableAsString("sv_hcad_mle_flare_gpz", text);  
							}  
						}  
					}  
		  
                    // ── Angles ────────────────────────────────────────────────────────
                    Row {
                        spacing: Math.ceil(5 * Theme.widthScale)
                        height: mainColumn.fh

                        Text {
                            width: mainColumn.lw; height: parent.height
                            text: "Angles (Y X):"; color: Theme.colors.text
                            font.family: Theme.fonts.regular; font.pixelSize: mainColumn.fs
                            verticalAlignment: Text.AlignVCenter
                        }
                        TextField { id: ang1Field
                            width: mainColumn.fw; height: parent.height; text: "0"; color: Theme.colors.text
                            font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs
                            enabled: editorRoot.flareType === 1
                            opacity: enabled ? 1.0 : 0.3
                            background: Rectangle { color: Theme.colors.modalBackground }
                            validator: DoubleValidator {
                                locale: "C"
                                notation: DoubleValidator.StandardNotation
                            }
                            selectByMouse: true
                            Keys.priority: Keys.BeforeItem
                            Keys.onLeftPressed: editorRoot.moveTextCursor(ang1Field, -1, event)
                            Keys.onRightPressed: editorRoot.moveTextCursor(ang1Field, 1, event)
                            onEditingFinished: text = editorRoot.compactFloatText(text, "0")
                            onTextChanged: editorRoot.applyAngles()
                        }
                        TextField { id: ang3Field
                            width: mainColumn.fw; height: parent.height; text: "0"; color: Theme.colors.text
                            font.family: Theme.fonts.devConsole; font.pixelSize: mainColumn.fs
                            enabled: editorRoot.flareType === 1
                            opacity: enabled ? 1.0 : 0.3
                            background: Rectangle { color: Theme.colors.modalBackground }
                            validator: DoubleValidator {
                                locale: "C"
                                notation: DoubleValidator.StandardNotation
                            }
                            selectByMouse: true
                            Keys.priority: Keys.BeforeItem
                            Keys.onLeftPressed: editorRoot.moveTextCursor(ang3Field, -1, event)
                            Keys.onRightPressed: editorRoot.moveTextCursor(ang3Field, 1, event)
                            onEditingFinished: text = editorRoot.compactFloatText(text, "0")
                            onTextChanged: editorRoot.applyAngles()
                        }

                        // Keep the row at its original height. The visual gizmo
                        // extends upward into the unused right side of prior rows.
                        Item {
                            width: Math.max(0, mainColumn.width
                                - mainColumn.lw - mainColumn.fw * 2
                                - Math.ceil(15 * Theme.widthScale))
                            height: parent.height

                            Item {
                                id: rotationGizmo
                                anchors.left: parent.left
                                anchors.bottom: parent.bottom
                                width: mainColumn.fw * 2 + mainColumn.rw
                                height: mainColumn.fh * 5 + mainColumn.spacing * 4
                                enabled: editorRoot.flareType === 1
                                opacity: enabled ? 1.0 : 0.3

                                property real pitchAngle: isNaN(parseFloat(ang1Field.text))
                                        ? 0.0 : parseFloat(ang1Field.text)
                                property real yawAngle: isNaN(parseFloat(editorRoot.currentAngleZ))
                                        ? 0.0 : parseFloat(editorRoot.currentAngleZ)
                                property real rollAngle: isNaN(parseFloat(ang3Field.text))
                                        ? 0.0 : parseFloat(ang3Field.text)
                                property int dragRing: -1
                                property real dragLastPointerAngle: 0.0
                                property real dragAccumulatedDelta: 0.0
                                property real dragStartValue: 0.0
                                readonly property real axisLength: Math.min(width, height) * 0.21
                                readonly property real outerRingRadius: Math.min(width, height) * 0.40
                                readonly property real innerRingRadius: Math.min(width, height) * 0.30

                                function rotatedAxis(axisIndex) {
                                    var x = axisIndex === 0 ? 1.0 : 0.0;
                                    var y = axisIndex === 1 ? 1.0 : 0.0;
                                    var z = axisIndex === 2 ? 1.0 : 0.0;

                                    var pitch = pitchAngle * Math.PI / 180.0;
                                    var yaw = yawAngle * Math.PI / 180.0;
                                    var roll = rollAngle * Math.PI / 180.0;

                                    var cr = Math.cos(roll), sr = Math.sin(roll);
                                    var cp = Math.cos(pitch), sp = Math.sin(pitch);
                                    var cy = Math.cos(yaw), sy = Math.sin(yaw);

                                    // Roll around X, pitch around Y, then yaw around Z.
                                    var x1 = x;
                                    var y1 = y * cr - z * sr;
                                    var z1 = y * sr + z * cr;

                                    var x2 = x1 * cp + z1 * sp;
                                    var y2 = y1;
                                    var z2 = -x1 * sp + z1 * cp;

                                    return [
                                        x2 * cy - y2 * sy,
                                        x2 * sy + y2 * cy,
                                        z2
                                    ];
                                }

                                function projectedAxis(axisIndex) {
                                    var v = rotatedAxis(axisIndex);

                                    // the red X arrow points into the camera, while
                                    // the green Y arrow points to the screen left.
                                    return [-v[1], v[2], v[0]];
                                }

                                function axisEndpoint(axisIndex) {
                                    var p = projectedAxis(axisIndex);
                                    return [
                                        width * 0.5 + p[0] * axisLength,
                                        height * 0.5 - p[1] * axisLength,
                                        p[2]
                                    ];
                                }

                                function normalizeAngle(value) {
                                    while (value > 180.0) value -= 360.0;
                                    while (value <= -180.0) value += 360.0;
                                    return value;
                                }

                                function ringValue(ringIndex) {
                                    return ringIndex === 0 ? rollAngle : pitchAngle;
                                }

                                function ringRadius(ringIndex) {
                                    return ringIndex === 0
                                            ? innerRingRadius : outerRingRadius;
                                }

                                function ringPhase(ringIndex) {
                                    // X begins on the horizontal, Y on the vertical.
                                    return ringIndex === 0 ? 0.0 : -90.0;
                                }

                                function ringHandle(ringIndex) {
                                    var radians = (ringValue(ringIndex)
                                            + ringPhase(ringIndex)) * Math.PI / 180.0;
                                    var radius = ringRadius(ringIndex);
                                    return [
                                        width * 0.5 + Math.cos(radians) * radius,
                                        height * 0.5 + Math.sin(radians) * radius
                                    ];
                                }

                                function closestRing(mouseX, mouseY) {
                                    var dx = mouseX - width * 0.5;
                                    var dy = mouseY - height * 0.5;
                                    var pointerRadius = Math.sqrt(dx * dx + dy * dy);
                                    var xDistance = Math.abs(pointerRadius
                                        - innerRingRadius);
                                    var yDistance = Math.abs(pointerRadius
                                        - outerRingRadius);
                                    var tolerance = Math.max(3.5,
                                        4.0 * Theme.widthScale);

                                    if (Math.min(xDistance, yDistance) > tolerance)
                                        return -1;

                                    return xDistance <= yDistance ? 0 : 1;
                                }

                                function pointerAngle(mouseX, mouseY) {
                                    return Math.atan2(mouseY - height * 0.5,
                                        mouseX - width * 0.5) * 180.0 / Math.PI;
                                }

                                function setRingValue(ringIndex, value) {
                                    var formatted = editorRoot.compactFloatText(
                                        normalizeAngle(value).toFixed(2), "0");

                                    if (ringIndex === 0)
                                        ang3Field.text = formatted; // X
                                    else
                                        ang1Field.text = formatted; // Y
                                }

                                function beginRingDrag(mouseX, mouseY) {
                                    var selectedRing = closestRing(mouseX, mouseY);
                                    if (selectedRing < 0)
                                        return false;

                                    dragRing = selectedRing;
                                    dragLastPointerAngle = pointerAngle(mouseX, mouseY);
                                    dragAccumulatedDelta = 0.0;
                                    dragStartValue = ringValue(selectedRing);
                                    return true;
                                }

                                function updateRingDrag(mouseX, mouseY) {
                                    if (dragRing < 0)
                                        return;

                                    var currentPointerAngle = pointerAngle(mouseX, mouseY);
                                    var delta = currentPointerAngle
                                        - dragLastPointerAngle;
                                    while (delta > 180.0) delta -= 360.0;
                                    while (delta <= -180.0) delta += 360.0;

                                    dragAccumulatedDelta += delta;
                                    dragLastPointerAngle = currentPointerAngle;
                                    setRingValue(dragRing,
                                        dragStartValue + dragAccumulatedDelta);
                                }

                                function endRingDrag() {
                                    dragRing = -1;
                                }

                                Rectangle {
                                    anchors.fill: parent
                                    color: rotationMouse.containsMouse
                                           ? "#241f1f1f" : "#16141414"
                                    border.color: Theme.colors.dimmedText
                                    border.width: 1
                                    radius: Math.ceil(2 * Theme.widthScale)
                                }

                                Canvas {
                                    id: axisCanvas
                                    anchors.fill: parent
                                    property real shownPitch: rotationGizmo.pitchAngle
                                    property real shownYaw: rotationGizmo.yawAngle
                                    property real shownRoll: rotationGizmo.rollAngle
                                    property int shownDragRing: rotationGizmo.dragRing
                                    property bool shownEditorVisible: editorRoot.visible
                                    property bool shownEnabled: rotationGizmo.enabled

                                    onShownPitchChanged: requestPaint()
                                    onShownYawChanged: requestPaint()
                                    onShownRollChanged: requestPaint()
                                    onShownDragRingChanged: requestPaint()
                                    onShownEditorVisibleChanged: {
                                        if (shownEditorVisible)
                                            requestPaint();
                                    }
                                    onShownEnabledChanged: requestPaint()
                                    Component.onCompleted: requestPaint()
                                    onPaint: {
                                        var ctx = getContext("2d");
                                        ctx.clearRect(0, 0, width, height);

                                        var centerX = width * 0.5;
                                        var centerY = height * 0.5;
                                        var ringColors = ["#e53935", "#43a047"];

                                        // Only the X and Y rings are controls. The
                                        // orientation arrows below are decorative.
                                        for (var ringIndex = 0;
                                             ringIndex < 2; ringIndex++) {
                                            var selectedRing = ringIndex
                                                === rotationGizmo.dragRing;
                                            var handle = rotationGizmo.ringHandle(
                                                ringIndex);

                                            ctx.save();
                                            ctx.globalAlpha = selectedRing ? 1.0 : 0.8;
                                            ctx.strokeStyle = ringColors[ringIndex];
                                            ctx.lineWidth = selectedRing ? 3.5 : 2.0;
                                            ctx.beginPath();
                                            ctx.arc(centerX, centerY,
                                                rotationGizmo.ringRadius(ringIndex),
                                                0, Math.PI * 2.0, false);
                                            ctx.stroke();

                                            ctx.fillStyle = ringColors[ringIndex];
                                            ctx.beginPath();
                                            ctx.arc(handle[0], handle[1],
                                                selectedRing ? 4.5 : 3.5,
                                                0, Math.PI * 2.0, false);
                                            ctx.fill();
                                            ctx.restore();
                                        }

                                        var colors = ["#e53935", "#43a047", "#1e88e5"];
                                        var labels = ["X", "Y", "Z"];
                                        var order = [0, 1, 2];
                                        order.sort(function(a, b) {
                                            return rotationGizmo.axisEndpoint(a)[2]
                                                    - rotationGizmo.axisEndpoint(b)[2];
                                        });

                                        for (var drawIndex = 0;
                                             drawIndex < order.length; drawIndex++) {
                                            var axisIndex = order[drawIndex];
                                            var endpoint = rotationGizmo.axisEndpoint(
                                                axisIndex);
                                            var vx = endpoint[0] - centerX;
                                            var vy = endpoint[1] - centerY;
                                            var lineLength = Math.sqrt(vx * vx + vy * vy);

                                            // An axis pointing into the camera has no
                                            // visible screen-space arrow.
                                            if (lineLength < 3.0)
                                                continue;

                                            var ux = vx / lineLength;
                                            var uy = vy / lineLength;
                                            var headLength = 5.5;
                                            var headWidth = 3.5;
                                            var backX = endpoint[0] - ux * headLength;
                                            var backY = endpoint[1] - uy * headLength;

                                            ctx.save();
                                            ctx.globalAlpha = 0.65 + 0.25
                                                * (endpoint[2] + 1.0) * 0.5;
                                            ctx.strokeStyle = colors[axisIndex];
                                            ctx.fillStyle = colors[axisIndex];
                                            ctx.lineWidth = 2.25;
                                            ctx.lineCap = "round";
                                            ctx.beginPath();
                                            ctx.moveTo(centerX, centerY);
                                            ctx.lineTo(backX, backY);
                                            ctx.stroke();

                                            ctx.beginPath();
                                            ctx.moveTo(endpoint[0], endpoint[1]);
                                            ctx.lineTo(backX - uy * headWidth,
                                                       backY + ux * headWidth);
                                            ctx.lineTo(backX + uy * headWidth,
                                                       backY - ux * headWidth);
                                            ctx.closePath();
                                            ctx.fill();

                                            ctx.globalAlpha = 1.0;
                                            ctx.font = "bold "
                                                + Math.max(8, Math.ceil(
                                                    9 * Theme.heightScale))
                                                + "px sans-serif";
                                            ctx.fillText(labels[axisIndex],
                                                endpoint[0] + ux * 4.0 - 3.0,
                                                endpoint[1] + uy * 4.0 + 3.0);
                                            ctx.restore();
                                        }

                                        ctx.save();
                                        ctx.fillStyle = "#ffffff";
                                        ctx.beginPath();
                                        ctx.arc(centerX, centerY, 2.75, 0,
                                                Math.PI * 2.0, false);
                                        ctx.fill();
                                        ctx.restore();
                                    }
                                }

                                MouseArea {
                                    id: rotationMouse
                                    anchors.fill: parent
                                    enabled: rotationGizmo.enabled
                                    hoverEnabled: true
                                    acceptedButtons: Qt.LeftButton
                                    preventStealing: true
                                    cursorShape: pressed
                                                 && rotationGizmo.dragRing >= 0
                                                 ? Qt.ClosedHandCursor
                                                 : Qt.OpenHandCursor
                                    onPressed: {
                                        mouse.accepted = rotationGizmo.beginRingDrag(
                                            mouse.x, mouse.y);
                                    }
                                    onPositionChanged: {
                                        if (pressed && rotationGizmo.dragRing >= 0)
                                            rotationGizmo.updateRingDrag(
                                                mouse.x, mouse.y);
                                    }
                                    onReleased: rotationGizmo.endRingDrag()
                                    onCanceled: rotationGizmo.endRingDrag()
                                }
                            }
                        }
                    } //lockableContent column
				} //lockableContent
            }  
        } // Column  
    } // Flickable  

    // Static replacement for the removed panel scrollbar.
    Rectangle {
        id: editorRightRail
        anchors.top: editorHeader.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: Math.ceil(16 * Theme.widthScale)
        color: Theme.colors.highlight
        z: 1
    }
	
	// ── Texture Browser Overlay ───────────────────────────────────────────────  
	Item { id: textureBrowserOverlay  
		parent: appRoot          // escape editorRoot's clip:true  
		anchors.fill: parent  
		visible: false  
		z: 200  
	  
		// ── Non-visual items: MUST be direct children, NOT inside Column/Row ──  
		ListModel { id: textureModel }  
	  
		Timer { id: populateTimer  
			interval: 200; repeat: false  
			onTriggered: {  
				textureModel.clear();  
				var max = BlackMesaEngine.getConsoleVariableAsInt("sv_hcad_browserhelper_maxfile");  
				for (var i = 0; i < max; i++) {  
					BlackMesaEngine.setConsoleVariableAsInt("sv_hcad_browserhelper_index", i);  
					var path = BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_browserhelper_file");  
					if (path.length === 0) continue;  
					if (path.substring(path.length - 4) !== ".vtf") continue;  
					var slash = path.lastIndexOf("/");  
					var fname = (slash >= 0) ? path.substring(slash + 1) : path;  
					var nameNoExt = fname.substring(0, fname.length - 4);  
					textureModel.append({  
						filePath:    path,  
						displayName: nameNoExt,  
						textureName: "effects/lensflare/" + nameNoExt  
					});  
				}  
				// reset the helper  
				BlackMesaEngine.setConsoleVariableAsString("sv_hcad_browserhelper_readfolder", "-");  
			}  
		}  
	  
		function open() {  
			textureModel.clear();  
			BlackMesaEngine.setConsoleVariableAsString(  
				"sv_hcad_browserhelper_readfolder", "materials/effects/lensflare");  
			populateTimer.restart();  
			visible = true;  
		}  
	  
		// ── Dark backdrop (blocks clicks through to the editor) ───────────────  
		Rectangle {  
			anchors.fill: parent  
			color: "#b0000000"  
			MouseArea { anchors.fill: parent }   // swallow all clicks  
		}  
	  
		// ── Browser panel ─────────────────────────────────────────────────────  
		Rectangle { id: browserPanel  
			anchors.centerIn: parent  
			width:  Math.min(parent.width  * 0.80, Math.ceil(820 * Theme.widthScale))  
			height: Math.min(parent.height * 0.80, Math.ceil(620 * Theme.heightScale))  
			color: Theme.devConsole.colors.background  
	  
			// Header bar  
			Rectangle { id: browserHeader  
				anchors.left: parent.left; anchors.right: parent.right; anchors.top: parent.top  
				height: Math.ceil(30 * Theme.heightScale)  
				color: Theme.colors.highlight; opacity: 0.9  
	  
				Text {  
					anchors.left: parent.left  
					anchors.leftMargin: Math.ceil(8 * Theme.widthScale)  
					anchors.verticalCenter: parent.verticalCenter  
					text: "LENS FLARE TEXTURE BROWSER"  
					color: Theme.colors.text; font.family: Theme.fonts.bold  
					font.pixelSize: Math.ceil(13 * Theme.heightScale)  
					font.capitalization: Font.AllUppercase  
				}  
	  
				Rectangle {  
					anchors.right: parent.right; anchors.top: parent.top; anchors.bottom: parent.bottom  
					width: Math.ceil(70 * Theme.widthScale)  
					color: browserExitMouse.containsMouse ? "#e03030" : Theme.colors.warning  
					Text {  
						anchors.centerIn: parent; text: "EXIT"  
						color: Theme.colors.text; font.family: Theme.fonts.bold  
						font.pixelSize: Math.ceil(12 * Theme.heightScale)  
						font.capitalization: Font.AllUppercase  
					}  
					MouseArea { id: browserExitMouse  
						anchors.fill: parent; hoverEnabled: true  
						onClicked: textureBrowserOverlay.visible = false   // no apply  
					}  
				}  
			}  
	  
			// Texture grid  
			GridView { id: textureGrid  
				anchors.left: parent.left; anchors.right: parent.right  
				anchors.top: browserHeader.bottom; anchors.bottom: parent.bottom  
				anchors.margins: Math.ceil(4 * Theme.widthScale)  
				clip: true  
				boundsBehavior: Flickable.StopAtBounds  
				ScrollBar.vertical: VerticalScrollBar {}  
	  
				property int thumbSize: Math.ceil(110 * Theme.widthScale)  
				property int labelH:    Math.ceil(18  * Theme.heightScale)  
				cellWidth:  thumbSize + Math.ceil(8 * Theme.widthScale)  
				cellHeight: thumbSize + labelH + Math.ceil(8 * Theme.heightScale)  
	  
				model: textureModel  
	  
				delegate: Item {  
					width:  textureGrid.cellWidth  
					height: textureGrid.cellHeight  
	  
					Rectangle {  
						anchors.fill: parent  
						anchors.margins: Math.ceil(3 * Theme.widthScale)  
						color: delegateMouse.containsMouse  
							   ? Theme.colors.highlight : Theme.colors.subNavBackground  
						border.color: Theme.colors.dimmedText; border.width: 1  
	  
						Image {  
							anchors.top: parent.top; anchors.left: parent.left  
							anchors.right: parent.right; anchors.bottom: thumbLabel.top  
							anchors.margins: Math.ceil(2 * Theme.widthScale)  
							source: "image://game/" + model.filePath  
							fillMode: Image.PreserveAspectFit  
							asynchronous: true  
						}  
	  
						Text { id: thumbLabel  
							anchors.bottom: parent.bottom; anchors.left: parent.left  
							anchors.right: parent.right  
							anchors.bottomMargin: Math.ceil(2 * Theme.heightScale)  
							height: textureGrid.labelH  
							text: model.displayName  
							color: Theme.colors.text; font.family: Theme.fonts.regular  
							font.pixelSize: Math.ceil(9 * Theme.heightScale)  
							horizontalAlignment: Text.AlignHCenter  
							elide: Text.ElideRight  
						}  
	  
						MouseArea { id: delegateMouse  
							anchors.fill: parent; hoverEnabled: true  
							onClicked: {  
								textureField.text = model.textureName;  
								editorRoot.applyTexture(model.textureName);
								textureBrowserOverlay.visible = false;  
							}  
						}  
					}  
				}  
			}  
		}  
	}
	
	// ── Flare circles overlay ─────────────────────────────────────────────  
    Item { id: flaresOverlay  
        parent: appRoot  
        anchors.fill: parent  
        z: 1  
        visible: editorRoot.state === "opened"  
  
        // ── Helpers ──────────────────────────────────────────────────────  
        function parseVec3(str) {  
            var parts = str.split(" ");  
            return [  
                parseFloat(parts[0]) || 0.0,  
                parseFloat(parts[1]) || 0.0,  
                parseFloat(parts[2]) || 0.0  
            ];  
        }  
  
        function beginFlareUpdate() {
  
  
            editorRoot.flaresReady = false;
  
  
            editorRoot.flareUpdateCount = 0;
  
  
            flaresModel.clear();

  
  
            // The command is processed asynchronously by the game/server.
  
  
            BlackMesaEngine.executeClientCommandUnrestricted("sv_hcad_mle_requastdata");
  
  
            flareUpdateTimer.restart();
  
  
        }

  
  
        function updateFlares() {
            var maxEnts = BlackMesaEngine.getConsoleVariableAsInt("sv_hcad_mle_maxents");  
            if (maxEnts <= 0) return;  
  
            // 2. Read eye position and angles  
            var eyePos = parseVec3(  
                BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_playervisionpos"));  
            var eyeAng = parseVec3(  
                BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_playervisionang"));  
  
            // 3. FOV — fov_desired is horizontal FOV at 4:3.  
            //    Source keeps vertical FOV constant when aspect changes.  
            var fovDeg = BlackMesaEngine.getConsoleVariableAsFloat("fov_desired");  
            if (fovDeg <= 0) fovDeg = 90;  
  
            var screenW = Theme.rootWidth;  
            var screenH = Theme.rootHeight;  
  
            // 4. Build view vectors (Source AngleVectors, roll = 0)  
            var pitch = eyeAng[0] * Math.PI / 180.0;  
            var yaw   = eyeAng[1] * Math.PI / 180.0;  
            var cp = Math.cos(pitch), sp = Math.sin(pitch);  
            var cy = Math.cos(yaw),   sy = Math.sin(yaw);  
  
            var fwd   = [cp*cy,  cp*sy,  -sp];  
            var right = [sy,     -cy,     0 ];  
            var up    = [sp*cy,  sp*sy,   cp];  
  
            // 5. Projection scale  
            //    tanHalfFovV = tan(vertFOV/2), derived from fov_desired at 4:3  
            var tanHalfFovV = Math.tan(fovDeg * Math.PI / 360.0) * (3.0 / 4.0);  
            var tanHalfFovH = tanHalfFovV * (screenW / screenH);  
  
            // 6. Iterate entities  
            flaresModel.clear();  
            for (var i = 0; i < maxEnts; i++) {  
                BlackMesaEngine.setConsoleVariableAsInt("sv_hcad_mle_requastedentindex", i);  
                if (BlackMesaEngine.getConsoleVariableAsInt("sv_hcad_mle_isflare") !== 1)  
                    continue;  
  
                var wpos = parseVec3(  
                    BlackMesaEngine.getConsoleVariableAsString("sv_hcad_mle_flare_pos"));  
  
                var dx = wpos[0] - eyePos[0];  
                var dy = wpos[1] - eyePos[1];  
                var dz = wpos[2] - eyePos[2];  
  
                // View-space depth (must be > 0 to be in front of camera)  
                var depth = dx*fwd[0] + dy*fwd[1] + dz*fwd[2];  
                if (depth <= 0.1) continue;  
  
                // View-space right and up components  
                var vRight = dx*right[0] + dy*right[1] + dz*right[2];  
                var vUp    = dx*up[0]    + dy*up[1]    + dz*up[2];  
  
                // Project to screen pixels  
                var sx = (screenW / 2.0) * (1.0 + vRight / (depth * tanHalfFovH));  
                var sy = (screenH / 2.0) * (1.0 - vUp    / (depth * tanHalfFovV));  
  
                // Cull if far off-screen  
                if (sx < -60 || sx > screenW + 60 || sy < -60 || sy > screenH + 60)  
                    continue;  
  
                flaresModel.append({ entIndex: i, sx: sx, sy: sy });  
            }  
        }  
  
        // ── Data ─────────────────────────────────────────────────────────  
        ListModel { id: flaresModel }  
  
		// ── One-shot delayed update ───────────────────────────────────────
        Timer {
            id: flareIndexSyncTimer
            interval: 50
            repeat: true
            running: false

            onTriggered: {
                if (editorRoot.state !== "opened") {
                    stop();
                    return;
                }

                editorRoot.syncFlareIndexFromCvar();
            }
        }

        Timer {
            id: flareUpdateTimer
            interval: 100
            repeat: false
            running: false

            onTriggered: {
                if (editorRoot.state !== "opened") {
                    editorRoot.flaresReady = false;
                    return;
                }

                // Read only after the server command has updated the view ConVars.
                flaresOverlay.updateFlares();
                editorRoot.flaresReady = true;
            }
        }
  
        // ── Circles ───────────────────────────────────────────────────────  
        Repeater {  
            model: flaresModel  
  
            delegate: Item {  
                x: model.sx - 12  
                y: model.sy - 12  
                width: 24  
                height: 24  
  
                // Hide the circle for the currently selected flare  
                visible: editorRoot.flaresReady && model.entIndex !== editorRoot.flareIndex  
  
                Rectangle {  
                    anchors.fill: parent  
                    radius: width / 2  
                    color: "transparent"  
                    border.color: flareMouse.containsMouse ? "#ffffff" : Theme.colors.highlight
                    border.width: 2  
                }  
  
                // Thin crosshair dot in centre  
                Rectangle {  
                    anchors.centerIn: parent  
                    width: 4; height: 4  
                    radius: 2  
                    color: flareMouse.containsMouse ? "#ffffff" : Theme.colors.highlight
                }  
  
                MouseArea {
                    id: flareMouse
                    anchors.fill: parent
                    enabled: editorRoot.flaresReady
                    hoverEnabled: true
                    // Slightly larger hit area  
                    anchors.margins: -8  
                    onClicked: {  
                        editorRoot.flareIndex = model.entIndex;  
                        indexField.text = model.entIndex;  
                        BlackMesaEngine.setConsoleVariableAsInt(  
                            "sv_hcad_mle_flare_index", model.entIndex);  
                        editorRoot.loadAllFromCvars();  
                    }  
                }  
            }  
        }  
    }  
  
    // ── States & transitions (mirrors DevConsole) ─────────────────────────────  
    states: [  
        State {  
            name: "closed"  
            PropertyChanges { target: editorRoot; y: -editorRoot.height; opacity: 0.0 }  
        },  
        State {  
            name: "opened"  
            PropertyChanges { target: editorRoot; y: 0; opacity: 1.0 }  
        }  
    ]  
  
    transitions: [  
        Transition {  
            from: "closed"; to: "opened"  
            SequentialAnimation {  
                NumberAnimation { properties: "y, opacity"; duration: 50; easing.type: Easing.OutQuint }  
                ScriptAction { script: { BlackMesaUtils.disableUINavigation = true; } }  
            }  
        },  
        Transition {  
            from: "opened"; to: "closed"  
            SequentialAnimation {  
                ScriptAction { script: { appRoot.forceActiveFocus(); } }  
                NumberAnimation { properties: "y, opacity"; duration: 50; easing.type: Easing.OutQuint }  
                ScriptAction { script: { BlackMesaUtils.disableUINavigation = false; } }  
            }  
        }  
    ]  
}
