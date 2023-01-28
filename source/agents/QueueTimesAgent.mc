import Toybox.System;
import Toybox.Communications;
import Toybox.Lang;
/*
    Agent for talking to the QueueTimes api
*/
class QueueTimesAgent extends BaseHttpAgent {

    /*
        Default constructor
    */
    public function initialize(){
        BaseHttpAgent.initialize("https://queue-times.com/nl/");
    }

    /*
        Retrieve the ride queues of a specific park
    */
    public function getQueues(parkId as Number, callback as Method(responseCode as Number, data as Null or Dictionary or String) as Void) as Void{
        var url = "/parks/" + parkId + "/queue_times.json";
        get(url, callback);
    }

    /*
        Retrieve all of the theme parks, grouped by their park group
    */
    public function getThemeParks(callback as Method(responseCode as Number, data as Null or Dictionary or String) as Void) {
        var url = "parks.json";
        get(url, callback);
    }
}
