using Toybox.WatchUi as Ui;
import Toybox.Application.Storage;
import Toybox.Lang;

class GeneralSettingsMenuDelegate extends Ui.Menu2InputDelegate {
     private var _callback as Method;                // Callback used for when settings has been changed

    function initialize(callback) {
        Menu2InputDelegate.initialize();
        _callback = callback;
    }

    function onBack() as Void{
        _callback.invoke();
    }

    function onSelect(item) as Void {
        var selectedItemId = item.getId();
        if(selectedItemId.equals("selected_park")){
            var subMenu = new ParkSelection(_callback);
        }
    }
}