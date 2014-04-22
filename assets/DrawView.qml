import bb.cascades 1.2

Page {
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        background: Color.White
        leftPadding: 20
        rightPadding: 10
        layout: StackLayout {
        }

        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {

                layoutProperties: StackLayoutProperties {
                    spaceQuota: 3
                }
                Label {
                    text: "Here is an example article, long title and stuff.  "
                    multiline: true
                    textStyle.fontWeight: FontWeight.Light
                    topMargin: 0
                    bottomMargin: 0
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 7
                    attachedObjects: [
                        LayoutUpdateHandler {
                            id: mainDimensions
                        }
                    ]
                }
                Label {
                    topMargin: 0
                    bottomMargin: 0
                    text: "reddit.com"
                    multiline: true
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 6
                    textStyle.color: Color.DarkGray
                }
                Container {
                    maxWidth: mainDimensions.layoutFrame.width
                    minWidth: mainDimensions.layoutFrame.width
                    horizontalAlignment: HorizontalAlignment.Fill
                    layout: DockLayout {
                    }
                    Label {
                        text: "3 hours ago"
                        textStyle.fontSize: FontSize.PointValue
                        textStyle.fontSizeValue: 6

                    }
                    Label {
                        textStyle.color: Color.create("#ff8c00")
                        horizontalAlignment: HorizontalAlignment.Right
                        text: "madk"
                        textStyle.textAlign: TextAlign.Right
                        textStyle.fontSize: FontSize.PointValue
                        textStyle.fontSizeValue: 6

                    }
                }
            }
            Label {
                text: "▴ 45 | 89 ▰"
                translationY: 10
                textStyle.color: Color.DarkGray
                horizontalAlignment: HorizontalAlignment.Right
                textStyle.fontStyle: FontStyle.Italic
                textStyle.fontSize: FontSize.PointValue
                textStyle.fontSizeValue: 6
            }
        }
        Divider {
            translationX: 80
        }

    }
}
