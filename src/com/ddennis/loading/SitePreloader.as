package com.ddennis.loading {
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author ddennis.dk aka meresukker.dk aka fantastisk.dk - info@ddennis.dk
	 */
	public class SitePreloader extends MovieClip{
		
			
		
		
		/**
		* Alias for content LoaderInfo instance
		*/
		private var _targetLoaderInfo:LoaderInfo;
		/**
		* The percent loaded
		*/
		public var _loadPercent:Number = 0;
		private var m:DisplayObject;
		private var location_is_IDE:Boolean;
		
	
		
		/**
		* Constructor
		* Creates Loader instance, adds event listeners and begins loading content SWF.
		*/
		
		public function SitePreloader() {
					
			stage.align     = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE
			
					
		}
		
		
	
		
		
		
		public function loadFile(swfPath:String):void {
			
			var loader:Loader = new Loader();
			_targetLoaderInfo = loader.contentLoaderInfo;
			_targetLoaderInfo.addEventListener( ProgressEvent.PROGRESS, _loadingData );
			_targetLoaderInfo.addEventListener( Event.COMPLETE , _finishedLoading );
			
			location_is_IDE = Boolean (Capabilities.playerType == 'External') 
			
			
			if (location_is_IDE) {
				loader.load( new URLRequest(swfPath) );
				
			}else {
				var cacheDate:Number = new Date ().getTime ()
				loader.load( new URLRequest(swfPath = swfPath+"?nocache=" + cacheDate) );
			}
			
			
			stage.addEventListener(Event.RESIZE , stageResize)
			//stageResize (null)
			
		}
		
		
		
		
		public function stageResize(e:Event):void {
			
			//preloader.x = stage.stageWidth/2 - 20
			//preloader.y = stage.stageHeight/2 - preloader.height/2
			
			//preloadTxt.x = preloader.x //+ preloadTxt.width/2
			//preloadTxt.y = preloader.y + preloader.height +5
		
		}
		
		
		
		/**
		* Monitor loading progress and update progress bar.
		*/
		
		public function _loadingData( evt:ProgressEvent ):void {
			
			_loadPercent =  ( _targetLoaderInfo.bytesLoaded / _targetLoaderInfo.bytesTotal  ) 
			//preloader.preloadTxt.text = String (int(_loadPercent * 100)  )
			
								
		}
		
		/**
		* Remove event listeners and preloader, and attach content SWF to stage.
		*/
		
		
		private function _finishedLoading( evt:Event ):void {
			
			_targetLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, _loadingData );
			_targetLoaderInfo.removeEventListener( Event.COMPLETE , _finishedLoading );
			stage.removeEventListener(Event.RESIZE , stageResize)
						
			swfLoadedd (DisplayObject(LoaderInfo(evt.target).content))
				
		}
		
		
		public function swfLoadedd(mc:DisplayObject):void {
			
		}
		
		
	
		
	
		
		
	}

}