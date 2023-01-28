import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class QueueDelegate extends WatchUi.Menu2InputDelegate {
    function QueueDelegate() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        new GeneralSettings();
    }
} 