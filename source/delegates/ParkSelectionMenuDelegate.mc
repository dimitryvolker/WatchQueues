using Toybox.WatchUi as Ui;
import Toybox.Application.Storage;

class ParkSelectionMenuDelegate extends Ui.Menu2InputDelegate {
    private var _callback as Method;                // Callback used for when settings has been changed

    function initialize(callback) {
        Menu2InputDelegate.initialize();
        _callback = callback;
    }

    function onSelect(item) {
        Storage.setValue("selected_themepark_label", item.getLabel());
        Storage.setValue("selected_themepark_id", item.getId());
        _callback.invoke();
    }
}