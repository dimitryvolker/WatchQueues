import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class GeneralSettingsMenuDelegate extends Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) as Void {
        var selectedItemId = item.getId();

        if(selectedItemId.equals("selected_park")){
            var subMenu = new ParkSelection();
        }
    }

    function onBack() as Void {
        WatchUi.switchToView(new InitView() ,new InitViewDelegate(), WatchUi.SLIDE_RIGHT);
    }
}