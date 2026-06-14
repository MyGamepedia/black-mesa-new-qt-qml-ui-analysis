import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

Rectangle {
    id: bsbindingsView
    signal requestInputBinding(var cfg, var callback)
    signal requestInputSelection(var model, var ordinal)

    property int scrollbarDimension: Math.ceil(15 * Theme.widthScale)
    
    property color bsOuterColor: Theme.colors.bssecondaryhighlight

    property string titleNameText: "Unset"
    property int visibleRows: 12
	property bool isLessRows: false
    property int listVerticalMargins: Math.ceil(35 * Theme.heightScale)
    property int rowHeight: Math.ceil(56 * Theme.heightScale)
    property int buttonTopMargin: Math.ceil(10 * Theme.heightScale)
    property int buttonMargin: Math.ceil(35 * Theme.widthScale)
    property int leftAllMargin: Math.ceil(50 * Theme.widthScale)
    property int rightAllMargin: Math.ceil(16 * Theme.widthScale)
    property int listPaddingBottom: Math.ceil(15 * Theme.heightScale)
    property int optlistcut: Math.ceil(15 * Theme.heightScale)
    property int listHeight: Math.floor(782 * Theme.heightScale)
    
    height: parent.height
    width: parent.width
    color: "transparent"

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

    Item {
		id: bindListBody
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
		anchors.topMargin: Math.ceil(116 * Theme.heightScale)
        anchors.leftMargin: leftAllMargin
        anchors.rightMargin: rightAllMargin
        
        height: listHeight
        
        Rectangle {
            id: damnScrollBG
            visible: bindingsList.height <= bindingsList.contentHeight
            width: Math.ceil(2 * Theme.heightScale)
            height: parent.height
            opacity: 0.8
            
            anchors.right: parent.right
            anchors.rightMargin: Math.ceil(6 * Theme.heightScale)
            anchors.verticalCenter: parent.verticalCenter
            
            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.2; color: bsbindingsView.bsOuterColor }
                GradientStop { position: 0.8; color: bsbindingsView.bsOuterColor }
                GradientStop { position: 1; color: "transparent" }
            }
        }
        
        ListView { id: bindingsList
            clip: true
            anchors.fill: bindListBody
            interactive: true
            boundsBehavior: Flickable.StopAtBounds
            cacheBuffer: 5000
            spacing: buttonTopMargin


			header: Rectangle {
					  width: bindingsList.width
					  height: bsbindingsView.listVerticalMargins
					  color: "transparent"
			}
			
			footer: Rectangle {
					  width: bindingsList.width
					  height: !isLessRows ? bsbindingsView.listVerticalMargins : 0
					  color: "transparent"
			}



            model: ListModel {
                Component.onCompleted: {
                    commands.forEach(function (cfg) {
                        append(cfg);
                    });
                }
            }

            ScrollBar.vertical: VerticalScrollBar {
                visible: damnScrollBG.visible
                policy: ScrollBar.AlwaysOn
                wheelEnabled: true
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
	
	
	
	
	
	
    Item {
        id: header

        anchors.topMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.rightMargin: 0

        anchors.top: parent.top
		anchors.bottom: bindListBody.top
        anchors.left: parent.left
        anchors.right: parent.right

        width: parent.width - Math.ceil(6 * Theme.heightScale)
		
        Item {
            id: headerTextBody
			
            anchors.top: parent.top
			anchors.topMargin: Math.ceil(-1 * Theme.heightScale)
            anchors.left: parent.left
            anchors.right: parent.right
			anchors.rightMargin: Math.ceil(-1 * Theme.heightScale)

            width: parent.width
            height: Math.ceil(85 * Theme.heightScale)		// OptionsList Footer Height
			
			property int titleNameFontSize: Math.ceil(60 * Theme.heightScale)
			property int titleMargin: Math.ceil(46 * Theme.widthScale)
			
					Rectangle {
						id: titleBGSec
						rotation: -90
						
						opacity: 0.9
						
						anchors.centerIn: parent
						height: parent.width
						width: parent.height - Math.ceil(30 * Theme.heightScale)
						anchors.verticalCenterOffset: Math.ceil(24 * Theme.heightScale)
									
						gradient: Gradient {
							GradientStop { position: 0.3; color:  "transparent" }
							GradientStop { position: 0.7; color: Theme.colors.highlight }
						}
					}
					
					Rectangle {
						id: titleBGFirst
						rotation: -90
						
						opacity: 0.9
						
						anchors.centerIn: parent
						height: parent.width
						width: parent.height
									
						gradient: Gradient {
							GradientStop { position: 0.1; color:  "transparent" }
							GradientStop { position: 0.6; color: Theme.colors.subMenuHintPrimary }
						}
					}
            
            Text { id: titleText
                anchors.right: parent.right
                anchors.rightMargin: headerTextBody.titleMargin
				anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: Math.ceil(-3 * Theme.heightScale)
                text: titleNameText
                font.capitalization: Font.MixedCase
                font.pixelSize: headerTextBody.titleNameFontSize
                font.family: Theme.fonts.regular
                font.bold: true
                color: Theme.colors.buttonText
            }
		}

	}
	

}
