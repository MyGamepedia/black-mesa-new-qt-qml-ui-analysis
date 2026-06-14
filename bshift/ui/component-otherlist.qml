import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

Rectangle {
    id: otherView
    property ListModel model
    property variant models

    property string titleNameText: "Unset"
    property int visibleRows: 9
    property bool batchUpdates: false

    property int fakeVisibleRows: 13
    property int listVerticalMargins: Math.ceil(35 * Theme.heightScale)
	
    property int itemHeight: Math.ceil(86 * Theme.heightScale)				//Default item height
    property int buttonMargin: Math.ceil(17 * Theme.widthScale)
    property int buttonTopMargin: Math.ceil(10 * Theme.heightScale)
    property int leftAllMargin: Math.ceil(50 * Theme.widthScale)
    property int rightAllMargin: Math.ceil(16 * Theme.widthScale)
    property int listPaddingBottom: Math.ceil(15 * Theme.heightScale)
    property int optlistcut: Math.ceil(15 * Theme.heightScale)
    property int listHeight: Math.floor(896 * Theme.heightScale)
    
    property color bsOuterColor: Theme.colors.bssecondaryhighlight

    property bool scrowbActive: otherList.height + otherList.bottomMargin + otherList.topMargin + 2 < otherList.contentHeight
    
    height: parent.height
    width: parent.width
    color: "transparent"

    Item {
		id: othListBody
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
		anchors.topMargin: Math.ceil(116 * Theme.heightScale)
        anchors.leftMargin: leftAllMargin
        anchors.rightMargin: rightAllMargin
        
        height: listHeight

        Rectangle { 
            visible: scrowbActive
            width: Math.floor(2 * Theme.heightScale)
            height: parent.height
            opacity: 0.8
            
            anchors.right: parent.right
            anchors.rightMargin: Math.floor(6 * Theme.heightScale)
            anchors.verticalCenter: parent.verticalCenter
            
            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.2; color: otherView.bsOuterColor }
                GradientStop { position: 0.8; color: otherView.bsOuterColor }
                GradientStop { position: 1; color: "transparent" }
            }
        }

        ListView { id: otherList
            clip: true
            anchors.fill: parent
            model: otherView.model
            // TODO: interactive should be true for supporting mouse scroll,
            // when it set to false mouse wheel will not work
            interactive: true
            boundsBehavior: Flickable.StopAtBounds
            cacheBuffer: 15000		//for ~152 items
            keyNavigationEnabled: false
            keyNavigationWraps: false
            spacing: buttonTopMargin

			header: Rectangle {
					  width: otherList.width
					  height: otherView.listVerticalMargins
					  color: "transparent"
			}
			
			footer: Rectangle {
					  width: otherList.width
					  height: otherView.listVerticalMargins
					  color: "transparent"
			}

            ScrollBar.vertical: VerticalScrollBar {
                visible: scrowbActive
            }

            delegate: Loader {
                id: loader
                width: otherList.width
                height: itemHeight

                Component.onCompleted: {
                    loader.setSource('component-otherlist-row.qml', { model: model, inputWidth: parent.width / 2 - (Theme.widthScale * 300) });
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
		anchors.bottom: othListBody.top
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
