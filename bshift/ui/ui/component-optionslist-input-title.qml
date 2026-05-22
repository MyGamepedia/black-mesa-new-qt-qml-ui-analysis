import QtQuick 2.9
import CrowbarCollective 1.0

Item { id: optionsTitle
    objectName: "ui--navigation:option-item:level_2"

    state: "blurred"
    states: [
        State {
            name: "focused"
            when: optionsTitle.activeFocus
            PropertyChanges { target: optionsTitle.parent.parent; state: "focused" }
        },
        State {
            name: "blurred"
            when: !optionsTitle.activeFocus
            PropertyChanges { target: optionsTitle.parent.parent; state: "blurred" }
        },
        State {
            name: "disabled"
            PropertyChanges { target: optionsTitle.parent.parent; state: "disabled" }
        }
    ]
	
    transitions: [
        Transition {
            from: "blurred"
            to: "focused"
			
            ScriptAction {
                script: {
				
					if ( appRoot.isLeftMenuFocused ) {
						appRoot.isLeftMenuFocusedFunction( false );
					}
					
					onSelectionChanged(optionRow.model.type);
				}
			}
        }
    ]
}
