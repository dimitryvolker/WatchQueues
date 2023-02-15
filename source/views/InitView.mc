import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class InitView extends WatchUi.View {
    private var _parkService as ParkService;
    private var _storageService as StorageService;
    private var _menu as Menu2;
    private var _isShowingMenu as Boolean;
    private var _loadingAnimation as AnimationLayer;

    function initialize() {
        View.initialize();
        _parkService = new ParkService(method(:onQueueTimesUpdated), null);
        _storageService = new StorageService();
        _menu = new WatchUi.Menu2({:title=>_storageService.getSelectedParkName()});
        _isShowingMenu = false;


        var dev = System.getDeviceSettings();
        var x = 0;
        var y = 0;

        // create a new AnimationLayer with the resource then add it to the view
        // as a WatchUi.Layer
        _loadingAnimation = new WatchUi.AnimationLayer(Rez.Drawables.loading, {:locX=>x, :locY=>y});
        View.addLayer( _loadingAnimation );
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {

    }

    function animateLoading(){
        _loadingAnimation.play({
            :delegate => new LoadingAnimationDelegate(self)
        });
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        animateLoading();
        _parkService.fetchRides();
        WatchUi.switchToView(_menu, new QueueDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    function onAnimationEvent(state as Dictionary?){

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
                        ride["is_open"] == true ? ride["wait_time"] + " minutes" : "Closed",
                        "" + ride["id"],
                        {}
                    )
                );
            }else{
                var relatedMenuItem = _menu.getItem(relatedMenuItemId);
                relatedMenuItem.setSubLabel(ride["is_open"] == true ? ride["wait_time"] + " minutes" : "Closed");
            }
        }

        WatchUi.requestUpdate();
    }
}
