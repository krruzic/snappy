import bb.cascades 1.2
import "tart.js" as Tart

TabbedPane {
    id: root
    onCreationCompleted: {
        Tart.debug = false;
        Tart.init(_tart, Application);
        
        Tart.register(root);
        Tart.send('uiReady');
    
    }
    function onTokenExpired() {
        Tart.send('login')
    }
    Tab {
        SnapPage {
            
        }
    }
}
