import bb.cascades 1.2

CustomListItem {
    highlightAppearance: HighlightAppearance.Frame
    property string snapStatus: "picture"
    property string snapTime: "4 mins ago"
    property string snapType: "picture"
    property string snapUser: "madk"
    property string snapURL: "invisible" // URL to the snap (not visible)
    Container {
        minHeight: 120
        horizontalAlignment: HorizontalAlignment.Fill
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        ImageView {
            verticalAlignment: VerticalAlignment.Center
            imageSource: "asset:///images/" + snapStatus + ".png"
        }
        Container {
            verticalAlignment: VerticalAlignment.Center
            Label {
                text: snapUser
                topMargin: 0
                bottomMargin: 0
            }
            Label {
                text: snapTime + " - " + snapStatus
                topMargin: 0
                bottomMargin: 0
                textStyle.fontSize: FontSize.PointValue
                textFit.maxFontSizeValue: 4.0
                textFit.minFontSizeValue: 4.0
                textStyle.color: Color.Gray

            }
        }

    }
    //        StandardListItem {
    //            title: snapUser
    //            description: snapTime + " - " + snapStatus
    //
    //            imageSource: "asset:///images/" + snapStatus + ".png"
    //            // Listview properties, kind of self explanatory
    //
    //        }
}