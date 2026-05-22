import QtQuick 2.9
import CrowbarCollective 1.0

Item { id: creditsOther
	
    property variant model
    property int labelFontSize: Math.ceil(26 * Theme.heightScale)
    property int nickFontSize: Math.ceil(20 * Theme.heightScale)
    property int aboutTextFontSize: Math.ceil(20 * Theme.heightScale)
    property color textColor: Theme.colors.buttonText
	
	property int paddingVert: Math.ceil(16 * Theme.heightScale)
	property int paddingHoriz: Math.ceil(16 * Theme.widthScale)
	
	property int avatarSize: Math.ceil(64 * Theme.heightScale)
	
    anchors.fill: parent

	Image {
		id: avatarImg
		
		anchors.left: parent.left
		
        anchors.top: parent.top
        anchors.topMargin: Math.ceil(12 * Theme.heightScale)
		
		width: avatarSize
		height: avatarSize
		
		source: "image://game/ui/images/credits/" + ( model.avatar ? model.avatar : "noav" ) + Theme.setImgDef
		
        fillMode: Image.PreserveAspectFit
		asynchronous: true
	}
	
    Text { id: labelText
        text: model && L10n.getString(model.label)

        anchors.top: avatarImg.top
        anchors.topMargin: model.descr ? Math.ceil(-7 * Theme.heightScale) :  Math.ceil(13 * Theme.heightScale)
		
        anchors.left: avatarImg.right
        anchors.leftMargin: paddingHoriz
		
        //anchors.right: parent.right
        //anchors.rightMargin: paddingHoriz

        color: textColor
        font.family: Theme.fonts.regular
        font.pixelSize: labelFontSize
    }
	
	Text { id: subLabelText
		visible: model.nick
        text: model && L10n.getString(model.nick)

        anchors.bottom: labelText.bottom
		
        anchors.left: labelText.right
        anchors.leftMargin: paddingHoriz
		
        //anchors.right: parent.right
        //anchors.rightMargin: paddingHoriz

        color: Theme.colors.texthighlight
        font.family: Theme.fonts.regular
        font.pixelSize: nickFontSize
    }
	
	Item {
		visible: model.descr
        anchors.top: labelText.bottom
        anchors.topMargin: Math.ceil(19 * Theme.heightScale)
		
        anchors.left: avatarImg.right
        anchors.leftMargin: paddingHoriz + Math.ceil(1 * Theme.heightScale)
		
        anchors.right: parent.right
        anchors.rightMargin: paddingHoriz
	
		Text { id: about
			text: model.descr
			
			anchors.fill: parent
			
			verticalAlignment: Text.AlignVCenter
			anchors.verticalCenter: parent.verticalCenter
			
			lineHeight: 0.9
			
			font.pixelSize: aboutTextFontSize
			font.family: Theme.fonts.regular
			wrapMode: Text.WordWrap
			color: textColor
		}
	}
}
