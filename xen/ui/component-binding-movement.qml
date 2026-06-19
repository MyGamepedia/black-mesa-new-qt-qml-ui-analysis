import QtQuick 2.9

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

