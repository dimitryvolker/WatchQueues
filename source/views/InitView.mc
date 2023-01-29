import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class InitView extends WatchUi.View {
    private var _parkService as ParkService;
    private var _storageService as StorageService;
    private var _menu as Menu2;
    private var _isShowingMenu as Boolean;

    function initialize() {
        View.initialize();
        _parkService = new ParkService(method(:onQueueTimesUpdated), null);
        _storageService = new StorageService();
        _menu = new WatchUi.Menu2({:title=>_storageService.getSelectedParkName()});
        _isShowingMenu = false;
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
        WatchUi.switchToView(_menu, new QueueDelegate(), WatchUi.SLIDE_IMMEDIATE);
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
        _isShowingMenu = false;
    }

    function onQueueTimesUpdated(rides as Array<Dictionary>) as Void{
        for (var i = 0; i < rides.size() as Number; i++) {
            var ride = rides[i];
            var relatedMenuItemId = _menu.findItemById("" + ride["id"]);
            if(relatedMenuItemId == -1){
                _menu.addItem(
                    new MenuItem(
                        ride["name"],
                        ride["is_open"] == true ? ride["wait_time"] + " minuten" : "Gesloten",
                        "" + ride["id"],
                        {}
                    )
                );
            }else{
                var relatedMenuItem = _menu.getItem(relatedMenuItemId);
                relatedMenuItem.setSubLabel(ride["is_open"] == true ? ride["wait_time"] + " minuten" : "Gesloten");
            }
        }

        WatchUi.requestUpdate();
    }
}
