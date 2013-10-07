import bb.cascades 1.2

TitleBar {
    property alias text: pageTitle.text
    kind: TitleBarKind.FreeForm
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
                    text: ""
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.fontWeight: FontWeight.Default
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.color: Color.White
                    textStyle.fontStyle: FontStyle.Italic
                    textStyle.fontSizeValue: 12

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