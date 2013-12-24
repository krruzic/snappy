import bb.cascades 1.2
import "tart.js" as Tart
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
    Container {
        background: background.imagePaint
        attachedObjects: [
            ImagePaintDefinition {
                id: background
                imageSource: "asset:///images/background.png"
            }
        ]
        Container {
            maxHeight: 240
            horizontalAlignment: HorizontalAlignment.Fill
            layout: DockLayout {
                // orientation: LayoutOrientation.LeftToRight
            }
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                ImageView {
                    maxWidth: 240
                    imageSource: "asset:///images/city.png"
                    scalingMethod: ScalingMethod.AspectFit
                    horizontalAlignment: HorizontalAlignment.Left
                    loadEffect: ImageViewLoadEffect.FadeZoom
                }
                ImageButton {
                    defaultImageSource: "asset:///images/sendButton.png"
                    maxWidth: 240
                }
                ImageButton {
                    defaultImageSource: "asset:///images/editButton.png"
                    maxWidth: 240
                }
            }
        }
        Container {
            layoutProperties: StackLayoutProperties {
                spaceQuota: 3
            }
            Label {
                text: "SEND TO:"
                textStyle.fontWeight: FontWeight.Bold
                textStyle.fontSize: FontSize.PointValue
                textFit.maxFontSizeValue: 10.0
                textFit.minFontSizeValue: 10.0
                textStyle.color: Color.Black
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
                        Container {
                            background: Color.create("#47ffffff")
                            layout: DockLayout {
                            }
                            minHeight: layoutT.layoutFrame.height
                            minWidth: layoutT.layoutFrame.width

                            Container {
                                rightPadding: 20
                                leftPadding: 20
                                minHeight: 100
                                layout: DockLayout {
                                }
                                horizontalAlignment: HorizontalAlignment.Fill
                                Label {
                                    horizontalAlignment: HorizontalAlignment.Left
                                    verticalAlignment: VerticalAlignment.Center
                                    id: user
                                    text: ListItemData.user
                                    textStyle.color: Color.Black
                                }
                                CheckBox {
                                    horizontalAlignment: HorizontalAlignment.Right
                                    verticalAlignment: VerticalAlignment.Center

                                    id: checkBox
                                }
                                Divider {
                                    verticalAlignment: VerticalAlignment.Bottom
                                }
                            }
                        }

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