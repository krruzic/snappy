import bb.cascades 1.0
import "tart.js" as Tart

TabbedPane {
    id: root
    onCreationCompleted: {
        Tart.debug = false;
        Tart.init(_tart, Application);
        
        Tart.register(root);
        Tart.send('uiReady');
    
    }
    Tab {
        SnapPage {
            
        }
    }
}
