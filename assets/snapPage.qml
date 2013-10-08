import bb.cascades 1.0
import "tart.js" as Tart

Page {
    function onSnapsExist(data) { // If we have snaps add the snaps header
        snapModel.append({
                type: 'header',
                title: 'Snaps'
            });
    }
    function onReceiveSnaps(data) {
        var currType = data.snap['type']; // Keep track of the current snap type
        if (currType != prevType) { // If our new item is a different type than the last one,
            insertHeader(currType); // Append a header
        }
        snapModel.append({ // Append an item with the necessary info
                type: 'item', //+ String(currType), // Allows easy appending of different items
                snapStatus: data.snap['title'],
                snapTime: data.snap['time'],
                snapType: data.snap['type'],
                snapUser: data.snap['user'],
                snapURL: data.snap['url']
            });
        var prevType = data.snap['type'];
    }
    function insertHeader(type) { // Just checks which type we are about to insert
        if (type == 2) { // It will never be 1 since we insert that first
            snapModel.append({
                    type: 'header',
                    title: 'Sent'
                });
        } else if (type == 3) {
            snapModel.append({
                    type: 'header',
                    title: 'Notifications'
                });
        }
    }
    titleBar: SnappyTitleBar {
        text: "Snappy"
    }

    Container {
        layout: DockLayout {

        }
        Container {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            Label {
                textStyle.textAlign: TextAlign.Center
                text: "Sorry, you have no snaps :("
            }
            Button {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                text: "Send one?"
            }
        }
        ListView {
            dataModel: ArrayDataModel {
                id: snapModel
            }
            function itemType(data, indexPath) {
                return data.type
            }
            listItemComponents: [
                ListItemComponent {
                    type: 'item'
                    SnapItem {
                        id: recievedItem
                        snapStatus: ListItemData.snapStatus
                        snapTime: ListItemData.snapTime
                        snapType: ListItemData.snapType
                        snapUser: ListItemData.snapUser
                        snapURL: ListItemData.snapURL // URL the snap resides in (fetch this onTriggered)
                    }
                },
                ListItemComponent {
                    type: 'header'
                    Header {
                        id: headerItem
                        title: ListItemData.title
                    }
                },
                ListItemComponent {
                    SnapItem {
                        id: sentItem
                    }
                }
            ]
        }
    }
}
