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

    /**
     *  Send a GET Request 
     */
    protected function get(url as String, callback as Method(responseCode as Number, data as Null or Dictionary or String) as Void) as Void {
        System.println("Sending get request to " + _baseUrl + url);
        var options = {                                             
            :method => Communications.HTTP_REQUEST_METHOD_GET,      
            :headers => { "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON },
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };

        Communications.makeWebRequest(_baseUrl + url, {}, options, callback);
    }
}