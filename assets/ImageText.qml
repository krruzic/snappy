import bb.cascades 1.2

Container {
    property alias text: textS.text
    property alias image:buttonImage.imageSource
    property alias textX: abs.positionX
    property alias textY: abs.positionY
    attachedObjects: [
        TextStyleDefinition {
            id: lightStyle
            base: SystemDefaults.TextStyles.BodyText
            fontWeight: FontWeight.W900
        }
    ]
    layout: AbsoluteLayout {
        
    }

    ImageView {
        id: buttonImage
       //defaultImageSource: "asset:///images/pictureH.png"
    }
    Label {
        id: textS
        minWidth: 50
        maxWidth: 50
        textStyle.base: lightStyle.style
        layoutProperties: AbsoluteLayoutProperties {
            id: abs
            positionX: 10
            positionY: 15
        }
        textStyle.textAlign: TextAlign.Center
        textStyle.color: Color.create("#3376ff")
    }
}
