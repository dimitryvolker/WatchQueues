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

    function onUpdate(dc) {
        if(dc has :setAntiAlias) {
            dc.setAntiAlias(true);
        }

        // Call the parent onUpdate function to redraw the layout
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK); //Keep Bg color
        dc.clear();//Clear screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK); //Set text color
        
        // If there is a previous view we show a arrow that points upwards
        if(_hasPrev){
            var upArrow = WatchUi.loadResource( Rez.Drawables.UpArrow ) as BitmapResource;
            dc.drawBitmap( (dc.getWidth() / 2) - (upArrow.getWidth() / 2), 0, upArrow );
        }

        // Draw the rides
        drawRides(dc);

        // If there is a next view we show a arrow that points downwards
        if(_hasNext){
            var downArrow = WatchUi.loadResource( Rez.Drawables.DownArrow ) as BitmapResource;
            dc.drawBitmap( (dc.getWidth() / 2) - (downArrow.getWidth() / 2), dc.getHeight() - downArrow.getHeight(), downArrow );
        }
    }

    function drawRides(dc){
        var gap = 8;
        var rideHeight = 47;
        var initPosition = new Position();
        initPosition.x = 33;
        initPosition.y = 48;

        for (var i = 0; i < _rides.size(); i++) {
            var position = new Position();
            position.x = initPosition.x;
            position.y = initPosition.y + ((gap + rideHeight)  * i);

            var queueDrawable = new RideQueue({
                :ride=>_rides[i],
                :position=>position
            });

            queueDrawable.draw(dc);
        }
    }
}