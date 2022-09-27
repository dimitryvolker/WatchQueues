import Toybox.Application;
import Toybox.Lang;
using Toybox.WatchUi as Ui;

class WatchQueuesApp extends Application.AppBase {
    private var _controller as RideQueueViewController;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        _controller = new RideQueueViewController(method(:onControllerInitialized));
    }

    function onControllerInitialized() as Void {
        Ui.switchToView(_controller.currentPage, new RideQueueDelegate(_controller), Ui.SLIDE_IMMEDIATE);
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView(){
        return [ new LoadingView() ];
    }
}

function getApp() as WatchQueuesApp {
    return Application.getApp() as WatchQueuesApp;
}