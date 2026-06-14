import QtQuick 2.9
import CrowbarCollective 1.0

FocusScope { id: root
    property variant model

    function requestSelection(ordinal, begin, end) {
        // qt 5.9 apparently lacks `Object.assign`
        var cfg = {}, k;

        for (k in model) {
            if (model.hasOwnProperty(k)) {
                cfg[k] = model[k];
            }
        }

        cfg.ordinal = ordinal;
        cfg.current = model[ordinal];
        cfg.begin = begin;
        cfg.end = end;

        InputBindingsManager.selectBinding(cfg);
    }

    Item {
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: Math.ceil(1 * Theme.heightScale)
        height: parent.height
        width: parent.width

        Row {
            anchors.fill: parent
            spacing: 0

            BindingCell { id: primary
                objectName: "ui--navigation:binding-cellleft:level_2"
                width: parent.width / 2
                key: model.key1
                selected: {
                    var cfg = InputBindingsManager.selectedCfg || {};
                    return cfg.ordinal === 'key1' && cfg.command === model.command;
                }
                onRequestInputSelection: requestSelection('key1', begin, end)
            }

            BindingCell { id: secondary
                objectName: "ui--navigation:binding-cellright:level_3"
                width: parent.width / 2
                key: model.key2
                selected: {
                    var cfg = InputBindingsManager.selectedCfg || {};
                    return cfg.ordinal === 'key2' && cfg.command === model.command;
                }
                onRequestInputSelection: requestSelection('key2', begin, end)
            }
        }
    }
}
