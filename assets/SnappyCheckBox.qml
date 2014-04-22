import bb.cascades 1.2
ImageButton {
    onCheckedChanged: {
        if (checked)
            defaultImageSource = checkedImage;
        else
            defaultImageSource = nonCheckedImage;
    }
    property bool checked: false
    id: addFriendButton
    enabled: true
    property variant checkedImage: "asset:///images/addFriendD.png"
    property variant nonCheckedImage: "asset:///images/addFriend.png"
    defaultImageSource: nonCheckedImage
    pressedImageSource: defaultImageSource
    horizontalAlignment: HorizontalAlignment.Right
    verticalAlignment: VerticalAlignment.Center
    onClicked: {
        checked = !checked;
    }
}