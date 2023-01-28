import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.Lang;

class ParkSelection {
    private var _agent as QueueTimesAgent;

    public var menu as Menu2;
    public var delegate as ParkSelectionMenuDelegate;

    function initialize(callback) {
        menu = new Menu2({:title=>"Themepark"});
        _agent = new QueueTimesAgent();
        _agent.getThemeParks(method(:onInitDataRecieve));
        delegate = new ParkSelectionMenuDelegate(callback);
    }

    function onInitDataRecieve(responseCode as Number, data as Dictionary?) as Void {
        if (responseCode != 200){
            return;
        }

        var parkgroups = new [0];
        var themeparks = new [0];

        for (var i = 0; i < data.size(); i++) {
            parkgroups.add(new ParkGroup(data[i]));
        }

        for (var i = 0; i < parkgroups.size(); i++) {
            for(var j = 0; j < parkgroups[i].parks.size(); j++){
                themeparks.add(parkgroups[i].parks[j]);
            }
        }

        for (var i = 0; i < themeparks.size(); i++) {
            var id = themeparks[i].id;
            var label = themeparks[i].name;
            var subLabel = themeparks[i].country + ", " + themeparks[i].continent;
            menu.addItem(new MenuItem(label, subLabel, id, null));
        }

        // Push the Menu2 View set up in the initializer
        WatchUi.switchToView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
    }
}