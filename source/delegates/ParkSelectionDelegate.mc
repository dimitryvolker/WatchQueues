import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class ParkSelectionDelegate extends Menu2InputDelegate {
    private var _storageService as StorageService;

    function initialize() {
        Menu2InputDelegate.initialize();
        _storageService = new StorageService();
    }

    function onSelect(item as MenuItem) {
        var selectedItemId = item.getId();
        var selectedItemLabel = item.getLabel();

        _storageService.setSelectedParkId(selectedItemId.toNumber());
        _storageService.setSelectedParkName(selectedItemLabel);
        var _ = new GeneralSettings();

        return true;
    }

    function onBack() as Boolean {
        var _ = new GeneralSettings();
        return true;
    }
}