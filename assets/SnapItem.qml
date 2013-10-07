import bb.cascades 1.0

Container {
    // Listview properties, kind of self explanatory
    property string snapStatus: ""
    property string snapTime: ""
    property string snapType: ""
    property string snapUser: ""
    property string snapURL: "" // URL to the snap (not visible)
    layout: StackLayout {

    }
    property int padding: 10
    topPadding: 5
    bottomPadding: 0
    leftPadding: padding
    rightPadding: padding

    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        Label {
            text: snapStatus
        }
        Label {
            text: snapType + snapUser
        }
    }
    Label {
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Bottom
        text: snapTime
    }
}