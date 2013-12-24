import bb.cascades 1.2

TitleBar {
    kind: TitleBarKind.FreeForm
    scrollBehavior: TitleBarScrollBehavior.Sticky

    kindProperties: FreeFormTitleBarKindProperties {
        content: Container {
            background: background.imagePaint
            leftPadding: 30
            topPadding: 10
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Center
                Label {
                    id: pageTitle
                    text: "Snappy"
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.fontWeight: FontWeight.Default
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.color: Color.White
                    textStyle.fontStyle: FontStyle.Italic
                    textStyle.fontSizeValue: 12
                    textStyle.textAlign: TextAlign.Center
                }
            }

        }
        attachedObjects: [
            ImagePaintDefinition {
                id: background
                imageSource: "asset:///images/titleBarBackground.png"
            }
        ]
    }
}