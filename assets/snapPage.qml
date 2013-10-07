import bb.cascades 1.0
import "tart.js" as Tart

Page {
    function onReceiveSnaps(data) {
        snapModel.append({
                type: 'item',
                snapStatus: data.snap['title'],
                snapTime: data.snap['time'],
                snapType: data.snap['type'],
                snapUser: data.snap['user'],
                snapURL: data.snap['url']
        });
    }
    Container {
        ListView {
            dataModel: ArrayDataModel {
                id: snapModel
            }
            listItemComponents: [
                ListItemComponent {
                    SnapItem {
                        snapStatus: ListItemData.snapStatus 
                        snapTime: ListItemData.snapTime
                        snapType: ListItemData.snapType
                        snapUser: ListItemData.snapUser
                        snapURL: ListItemData.snapURL // URL the snap resides in (fetch this onTriggered)
                    }
                }
            ]
        }
    }
}
