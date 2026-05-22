pragma Singleton

import QtQuick 2.9
import CrowbarCollective 1.0

QtObject {
    property int ambientId

    readonly property var music: [
        Theme.sounds.music1,
        Theme.sounds.music2
    ]
	
    readonly property var focusO: [
        Theme.sounds.buttonFocusedO1,
        Theme.sounds.buttonFocusedO2,
        Theme.sounds.buttonFocusedO3,
        Theme.sounds.buttonFocusedO4,
        Theme.sounds.buttonFocusedO5
		
    ]
	
    readonly property var clickO: [
        Theme.sounds.buttonClickedO1,
        Theme.sounds.buttonClickedO2,
        Theme.sounds.buttonClickedO3,
        Theme.sounds.buttonClickedO4,
        Theme.sounds.buttonClickedO5,
        Theme.sounds.buttonClickedO6,
        Theme.sounds.buttonClickedO7,
        Theme.sounds.buttonClickedO8,
        Theme.sounds.buttonClickedO9,
        Theme.sounds.buttonClickedO10,
        Theme.sounds.buttonClickedO11,
        Theme.sounds.buttonClickedO12,
        Theme.sounds.buttonClickedO13,
        Theme.sounds.buttonClickedO14,
        Theme.sounds.buttonClickedO15,
        Theme.sounds.buttonClickedO16,
        Theme.sounds.buttonClickedO17
    ]

    function startMusic() {
        var sound = music[Math.floor(Math.random() * music.length)];

        startAmbient(sound);
    }
	
    function startSp() {
        BlackMesaEngine.stopSoundById(ambientId);
        var ambientVolume = BlackMesaEngine.getConsoleVariableAsFloat("snd_musicvolume");
        ambientId = BlackMesaEngine.playAmbientSound(Theme.sounds.sp, ambientVolume);
    }

    function stopMusic() {
        stopAmbient();
    }

    function playEffect( type ) {
		var effect;
		if ( !Theme.currentDay ) {
			effect = ( type === "sndfocus" ) ? Theme.sounds.buttonFocused : Theme.sounds.buttonClicked;
		} else {
			effect = ( type === "sndfocus" ) ? focusO[Math.floor(Math.random() * focusO.length)] : clickO[Math.floor(Math.random() * clickO.length)];
		}
        BlackMesaEngine.playSoundEffect( effect );
    }

    function isPlayingAmbient() {
        return !!ambientId;
    }

    function startAmbient(filestr) {
        stopAmbient();

        var ambientVolume = BlackMesaEngine.getConsoleVariableAsFloat("snd_musicvolume")
        ambientId = BlackMesaEngine.playAmbientSound(filestr, ambientVolume);
    }

    function stopAmbient() {
        if (ambientId && BlackMesaEngine.isSoundStillPlaying(ambientId)) {
            BlackMesaEngine.stopSoundById(ambientId);
            ambientId = null;
        }
    }
}
