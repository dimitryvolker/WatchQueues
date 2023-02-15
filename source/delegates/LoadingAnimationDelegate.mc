import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class LoadingAnimationDelegate extends AnimationDelegate {

    var _controller;

    function initialize(controller) {
        AnimationDelegate.initialize();
        _controller = controller;
    }

    function onAnimationEvent(event, options) {
        switch(event) {
            case WatchUi.ANIMATION_EVENT_COMPLETE:
            case WatchUi.ANIMATION_EVENT_CANCELED:
                _controller.animateLoading();
                break;
        }
    }
}