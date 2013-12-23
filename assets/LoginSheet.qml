import bb.cascades 1.0
import "tart.js" as Tart

Sheet {
    id: loginSheet
    onCreationCompleted: {
        Tart.register(loginSheet);
    }
    function onLoginResult(data) {
        loginButton.enabled = true;
        console.log(data.value);
        if (data.value == 'true') {
            loginSheet.close();
        } if (data.value == 'false') {
            activity.visible = false;
            errorLabel.opacity = 1;
        }
    }
    peekEnabled: false
    Page {

        Container {
            layout: DockLayout {
            }
            background: background.imagePaint
            Container {
                leftPadding: 40
                rightPadding: 40
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                Label {
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    text: "Welcome to Snappy"
                    autoSize.maxLineCount: 1
                    textStyle.color: Color.White
                    textStyle.textAlign: TextAlign.Center
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontStyle: FontStyle.Italic
                    textStyle.fontSizeValue: 13
                }
                Label {
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    text: "Sign into your snapchat account to get started"
                    multiline: true
                    autoSize.maxLineCount: 2
                    textStyle.color: Color.White
                    textStyle.textAlign: TextAlign.Center
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontStyle: FontStyle.Italic
                    textStyle.fontSizeValue: 9
                }
                TextField {
                    id: usernameField
                    topMargin: 20
                    hintText: "Username"
                }
                TextField {
                    id: passwordField
                    hintText: "Password"
                    inputMode: TextFieldInputMode.Password
                    //                input.onSubmitted: {
                    //                    errorLabel.opacity = 0;
                    //                    Tart.send('login', {
                    //                            'username': usernameField.text,
                    //                            'password': passwordField.text
                    //                        });
                    //                }
                }
                Label {
                    id: errorLabel
                    opacity: 0
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.textAlign: TextAlign.Center
                    text: "Incorrect username/password, please try again"
                    multiline: true
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 7
                    textStyle.color: Color.create("#ffed1515")
                }
                Button {
                    id: loginButton
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    text: "Login"
                    onClicked: {
                        enabled = false;
                        errorLabel.opacity = 0; // hide the error label
                        activity.visible = true; // show the indicator
                        Tart.send('login', { // send a login request
                                'username': usernameField.text,
                                'password': passwordField.text
                            });
                    }
                }
            }
            ActivityIndicator {
                id: activity
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                running: activity.visible
                visible: false
                minHeight: 400
                minWidth: 400
            }
        }
        attachedObjects: [
            ImagePaintDefinition {
                id: background
                imageSource: "asset:///images/city.png"
            }
        ]

    }
}
//Page {
//    property alias activity: activity
//    function onLoginResult(data) {
//        activity.visible = false;
//        if (data.value == 'true') {
//            var page = snapPage.createObject();
//            root.push(page);
//        } else {
//            errorLabel.opacity = 1;
//        }
//    }
//    //    titleBar: SnappyTitleBar {
//    //        text: "Snappy"
//    //    }
//    Container {
//        layout: DockLayout {
//        }
//        background: background.imagePaint
//        Container {
//            leftPadding: 40
//            rightPadding: 40
//            horizontalAlignment: HorizontalAlignment.Center
//            verticalAlignment: VerticalAlignment.Center
//            Label {
//                horizontalAlignment: HorizontalAlignment.Center
//                verticalAlignment: VerticalAlignment.Center
//                text: "Welcome to Snappy"
//                autoSize.maxLineCount: 1
//                textStyle.color: Color.White
//                textStyle.textAlign: TextAlign.Center
//                textStyle.fontSize: FontSize.PointValue
//                textStyle.fontStyle: FontStyle.Italic
//                textStyle.fontSizeValue: 13
//            }
//            Label {
//                horizontalAlignment: HorizontalAlignment.Center
//                verticalAlignment: VerticalAlignment.Center
//                text: "Sign into your snapchat account to get started"
//                multiline: true
//                autoSize.maxLineCount: 2
//                textStyle.color: Color.White
//                textStyle.textAlign: TextAlign.Center
//                textStyle.fontSize: FontSize.PointValue
//                textStyle.fontStyle: FontStyle.Italic
//                textStyle.fontSizeValue: 9
//            }
//            TextField {
//                id: usernameField
//                topMargin: 20
//                hintText: "Username"
//            }
//            TextField {
//                id: passwordField
//                hintText: "Password"
//                //                input.onSubmitted: {
//                //                    errorLabel.opacity = 0;
//                //                    Tart.send('login', {
//                //                            'username': usernameField.text,
//                //                            'password': passwordField.text
//                //                        });
//                //                }
//            }
//            Label {
//                id: errorLabel
//                opacity: 0
//                horizontalAlignment: HorizontalAlignment.Center
//                verticalAlignment: VerticalAlignment.Center
//                textStyle.textAlign: TextAlign.Center
//                text: "Incorrect username/password, please try again"
//                multiline: true
//                textStyle.fontSize: FontSize.PointValue
//                textStyle.fontSizeValue: 7
//                textStyle.color: Color.create("#ffed1515")
//            }
//            Button {
//                horizontalAlignment: HorizontalAlignment.Center
//                verticalAlignment: VerticalAlignment.Center
//                text: "Login"
//                onClicked: {
//                    errorLabel.opacity = 0; // hide the error label
//                    activity.visible = true; // show the indicator
//                    Tart.send('login', { // send a login request
//                            'username': usernameField.text,
//                            'password': passwordField.text
//                        });
//                }
//            }
//        }
//        ActivityIndicator {
//            id: activity
//            horizontalAlignment: HorizontalAlignment.Center
//            verticalAlignment: VerticalAlignment.Center
//            running: activity.visible
//            visible: false
//            minHeight: 400
//            minWidth: 400
//        }
//    }
//    attachedObjects: [
//        ImagePaintDefinition {
//            id: background
//            imageSource: "asset:///images/city.png"
//        }
//    ]
//    onCreationCompleted: {
//        Tart.send('login'); // attempt a login right away (saved creds)
//    }
//}
