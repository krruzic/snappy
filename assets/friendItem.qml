import bb.cascades 1.2
Container {
    horizontalAlignment: HorizontalAlignment.Fill

    property string friend: "teamsnapchat"
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        layout: DockLayout {
        }
        background: Color.create("#a2ffffff")
        leftPadding: 20
        rightPadding: 20
        topPadding: 10
        bottomPadding: 10
        Container {
            Label {
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
                text: "    Wants to add you as a friend!"
            }
        }
        ImageButton {
            defaultImageSource: "asset:///images/addFriend.png"
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Center
            onClicked: {
                Tart.send('addFriend', {
                        'user': friend
                    })
            }
        }
    }
    Divider {

    }
}