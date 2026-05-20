pragma Singleton

import QtQuick 2.9
import CrowbarCollective 1.0

QtObject {
    property int ambientId

    readonly property var music: [
        Theme.sounds.music1,
        Theme.sounds.music2
    ]

    function startMusic() {
        var sound = music[Math.floor(Math.random() * music.length)];

        startAmbient(sound);
    }

    function stopMusic() {
        stopAmbient();
    }

    function playEffect(filestr) {
        BlackMesaEngine.playSoundEffect(filestr);
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
            BlackMesaEngine.stopSoundById(ambiendId);
            ambientId = null;
        }
    }
}
