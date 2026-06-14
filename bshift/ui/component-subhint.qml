import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import CrowbarCollective 1.0

Item { id: container
    property string hintButtonText: "A"
    property string hintTextText: "Action"

    property color hintButtonColor: Theme.colors.text
    property color hintTextColor: Theme.colors.text

    property int hintButtonHeight: Math.ceil(34 * Theme.heightScale)
    property int hintTextMargin: Math.ceil(4 * Theme.heightScale)
	
    property int hintTextHeight: Math.ceil(24 * Theme.heightScale)
	
	property bool isHintVisible: true

	clip: true
	
    height: hintButtonHeight + Math.ceil(35 * Theme.heightScale)
    width: isHintVisible ? ( hintButton.width + ( hintTextMargin * 5 ) + hintText.width ) : 0
	
	opacity: isHintVisible ? 1 : 0
	
	Behavior on width {
		NumberAnimation { duration: 100; easing.type: Easing.OutQuint }
	}
	
	Behavior on opacity {
		OpacityAnimator { duration: 100; easing.type: Easing.OutQuint }
	}

    Text { id: hintButton
        text: container.hintButtonText
		color: hintButtonColor
        font.family: Theme.fonts.controlsIconsHints
        font.pixelSize: hintButtonHeight
    }
	
    Text { id: hintText
        text: container.hintTextText
		color: hintTextColor
        font.family: Theme.fonts.regular
        font.pixelSize: hintTextHeight
		anchors.left: hintButton.right
		anchors.leftMargin: hintTextMargin
		anchors.verticalCenter: hintButton.verticalCenter
		anchors.verticalCenterOffset: Math.ceil(3 * Theme.heightScale)
    }
}
