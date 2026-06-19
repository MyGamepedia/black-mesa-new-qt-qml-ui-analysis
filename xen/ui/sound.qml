pragma Singleton

import QtQuick 2.9
import CrowbarCollective 1.0

QtObject {
    property int ambientId
    property real ambientVolume: 0.21 // TODO: Get from engine

    function playEffect(filestr) {
        BlackMesaEngine.playSoundEffect(filestr);
    }

    function isPlayingAmbient() {
        return !!ambientId;
    }

    function startAmbient(filestr) {
        stopAmbient();

        ambientId = BlackMesaEngine.playAmbientSound(filestr, ambientVolume);
    }

    function stopAmbient() {
        if (ambientId && BlackMesaEngine.isSoundStillPlaying(ambientId)) {
            BlackMesaEngine.stopSoundById(ambiendId);
            ambientId = null;
        }
    }
}
