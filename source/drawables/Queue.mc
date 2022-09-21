using Toybox.WatchUi;
using Toybox.Graphics;

public class Queue {
    public var ride as Ride;
    public var marginLeft = 40;

    function initialize(ride as Ride){
        me.ride = ride;
    }

    function draw(dc as Dc, container as Container) {
        var containerWidthPercentage = container.width / 100;
        var containerHeightPercentage = container.width / 100;
        var marginLeft = container.start.x + containerWidthPercentage * 20;
        var marginRight = container.width - (containerWidthPercentage * 40);
        var queueBarMarginTop = (containerHeightPercentage * 20) - 2;

        dc.drawText(marginLeft, container.start.y, Graphics.FONT_TINY, ride.name, Graphics.TEXT_JUSTIFY_LEFT);
        var stringHeight = dc.getTextDimensions(ride.name, Graphics.FONT_TINY);
        dc.fillRectangle(marginLeft, (container.start.y + stringHeight[1]) + (containerHeightPercentage * 2), marginRight, 2);

        var queueLabelMargin = (container.start.y + stringHeight[1]) + (containerHeightPercentage * 2);
        if(ride.isOpen){
            if(ride.waitTime <= 15){
                dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
            }else if(ride.waitTime <= 30d){
                dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
            }else{
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
            }
            dc.drawText(marginLeft, queueLabelMargin, Graphics.FONT_XTINY, ride.waitTime + " minuten wachten", Graphics.TEXT_JUSTIFY_LEFT);
        }else{
            dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(marginLeft, queueLabelMargin, Graphics.FONT_XTINY, "Vandaag gesloten", Graphics.TEXT_JUSTIFY_LEFT);
        }
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    }
}