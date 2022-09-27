using Toybox.WatchUi as Ui;

/**
 * Delegate for handling user input on the RideQueueViews
 */
class RideQueueDelegate extends Ui.BehaviorDelegate {
    // Reference to the big overview handler
    hidden var _overview as Overview;

    /*
     *  Default Constructor
     */
    function initialize(overview as Overview) {
        BehaviorDelegate.initialize();
        _overview = overview;
    }

    /*
     *  Handle watch key presses
     */
    function onKeyPressed(keyEvent){
        if(keyEvent.getKey() == 8){ // Down
            _overview.showNextPage();
        }

        if(keyEvent.getKey() == 13){ // Up
            _overview.showPrevPage();
        }

        if(keyEvent.getKey() == 4){ // Start/Stop
            _overview.showSettings();
        }

        return true;
    }


    /*
     *  Handle swipe events
     */
    function onSwipe(swipeEvent) {
        if(swipeEvent.getDirection() == 2){ // Up
            _overview.showPrevPage();
        }

        if(swipeEvent.getDirection() == 0){ // Down
            _overview.showNextPage();
        }
    }
}