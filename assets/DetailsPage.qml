import bb.cascades 1.2
import "tart.js" as Tart
Page {

    id: detailsPage

    objectName: ' detailsPage'
    property alias imageSource: image.imageSource
    property int currentCount: 0
    actionBarVisibility: ChromeVisibility.Hidden
    onCreationCompleted: {
        Tart.register(detailsPage);
    }
    function onScreenShotAttempt(data) {
        console.log("Aware of attempt!")
        image.imageSource = "";
        nav.pop();
    }
    onImageSourceChanged: {
        picTimer.start();
    }
    Container {
        background: Color.Black
        layout: DockLayout {
        }
        verticalAlignment: VerticalAlignment.Fill
        horizontalAlignment: HorizontalAlignment.Fill
        ImageView {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            id: image
            imageSource: "asset:///images/city.png"
            scalingMethod: ScalingMethod.AspectFit
        }
        Container {
            horizontalAlignment: HorizontalAlignment.Right
            rightPadding: 20
            topPadding: 20
            Container {
                attachedObjects: [
                    QTimer {
                        id: picTimer
                        // Specify a timeout interval of 1 second
                        interval: 1000
                        onTimeout: {
                            currentCount -= 1;
                            timerDisplay.text = "" + currentCount;

                            // When the counter reaches 0, change the traffic light
                            // state, stop the countdown timer, and start the pause
                            // timer
                            if (currentCount <= 0) {
                                nav.pop();
                            }
                        } // end of onTimeout signal handler
                    } // end of Timer
                ]
                layout: DockLayout {
                }
                minWidth: 100
                minHeight: 100 //
                ImageText {
                    text: currentCount
                    id: timerDisplay
                    textX: 15
                    textY: 15
                    image: "asset:///images/timer.png"
                }
            }
        }
    }
}
