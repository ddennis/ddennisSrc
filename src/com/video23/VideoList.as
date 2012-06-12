package com.video23 {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class VideoList extends EventDispatcher {
		
		private var loader:URLLoader;
		private var videoListXml:XML;
		private var video23ListPath:String
		private var rootPath:String;
		
		/**
		 * @example ddennis.23video.com/api/photo/list.23video.com/api/photo/list
		 * @usage  path.23video.com/api/photo/list.23video.com/api/photo/list
		 * @param	23 video channel name - must be to a 23 video channel
		 */
		
		
		public function VideoList(video23ChannelUrl:String ) {		
			
			rootPath =  video23ChannelUrl 
			video23ListPath = video23ChannelUrl + "/api/photo/list"			
			
			loadXML(video23ListPath)
			
		}
		
		
		public function videoPathFromId(id:String, size:String = "video_medium_download"):String {		
			
			var videoPath:XMLList = videoListXml.photo.(@photo_id == id).attribute(size)
			return rootPath + videoPath
			
		}
		
		
		private function loadXML(path:String ):void {
						
			loader = new URLLoader(new URLRequest (path));
			loader.dataFormat = "text"		
			loader.addEventListener(Event.COMPLETE , xmlLoaded)
			//loader.addEventListener(ProgressEvent.PROGRESS , loadProgress)
			
		}
		
		private function xmlLoaded(e:Event):void {		
			
			loader.removeEventListener(Event.COMPLETE , xmlLoaded)
			//loader.removeEventListener(ProgressEvent.PROGRESS , loadProgress)					
			// parse XML ------------------------------------------------
			videoListXml = new XML(e.target.data);				
			trace ("VideoList.as >videoListXml  = " + videoListXml)		
			trace ("   *******************************")
			dispatchEvent(e)
			
			
		}	
		
		
	}

}