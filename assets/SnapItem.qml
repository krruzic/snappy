import bb.cascades 1.0
StandardListItem {
    title: snapUser
    description: snapTime + " - " + snapStatus

    imageSource: "asset:///images/" + snapStatus + ".png"
    // Listview properties, kind of self explanatory
    property string snapStatus: "picture"
    property string snapTime: "4 mins ago"
    property string snapType: "picture"
    property string snapUser: "madk"
    property string snapURL: "invisible" // URL to the snap (not visible)
    property int padding: 10
    topPadding: 5
    bottomPadding: 0
    leftPadding: padding
    rightPadding: padding
}