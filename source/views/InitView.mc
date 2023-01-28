import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class InitView extends WatchUi.View {
    private var _parkService as ParkService;
    private var _storageService as StorageService;

    function initialize() {
        View.initialize();
        _parkService = new ParkService(method(:onQueueTimesUpdated), null);
        _storageService = new StorageService();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        _parkService.fetchRides();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        
    }

    function onQueueTimesUpdated(rides as Array<Dictionary>) as Void{
        var menu = new WatchUi.Menu2({:title=>_storageService.getSelectedParkName()});
        var delegate;

        for (var i = 0; i < rides.size() as Number; i++) {
            var ride = rides[i];
            menu.addItem(
                new MenuItem(
                    ride["name"],
                    ride["wait_time"] + " minuten wachten",
                    "ride_" + ride["id"],
                    {}
                )
            );
        }

        // Push the Menu2 View set up in the initializer
        WatchUi.pushView(menu, new QueueDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }
}
