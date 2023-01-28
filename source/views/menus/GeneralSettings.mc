import Toybox.WatchUi;
import Toybox.Application.Storage;

class GeneralSettings {

    function initialize() {
        var menu = new Menu2({:title=>"Settings"});
        var storageService = new StorageService();
        
        var parkItem = new MenuItem("Selected Park",storageService.getSelectedParkName(), "selected_park", null);
        menu.addItem(parkItem);

        var sortItem = new MenuItem("Sorted By", "Default", "selected_sorted", null);
        menu.addItem(sortItem);

        // delegate = new GeneralSettingsMenuDelegate(callback);

        // Push the Menu2 View set up in the initializer
        WatchUi.switchToView(menu, new GeneralSettingsMenuDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }
}