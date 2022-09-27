using Toybox.WatchUi as Ui;
import Toybox.Application.Storage;

class GeneralSettingsMenuDelegate extends Ui.Menu2InputDelegate {
     private var _callback as Method;                // Callback used for when settings has been changed

    function initialize(callback) {
        Menu2InputDelegate.initialize();
        _callback = callback;
    }

    function onBack(){
        _callback.invoke();
        return true;
    }

    function onSelect(item) {
        var selectedItemId = item.getId();
        System.println(selectedItemId);
        System.println(item.getLabel());

        if(selectedItemId.equals("selected_park")){
            System.println("TEST");
            var subMenu = new ParkSelection(_callback);
            return true;
        }

        return false;
    }
}