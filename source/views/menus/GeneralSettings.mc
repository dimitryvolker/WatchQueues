using Toybox.WatchUi as Ui;
import Toybox.Application.Storage;

class GeneralSettings {
    public var menu as WatchUI.Menu2;
    public var delegate as GeneralSettingsMenuDelegate;
    private var _parkItem as WatchUI.MenuItem;
    private var _sortItem as WatchUI.MenuItem;

    function initialize(callback) {
        menu = new Ui.Menu2({:title=>"Settings"});
        var selectedThemepark = Storage.getValue("selected_themepark_label");
        System.println(selectedThemepark);

        var selectedThemparkLabel = "Efteling";
        if(selectedThemepark != null){
            selectedThemparkLabel = selectedThemepark;
        }

        _parkItem = new Ui.MenuItem("Selected Park",selectedThemparkLabel, "selected_park", null);
        menu.addItem(_parkItem);

        _sortItem = new Ui.MenuItem("Sorted By", "Default", "selected_sorted", null);
        menu.addItem(_sortItem);

        delegate = new GeneralSettingsMenuDelegate(callback);

        // Push the Menu2 View set up in the initializer
        WatchUi.switchToView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
    }
}