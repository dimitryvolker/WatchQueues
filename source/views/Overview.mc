using Toybox.WatchUi as Ui;
using Toybox.Application;
import Toybox.Application.Storage;

class OverviewDelegate extends Ui.BehaviorDelegate {
    hidden var _view;

    function initialize(view) {
        BehaviorDelegate.initialize();
        _view = view;
    }

    function onKeyPressed(keyEvent){
        System.println(keyEvent.getKey());
        if(keyEvent.getKey() == 8){ // Down
            nextPage();
            return true;
        }

        if(keyEvent.getKey() == 13){ // Up
            prevPage();
            return true;
        }

        if(keyEvent.getKey() == 5){
            var app = Application.getApp();
            app.onStop(null);
            app.onStop(null);
            return true;
        }

        // Open settings menu
        if(keyEvent.getKey() == 4){
            var generalSettings = new GeneralSettings();
            return true;
        }

        return false;
    }

    function onSwipe(swipeEvent){
        System.println(swipeEvent.getDirection());
        if(swipeEvent.getDirection() == 2){
            prevPage();
        }

        if(swipeEvent.getDirection() == 0){
            nextPage();
        }
    }

    function nextPage(){
        if(_view._currentPage.hasNext){
            _view._currentPage = _view._pages[_view._currentPage.index + 1]; 
            var fView = new RideQueueView(_view._currentPage.rides, _view._currentPage.hasPrev, _view._currentPage.hasNext);
            WatchUi.pushView(fView, new OverviewDelegate(_view), Ui.SLIDE_UP);
        }
    }

    function prevPage(){
         if(_view._currentPage.hasPrev){
            _view._currentPage = _view._pages[_view._currentPage.index - 1]; 
            var fView = new RideQueueView(_view._currentPage.rides, _view._currentPage.hasPrev, _view._currentPage.hasNext);
            WatchUi.popView(Ui.SLIDE_DOWN);
        }
    }
}

class Page {
    public var index as Number;
    public var rides as Array<Ride>;
    public var hasNext as Boolean;
    public var hasPrev as Boolean;
}

class Overview extends Ui.View {
    private var _agent as QueueTimesAgent;
    public var _pages as Array<Page>;
    public var _currentPage as Page;

    function initialize() {
        View.initialize();
        _agent = new QueueTimesAgent();
        _pages = new [0];
        _currentPage = new Page();
        _currentPage.rides = new [0];
        _currentPage.hasNext = true;
        _currentPage.hasPrev = false;

        var themeParkId = 160;
        var selectedThemepark = Storage.getValue("selected_themepark_id");
        if(selectedThemepark != null){
            themeParkId = selectedThemepark;
        }

        System.println("Showing park: " + themeParkId);
        _agent.getQueues(themeParkId,method(:onInitDataRecieve));
    }

    // Handle layout
    function onLayout(dc) {

    }

    // Handle becoming visible
    function onShow() {
        // Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK); //Keep Bg color
        dc.clear();//Clear screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK); //Set text color
    }

    public function onInitDataRecieve(responseCode as Number, data as Dictionary?) as Void {
        if (responseCode == 200) {
            var dataLands = data["lands"];
            var lands = new [0];
            var rides = new [0];
            for (var i = 0; i < dataLands.size(); i++) {
                lands.add(new Land(dataLands[i]));
            }

            // Convert lands into rides into pages
            for (var i = 0; i < lands.size(); i++) {
                for(var j = 0; j < lands[i].rides.size(); j++){
                    rides.add(lands[i].rides[j]);
                }
            }

            var rideCount = 0;
            var pIndex = 0;
            for (var i = 0; i < rides.size(); i += 3)
            {
                var newPage = new Page();
                newPage.index = pIndex;
                newPage.rides = rides.slice(i, i + 3);
                newPage.hasPrev = i > 0 ;
                newPage.hasNext = (i + 3) <= rides.size();
                _pages.add(newPage);
                pIndex++;
            }

            _currentPage = _pages[0];

            var fView = new RideQueueView(_currentPage.rides, _currentPage.hasPrev, _currentPage.hasNext);
            WatchUi.pushView(fView, new OverviewDelegate(self), Ui.SLIDE_IMMEDIATE);
        } else {
            System.println("Response: " + responseCode);            // print response code
        }
    }
}