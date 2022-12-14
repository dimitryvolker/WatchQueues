using Toybox.WatchUi;

/**
 *  Ride Queue view for displaying rides
 */
class RideQueueView extends WatchUi.View{
    private var _rides as Array<Ride>;
    private var _enableHeader = false;

    public var hasPrev as Boolean;
    public var hasNext as Boolean;
    public var id as Number;

    // Default Constructor
    function initialize(id as Number, rides as Array<Ride>, hasPrev as Boolean, hasNext as Boolean){
        View.initialize();
        self.id = id;
        _rides = rides;
        self.hasPrev = hasPrev;
        self.hasNext = hasNext;
    }

    /*
     *  Triggered when the view is updated (also triggers the first time it shows).
     */
    function onUpdate(dc) {
        // Set anti alias when device supports it.
        if(dc has :setAntiAlias) {
            dc.setAntiAlias(true);
        }

        var deviceHeight = dc.getHeight();
        var onePercent = deviceHeight.toFloat() / 100.0;
        var deviceWidth = dc.getWidth();

        // Call the parent onUpdate function to redraw the layout
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK); //Keep Bg color
        dc.clear();//Clear screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK); //Set text color
 
        // If there is a previous view we show a arrow that points upwards
        if(hasPrev){
            var hc = getHeader(dc);
            var upArrow = WatchUi.loadResource( Rez.Drawables.UpArrow ) as BitmapResource;
            hc.drawBitmapCenter(dc, upArrow);
        }

        // Draw the rides
        dRides(dc);

        // If there is a next view we show a arrow that points downwards
        if(hasNext){
            var fc = getFooter(dc);
            var downArrow = WatchUi.loadResource( Rez.Drawables.DownArrow ) as BitmapResource;
            fc.drawBitmapCenter(dc, downArrow);
        }
    }


    function dRides(dc){
        var cc = getContent(dc);
        for (var i = 0; i < _rides.size(); i++) {
            // Create a child container for the rendering
            var rideContainer = cc.addChildContainer(100.0 / 3);
            var queue = new Queue(_rides[i]);
            queue.draw(dc, rideContainer);
        }
    }
}