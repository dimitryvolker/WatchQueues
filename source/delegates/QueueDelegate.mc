import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.System;

class QueueDelegate extends WatchUi.Menu2InputDelegate {
    function QueueDelegate() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        new GeneralSettings();
    }

    function onBack() as Boolean {
        System.exit();
    }
} 