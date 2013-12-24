import bb.cascades 1.0
import "tart.js" as Tart

NavigationPane {
    id: nav
    property variant selectedItem: null
    property int countDown: 0
    onPopTransitionEnded: {
        page.destroy();
        Application.menuEnabled = ! Application.menuEnabled;
    }
    Page {
        id: snapPage
        onCreationCompleted: {
            Tart.register(snapPage);
        }
        function onLoginChecked(data) {
            console.log("LOGIN CHECKED!!")
            if (data.login == 'true')
                Tart.send('login');
            else
                loginSheet.open();
        }

        function onSnapsReceived(data) {
            activity.visible = false;
            snapModel.append({ // Append an item with the necessary info
                    type: 'item',  // Allows easy appending of different items
                    snapStatus: data.snap['media'],
                    snapTime: data.snap['time'],
                    snapType: data.snap['type'],
                    snapUser: data.snap['user'],
                    snapURL: data.snap['url'],
                    snapView: data.snap['countdown']
                });
        }

        function onSnapData(data) {
            console.log('Snap downloaded. Snap image ' + data.imageSource);
            var page = detailsPage.createObject();
            page.imageSource = data.imageSource;
            page.currentCount = countDown;
            nav.push(page);
        }

        //        function snapCountdown(item, start) {
        //            qtimer
        //        }
        titleBar: SnappyTitleBar {
        }

        Container {
            background: background.imagePaint
            Container {

                layout: DockLayout {
                }

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
                preferredWidth: Infinity.MAX_VALUE

                onTriggered: {
                    var selectedItem = dataModel.data(indexPath);
                    countDown = parseInt(selectedItem.snapView)
                    Tart.send('requestImage', {
                            source: selectedItem.snapURL
                        });
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
                            snapView: ListItemData.snapView
                            //snapSelectable: ListItemData.snapSelectable
                        }
                    }
                ]

            }
            ImageButton {
                maxHeight: 100
                maxWidth: 100
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Bottom
                defaultImageSource: "asset:///images/cam.png"
                pressedImageSource: "asset:///images/cam.png"
                onClicked: {
                    var page = cameraPage.createObject();
                    nav.push(page);
                }
            }

        }
    }
    attachedObjects: [
        LoginSheet {
            id: loginSheet
        },
        ComponentDefinition {
            id: detailsPage
            source: "DetailsPage.qml"
        },
        ComponentDefinition {
            id: cameraPage
            source: "CameraPage.qml"
        },
        ComponentDefinition {
            id: sendPage
            source: "SendPage.qml"
        },
        ImagePaintDefinition {
            id: background
            imageSource: "asset:///images/background.png"
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
