import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

Item {
    signal requestInputBinding(var cfg, var callback)
    signal requestInputSelection(var model, var ordinal)

    property int rowHeight: Math.ceil(85 * Theme.heightScale)
    property int scrollbarDimension: Math.ceil(15 * Theme.widthScale)

    opacity: 0

    property variant commands
    property variant bindings
    property bool selected

    function refreshBindings() {
        timer.setTimeout(function () {
            var keys = commands.map(function (cfg) { return cfg.command; });
            InputBindingsManager.getBindings(keys, function (response) { bindings = response; });
        }, 1);
    }

    Timer { id: timer
        function setTimeout(callback, delay) {
            timer.stop();
            timer.interval = delay || 1;
            timer.repeat = false;
            timer.triggered.connect(callback);
            timer.triggered.connect(function release() {
                timer.triggered.disconnect(callback);
                timer.triggered.disconnect(release);
            });
            timer.start();
        }
    }

    Connections {
        target: InputBindingsManager

        onBindingSet: {
            refreshBindings();
        }

        onBindingClear: {
            refreshBindings();
        }

        onDefaultsRestored: {
            refreshBindings();
        }
    }

    Component.onCompleted: {
        refreshBindings();
    }

    onBindingsChanged: {
        var list = bindingsList.model,
            i, current;

        for (i = 0; i < list.count; i++) {
            current = list.get(i);
            current.key1 = "";
            current.key2 = "";

            if (bindings[current.command]) {
                current.key1 = bindings[current.command][0];
                current.key2 = bindings[current.command][1];
            }
        }
    }

    ListView { id: bindingsList
        anchors.fill: parent
        interactive: true
        boundsBehavior: Flickable.StopAtBounds
        cacheBuffer: 50000

        model: ListModel {
            Component.onCompleted: {
                commands.forEach(function (cfg) {
                    append(cfg);
                });
            }
        }

        ScrollBar.vertical: ScrollBar {
            visible: bindingsList.height + bindingsList.bottomMargin + bindingsList.topMargin + 2 < bindingsList.contentHeight
            policy: ScrollBar.AlwaysOn
            wheelEnabled: true

            contentItem: Rectangle {
                implicitWidth: scrollbarDimension
                implicitHeight: scrollbarDimension

                color: Theme.colors.highlight
            }
        }

        delegate: Loader { id: loader
            width: bindingsList.width
            height: rowHeight

            Component.onCompleted: {
                loader.setSource('component-optionslist-row.qml', { model: model, selected: selected });
            }
        }
    }
}
