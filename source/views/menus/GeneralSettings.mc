import Toybox.WatchUi;
import Toybox.Application.Storage;

class GeneralSettings {
    public var menu as Menu2;
    // public var delegate as GeneralSettingsMenuDelegate;
    private var _parkItem as MenuItem;
    private var _sortItem as MenuItem;

    function initialize() {
        menu = new Menu2({:title=>"Settings"});
        var selectedThemepark = Storage.getValue("selected_themepark_label");
        System.println(selectedThemepark);

        var selectedThemparkLabel = "Efteling";
        if(selectedThemepark != null){
            selectedThemparkLabel = selectedThemepark;
        }

        _parkItem = new MenuItem("Selected Park",selectedThemparkLabel, "selected_park", null);
        menu.addItem(_parkItem);

        _sortItem = new MenuItem("Sorted By", "Default", "selected_sorted", null);
        menu.addItem(_sortItem);

        // delegate = new GeneralSettingsMenuDelegate(callback);

        // Push the Menu2 View set up in the initializer
        WatchUi.switchToView(menu, null, WatchUi.SLIDE_IMMEDIATE);
    }
}