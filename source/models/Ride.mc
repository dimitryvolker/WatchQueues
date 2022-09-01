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
        isOpen = data["isOpen"];
        waitTime = data["waitTime"];
        lastUpdated = data["lastUpdated"];
    }
}