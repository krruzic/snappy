import bb.cascades 1.2
//import "tart.js" as Tart
Page {
    id: sendPage
    actionBarVisibility: ChromeVisibility.Hidden
    property string imageLocation: ""
//    actions: ActionItem {
//        title: "Send"
//        ActionBar.placement: ActionBarPlacement.OnBar
//        onTriggered: {
//            var indexPath = new Array();
//            for (var i = 0; i < friendDataModel.size(); i ++) {
//                var receipents = []
//                indexPath[0] = i
//                var selectedItem = friendDataModel.data(indexPath);
//                if (selectedItem.checkBox.checked)
//                    receipents.append(selectedItem.user.text)
//            }
//            Tart.send('sendImage', {
//                    image: imageLocation,
//                    users: receipents
//                });
//        }
//    }
    onCreationCompleted: {
        Tart.register(sendPage);
    }
    onImageLocationChanged: {
        Tart.send('getFriends')
    }
    function onFriends(data) {
        friendDataModel.append({
                type: 'item', //+ String(currType), // Allows easy appending of different items
                user: data.name
            });
    }
    titleBar: SnappyTitleBar {
        text: "Friends"
        b1.onClicked: {
            
        }
    }
    Container {
        background: background.imagePaint
        attachedObjects: [
            ImagePaintDefinition {
                id: background
                imageSource: "asset:///images/backgroundP.amd"
                repeatPattern: RepeatPattern.XY
            }
        ]

        Container {
            layoutProperties: StackLayoutProperties {
                spaceQuota: 3
            }
            ListView {
                dataModel: ArrayDataModel {
                    id: friendDataModel
                }
                id: friendList
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 2
                }
                function itemType(data, indexPath) {
                    return data.type
                }

                listItemComponents: [
                    ListItemComponent {
                        type: 'item'


                    }
                ]
            }
        }
    }
}
//    Container {
//        layout: DockLayout {
//        }
//        attachedObjects: [
//            LayoutUpdateHandler {
//                id: layoutT
//            }
//        ]
//        Container {
//            layout: DockLayout {
//            }
//            minHeight: layoutT.layoutFrame.height
//            minWidth: layoutT.layoutFrame.width
//
//
//            ImageView {
//                horizontalAlignment: HorizontalAlignment.Fill
//                verticalAlignment: VerticalAlignment.Fill
//                rotationZ: -90
//                imageSource: imageLocation
//                scalingMethod: ScalingMethod.AspectFit
//                loadEffect: ImageViewLoadEffect.None
//
//            }
//        }
//}