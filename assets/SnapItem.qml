import bb.cascades 1.2
Container {
    //horizontalAlignment: HorizontalAlignment.Fill
    
    property string snapStatus: "pictureH"
    property string snapTime: "4 minutes ago"
    property string snapType: "picture"
    property string snapUser: "madk "
    property string snapURL: "invisible" // URL to the snap (not visible)
    property int snapView: 10 // time you can view the snap for
    property string snapSelectable: "true" // can you view this snap?
    Container {
        Container {
            attachedObjects: [
                TextStyleDefinition {
                    //id: lightStyle
                    base: SystemDefaults.TextStyles.BodyText
                    fontWeight: FontWeight.W300
                }
            ]
            horizontalAlignment: HorizontalAlignment.Fill
            layout: DockLayout {
            }
            //background: Color.create("#a2ffffff")

            topPadding: 10
            //bottomPadding: 10
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
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Label {
                            textStyle.base: lightStyle.style
                            textStyle.fontWeight: FontWeight.Bold
                            textStyle.fontSize: FontSize.PointValue
                            textFit.maxFontSizeValue: 8.0
                            textFit.minFontSizeValue: 8.0
                            text: snapUser + " "
                            topMargin: 0
                            bottomMargin: 0
                        }
                    }

                    Label {
                        textStyle.base: lightStyle.style
                        topMargin: 0
                        bottomMargin: 0
                        textStyle.fontSize: FontSize.PointValue
                        textFit.maxFontSizeValue: 8.0
                        textFit.minFontSizeValue: 8.0
                        text: "    " + snapTime + " - Press to view"
                    }
                }
                ImageText {
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    text: "10"
                    image: "asset:///images/pictureH.png"
                }

            }

            Divider {
                verticalAlignment: VerticalAlignment.Bottom
            }

        }
    }
}
