using Toybox.WatchUi;

public class LandQueue extends WatchUi.Drawable {
    private var _land as Land;
    private var _initPosition as Position;
    private var _gap as Number;
    private var _drawableHeight as Number;
    public var Height as Number;

    function initialize(params) {
        Drawable.initialize(params);
        _land = params.get(:land);
        _initPosition = params.get(:position);
        _drawableHeight = 47;
        _gap = 10; 

        System.println(_land.name);
        System.println("    Height calculation: ((" + _drawableHeight + " + " + _gap + ") * " + _land.rides.size() +") + 67" );

        Height = ((_drawableHeight + _gap) * _land.rides.size() )+ 67;
        System.println("    Result: " + Height);
        System.println("");
    }

    function draw(dc) {
        dc.drawText(_initPosition.x, _initPosition.y, Graphics.FONT_XTINY, _land.name, Graphics.TEXT_JUSTIFY_LEFT);
        _initPosition.y += 37;
        for (var i = 0; i < _land.rides.size(); i++) {
            var position = new Position();
            position.x = _initPosition.x;
            position.y = _initPosition.y + ((_gap + _drawableHeight)  * i);

            var queueDrawable = new RideQueue({
                :ride=>_land.rides[i],
                :position=>position
            });

            queueDrawable.draw(dc);
        }
    }
} 