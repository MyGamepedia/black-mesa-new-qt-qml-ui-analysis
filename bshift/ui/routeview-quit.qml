import QtQuick 2.9
import CrowbarCollective 1.0

RouteView {
    id: quitView
    
    property variant quotes: (function () {
        return Object.keys(L10n.strings.quit).map(function (key) {
            return L10n.strings.quit[key];
        });
    }())
    
    property bool isInGame: false
    
    property bool isWidescreen: appRoot.width / appRoot.height >= 1.586

    property int logoVerticalCenterOffset: Math.ceil(-123 * Theme.heightScale)
    property int childTopMargin: Math.ceil(69 * Theme.heightScale)
    property int titleNameFontSize: Math.ceil(60 * Theme.heightScale)
    property int descrFontSize: Math.ceil(28 * Theme.heightScale)
    
    property int childLogoMargin: isWidescreen ? Math.ceil(200 * Theme.widthScale) :  Math.ceil(70 * Theme.widthScale)
    property int childMargin: isWidescreen ? Math.ceil(120 * Theme.widthScale) :  Math.ceil(20 * Theme.widthScale)

    anchors.fill: parent
	
    function goBack() {
		quitView.routeRequest(Routes.index.name);
		if ( isInGame ) {
			appRoot.isIndexHints = true;
		}
		return;
    }
	
    
        Item {
            id: root
            anchors.fill: parent

            Text {
                id: titleTextShadowRight
                anchors.left: parent.left
                anchors.leftMargin: childLogoMargin + Math.ceil(2 * Theme.heightScale)
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: logoVerticalCenterOffset + Math.ceil(2 * Theme.heightScale)
                text: titleText.text
                font.capitalization: Font.MixedCase
                font.pixelSize: quitView.titleNameFontSize
                font.family: Theme.fonts.regular
                font.bold: true
                color: Theme.colors.bsMenuBackDropRight
                opacity: 0.7
            }
            
            Text {
                id: titleText
                anchors.left: parent.left
                anchors.leftMargin: childLogoMargin
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: logoVerticalCenterOffset
                text: L10n.strings.headers.quit
                font.capitalization: Font.MixedCase
                font.pixelSize: quitView.titleNameFontSize
                font.family: Theme.fonts.regular
                font.bold: true
                color: Theme.colors.buttonText
            }
            
            Text {
                id: descrText
                anchors.top: titleText.bottom
                anchors.left: parent.left
                anchors.leftMargin: childLogoMargin + Math.ceil(5 * Theme.widthScale)
                text:  quotes[Math.floor(Math.random() * quotes.length)]
                font.capitalization: Font.MixedCase
                font.pixelSize: quitView.descrFontSize
                font.family: Theme.fonts.regular
                color: Theme.colors.buttonText
            }
            

			Column { id: buttonsContainer
			
                anchors.top: titleText.bottom
                anchors.topMargin: childTopMargin
                anchors.left: parent.left
                anchors.leftMargin: childMargin
				
				spacing: Math.ceil(10 * Theme.heightScale)
			
                
                    BSButton {
                        id: quitSaveButton
                        objectName:  "ui--navigation:bsbutton:level_1"
                        visible: isInGame
                        text: L10n.strings.buttons.saveandquit
                        callback: function() {
                            quitView.saveGameRequest(null);
                            BlackMesaEngine.executeClientCommandUnrestricted("wait;wait;wait;wait;quit");
                        }
                        onClicked: {
                            quitView.saveGameRequest(null);
                            BlackMesaEngine.executeClientCommandUnrestricted("wait;wait;wait;wait;quit");
                        }
						
                        Keys.onLeftPressed: { return; }
                        Keys.onRightPressed: { return; }
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                    
                    BSButton {
                        id: quitNoSaveButton
                        objectName: "ui--navigation:bsbutton:level_1"
                        bsInnerColor: Theme.colors.warning
                        text: isInGame ? L10n.strings.buttons.savenoquit : L10n.strings.buttons.quit
                        callback: function() {
                            BlackMesaEngine.executeClientCommandUnrestricted("quit");
                        }
                        onClicked: {
                            BlackMesaEngine.executeClientCommandUnrestricted("quit");
                        }
						
                        Keys.onLeftPressed: { return; }
                        Keys.onRightPressed: { return; }
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                    
                    BSButton {
                        id: quitButton
                        objectName: "ui--navigation:bsbutton:level_1"
                        text: L10n.strings.buttons.back
                        callback: function() { goBack(); }
                        onClicked: { goBack();  }
						
                        Keys.onLeftPressed: { return; }
                        Keys.onRightPressed: { return; }
						Keys.onPressed: {
							if ( event.key === Qt.Key_Escape || event.key === Qt.Key_Backspace ) {
								Sound.playEffect("sndclick"); goBack(); return;
							}
						}
                    }
                    
                    
                    
                
            }   //buttonsContainer
            
            
        }   //root
            
    
    
}
