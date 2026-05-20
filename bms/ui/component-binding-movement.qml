import QtQuick 2.9
import CrowbarCollective 1.0

BindingList {
    commands: [
        InputBindingsManager.getBindingComponentConfig('+forward'),
        InputBindingsManager.getBindingComponentConfig('+back'),
        InputBindingsManager.getBindingComponentConfig('+moveleft'),
        InputBindingsManager.getBindingComponentConfig('+moveright'),
        InputBindingsManager.getBindingComponentConfig('+jump'),
        InputBindingsManager.getBindingComponentConfig('+duck'),
        InputBindingsManager.getBindingComponentConfig('+speed')
    ];
}

