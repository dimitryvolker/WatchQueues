import Toybox.Lang;

/*
    Service for handling storage on the device
*/
class ParkService {
    private var _agent as QueueTimesAgent;                                              // Agent for communicating with the QueueTimes API
    private var _selectedThemeparkId as Number;                                         // Selected Thempark id
    private var _storageService as StorageService;                                      // Service for handling storage on the garmin device
    private var _onQueueTimesUpdated as Method(rides as Array<Dictionary>) as Void;     // Callback method triggered when new data has been added

    /*
     *   Default constructor
     */
    public function initialize(onQueueTimesUpdated as Method(rides as Array<Dictionary>) as Void){
        _agent = new QueueTimesAgent();
        _storageService = new StorageService();
        _selectedThemeparkId = _storageService.getSelectedParkId();
        _onQueueTimesUpdated = onQueueTimesUpdated;
    }

    /*
     *   Retrieves the rides of a selected themepark
     */
    public function fetchRides() as Void{
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

        var rides = []; // Rides collection
        
        // Queue-times can divide a theme park into so called "lands" 
        if(data["lands"].size() as Number > 0){
            for (var i = 0; i < data["lands"].size() as Number; i++) {
                var land = data["lands"][i];
                var landRides = land["rides"];
                var x = landRides[0];
                rides.addAll(landRides);
            }
        }else{
            rides.addAll(data["rides"]);
        }

        _onQueueTimesUpdated.invoke(rides);
    }
}