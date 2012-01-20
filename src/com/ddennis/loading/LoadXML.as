package com.ddennis.loading {
	
	
	import com.ddennis.display.text.TextBox;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author ddennis.dk aka meresukker.dk aka fantastisk.dk - info@ddennis.dk
	 */
	
	public class LoadXML extends EventDispatcher{
		
		private var loader:URLLoader;
		
		public var xml:XML;
		private var tb:TextBox;
		
		public function LoadXML(path:String) {
			
			
			var location_is_IDE:Boolean  = Boolean (Capabilities.playerType == 'External') 
			
			if (location_is_IDE) {
				
				
				
			}else {
				var cacheDate:Number = new Date ().getMilliseconds()
				path = path+"?nocache=" + cacheDate
				
			}
			
			loader = new URLLoader(new URLRequest (path));
			loader.dataFormat = "text"
		
			loader.addEventListener(Event.COMPLETE , xmlLoaded)
			loader.addEventListener(ProgressEvent.PROGRESS , loadProgress)
				
		}
	
		
		private function loadProgress(e:ProgressEvent):void {
			//trace ("   = "+e)
				//trace ("   = " + e.bytesTotal)
				//trace ("   = " + e.bytesLoaded)
						
				
				dispatchEvent (e)
			
		}
		
				
		
		
		private function xmlLoaded(e:Event):void {		
			
			loader.removeEventListener(Event.COMPLETE , xmlLoaded)
			loader.removeEventListener(ProgressEvent.PROGRESS , loadProgress)
					
			// parse XML ------------------------------
			xml = new XML(e.target.data);	
			
			dispatchEvent(e)
			
			
		}	
		
			
		
		
	}

}