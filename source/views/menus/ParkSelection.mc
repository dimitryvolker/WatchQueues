import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.Lang;

class ParkSelection {
    private var _parkService as ParkService;
    private var _menu as Menu2;

    function initialize() {
        _menu = new Menu2({:title=>"Select Themepark"});
        _parkService = new ParkService(null, method(:onParksRecieved));
        _parkService.fetchParks();
    }

    function onParksRecieved(parks as Array<Dictionary>) as Void{
        for (var i = 0; i < parks.size() as Number; i++) {
            var park = parks[i];
            _menu.addItem(
                new MenuItem(
                    park["name"],
                    park["continent"] + " minuten wachten",
                    "" + park["id"],
                    {}
                )
            );
        }

        // Push the Menu2 View set up in the initializer
        WatchUi.pushView(_menu, new ParkSelectionDelegate(), WatchUi.SLIDE_LEFT);
    }
}