import Toybox.Lang;
import Toybox.Application;

/*
    Service for handling storage on the device
*/
class StorageService {
    private var _selectedParkIdKey = "selected_themepark_id";

    /*
     *  Set the selected park id into the storage of the device
     */
    public function setSelectedParkId(parkId as Number) as Void{
        Storage.setValue(_selectedParkIdKey, parkId);
    }

    /*
     *  Get the selected park id on the device
     */
    public function getSelectedParkId() as Number {
        return Storage.getValue(_selectedParkIdKey);
    }
}