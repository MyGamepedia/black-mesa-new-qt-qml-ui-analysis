import QtQuick 2.9
import CrowbarCollective 1.0

Item { id: carouselItem
    objectName: "ui--navigation:carousel:level_2"
    property bool isLocked: false

    // data-based properties that should really be on some data object
    property string chapterName: "DEFAULT CHAPTER NAME"
    property string thumbnailUrl: "image://game/ui/images/carousel/background-reception" + Theme.setImgDef
    property string thumbnailNewSave: "image://game/ui/images/carousel/newSaveThumbnail" + Theme.setImgDef
    property string buttonText: "DEFAULT BUTTON TEXT"
    property string buttonTextSecondary: "DEFAULT BUTTON TEXT"
    property string buttonType: "bsstart"
    property string buttonTypeSecondary: "bsdelete"

    property bool secondaryButtonVisible: false

    property Component textComponent

    signal selected()
    signal selectedWithDoubleClick()

    signal selectedSecondary()

    width: itemWidth
    height: itemHeight

    anchors.left: parent.left

    property int itemWidth: Math.ceil(1100 * Theme.widthScale)
    property int itemHeight: Math.ceil(224 * Theme.heightScale)
    
    property int verticalSpacing: Math.ceil(18 * Theme.heightScale)
    property int horizontalSpacing: Math.ceil(18 * Theme.widthScale)
    
    property int leftButtonSpacing: Math.ceil(20 * Theme.widthScale)
    property int bottomButtonSpacing: Math.ceil(22 * Theme.heightScale)
    
    property int thumbnailBottomMargin: Math.ceil(5 * Theme.heightScale)
    property int thumbnailHeight: Math.ceil(540 * Theme.heightScale)
    property int thumbnailWidth: Math.ceil(1100 * Theme.widthScale)
    
    property int leftPreviewMargin: Math.ceil(580 * Theme.widthScale)
    property int rightPreviewMargin: Math.ceil(140 * Theme.heightScale)
    property int previewWidth: Math.ceil(380 * Theme.heightScale)
    
    
    property color bsOuterColor: Theme.colors.bssecondaryhighlight
    property real bsOuterOpacity: Theme.opacity.bsSecondary
    
    property int topRectMargin: Math.ceil(6 * Theme.heightScale)
    property int bottomRectMargin: Math.ceil(4 * Theme.heightScale)
    
    
    
    
    

    property var callback: function() {
        carouselItem.selectedWithDoubleClick();
    }

    Item {
        anchors.fill: parent

        
        
        Item {
            id: thumbnailContainer
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            
            anchors.topMargin: topRectMargin
            anchors.bottomMargin: bottomRectMargin
            

            height: thumbnailHeight
            width: thumbnailWidth

        // Backdrop Hover
            Image {
                id: backdrop
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop

				cache: false
				asynchronous: true
				visible: status == Image.Ready
				
                source: "image://game/ui/images/carousel/backdrop_save_hover" + Theme.setImgDef

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 150
                    }
                }
            }

        // Backdrop Blurred
            Image {
                id: backdropSave
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop

				cache: false
				asynchronous: true
				visible: status == Image.Ready
				
                source: "image://game/ui/images/carousel/backdrop_save_blurred" + Theme.setImgDef

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 150
                    }
                }
            }
            
        Item {  id: previewContainer
            anchors.left: parent.left
            anchors.leftMargin: ( thumbnailUrl == thumbnailNewSave) ? 0 : leftPreviewMargin
            anchors.top: parent.top
            width:  ( thumbnailUrl == thumbnailNewSave) ? parent.width : previewWidth
            height: parent.height
            
        // Thumbnail
            Image {
                id: thumbnail
                anchors.fill: parent
                source: carouselItem.thumbnailUrl
                fillMode: Image.PreserveAspectCrop

                opacity: 0.7

				cache: false
				asynchronous: true
				visible: status == Image.Ready
				
                //onStatusChanged: if (status === Image.Ready) opacity = 0.7

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 150
                    }
                }
            }
        }
			
			Rectangle { id: border
				anchors.centerIn: parent
				anchors.horizontalCenterOffset: Math.ceil(0 * Theme.heightScale)

				rotation: -90
				
				width: parent.height
				height: parent.width
				
					gradient: Gradient {
						GradientStop { position: 0; color: "transparent" }
						GradientStop { position: 1; color: "transparent" }
					}
				
				Rectangle { id: topShape
					anchors.top: parent.top
					anchors.right: parent.right
					
					anchors.rightMargin: 0 - topRectMargin
					
					width: Math.ceil(12 * Theme.heightScale)
					height: parent.height
					
					gradient: Gradient {
						GradientStop { position: 0.05; color: "transparent" }
						GradientStop { position: 0.53; color: bsOuterColor }
						GradientStop { position: 0.87; color: bsOuterColor }
						GradientStop { position: 0.95; color: "transparent" }
					}
					
						Behavior on opacity {
							OpacityAnimator {
								duration: 150
							}
						}
				}

				Rectangle { id: bottomShape
					anchors.top: parent.top
					anchors.left: parent.left
					anchors.leftMargin: 0 - bottomRectMargin
					
					width: Math.ceil(8 * Theme.heightScale)
					height: parent.height
					
					gradient: Gradient {
						GradientStop { position: 0.05; color: "transparent" }
						GradientStop { position: 0.53; color: bsOuterColor }
						GradientStop { position: 0.87; color: bsOuterColor }
						GradientStop { position: 0.95; color: "transparent" }
					}
					
						Behavior on opacity {
							OpacityAnimator {
								duration: 150
							}
						}
				}
			}
            
        }

        Loader { id: textComponentLoader
            visible: !isLocked
            anchors.top: parent.top
            anchors.topMargin: verticalSpacing
            anchors.left: parent.left
            anchors.leftMargin: horizontalSpacing

            sourceComponent: textComponent
            onLoaded: mouseArea.state = "blurred"
        }
    }

    Keys.onRightPressed: {
        if (secondaryButtonVisible) {
            selectedSecondary();
        }
    }

    MouseArea { id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        scrollGestureEnabled: false
        enabled: !isLocked
        propagateComposedEvents: true
        state: "blurred"

        states: [
            State {
                name: "blurred"
                when: !carouselItem.activeFocus
                PropertyChanges { target: loader; opacity: 0 }
                PropertyChanges { target: loaderSecondary; opacity: 0 }
                PropertyChanges { target: textComponentLoader; opacity: 1 }
                PropertyChanges { target: textComponentLoader.item; opacity: 0.70 }
                PropertyChanges { target: thumbnail; opacity: 0.7 }
                PropertyChanges { target: backdropSave; opacity: 0.5 }
                PropertyChanges { target: backdrop; opacity: 0 }
                PropertyChanges { target: topShape; opacity: 0 }
                PropertyChanges { target: bottomShape; opacity: 0 }
            },
            State {
                name: "focused"
                when: carouselItem.activeFocus
                PropertyChanges { target: loader; opacity: 1 }
                PropertyChanges { target: loaderSecondary; opacity: 1 }
                PropertyChanges { target: textComponentLoader; opacity: 1}
                PropertyChanges { target: textComponentLoader.item; opacity: 1 }
                PropertyChanges { target: thumbnail; opacity: 1 }
                PropertyChanges { target: backdropSave; opacity: 0 }
                PropertyChanges { target: backdrop; opacity: 1 }
                PropertyChanges { target: topShape; opacity: 0.6 }
                PropertyChanges { target: bottomShape; opacity: bsOuterOpacity }
                StateChangeScript {
                    script: { Sound.playEffect("sndfocus"); }
                }
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
						
						onSelectionChanged( carouselItem.saveType );
					}
				}
			}
		]

        onEntered: {
			if ( state === "focused" ) {
				state = "focused"
			} else {
				state = "focused"
				forceActiveFocus();
			}
        }

        onExited: {
            state = "blurred"
        }

        onDoubleClicked: {
            carouselItem.selectedWithDoubleClick();
        }

        Loader { id: loader
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: leftButtonSpacing
            anchors.bottomMargin: bottomButtonSpacing

            Component.onCompleted: {
                loader.setSource("button-" + buttonType + ".qml")
            }

            onLoaded: {
                item.text = carouselItem.buttonText;
                item.clicked.connect(function () { carouselItem.selected(); });
            }
        }

        Loader { id: loaderSecondary
            anchors.bottom: parent.bottom
            anchors.left: loader.right
            anchors.leftMargin: horizontalSpacing
            anchors.bottomMargin: bottomButtonSpacing

            visible: carouselItem.secondaryButtonVisible

            Component.onCompleted: {
                loaderSecondary.setSource("button-" + buttonTypeSecondary + ".qml")
            }

            onLoaded: {
                item.text = carouselItem.buttonTextSecondary;
                item.clicked.connect(function () { carouselItem.selectedSecondary(); });
            }
        }
    }
}
