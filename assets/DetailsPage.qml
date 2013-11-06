import bb.cascades 1.2

Page {
    id: detailsPage
    objectName: ' detailsPage'
    property alias imageSource: image.imageSource
    titleBar: SnappyTitleBar {
        // Localized text with the dynamic translation and locale updates support
        text: "Snappy"
    }
    Container {
        verticalAlignment: VerticalAlignment.Fill
        horizontalAlignment: HorizontalAlignment.Fill
        ImageView {
            id: image
        }
    }
}
