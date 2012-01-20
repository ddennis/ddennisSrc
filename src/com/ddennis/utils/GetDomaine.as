
package{

import flash.display.LoaderInfo
import flash.display.MovieClip


public class GetDomaine extends MovieClip {
    public var urlStr:String;

    public function GetDomaine (){
        getLocation(this.loaderInfo.url);

    }
	
	
    public function getLocation(urlStr:String){
        var urlPattern:RegExp = new RegExp("http://(www|).*?\.(com|org|net)","i");
        var found:Object =  urlPattern.exec(urlStr);
        trace(found[0]);

    }

}

}
















