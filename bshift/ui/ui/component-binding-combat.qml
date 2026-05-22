import QtQuick 2.9
import CrowbarCollective 1.0

BindingList {

	titleNameText: L10n.strings.options.labels.binding_combat
		
    commands: [
        InputBindingsManager.getBindingComponentConfig('+use'),
        InputBindingsManager.getBindingComponentConfig('+attack'),
        InputBindingsManager.getBindingComponentConfig('+attack2'),
        InputBindingsManager.getBindingComponentConfig('+reload'),
        InputBindingsManager.getBindingComponentConfig('impulse 100'),
        InputBindingsManager.getBindingComponentConfig('+zoom'),
        InputBindingsManager.getBindingComponentConfig('invnext'),
        InputBindingsManager.getBindingComponentConfig('invprev'),
        InputBindingsManager.getBindingComponentConfig('lastinv'),
        InputBindingsManager.getBindingComponentConfig('+quickfrag'),
        InputBindingsManager.getBindingComponentConfig('slot1'),
        InputBindingsManager.getBindingComponentConfig('slot2'),
        InputBindingsManager.getBindingComponentConfig('slot3'),
        InputBindingsManager.getBindingComponentConfig('slot4'),
        InputBindingsManager.getBindingComponentConfig('slot5')
    ]
}
