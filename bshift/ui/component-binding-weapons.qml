import QtQuick 2.9
import CrowbarCollective 1.0

BindingList {

	titleNameText: L10n.strings.options.labels.binding_weapons
		
    commands: [
        InputBindingsManager.getBindingComponentConfig('use weapon_crowbar'),
        InputBindingsManager.getBindingComponentConfig('use weapon_glock'),
        InputBindingsManager.getBindingComponentConfig('use weapon_357'),
        InputBindingsManager.getBindingComponentConfig('use weapon_mp5'),
        InputBindingsManager.getBindingComponentConfig('use weapon_shotgun'),
        InputBindingsManager.getBindingComponentConfig('use weapon_rpg'),
        InputBindingsManager.getBindingComponentConfig('use weapon_frag'),
        InputBindingsManager.getBindingComponentConfig('use weapon_satchel'),
        InputBindingsManager.getBindingComponentConfig('use weapon_crossbow'),
        InputBindingsManager.getBindingComponentConfig('use weapon_snark')
    ]
}
