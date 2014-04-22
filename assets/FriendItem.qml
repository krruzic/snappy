import bb.cascades 1.2

Container {
    property string friend: "teamsnapchat"
    property bool added: false
    horizontalAlignment: HorizontalAlignment.Fill

    Container {
        attachedObjects: [
            TextStyleDefinition {
                id: lightStyle
                base: SystemDefaults.TextStyles.BodyText
                fontWeight: FontWeight.W300
            }
        ]
        horizontalAlignment: HorizontalAlignment.Fill
        background: Color.create("#a2ffffff")
        topPadding: 10
        layout: DockLayout {

        }
        Container {
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            leftPadding: 20
            rightPadding: 20
            bottomPadding: 15
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 3
                }
                Label {
                    textStyle.base: lightStyle.style
                    textStyle.fontWeight: FontWeight.Bold
                    textStyle.fontSize: FontSize.PointValue
                    textFit.maxFontSizeValue: 8.0
                    textFit.minFontSizeValue: 8.0
                    text: friend
                    topMargin: 0
                    bottomMargin: 0
                }
                Label {
                    topMargin: 0
                    bottomMargin: 0
                    textStyle.fontSize: FontSize.PointValue
                    textFit.maxFontSizeValue: 8.0
                    textFit.minFontSizeValue: 8.0
                    textStyle.base: lightStyle.style
                    text: "    Wants to add you as a friend!"
                }
            }
            ImageButton {
                id: addFriendButton
                enabled: !added
                defaultImageSource: "asset:///images/addFriend.png"
                pressedImageSource: "asset:///images/addFriendP.png"
                disabledImageSource: "asset:///images/addFriendD.png"
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Center
                onClicked: {
                    Tart.send('addFriend', {
                            'user': friend
                        });
                    addFriendButton.enabled = false;
                }
            }
        }
        Divider {
            verticalAlignment: VerticalAlignment.Bottom
        }
    }
}