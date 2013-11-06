import bb.cascades 1.2

CustomListItem {
    highlightAppearance: HighlightAppearance.Frame
    property string snapStatus: "picture"
    property string snapTime: "4 mins ago"
    property string snapType: "picture"
    property string snapUser: "madk"
    property string snapURL: "invisible" // URL to the snap (not visible)
    property string snapView: "" // time you can view the snap for
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        layout: DockLayout {
        }
        Container {
            ImageView {
                verticalAlignment: VerticalAlignment.Center
                imageSource: "asset:///images/" + snapStatus + ".png"
            }
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            verticalAlignment: VerticalAlignment.Center
            Container {
                verticalAlignment: VerticalAlignment.Center
                Label {
                    text: snapUser
                    topMargin: 0
                    bottomMargin: 0
                }
                Label {
                    text: snapTime + " - " + snapType
                    topMargin: 0
                    bottomMargin: 0
                    textStyle.fontSize: FontSize.PointValue
                    textFit.maxFontSizeValue: 4.0
                    textFit.minFontSizeValue: 4.0
                    textStyle.color: Color.Gray
                }
            }
        }
        Label {
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Right
            text: snapView
            textStyle.fontSize: FontSize.PointValue
            textFit.maxFontSizeValue: 6.0
            textFit.minFontSizeValue: 6.0
            translationX: -10.0
            textStyle.color: Color.Gray
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