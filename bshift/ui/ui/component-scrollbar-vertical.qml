import QtQuick 2.9
import QtQuick.Controls 2.2
import CrowbarCollective 1.0

ScrollBar {
    visible: true
    policy: ScrollBar.AlwaysOn
    wheelEnabled: true
    property int scrollbarDimension: Math.floor(10 * Theme.heightScale)
	
    property color bsInnerColor: Theme.colors.highlight






    contentItem: Rectangle { 
			implicitWidth: scrollbarDimension
			implicitHeight: scrollbarDimension
            opacity: 0.8
            
            gradient: Gradient {
                GradientStop { position: 0; color: "transparent" }
                GradientStop { position: 0.08; color: "transparent" }
                GradientStop { position: 0.35; color: bsInnerColor }
                GradientStop { position: 0.65; color: bsInnerColor }
                GradientStop { position: 0.92; color: "transparent" }
                GradientStop { position: 1; color: "transparent" }
            }
        }
        
        
        
        
        
        
}
