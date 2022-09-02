import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class WatchQueuesApp extends Application.AppBase {
    hidden var View;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    		View = new Overview();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView(){
        return [ View ];
    }
}

function getApp() as WatchQueuesApp {
    return Application.getApp() as WatchQueuesApp;
}