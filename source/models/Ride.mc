import Toybox.System;
import Toybox.Lang;

class Ride {
    public var id as Number;
    public var name as String;
    public var isOpen as Boolean;
    public var waitTime as Number;
    public var lastUpdated as String;

    function initialize(data as Dictionary) {
        id = data["id"];
        name = data["name"];
        isOpen = data["is_open"];
        waitTime = data["wait_time"];
        lastUpdated = data["last_updated"];
    }
}