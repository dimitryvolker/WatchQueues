import Toybox.System;
import Toybox.Lang;

class Ride {
    public var id as Number;
    public var name as String;
    public var isOpen as Boolean;
    public var waitTime as Number;
    public var lastUpdated as String;

    function initialize(data as Dictionary) {
        System.println(data);
        
        id = data["id"];
        System.println("    " + id);
        name = data["name"];
        System.println("    " + name);
        isOpen = data["is_open"];
        System.println("    " + isOpen);
        waitTime = data["wait_time"];
        System.println("    " + waitTime);
        lastUpdated = data["last_updated"];
        System.println("    " + lastUpdated);

        
        System.println("");
    }
}