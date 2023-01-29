import Toybox.Lang;
import Toybox.Timer;
import Toybox.System;

/*
    Service for handling storage on the device
*/
class ParkService {
    private var _agent as QueueTimesAgent;
    private var _timer as Timer;                                                // Agent for communicating with the QueueTimes API
    private var _selectedThemeparkId as Number;                                                 // Selected Thempark id
    private var _storageService as StorageService;                                              // Service for handling storage on the garmin device
    private var _onQueueTimesUpdated as Method(rides as Array<Dictionary>) as Void or Null;     // Callback method triggered when new data has been added
    private var _onParksReceived as Method(parks as Array<Dictionary>) as Void or Null;
    
    /*
     *   Default constructor
     */
    public function initialize(onQueueTimesUpdated as Method(rides as Array<Dictionary>) as Void or Null, onParksReceived as Method(parks as Array<Dictionary>) as Void or Null){
        _agent = new QueueTimesAgent();
        _storageService = new StorageService();
        _selectedThemeparkId = _storageService.getSelectedParkId();
        _onQueueTimesUpdated = onQueueTimesUpdated;
        _onParksReceived = onParksReceived;
        _timer = new Timer.Timer();
    }

    /*
     *   Retrieves the rides of a selected themepark
     */
    public function fetchRides() as Void{
        fetchRidesTimerCallback();
        _timer.start(method(:fetchRidesTimerCallback), 10000, true);
    }

    public function fetchRidesTimerCallback() as Void{
        System.println("Checking queue times");
        _agent.getQueues(_selectedThemeparkId, method(:onQueueDataRecieved));
    }

    /*
     *   Retrieves all the parks to select
     */
    public function fetchParks() as Void{
        _agent.getThemeParks(method(:onParkDataRecieved));
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

     /*
    *  Triggered when data has been recieved about the ride queues
    */
    public function onParkDataRecieved(responseCode as Number, data as Dictionary or String or Null) as Void {
        if(responseCode != 200){
            System.println("Request has failed with " + responseCode + " as response");
            return;
        }

        var parks = []; // Park collections
        for (var i = 0; i < data.size() as Number; i++) {
            parks.addAll(data[i]["parks"]);
        }

        _onParksReceived.invoke(parks);
    }
}