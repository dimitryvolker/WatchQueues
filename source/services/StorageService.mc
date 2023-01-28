import Toybox.Lang;
import Toybox.Application;

/*
    Service for handling storage on the device
*/
class StorageService {
    private var _parksStorageLocation = "parks";
    private var _ridesStorageLocation = "rides";

    /*
        Save lands on the device
    */
    public function saveRides(themeparkId as Number, rides as Array<Ride>){
        Storage.setValue("rides_" + themeparkId, rides);
    }

    public function getRides(themeparkId as Number) as Array<Ride>{
        return Storage.getValue("rides_" + themeparkId);
    }

    public function getSelectedPark() as Number{
        return Storage.getValue("selected_themepark_id") != null ? Storage.getValue("selected_themepark_id") : 160;
    }

}