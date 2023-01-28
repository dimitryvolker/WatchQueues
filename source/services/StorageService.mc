import Toybox.Lang;
import Toybox.Application;

/*
    Service for handling storage on the device
*/
class StorageService {
    private var _selectedParkIdKey = "selected_themepark_id";
    private var _selectedParkNameKey = "selected_themepark_name";

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
        return Storage.getValue(_selectedParkIdKey) != null ? Storage.getValue(_selectedParkIdKey) : 160;
    }

    /*
     *  Set the selected park name into the storage of the device
     */
    public function setSelectedParkName(parkName as String) as Void{
        Storage.setValue(_selectedParkNameKey, parkName);
    }

    /*
     *  Get the selected park name on the device
     */
    public function getSelectedParkName() as String {
        return Storage.getValue(_selectedParkNameKey) != null ? Storage.getValue(_selectedParkNameKey) : "Efteling";
    }
}