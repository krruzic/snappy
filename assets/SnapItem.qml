import bb.cascades 1.2
Container {
    //    dividerVisible: false
    //    highlightAppearance: HighlightAppearance.None
    preferredWidth: Infinity.MAX_VALUE

    property string snapStatus: "picture"
    property string snapTime: "4 mins ago"
    property string snapType: "picture"
    property string snapUser: "madk"
    property string snapURL: "invisible" // URL to the snap (not visible)
    property string snapView: "3" // time you can view the snap for
    property string snapSelectable: "true" // can you view this snap?
    attachedObjects: [
        ImagePaintDefinition {
            imageSource: "asset:///images/item.amd"
            id: background
        }
    ]
    Container {

        horizontalAlignment: HorizontalAlignment.Fill
        layout: DockLayout {
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            ImageView {
                horizontalAlignment: HorizontalAlignment.Left
                rightMargin: 20
                verticalAlignment: VerticalAlignment.Center
                imageSource: "asset:///images/" + snapStatus + ".png"
            }

            Container {
                preferredWidth: Infinity.MAX_VALUE
                leftMargin: 10
                rightMargin: 0
                layout: StackLayout {
                }
                horizontalAlignment: HorizontalAlignment.Fill
                Label {
                    preferredWidth: Infinity.MAX_VALUE
                    textStyle.color: Color.Black
                    
                    verticalAlignment: VerticalAlignment.Top
                    enabled: false
                    textStyle.fontSize: FontSize.PointValue
                    textFit.maxFontSizeValue: 10.0
                    textFit.minFontSizeValue: 12.0
                    text: snapUser
                    topMargin: 0
                    bottomMargin: 0
                    horizontalAlignment: HorizontalAlignment.Fill
                }
                Label {
                    preferredWidth: Infinity.MAX_VALUE

                    verticalAlignment: VerticalAlignment.Bottom
                    text: snapTime + " - " + snapType
                    topMargin: 0
                    bottomMargin: 0
                    textStyle.fontSize: FontSize.PointValue
                    textFit.maxFontSizeValue: 6.0
                    textFit.minFontSizeValue: 6.0
                    textStyle.color: Color.Black
                    horizontalAlignment: HorizontalAlignment.Fill
                }
            }

        }
        Label {
            textStyle.textAlign: TextAlign.Right
            horizontalAlignment: HorizontalAlignment.Right
            text: snapView
            textStyle.fontSize: FontSize.PointValue
            textFit.maxFontSizeValue: 6.0
            textFit.minFontSizeValue: 6.0
            textStyle.color: Color.Black
            translationX: -10
        }
        bottomPadding: 10
    }
    Divider {
    }

}