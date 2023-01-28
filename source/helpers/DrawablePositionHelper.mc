import Toybox.Application;
import Toybox.WatchUi;
import Toybox.Graphics;

function getHeader(dc as Dc) as DrawableContainer{
    var deviceHeight = dc.getHeight();
    var onePercent = deviceHeight.toFloat() / 100.0;
    var deviceWidth = dc.getWidth();

    var startPosition = new Position(0,0);
    var endPosition = new Position(deviceWidth, onePercent * 10);

    return new DrawableContainer(startPosition, endPosition);
}

function getContent(dc as Dc) as DrawableContainer{
    var deviceHeight = dc.getHeight();
    var onePercent = deviceHeight.toFloat() / 100.0;
    var deviceWidth = dc.getWidth();

    var startPosition = new Position(0,onePercent * 10);
    var endPosition = new Position(deviceWidth, startPosition.y + (onePercent * 80));

    return new DrawableContainer(startPosition, endPosition);
}

function getFooter(dc as Dc) as DrawableContainer{
    var deviceHeight = dc.getHeight();
    var onePercent = deviceHeight.toFloat() / 100.0;
    var deviceWidth = dc.getWidth();

    var startPosition = new Position(0,onePercent * 90);
    var endPosition = new Position(deviceWidth, onePercent * 10);

    return new DrawableContainer(startPosition, endPosition);
}
