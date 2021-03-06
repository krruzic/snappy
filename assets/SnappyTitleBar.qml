import bb.cascades 1.2

TitleBar {
    kind: TitleBarKind.FreeForm
    scrollBehavior: TitleBarScrollBehavior.Sticky
    property alias text: name.text
    property alias b1: button1
    property alias b2: button2
    property alias b3: button3
    property alias button1Visible: button1.visible
    property alias button2Visible: button2.visible
    property alias button3Visible: button3.visible
    property alias button1Image: button1.defaultImageSource
    property alias button2Image: button2.defaultImageSource
    property alias button3Image: button3.defaultImageSource
    kindProperties: FreeFormTitleBarKindProperties {
        Container {
            background: Color.create("#ff3351ff")
            topPadding: 10
            bottomPadding: 10
            leftPadding: 10
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }

            Label {
                id: name
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 3
                }
                text: "Snappy"
                textStyle.fontWeight: FontWeight.W600
                textStyle.fontSize: FontSize.PointValue
                textFit.maxFontSizeValue: 10.0
                textFit.minFontSizeValue: 10.0
                textStyle.color: Color.create("#3376ff")
            }
            Container {
                rightPadding: 20
                horizontalAlignment: HorizontalAlignment.Right
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                ImageButton {
                    id: button1
                    enabled: visible
                    defaultImageSource: "asset:///images/sendButton.png"
                    pressedImageSource: defaultImageSource
                    maxWidth: 81
                    maxHeight: 81
                    minHeight: 81
                    minWidth: 81

                }
                ImageButton {
                    id: button2
                    enabled: visible
                    defaultImageSource: "asset:///images/editButton.png"
                    pressedImageSource: defaultImageSource
                    maxWidth: 81
                    maxHeight: 81
                    minHeight: 81
                    minWidth: 81
                }
                ImageButton {
                    id: button3
                    enabled: visible
                    defaultImageSource: "asset:///images/shareButton.png"
                    pressedImageSource: defaultImageSource
                    maxWidth: 81
                    maxHeight: 81
                    minHeight: 81
                    minWidth: 81
                }
            }
            //        }
            //        content: Container {
            //            background: background.imagePaint
            //            leftPadding: 20
            //            rightPadding: 20
            //            //topPadding: 10
            //            Container {
            //                layout: DockLayout {
            //
            //                }
            //                horizontalAlignment: HorizontalAlignment.Fill
            //                verticalAlignment: VerticalAlignment.Center
            //                Label {
            //                    id: pageTitle
            //                    text: "Snappy"
            //                    horizontalAlignment: HorizontalAlignment.Center
            //                    verticalAlignment: VerticalAlignment.Center
            //                    textStyle.fontWeight: FontWeight.Default
            //                    textStyle.fontSize: FontSize.PointValue
            //                    textStyle.color: Color.White
            //                    textStyle.fontStyle: FontStyle.Italic
            //                    textStyle.fontSizeValue: 12
            //                    textStyle.textAlign: TextAlign.Center
            //                }
            //                ImageView {
            //                    translationY: 5
            //                    maxHeight: 81
            //                    maxWidth: 81
            //                    verticalAlignment: VerticalAlignment.Center
            //                    horizontalAlignment: HorizontalAlignment.Right
            //                    imageSource: "asset:///images/cam.png"
            //                }
            //            }
            //
            //        }
            attachedObjects: [
                ImagePaintDefinition {
                    id: background
                    imageSource: "asset:///images/titleBarBackground.png"
                }
            ]
        }
    }
}