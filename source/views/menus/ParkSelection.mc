using Toybox.WatchUi as Ui;
import Toybox.Application.Storage;

class ParkSelectionMenuDelegate extends Ui.Menu2InputDelegate {
    private var _callback as Method;                // Callback used for when settings has been changed

    function initialize(callback) {
        Menu2InputDelegate.initialize();
        _callback = callback;
    }

    function onSelect(item) {
        Storage.setValue("selected_themepark_label", item.getLabel());
        Storage.setValue("selected_themepark_id", item.getId());
        var generalSettings = new GeneralSettings(_callback);
    }
}

class ParkSelection {
    private var _agent as QueueTimesAgent;

    public var menu as WatchUI.Menu2;
    public var delegate as GeneralSettingsMenuDelegate;

    function initialize(callback) {
        menu = new Ui.Menu2({:title=>"Themepark"});
        _agent = new QueueTimesAgent();
        _agent.getThemeParks(method(:onInitDataRecieve));
        delegate = new ParkSelectionMenuDelegate(callback);
    }

    function onInitDataRecieve(responseCode as Number, data as Dictionary?) as Void {
        if (responseCode != 200){
            System.println("Response: " + responseCode);            // print response code
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
            menu.addItem(new Ui.MenuItem(label, subLabel, id, null));
        }

        // Push the Menu2 View set up in the initializer
        WatchUi.switchToView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
    }
}