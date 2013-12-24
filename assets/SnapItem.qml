import bb.cascades 1.2
Container {
    horizontalAlignment: HorizontalAlignment.Fill
    property string snapStatus: "picture"
    property string snapTime: "4 minutes ago"
    property string snapType: "picture"
    property string snapUser: "madk "
    property string snapURL: "invisible" // URL to the snap (not visible)
    property int snapView: 10 // time you can view the snap for
    property string snapSelectable: "true" // can you view this snap?
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
            Container {
                maxWidth: 600
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    textStyle.fontWeight: FontWeight.Bold
                    textStyle.fontSize: FontSize.PointValue
                    textFit.maxFontSizeValue: 8.0
                    textFit.minFontSizeValue: 8.0
                    text: snapUser + " -"
                    topMargin: 0
                    bottomMargin: 0
                }
                Label {
                    translationX: -10
                    textStyle.fontSize: FontSize.PointValue
                    textFit.maxFontSizeValue: 8.0
                    textFit.minFontSizeValue: 8.0
                    text: snapView
                    topMargin: 0
                    bottomMargin: 0
                }
                ImageView {
                    translationX: -20
                    translationY: 2
                    maxHeight: 28
                    maxWidth: 28
                    imageSource: "asset:///images/time.png"
                    horizontalAlignment: HorizontalAlignment.Right
                    verticalAlignment: VerticalAlignment.Center

                }
            }

            Label {
                topMargin: 0
                bottomMargin: 0
                textStyle.fontSize: FontSize.PointValue
                textFit.maxFontSizeValue: 8.0
                textFit.minFontSizeValue: 8.0
                text: "  " + snapTime
            }

        }
        ImageView {
            imageSource: "asset:///images/" + snapStatus + ".png"
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Center
        }
        Divider {
            translationY: 5
            verticalAlignment: VerticalAlignment.Bottom
        }

    }

}
//    Container {
//
//        layout: DockLayout {
//        }
//        background: Color.create("#47ffffff")
//        Container {
//            horizontalAlignment: HorizontalAlignment.Fill
//            verticalAlignment: VerticalAlignment.Top
//            layout: StackLayout {
//                orientation: LayoutOrientation.LeftToRight
//            }
//            Container {
//                //background: Color.Red
//                horizontalAlignment: HorizontalAlignment.Left
//                verticalAlignment: VerticalAlignment.Fill
//                rightMargin: 20
//                ImageView {
//                    imageSource: "asset:///images/" + snapStatus + ".png"
//                }
//            }
//            Container {
//                verticalAlignment: VerticalAlignment.Fill
//                //            background: Color.Blue
//                layoutProperties: StackLayoutProperties {
//                    spaceQuota: 3
//                }
//                horizontalAlignment: HorizontalAlignment.Fill
//                Label {
//                    textStyle.color: Color.Black
//                    textStyle.fontWeight: FontWeight.Bold
//                    textStyle.fontSize: FontSize.PointValue
//                    textFit.maxFontSizeValue: 8.0
//                    textFit.minFontSizeValue: 8.0
//                    text: snapUser
//                    topMargin: -10
//                    bottomMargin: -10
//                }
//                Label {
//                    text: snapTime + " - " + snapType
//                    topMargin: -10
//                    bottomMargin: -10
//                    textStyle.fontSize: FontSize.PointValue
//                    textFit.maxFontSizeValue: 8.0
//                    textFit.minFontSizeValue: 8.0
//                    textStyle.color: Color.Black
//                }
//            }
//            Container {
//                horizontalAlignment: HorizontalAlignment.Right
//                verticalAlignment: VerticalAlignment.Top
//                rightPadding: 10
//                layout: DockLayout {
//                }
//                Label {
//                    verticalAlignment: VerticalAlignment.Top
//                    horizontalAlignment: HorizontalAlignment.Right
//                    textStyle.textAlign: TextAlign.Right
//                    text: snapView
//                    textStyle.fontSize: FontSize.PointValue
//                    textFit.maxFontSizeValue: 6.0
//                    textFit.minFontSizeValue: 6.0
//                    textStyle.color: Color.Black
//                }
//            }
//        }
//        Divider {
//            verticalAlignment: VerticalAlignment.Bottom
//        }
//    }
//}
