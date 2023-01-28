import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class GeneralSettingsMenuDelegate extends Menu2InputDelegate {
    private var _storageService as StorageService;
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        var selectedItemId = item.getId();

        if(selectedItemId.equals("selected_park")){
            var subMenu = new ParkSelection();
            return true;
        }

        return false;
    }

    function onBack() as Boolean {
        WatchUi.switchToView(new InitView() ,new InitViewDelegate(), WatchUi.SLIDE_RIGHT);
        return true;
    }
}