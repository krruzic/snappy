import bb.cascades 1.2
import "tart.js" as Tart
Page {
    id: sendPage
    property string imageLocation: ""
    actions: ActionItem {
        title: "Send"
        ActionBar.placement: ActionBarPlacement.OnBar
        onTriggered: {
            var indexPath = new Array();
            for (var i = 0; i < friendDataModel.size(); i ++) {
                var receipents = []
                indexPath[0] = i
                var selectedItem = friendDataModel.data(indexPath);
                if (selectedItem.checkBox.checked)
                    receipents.append(selectedItem.user.text)
            }
            Tart.send('sendImage', {
                    image: imageLocation,
                    users: receipents
                });
        }
    }
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
        layout: DockLayout {
        }
        background: background.imagePaint
        attachedObjects: [
            ImagePaintDefinition {
                id: background
                imageSource: imageLocation
            },
            LayoutUpdateHandler {
                id: layoutT
            }
        ]
        Container {
            layout: DockLayout {
            }
            minHeight: layoutT.layoutFrame.height
            minWidth: layoutT.layoutFrame.width

            background: Color.create("#47ffffff")
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