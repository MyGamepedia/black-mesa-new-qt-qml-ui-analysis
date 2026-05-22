import QtQuick 2.9
import CrowbarCollective 1.0

BindingList {

	titleNameText: L10n.strings.options.labels.binding_misc
		
    commands: [
        InputBindingsManager.getBindingComponentConfig('save quick'),
        InputBindingsManager.getBindingComponentConfig('load quick'),
        InputBindingsManager.getBindingComponentConfig('toggleconsole'),
        InputBindingsManager.getBindingComponentConfig('incrementvar closecaption 0 1 1'),
        InputBindingsManager.getBindingComponentConfig('+moveup'),
        InputBindingsManager.getBindingComponentConfig('+movedown'),
        InputBindingsManager.getBindingComponentConfig('+lookup'),
        InputBindingsManager.getBindingComponentConfig('+lookdown'),
        InputBindingsManager.getBindingComponentConfig('+left'),
        InputBindingsManager.getBindingComponentConfig('+right')
    ]
}

