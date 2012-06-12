package com.ddennis.loading {
	
	import app.display.YoutubeVideoPlayer;
	import com.ddennis.loading.LoadSwf
	import com.ddennis.loading.VideoLoader
	import com.ddennis.loading.LoadImage;
	import flash.events.ProgressEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class MedieLoader extends EventDispatcher{
		
		public static var DATA_LOADED:String = "dataLoaded"
		
		private var imageLoaderOne:LoadImage;
		private var imageLoaderTwo:LoadImage;
		
		public var currentLoader:Sprite;
		public var oldLoader:Sprite;
		
		//private var videoLoader:VideoLoader;
		private var videoLoader:YoutubeVideoPlayer
		private var swfLoader:LoadSwf
		public var currentLoaderType:String;

			
		
		public function MedieLoader() {		
			
			imageLoaderOne = new LoadImage ()
			imageLoaderTwo = new LoadImage ()
			//videoLoader = new VideoLoader ()
			videoLoader = new YoutubeVideoPlayer ()
			
			swfLoader = new LoadSwf ()
			
		}
				
		
		
		public function update( path:String , type:String = "" ):void {
					
			if (type == "") {
				type = getFileExtension (path)				
			}
			
									
			switch (type) {
			
				case "image":
				currentLoaderType = type
				setCurrentLoader (findImageLoader (), path	)
				
				break;
				
				case "video":	
				
				trace ("   asdasdasd ")
				//trace ("   VIDEO SPILLES IKKE IGENNE MEDIE LOADER ")
				currentLoaderType = type
				setCurrentLoader (videoLoader, path)
								
				break;
				
				case "swf":		
				currentLoaderType = type
				setCurrentLoader (swfLoader, path)
					
				break;
				
				default:
					
				break;
			}
				
		}
		
		
		
		
		
		
		
		
		private function setCurrentLoader(cLoader:Sprite , path:String  ):void{
			
			
			if (currentLoader) {				
				
				oldLoader = currentLoader	
				oldLoader.removeEventListener(ProgressEvent.PROGRESS, progress) 
				oldLoader.removeEventListener(Event.COMPLETE , dataLoaded)
				
				/*
				if (oldLoader is VideoLoader) {
					ILoader (oldLoader).close ()					
				}*/
				
				if (oldLoader is LoadSwf) {					
					ILoader (oldLoader).close ()					
				}
				
			}
			
			currentLoader = cLoader 
			
			
			currentLoader.addEventListener(Event.COMPLETE , dataLoaded)
			currentLoader.addEventListener(ProgressEvent.PROGRESS, progress)
			ILoader (currentLoader).load (path)
						
		}
		
		
		
		
		
		private function progress(e:ProgressEvent):void {
			dispatchEvent (e)
		}
				
		
		private function dataLoaded(e:Event):void {
			trace ("   .................. ")
				trace ("MedieLoader.as > dataLoaded  = ")
				trace ("   .................. ")
			currentLoader.removeEventListener(ProgressEvent.PROGRESS, progress)
			currentLoader.removeEventListener(Event.COMPLETE , dataLoaded)			
			dispatchEvent(new Event(MedieLoader.DATA_LOADED))
			 
		}
		
		
		
		
		
		private function findImageLoader():LoadImage {
			
			if (currentLoader == imageLoaderOne || currentLoader == imageLoaderTwo) {
				
					if (currentLoader == imageLoaderOne) {					
						return imageLoaderTwo
						
					}else {					
						return imageLoaderOne
					}
					
			}else {								
				return imageLoaderOne
			}
			
			
		}
				
		
		
		public function cleanUp():void {
			
			videoLoader.stopVideo ()
			
		}
		
		
		
		
		//				 * Get the file extension of an URL
		 
		public static function getFileExtension(url:String):String		{
			
			var type:String 
			var s:String = url.substr(url.length - 4 , 4)
			s = s.toLowerCase ()
						
			if (s == ".jpg" || s == ".png" ) {
				
				type = "image"
			}else {
				type = "video"
			}
			
			
			return type
			
			
		}
		
		
	}

}