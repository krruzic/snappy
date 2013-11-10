import bb.cascades 1.2
Container {
    property alias title: top.text
    property alias subtitle: bottom.text
    layout: StackLayout {
    }
    horizontalAlignment: HorizontalAlignment.Fill
    Label {
        id: top
        verticalAlignment: VerticalAlignment.Top
        //editable: false
        textStyle.fontSize: FontSize.PointValue
        textFit.maxFontSizeValue: 10.0
        textFit.minFontSizeValue: 12.0
        text: ""
        topMargin: 0
        bottomMargin: 0
    }
    Label {
        id: bottom
        verticalAlignment: VerticalAlignment.Bottom
        //editable: false
        text: ""
        topMargin: 0
        bottomMargin: 0
        textStyle.fontSize: FontSize.PointValue
        textFit.maxFontSizeValue: 6.0
        textFit.minFontSizeValue: 6.0
        textStyle.color: Color.Gray
    }
}