using Toybox.WatchUi;

public class QueueList extends WatchUi.Drawable {
    private var _lands as Array<Land>;
    private var _initPosition as Position;
    private var _gap as Number;
    private var _drawableHeight as Number;
    public var Height as Number;

    function initialize(params) {
        Drawable.initialize(params);
        _lands = params.get(:lands);
        _initPosition = params.get(:position);
        _gap = 10;
    }

    function draw(dc) {
        if(_lands == null){
            return;
        }
        var prevLandHeight = 0;
        for (var i = 0; i < _lands.size(); i++) {
            var position = new Position();
            position.x = _initPosition.x;
            position.y = _initPosition.y + ((_gap + prevLandHeight));
            System.println(position.y);

            var queueDrawable = new LandQueue({
                :land=>_lands[i],
                :position=>position
            });

            queueDrawable.draw(dc);
            prevLandHeight = prevLandHeight + (queueDrawable.Height + _gap);
        }
    }
} 