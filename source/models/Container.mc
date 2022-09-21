using Toybox.Application;

class Container{
    public var width as float;
    public var height as float;
    public var start as Position;
    public var end as Position;
    var _children as Dictionary;

    /**
     * Default Constructor
     * @constructor
     */
    public function initialize(start as Position, end as Position) {
        me.start = start;
        me.end = end;
        me.width = start.x + end.x;
        me.height = end.y - start.y;
        me._children = {};
    }

    /**
    * Draw a BitMap object within the container
    * @param {Dc} dc - Dc object of the related view
    * @param {Float} pos - Starting position (PERCENTAGE) of the bitmap (will be relative to the container)
    * @param {BitmapResource} bitmap - The BitmapResource
    */
    public function drawBitmapCenter(dc as Dc, bitmap as BitmapResource){
       dc.drawBitmap((me.width / 2) - (bitmap.getWidth() / 2), me.start.y, bitmap);
    }

    /**
    * Draw a BitMap object within the container
    * @param {Dc} dc - Dc object of the related view
    * @param {Float} pos - Starting position (PERCENTAGE) of the bitmap (will be relative to the container)
    * @param {BitmapResource} bitmap - The BitmapResource
    */
    public function drawBitmap(dc as Dc, pos as Position, bitmap as BitmapResource){
       var exactPos = calculateRelativePosition(pos);
       dc.drawBitmap(exactPos.x, exactPos.y, bitmap);
    }

    /**
    * Add a new container within this container
    * @param {Float} height - height (PERCENTAGE) of the new container
    * @returns New container
    */
    public function addChildContainer(height as Float){
        // Calculate the position based on the last child
        if(_children.size() == 0){
            var child = new Container(me.start, new Position(me.end.x, (me.height / 100) * height + me.start.y));
            _children.put(_children.size(), child);
            return child;
        }

        var prevChild = _children.get(_children.size() - 1);
        var child = new Container(new Position(me.start.x, prevChild.end.y), new Position(me.end.x, (me.height / 100) * height + prevChild.end.y));
        _children.put(_children.size(), child);
        return child;
    }

    /**
    * Draws a filled rectangle within the container. Also prints properties to the console
    * @param {Dc} dc - Dc object of the related view
    * @param {Color} color
    */
    public function drawDebug(dc, color){
        dc.setColor(color, Graphics.COLOR_BLACK); //Set text color
        dc.fillRectangle(me.start.x, me.start.y, me.width, me.height);

        System.println("drawDebug");
        System.println("    start.x" + me.start.x);
        System.println("    start.y" + me.start.y);
        System.println("    end.x" + me.end.x);
        System.println("    end.y" + me.end.y);
        System.println("    width" + me.width);
        System.println("    height" + me.height);

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK); //Set text color
    }

    /**
    * Calculate the relative position compared to the container
    * @param {Position} pos - Position with percentages
    * @returns Exact position within the container
    */
    function calculateRelativePosition(pos as Position){
        return new Position(me.width / 100 * pos.x, me.height / 100 * pos.y);
    }
}