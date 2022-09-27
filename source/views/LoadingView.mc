using Toybox.WatchUi;

class LoadingView extends WatchUi.View {
    function initialize(){
        View.initialize();
    }

    /*
     *  Triggered when the view is updated (also triggers the first time it shows).
     */
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK); //Keep Bg color
        dc.clear();//Clear screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK); //Set text color

        if(dc has :setAntiAlias) {
            dc.setAntiAlias(true);
        }

        // Get the middle of the screen
        var cc = getContent(dc);
        var loadingImage = WatchUi.loadResource( Rez.Drawables.LauncherIcon ) as BitmapResource;
        cc.drawBitmapCenter(dc, loadingImage);
    }
}