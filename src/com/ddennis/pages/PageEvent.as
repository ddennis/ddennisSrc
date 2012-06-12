package com.ddennis.pages {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ddennis.dk aka meresukker.dk aka fantastisk.dk - info@ddennis.dk
	 */
	public class PageEvent extends Event {
		
		public static const GOTO_PAGE:String = "gotoPage";
		public static const PAGE_LOADED:String = "pageLoaded";

		public static const PAGE_LOADING:String = "pageLoading";
		public static const START_LOADING:String = "startLoading";
		
		public static const SET_SCROLLER:String = "setScroller";
		
		
		
		private var _pageId:Object; // muliggøre at vi kan sende både en string eller int
		private var _dataArr:Array
				
		
		public function PageEvent(type:String, pageId:Object , dataArr:Array = null, bubbles:Boolean=false, cancelable:Boolean=false) { 
			
			super(type, bubbles, cancelable);			
			_pageId = pageId;
			_dataArr = dataArr;
			
			
		} 
		
		public override function clone():Event { 
			return new PageEvent(type, pageId, dataArr, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("PageEvent", "type", "pageIndexNum", "dataArr" , "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get pageId():Object { return _pageId }
		public function get dataArr():Array { return _dataArr }
		
	}	
}