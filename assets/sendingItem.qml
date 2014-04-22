import bb.cascades 1.2
Container {
    Container {
        background: Color.create("#47ffffff")
        layout: DockLayout {
        }
        Container {
            verticalAlignment: VerticalAlignment.Center
            rightPadding: 20
            leftPadding: 20
            minHeight: 100
            layout: DockLayout {
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Left
                verticalAlignment: VerticalAlignment.Center
                layout: AbsoluteLayout {
                }
                Label {
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    text: "Hello this is a test string"
                    id: user

                    textStyle.color: Color.Black
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: -1
                        positionY: -2
                    }

                }

                Label {
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    text: user.text
                    textStyle.color: Color.White

                }

            }
            SnappyCheckBox {
                checked: false
            }
            Divider {
                verticalAlignment: VerticalAlignment.Bottom
            }
        }
    }
}