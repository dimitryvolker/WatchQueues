import Toybox.System;
import Toybox.Lang;

/**
 * Park group that owns several parcs
 */
class ParkGroup {
    public var id as Number;
    public var name as String;
    public var parks as Array<Park or Null>;

    /**
    *  Default Constructor
    */
    function initialize(data as Dictionary) {
        id = data["id"];
        name = data["name"]; 
        
        var dataParks = data["parks"];
        parks = new[0];
        for (var i = 0; i < dataParks.size(); i++) {
            parks.add(new Park(dataParks[i]));
        }
    }
}