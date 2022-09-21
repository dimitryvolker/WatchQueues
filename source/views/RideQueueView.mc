using Toybox.WatchUi;

/**
 *  Ride Queue view for displaying rides
 */
class RideQueueView extends WatchUi.View{
    private var _rides as Array<Ride>;
    private var _hasPrev as Boolean;
    private var _hasNext as Boolean;
    private var _enableHeader = false;

    // Default Constructor
    function initialize(rides as Array<Ride>, hasPrev as Boolean, hasNext as Boolean){
        View.initialize();
        _rides = rides;
        _hasPrev = hasPrev;
        _hasNext = hasNext;
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

        System.println(deviceHeight.toFloat());
        System.println(onePercent);

        var hc = getHeader(dc);
        var fc = getFooter(dc);
        var cc = getContent(dc);
        cc.drawDebug(dc, Graphics.COLOR_GREEN);

        var ride = cc.addChildContainer(100.0 / 3.0);
        ride.drawDebug(dc, Graphics.COLOR_PINK);

        var rideTwo = cc.addChildContainer(100.0 / 3.0);
        rideTwo.drawDebug(dc, Graphics.COLOR_YELLOW);

        var rideThree = cc.addChildContainer(100.0 / 3.0);
        rideThree.drawDebug(dc, Graphics.COLOR_BLUE);

        // var headerRow = dc.fillRectangle(hc.start.x, hc.start.y, hc.width, hc.height);


        var upArrow = WatchUi.loadResource( Rez.Drawables.UpArrow ) as BitmapResource;
        hc.drawBitmapCenter(dc, upArrow);



        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK); //Set text color
        var downArrow = WatchUi.loadResource( Rez.Drawables.DownArrow ) as BitmapResource;
        fc.drawBitmapCenter(dc, downArrow);
 
        // // If there is a previous view we show a arrow that points upwards
        // if(_hasPrev){
        //     var upArrow = WatchUi.loadResource( Rez.Drawables.UpArrow ) as BitmapResource;
        //     dc.drawBitmap( (dc.getWidth() / 2) - (upArrow.getWidth() / 2), 0, upArrow );
        // }

        // // Draw the rides
        // drawRides(dc);

        // // If there is a next view we show a arrow that points downwards
        // if(_hasNext){
        //     var downArrow = WatchUi.loadResource( Rez.Drawables.DownArrow ) as BitmapResource;
        //     dc.drawBitmap( (dc.getWidth() / 2) - (downArrow.getWidth() / 2), dc.getHeight() - downArrow.getHeight(), downArrow );
        // }
    }

    /*
     *  Draw the ride drawables for the view
     */
    function drawRides(dc){
        var gap = 8;
        var rideHeight = 47;
        var initPosition = new Position(33,48);

        for (var i = 0; i < _rides.size(); i++) {
            var position = new Position(initPosition.x, initPosition.y + ((gap + rideHeight)  * i));

            var queueDrawable = new RideQueue({
                :ride=>_rides[i],
                :position=>position
            });

            queueDrawable.draw(dc);
        }
    }
}