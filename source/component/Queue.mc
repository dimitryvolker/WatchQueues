import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Lang;

public class Queue {
    private var _queueTime as Number;
    private var _queueName as String;
    private var _queueOpen as Boolean;

    function initialize(queueTime as Number, queueName as String, queueOpen as Boolean){
        _queueTime = queueTime;
        _queueName = queueName;
        _queueOpen = queueOpen;
    }

    function draw(dc as Dc, container as DrawableContainer) {
        var containerWidthPercentage = container.width / 100;
        var containerHeightPercentage = container.width / 100;
        var marginLeft = container.start.x + containerWidthPercentage * 20;
        var marginRight = container.width - (containerWidthPercentage * 40);
        var queueBarMarginTop = (containerHeightPercentage * 20) - 2;

        dc.drawText(marginLeft, container.start.y, Graphics.FONT_TINY, _queueName, Graphics.TEXT_JUSTIFY_LEFT);
        var stringHeight = dc.getTextDimensions(_queueName, Graphics.FONT_TINY);
        dc.fillRectangle(marginLeft, (container.start.y + stringHeight[1]) + (containerHeightPercentage * 2), marginRight, 2);

        var queueLabelMargin = (container.start.y + stringHeight[1]) + (containerHeightPercentage * 2);
        if(_queueOpen){
            if(_queueTime <= 15){
                dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
            }else if(_queueTime <= 30d){
                dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
            }else{
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
            }
            dc.drawText(marginLeft, queueLabelMargin, Graphics.FONT_XTINY, _queueTime + " minuten wachten", Graphics.TEXT_JUSTIFY_LEFT);
        }else{
            dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(marginLeft, queueLabelMargin, Graphics.FONT_XTINY, "Vandaag gesloten", Graphics.TEXT_JUSTIFY_LEFT);
        }
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    }
}
