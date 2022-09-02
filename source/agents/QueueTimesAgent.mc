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
    public function getQueues(parkId as Number, callback as Method){
        var url = "/parks/" + parkId + "/queue_times.json";
        get(url, callback);
    }

    /*
        Retrieve all of the theme parks, grouped by their park group
    */
    public function getThemeParks(callback as Method) {
        var url = "parks.json";
        get(url, callback);
    }
}