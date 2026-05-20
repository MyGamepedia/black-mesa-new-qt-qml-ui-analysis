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
        height: parent.height
        width: parent.width - 32

        Row {
            anchors.fill: parent
            spacing: 0

            BindingCell { id: primary
                width: parent.width / 2 + 16
                key: model.key1
                selected: {
                    var cfg = InputBindingsManager.selectedCfg || {};
                    return cfg.ordinal === 'key1' && cfg.command === model.command;
                }
                onRequestInputSelection: requestSelection('key1', begin, end)
            }

            BindingCell { id: secondary
                width: parent.width / 2 + 16
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
