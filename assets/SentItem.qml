import bb.cascades 1.2

Container {
    horizontalAlignment: HorizontalAlignment.Fill

    property string title: "Screenshot attempted!"
    property string time: "4 minutes ago"
    property string status: "screenshotH"
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
        layout: DockLayout {

        }
        topPadding: 10
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
                    text: title
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
                    text: "    " + time
                }
            }
            ImageButton {
                defaultImageSource: "asset:///images/" + status + ".png"
                pressedImageSource: defaultImageSource
                verticalAlignment: VerticalAlignment.Center
            }
        }
        Divider {
            verticalAlignment: VerticalAlignment.Bottom
        }
    }
}