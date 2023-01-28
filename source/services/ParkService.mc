import Toybox.Lang;

/*
    Service for handling storage on the device
*/
class ParkService {
    private var _agent as QueueTimesAgent;          // Agent for communicating with the QueueTimes API
    private var _selectedThemeparkId as Number;     // Selected Thempark id
    private var _storageService as StorageService;  // Service for handling storage on the garmin device
    private var _onQueueTimesUpdated as Method;    // Callback method triggered when new data has been added

    /*
        Default constructor
    */
    public function initialize(onQueueTimesUpdated as Method){
        _agent = new QueueTimesAgent();
        _storageService = new StorageService();
        _selectedThemeparkId = _storageService.getSelectedPark();
        _onQueueTimesUpdated = onQueueTimesUpdated;
    }

    /*
        Retrieves the rides of a selected themepark
    */
    public function getRidesOfSelectedThemepark() as Void{
        var localRides =  _storageService.getRides(_selectedThemeparkId);

        // If whe have the rides cached we can return them
        if(localRides != null || localRides.size() > 0){
            _onQueueTimesUpdated.invoke(localRides);
        }

        _agent.getQueues(_selectedThemeparkId, method(:onQueueDataRecieved));
    }

    /*
    *  Triggered when data has been recieved about the ride queues
    */
    public function onQueueDataRecieved(responseCode as Number, data as Dictionary or String or Null) as Void {
        if(responseCode != 200){
            System.println("Request has failed with " + responseCode + " as response");
            return;
        }

        var rides = data["lands"].size() > 0 ? mapLandResponseToRides(data["lands"]) : mapRidesResponseToRides(data["rides"]);
        _onQueueTimesUpdated.invoke(rides);
        _storageService.saveRides(_selectedThemeparkId, rides);
    }

    /*
     *  Map dictionary with lands to rides
     */
    private function mapLandResponseToRides(dataLands) as Array<Ride>{
        var lands = new [0];
        var rides = new [0];

        for (var i = 0; i < dataLands.size(); i++) {
            lands.add(new Land(dataLands[i]));
        }

        // Convert lands into rides into pages
        for (var i = 0; i < lands.size(); i++) {
            for(var j = 0; j < lands[i].rides.size(); j++){
                rides.add(lands[i].rides[j]);
            }
        }

        return rides;
    }

    /*
     *  Map dictionary to ride objects
     */
    private function mapRidesResponseToRides(dataRides) as Array<Ride>{
        var rides = new [0];
        for (var i = 0; i < dataRides.size(); i++) {
            rides.add(new Ride(dataRides[i]));
            System.println(rides[i].name);
        }

        return rides;
    }
}