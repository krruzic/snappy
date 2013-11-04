import bb.cascades 1.0
import "tart.js" as Tart

NavigationPane {
    Page {
        id: snapPage
        onCreationCompleted: {
            Tart.register(snapPage);
        }
        function onLoginChecked(data) {
            console.log("LOGIN CHECKED!!")
            if (data.login == 'true')
                Tart.send('requestFeed');
            else 
                loginSheet.open();
        }

        function onSnapsReceived(data) {
            activity.visible = false;
            var currType = data.snap['type']; // Keep track of the current snap type
            if (currType != prevType) { // If our new item is a different type than the last one,
                insertHeader(currType); // Append a header
            }
            snapModel.append({ // Append an item with the necessary info
                    type: 'item', //+ String(currType), // Allows easy appending of different items
                    snapStatus: data.snap['title'],
                    snapTime: data.snap['time'],
                    snapType: data.snap['media'],
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
                visible: false
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
            ActivityIndicator {
                id: activity
                running: true
                visible: true
                minHeight: 400
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
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
    attachedObjects: [
        LoginSheet {
            id: loginSheet
        }
    ]
}

//NavigationPane {
//peekEnabled: false
//id: root
//function onLoginChecked(data) {
//login.activity.visible = false;
//if (data.value == "true") {
//var page = snapPage.createObject();
//root.push(page);
//}
//}
//Page {
//id: login
//actionBarVisibility: ChromeVisibility.Hidden
//property alias activity: activity
//function onLoginResult(data) {
//activity.visible = false;
//if (data.value == 'true') {
//var page = snapPage.createObject();
//root.push(page);
//} else {
//errorLabel.opacity = 1;
//}
//}
////    titleBar: SnappyTitleBar {
////        text: "Snappy"
////    }
//Container {
//layout: DockLayout {
//}
//background: background.imagePaint
//Container {
//leftPadding: 40
//rightPadding: 40
//horizontalAlignment: HorizontalAlignment.Center
//verticalAlignment: VerticalAlignment.Center
//Label {
//horizontalAlignment: HorizontalAlignment.Center
//verticalAlignment: VerticalAlignment.Center
//text: "Welcome to Snappy"
//autoSize.maxLineCount: 1
//textStyle.color: Color.White
//textStyle.textAlign: TextAlign.Center
//textStyle.fontSize: FontSize.PointValue
//textStyle.fontStyle: FontStyle.Italic
//textStyle.fontSizeValue: 13
//}
//Label {
//horizontalAlignment: HorizontalAlignment.Center
//verticalAlignment: VerticalAlignment.Center
//text: "Sign into your snapchat account to get started"
//multiline: true
//autoSize.maxLineCount: 2
//textStyle.color: Color.White
//textStyle.textAlign: TextAlign.Center
//textStyle.fontSize: FontSize.PointValue
//textStyle.fontStyle: FontStyle.Italic
//textStyle.fontSizeValue: 9
//}
//TextField {
//id: usernameField
//topMargin: 20
//hintText: "Username"
//}
//TextField {
//id: passwordField
//hintText: "Password"
////                input.onSubmitted: {
////                    errorLabel.opacity = 0;
////                    Tart.send('login', {
////                            'username': usernameField.text,
////                            'password': passwordField.text
////                        });
////                }
//}
//Label {
//id: errorLabel
//opacity: 0
//horizontalAlignment: HorizontalAlignment.Center
//verticalAlignment: VerticalAlignment.Center
//textStyle.textAlign: TextAlign.Center
//text: "Incorrect username/password, please try again"
//multiline: true
//textStyle.fontSize: FontSize.PointValue
//textStyle.fontSizeValue: 7
//textStyle.color: Color.create("#ffed1515")
//}
//Button {
//horizontalAlignment: HorizontalAlignment.Center
//verticalAlignment: VerticalAlignment.Center
//text: "Login"
//onClicked: {
//errorLabel.opacity = 0; // hide the error label
//activity.visible = true; // show the indicator
//Tart.send('login', { // send a login request
//'username': usernameField.text,
//'password': passwordField.text
//});
//}
//}
//}
//ActivityIndicator {
//id: activity
//horizontalAlignment: HorizontalAlignment.Center
//verticalAlignment: VerticalAlignment.Center
//running: activity.visible
//visible: false
//minHeight: 400
//minWidth: 400
//}
//}
//attachedObjects: [
//ImagePaintDefinition {
//id: background
//imageSource: "asset:///images/city.png"
//}
//]
//onCreationCompleted: {
//login.activity.visible = true;
////Tart.debug = true;
//Tart.init(_tart, Application);
//
//Tart.register(root);
//Tart.send('uiReady');
//}
//}
//onPopTransitionEnded: {
//// Destroy the popped Page once the back transition has ended.
//page.destroy();
//}
//onPushTransitionEnded: {
//if (page.objectName == 'snapPage') {
//Tart.send('requestFeed')
//}
//}
//}
