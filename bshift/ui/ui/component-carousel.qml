import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

Item { id: carousel
    anchors.fill: parent
    width: Math.ceil(1200 * Theme.widthScale)
    height: parent.height

    property ListModel levels
    property Component itemComponent
	
    property string titleNameText: "Unset"

    property int buttonMargin: Math.ceil(76 * Theme.heightScale)
    property int maskWidth: Math.ceil(1200 * Theme.widthScale)
    property int maskPadding: Math.ceil(50 * Theme.heightScale)
    property int maskHeight: parent.height - ( maskPadding * 2 )
    property int itemWidth: parent.width
    property int itemHeight: Math.ceil(224 * Theme.heightScale)    // 200 for 4 chapters and more, 277 for 3 chapters

    property bool showDown: false
    property bool showUp: false
	
    property int listHeight: Math.floor(896 * Theme.heightScale)
    property int leftAllMargin: Math.ceil(50 * Theme.widthScale)
    property int rightAllMargin: Math.ceil(16 * Theme.widthScale)
    property int listVerticalMargins: Math.ceil(56 * Theme.heightScale)

	
    Item {
        id: header

        anchors.topMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.rightMargin: 0

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
		
        height: Math.ceil(116 * Theme.heightScale)		// OptionsList Footer Height

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
			property int thisonePadding: Math.ceil(56 * Theme.widthScale)
			
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


    Item { id: mask
        clip: true
		
        anchors.left: parent.left
        anchors.right: parent.right
		
        height: listHeight
        anchors.top: parent.top
		anchors.topMargin: Math.ceil(116 * Theme.heightScale)
        anchors.leftMargin: leftAllMargin
        anchors.rightMargin: rightAllMargin
        
        Rectangle {
            visible: itemsList.count > 3
            width: Math.floor(2 * Theme.heightScale)
            height: parent.height
            opacity: 0.8
            
            anchors.right: parent.right
            anchors.rightMargin: Math.floor(6 * Theme.heightScale)
            anchors.verticalCenter: parent.verticalCenter
            
            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.2; color: Theme.colors.bssecondaryhighlight }
                GradientStop { position: 0.8; color: Theme.colors.bssecondaryhighlight }
                GradientStop { position: 1; color: "transparent" }
            }
        }
		
		
        ListView { id: itemsList
            objectName: "ui--navigation:carousel-container"
            clip: true
            cacheBuffer: 9000	//Increase if navigation breaks
            interactive: true

            anchors.fill: mask

            orientation: ListView.Vertical
            spacing: listVerticalMargins

            boundsBehavior: Flickable.StopAtBounds
            keyNavigationEnabled: false
            keyNavigationWraps: false



            model: carousel.levels
            delegate: itemComponent




			header: Rectangle {
					  width: itemsList.width
					  height: listVerticalMargins
					  color: "transparent"
			}
			
			footer: Rectangle {
					  width: itemsList.width
					  height: ( itemsList.count > 3 ) ? listVerticalMargins : 0
					  color: "transparent"
			}

            ScrollBar.vertical: VerticalScrollBar {
                visible: itemsList.count > 3
            }
			
        }
    }
}
