import Toybox.System;
import Toybox.Lang;

class Land {
    public var id as Number;
    public var name as String;
    public var rides as Array<Ride>;

    function initialize(data as Dictionary) {
        id = data["id"];
        name = data["name"];
        var dataRides = data["rides"];
        rides = new[0];
        for (var i = 0; i < dataRides.size(); i++) {
            rides.add(new Ride(dataRides[i]));
        }
    }
}