import bb.cascades 1.2

Container {
    property string snapStatus: "picture"
    property string snapTime: "4 mins ago"
    property string snapType: "picture"
    property string snapUser: "madk"
    property string snapURL: "invisible" // URL to the snap (not visible)
    property int snapView: 3 // time you can view the snap for
    property string snapSelectable: "true" // can you view this snap?

    layout: DockLayout {
    }
    background: Color.create("#47ffffff")
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Top
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        Container {
            //background: Color.Red
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Fill
            rightMargin: 20
            ImageView {
                imageSource: "asset:///images/" + snapStatus + ".png"
            }
        }
        Container {
            verticalAlignment: VerticalAlignment.Fill
//            background: Color.Blue
            layoutProperties: StackLayoutProperties {
                spaceQuota: 3
            }
            horizontalAlignment: HorizontalAlignment.Fill
            Label {
                textStyle.color: Color.Black
                textStyle.fontWeight: FontWeight.Bold
                textStyle.fontSize: FontSize.PointValue
                textFit.maxFontSizeValue: 6.0
                textFit.minFontSizeValue: 6.0
                text: snapUser
                topMargin: -10
                bottomMargin: -10
            }
            Label {
                text: snapTime + " - " + snapType
                topMargin: -10
                bottomMargin: -10
                textStyle.fontSize: FontSize.PointValue
                textFit.maxFontSizeValue: 6.0
                textFit.minFontSizeValue: 6.0
                textStyle.color: Color.Black
            }
        }
        Container {
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Top
            rightPadding: 10
            layout: DockLayout {
            }
            Label {
                verticalAlignment: VerticalAlignment.Top
                horizontalAlignment: HorizontalAlignment.Right
                textStyle.textAlign: TextAlign.Right
                text: snapView
                textStyle.fontSize: FontSize.PointValue
                textFit.maxFontSizeValue: 6.0
                textFit.minFontSizeValue: 6.0
                textStyle.color: Color.Black
            }
        }
    }
    Divider {
        verticalAlignment: VerticalAlignment.Bottom
    }
}
