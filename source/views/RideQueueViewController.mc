using Toybox.WatchUi as Ui;
using Toybox.Application;
import Toybox.Application.Storage;

/*
 *  Controller that manages the partial RideQueueViews
 */
class RideQueueViewController {
    private var _agent as QueueTimesAgent;          // Agent for communicating with the QueueTimes API
    private var _selectedThemeparkId as Number;     // Selected Thempark id
    private var _callback as Method;                // Callback used for when initialization has happend

    /*
     *  All the ride pages that can be displayed
     */
    public var pages as Array<RideQueueView>;

    /*
     *  Currently shown page on the watch
     */
    public var currentPage as RideQueueView;

    /*
     *  Default constructor
     */
    function initialize(callback as Method){
        _agent = new QueueTimesAgent();
        _selectedThemeparkId = Storage.getValue("selected_themepark_id") != null ? Storage.getValue("selected_themepark_id") : 160;
        _callback = callback;
        _agent.getQueues(_selectedThemeparkId,method(:onInitDataRecieve));
    }

    public function showNextPage(){
        System.println(currentPage.id);
        if(currentPage.hasNext){
            currentPage = pages[currentPage.id + 1];
            Ui.switchToView(currentPage, new RideQueueDelegate(self), Ui.SLIDE_UP);
        }
    }

    public function showPrevPage(){
        if(currentPage.hasPrev){
            currentPage = pages[currentPage.id - 1];
            Ui.switchToView(currentPage, new RideQueueDelegate(self), Ui.SLIDE_DOWN);
        }
    }

    public function resetPage(){
        _selectedThemeparkId = Storage.getValue("selected_themepark_id") != null ? Storage.getValue("selected_themepark_id") : 160;
        _agent.getQueues(_selectedThemeparkId,method(:onInitDataRecieve));
    }

    public function showSettings(){
        var generalSettings = new GeneralSettings(method(:resetPage));
    }


    /*
     *  Triggered when data has been recieved about the ride queues
     */
    public function onInitDataRecieve(responseCode as Number, data as Dictionary?) as Void {
        if(responseCode != 200){
            System.println("Request has failed with " + responseCode + " as response");
            return;
        }

        pages = data["lands"].size() > 0 ? mapLandsToPages(data["lands"]) : mapRidesToPages(data["rides"]);
        currentPage = pages[0];
        _callback.invoke();
    }

    /*
     *  Map dictionary with lands to pages
     */
    private function mapLandsToPages(dataLands) as Array<RideQueueView>{
        var lands = new [0];
        var rides = new [0];

        for (var i = 0; i < dataLands.size(); i++) {
            lands.add(new Land(dataLands[i]));
            System.println(lands[i].name);
        }

        // Convert lands into rides into pages
        for (var i = 0; i < lands.size(); i++) {
            for(var j = 0; j < lands[i].rides.size(); j++){
                rides.add(lands[i].rides[j]);
            }
        }

        return generatePages(rides);
    }

    /*
     *  Map dictionary with rides to pages
     */
    private function mapRidesToPages(dataRides) as Array<RideQueueView>{
        System.println("MAP RIDES TO PAGES");
        var rides = new [0];
        System.println(dataRides);

        for (var i = 0; i < dataRides.size(); i++) {
            rides.add(new Ride(dataRides[i]));
            System.println(rides[i].name);
        }

        return generatePages(rides);
    }

    /*
     *  Generate views
     */
    private function generatePages(rides as Array<Ride>) as Array<RideQueueView>{
        var pages = new [0];
        var rideCount = 0;
        var pIndex = 0;
        for (var i = 0; i < rides.size(); i += 3)
        {
            pages.add(new RideQueueView(pIndex, rides.slice(i, i + 3),i > 0 , (i + 3) <= rides.size()));
            pIndex++;
        }

        return pages;
    }
}