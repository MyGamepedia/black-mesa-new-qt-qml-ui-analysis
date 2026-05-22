import QtQuick 2.9
import CrowbarCollective 1.0

BindingList {
    commands: [
        InputBindingsManager.getBindingComponentConfig('chooseteam'),
        InputBindingsManager.getBindingComponentConfig('+voicerecord'),
    ]
}
