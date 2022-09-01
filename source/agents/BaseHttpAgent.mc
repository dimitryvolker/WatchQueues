import Toybox.System;
import Toybox.Communications;
import Toybox.Lang;

class BaseHttpAgent {
    protected var _baseUrl;

    /**
    *  Default Constructor
    */
    public function initialize(baseUrl as String){
        _baseUrl = baseUrl;
    }

    // function onReceive(responseCode as Number, data as Dictionary?) as Void {
    //     if (responseCode == 200) {
    //         System.println("Request Successful");                   // print success
    //         System.println(data[0]["name"]);

    //         var test = data as Array<ParkGroup>;
    //         System.println(test[1]);
    //     } else {
    //         System.println("Response: " + responseCode);            // print response code
    //     }
    // }

    /**
     *  Send a GET Request 
     */
    protected function get(url as String, callback) as Void {
        System.println("Sending get request to " + _baseUrl + url);
        var options = {                                             
            :method => Communications.HTTP_REQUEST_METHOD_GET,      
            :headers => { "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON },
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };

        Communications.makeWebRequest(_baseUrl + url, {}, options, callback);
    }
}