using Toybox.WatchUi;
using Toybox.Graphics;

public class RideQueue extends WatchUi.Drawable { 
    private var _ride as Ride;
    private var _initPosition as Position;
    private const _marginLeft = 30;
    public var Height = 37;

    function initialize(params){
        Drawable.initialize(params);
        _ride = params.get(:ride);
        _initPosition = params.get(:position);
    }

    function draw(dc) {
        dc.drawText(_initPosition.x + _marginLeft, _initPosition.y, Graphics.FONT_XTINY, _ride.name, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawLine(_initPosition.x + _marginLeft, _initPosition.y + 25, (_initPosition.x + _marginLeft)+200, _initPosition.y + 25);
        if(_ride.isOpen){
            if(_ride.waitTime <= 15){
                dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
            }else if(_ride.waitTime <= 30d){
                dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
            }else{
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
            }
            dc.drawText(_initPosition.x + _marginLeft, _initPosition.y + 25, Graphics.FONT_XTINY, _ride.waitTime + " minuten wachten", Graphics.TEXT_JUSTIFY_LEFT);
        }else{
            dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(_initPosition.x + _marginLeft, _initPosition.y + 25, Graphics.FONT_XTINY, "Vandaag gesloten", Graphics.TEXT_JUSTIFY_LEFT);
        }
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    }
}