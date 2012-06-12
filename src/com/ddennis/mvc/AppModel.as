package com.ddennis.mvc {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class AppModel extends EventDispatcher{
		
		public static const MODEL_XML_LOADED:String = "modelMainXMLLoaded";
		public static const MODEL_ID_UPDATE:String = "modelIdUpdate";
		public static const MODEL_CHANGE:String = "modelChange";
		public static const MODEL_LAST_INDEX:String = "modelLastIndex";
		public static const MODEL_PREVIEW:String = "modelPreview";	
		public static const DATA_LOADED:String = "dataLoaded";	
		
		public var contentWidth:int 
		public var contentHeight:int 
		
		public var currentId:String;
		
		private var _mainXml:XML;
		private var _languageXml:XML;
		private var _basePath:String;
		
					
		public var previewIndex:int = 0;
		public var currentIndex:int = 0;		
		
		public var oldCurrentIndex:int 
		private var _totalItems:int;
		public var autoReset:Boolean = true // hvis den automatisk skal starte forfra - når der klikke næstets
		private var _sortedXML:XMLList;

		private var _previewNextIndex:int 
		private var _previewPrevIndex:int 

		public var sortingType:String = "placering"
		
		
		
		public function AppModel() {
			
		}
		
		
		
		public function forceUpdate():void {
			 			
			update()
			
		}
		
		
		
		public function dataLoaded():void {
			dispatchEvent (new Event (AppModel.DATA_LOADED));
		}
		
		
		protected function update ():void{
			dispatchEvent(new Event(AppModel.MODEL_CHANGE))
			// Model.as extendens - i den extended model - kaldes updateData() - og den extende model dispatcher dispatchEvent(new Event(Model.MODEL_CHANGE));
		}
		
		
		/*
		public function previewNextIndex():void {		
			
			previewIndex = controlCurrentIndex(currentIndex+1)
			dispatchEvent (new Event (AppModel.MODEL_PREVIEW));
			
		}
		
		public function previewPrevIndex ():void {			
			
			previewIndex = controlCurrentIndex(currentIndex-1)
			dispatchEvent (new Event (AppModel.MODEL_PREVIEW));
			
		}
		
		*/
		public function setCurrentIndex(index:int):void	{
			
			oldCurrentIndex = currentIndex 
			currentIndex = controlCurrentIndex(index);		
			//trace ("AppModel.as > currentIndex  = "+currentIndex)
			//trace ("AppModel.as > oldCurrentIndex  = "+oldCurrentIndex)
			if (currentIndex != oldCurrentIndex) {
				trace ("---- AppModel Index = " + currentIndex +"  --- ")
				update()
			}
			
		}
			
		
		public function resetIndex():void { // bruges når vi vil sætte index til 0 - men det allerede er 0
			oldCurrentIndex = currentIndex 
			currentIndex = 0
			update()
		}
		
		
		
		private function controlCurrentIndex(v:int):int	{		
			
			if (v >= totalItems)	{
				if (autoReset) {
					return 0;	
				}else {		
				dispatchEvent (new Event (AppModel.MODEL_LAST_INDEX));
				 return	totalItems - 1				 
				}				
			}
			
			else if (v < 0) { // før var det = else if (v <= 0)
				
				if (!autoReset) {					
					return 0
					
				}else {
					return totalItems - 1;					
				}				
			}
			
			return v
			
		}
		
		
		
		
		public function setSelected(id:String):void {
			
			if (currentId == id) {
				trace (" MODEL_ID ** NOT** UPDATE  = ")
				return 
			}			
			currentId = id					
			dispatchEvent(new Event(AppModel.MODEL_ID_UPDATE))			
		}
		
		
		public function get totalItems():int { return _totalItems; }
		
		public function set totalItems(value:int):void {
			
			_totalItems = value;
			
		}
		
		public function get sortedXML():XMLList { return _sortedXML; }
		
		public function set sortedXML(value:XMLList):void {
			_sortedXML = value;
			update ()
		}
		
		public function set mainXml(value:XML):void {
			
			_mainXml = value;
			dispatchEvent(new Event(AppModel.MODEL_XML_LOADED))
			
		}
		
		public function get mainXml():XML { return _mainXml; }
		
		public function get previewNextIndex():int { 			
			return controlCurrentIndex(currentIndex+1);
			
		}
			
		
		
		public function get previewPrevIndex():int { 			
			
			return controlCurrentIndex(currentIndex-1);
				
		}
		
		
		
		public function get languageXml():XML { return _languageXml; }
		
		public function set languageXml(value:XML):void {
			_languageXml = value;
		}
		
		public function get basePath():String {
			return _basePath;
		}
		
		public function set basePath(value:String):void {
			_basePath = value;
		}
		
		
		
	
		
		
		
	}

}