using Toybox.WatchUi as Ui;

class OverviewDelegate extends Ui.BehaviorDelegate {
    hidden var _view;

    function initialize(view) {
        BehaviorDelegate.initialize();
        _view = view;
    }

    function onKeyPressed(keyEvent){
        System.println(keyEvent.getKey());
        if(keyEvent.getKey() == 8){
            _view.scrollDown();
        }

        if(keyEvent.getKey() == 13){
            _view.scrollUp();
        }
    }
}

class Overview extends Ui.View {
    var dcHeight, dcWidth, dcWidthBM; //Device screen dimensions
    var scrollY;
    private var _agent as QueueTimesAgent;
    private var _lands as Array<Land>;

    function initialize() {
        View.initialize();
        _agent = new QueueTimesAgent();
    }

    function scrollUp() {
        scrollY += 50;
        WatchUi.requestUpdate();
    }

    function scrollDown() {
        scrollY -= 50;
        WatchUi.requestUpdate();
    }

    // Handle layout
    function onLayout(dc) {
        dcHeight = dc.getHeight();
        dcWidth = dc.getWidth()/3; //Divide by tree to right align text
        dcWidthBM = dc.getWidth()/8; //Left align bitmap icons
        scrollY = 0;

        System.println("Device height: " + dcHeight);
        System.println("Device width: " + dcWidth);
        System.println("Device width bm: " + dcWidthBM);
    }

    // Handle becoming visible
    function onShow() {
        _agent.getQueues(160,method(:onInitDataRecieve));
    }

    function onUpdate(dc) {
        if(dc has :setAntiAlias) {
            dc.setAntiAlias(true);
        }
        // Call the parent onUpdate function to redraw the layout
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK); //Keep Bg color
        dc.clear();//Clear screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK); //Set text color

        var initPosition = new Position();
        initPosition.x = 20;
        var pos = 75 + scrollY;
        if(pos < 75){
            initPosition.y = pos;
        }else{
            initPosition.y = 75;
        }

        var queueDrawable = new QueueList({
            :lands=>_lands,
            :position=>initPosition
        });
        // // Call the parent onUpdate function to redraw the layout
        // // System.println(label.setText("Parks found: 22"));
        // View.onUpdate(dc);
        queueDrawable.draw(dc);
    }

    public function onInitDataRecieve(responseCode as Number, data as Dictionary?) as Void {
        if (responseCode == 200) {
            var dataLands = data["lands"];
            _lands = new [0];
            for (var i = 0; i < dataLands.size(); i++) {
                _lands.add(new Land(dataLands[i]));
            }

            WatchUi.requestUpdate();
        } else {
            System.println("Response: " + responseCode);            // print response code
        }
    }
}