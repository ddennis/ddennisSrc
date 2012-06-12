package com.ddennis.pages {
	
	import com.ddennis.loading.LoadSwf;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class Page extends MovieClip{
				
		private var isLoading:Boolean = false;
		private var _pageNode:XML;
		
		public var inited:Boolean = false		
		public var scrollContent:Sprite
		
		public var loadProgress:Number;
		public var data:Object;		
		public var indexNum:int
		public var isCreated:Boolean = false
		public var loader:LoadSwf;		
		public var assetPage:AbstractPage;
		
		
	//##########################################################################################################
		
	
		public function Page(pageNode:XML) {
			_pageNode = pageNode;
			
		}
		
		
	//##########################################################################################################
	
		 
		public function setData(data:Object):void {
			this.data = data;					
			
		}
		
		
	//##########################################################################################################
	
	
		/**
		 * @usage 	super.loadSwf (path, this)
		 * @param	path
		 * @param	target
		 */		
		public function loadSwf():void {			
			isLoading = true
			loader = new LoadSwf (_pageNode.@swfPath)										
			loader.addEventListener(Event.COMPLETE , loaderComplete)
			loader.addEventListener(ProgressEvent.PROGRESS, loaderProgress)
			dispatchEvent(new PageEvent(PageEvent.START_LOADING , indexNum))
			
		}
	
		
	//##########################################################################################################
	
		
		private function loaderProgress(e:ProgressEvent):void {
					
				loadProgress = e.bytesLoaded / e.bytesTotal
				//trace ("Page.as > loadProgress   = "+loadProgress )
				dispatchEvent(new PageEvent(PageEvent.PAGE_LOADING, indexNum))
		}
				
		
	//##########################################################################################################
	
		
		private function loaderComplete(e:Event):void {			
			isLoading = false
			loader.removeEventListener(Event.COMPLETE , loaderComplete)		
			assetPage = loader.getNewClassByName(_pageNode.@classReference) as AbstractPage 			
			assetPage.setData (data)	
			assetPage.indexNum = indexNum			
			inited = true			
			initPageContent ()			
			dispatchEvent(new PageEvent(PageEvent.PAGE_LOADED, indexNum))			
		}
		
			
	//##########################################################################################################
	
		
		public function initPageContent():void {			
			this.addEventListener(Event.REMOVED_FROM_STAGE , offStage)
			addChild (assetPage)				
			assetPage.activatePage ()			
		}
				
		
	//##########################################################################################################
		
	
		public function requestPage():void{			
			if (inited) {					
				initPageContent ()				
			}else {					
				loadSwf ()
			}		
		}
		
		
	//##########################################################################################################
		
		
		private function offStage(e:Event):void {			
			assetPage.cleanUp ()			
			if (isLoading) {
				loader.close ()
			}
			removeEventListener(Event.REMOVED_FROM_STAGE, offStage);				
		}
		
		
	//##########################################################################################################
		
	
		public function fadeIn():void {			
			this.alpha = 0
			//TweenLite.to (this , 1, { alpha:1, delay:0 , ease:Expo.easeOut } );		
		}
		
		
	//##########################################################################################################
		
		
		public function fadeOut():void {			
			//TweenLite.to (this , 1, { alpha:0, delay:0 , ease:Expo.easeOut } );
		}
		
			
		
		
	}

}
