import QtQuick 2.9
import CrowbarCollective 1.0

BindingList {
    commands: [
        InputBindingsManager.getBindingComponentConfig('+showscores'),
        InputBindingsManager.getBindingComponentConfig('+voicerecord'),
        InputBindingsManager.getBindingComponentConfig('messagemode'),
        InputBindingsManager.getBindingComponentConfig('messagemode2'),
        InputBindingsManager.getBindingComponentConfig('chooseteam'),
    ]
}
