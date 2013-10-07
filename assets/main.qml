import bb.cascades 1.0
import "tart.js" as Tart

NavigationPane {
    peekEnabled: false
    id: root
    function onLoginChecked(data) {
        login.activity.visible = false;
        if (data.value == "true") {
            var page = snapPage.createObject();
            root.push(page);
        }
    }
    LoginPage {
        id: login
        actionBarVisibility: ChromeVisibility.Hidden
    }
    onCreationCompleted: {
        login.activity.visible = true;
        //Tart.debug = true;
        Tart.init(_tart, Application);
        
        Tart.register(root);
        Tart.send('uiReady');
    }
    onPopTransitionEnded: {
        // Destroy the popped Page once the back transition has ended.
        page.destroy();
    }
    onPushTransitionEnded: {
        if (page.objectName == 'snapPage') {
            Tart.send('requestFeed')
        }
    }
}
