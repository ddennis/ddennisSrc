package com.ddennis.social {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.graph.Facebook;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	OverwriteManager.init(OverwriteManager.AUTO); 
	
	//TweenPlugin.activate ([AutoAlphaPlugin]); 
	
	
	/**
	 * ... app.util.FacebookMediator
	 * @author ddennis.dk aka meresukker.dk aka fantastisk.dk - info@ddennis.dk
	 */
	public class FacebookMediator extends MovieClip {
		
		public static const LOGIN_COMPLETE:String ="loginComplete"
		public static const LOGIN_FAIL:String = "loginFail"
		public static const POST_COMPLETE:String = "postComplete"
		public static const POST_FAIL:String = "postFail"
		
		public static const APP_ID:String = ""
		
		private var _isLoggedIn:Boolean;
		
		public function FacebookMediator() {
			
		}

		
		
		public function init():void {
		
			Facebook.init(APP_ID, onInit);	
			
		}
		
		
		public function handleLogin():void {			
			var opts:Object = {scope:"publish_stream"};
			Facebook.login(onLogin, opts);
		}	
		
		
		private function onInit(result:Object, fail:Object):void {			
			if (result) { //already logged in because of existing session					
				_isLoggedIn = true				
				dispatchEvent(new Event(FacebookMediator.LOGIN_COMPLETE)) 				
			} else {
				_isLoggedIn = false
				dispatchEvent(new Event(FacebookMediator.LOGIN_FAIL))
			}			
		}
		
		
		private function onLogin(result:Object, fail:Object):void {
			if (result) { //successfully logged in
				_isLoggedIn = true	
				dispatchEvent(new Event(FacebookMediator.LOGIN_COMPLETE))				
			} else {
				_isLoggedIn = false		
				dispatchEvent(new Event(FacebookMediator.LOGIN_FAIL))
			}
		}
		
		
/////////////////////////////////////////////////////////////////////////////////////////////
		
		// Kald til FB.ui
		
		public function postLink(linkUrl:String, titleTxt:String = "title", descriptionTxt:String = "des" ):void {	
			
			// hvilke type der skal kaldes
			var method:String = "feed";
						
				var data:Object = { };				
				var obj:String =  String ( '{ "name": " ' + titleTxt  +  '", "link": "' +  linkUrl+ '" ,"picture" : "http://path to image/img/fb_share.png", "description": "'+ descriptionTxt+ '"}'  )
				  
				try {
															
					data = JSON.decode(obj);	
									
				} catch (e:Error) {
					
					//trace ("FacebookMediator.as > \n\nERROR DECODING JSON: " + e.message)
					//outputTxt.appendText("\n\nERROR DECODING JSON: " + e.message);
				}			
			
				Facebook.ui(method, data, onUICallback);
					
		}
		
		
		
		private function onUICallback(result:Object):void {
			var r:String = String ( JSON.encode(result)  )
			
			trace ("FacebookMediator.as > onUICallback  = ")
			trace ("FacebookMediator.as > r  = " + r)
			
			
			if (r == "null" ) {
				
				dispatchEvent(new Event(FacebookMediator.POST_FAIL))
				
			}else {
				
				dispatchEvent(new Event(FacebookMediator.POST_COMPLETE))
			}
			
			
			
		}
		
		public function get isLoggedIn():Boolean { return _isLoggedIn; }
		
		
		
		
		
		
		
		
		
	}
	
}