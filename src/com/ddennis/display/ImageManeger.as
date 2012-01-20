package com.ddennis.display {
	import com.ddennis.data.Model;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class ImageManeger extends Model{
		
		public static const IMAGE_LOADED:String = "imageLoaded"
		public static const IMAGE_LOADING:String = "imageLoading"
		
		private var _imagePath:String 
		
		private var loader:Loader;
		private var xml:XML;
		private var itemList:XMLList;
		
		public var headline:String;
		public var body:String;
		private var bmData:BitmapData;
		private var bmp:Bitmap;
		public var currentItemXML:XML;
					
		public function ImageManeger(xml:XML, itemList:XMLList) {
			
			this.xml = xml			
					
			this.itemList = itemList// xml.data.images.image
			totalItems = itemList.length ()
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, imageLoaded)
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loading)
			
		}
		
		
		
		private function loading(e:ProgressEvent):void {
			dispatchEvent(e as ProgressEvent)
		}
			
		
		
		
		private function loadImage( ):void {	
			
			dispatchEvent(new Event(ImageManeger.IMAGE_LOADING))
			loader.load(new URLRequest(imagePath));
			
		}
		
		
		
		
		override protected function updateData():void {
			super.updateData();
			currentItemXML = itemList[currentIndex]
			
			if (!bitmapDataArr[currentIndex]) {
				loadImage ()
			}else {
				dispatchEvent(new Event(Model.MODEL_CHANGE));				
			}								
			
		}
		
			
		
		
		private function imageLoaded(e:Event):void {
			dispatchEvent(new Event(ImageManeger.IMAGE_LOADED))
			
			if (!bmData) {
				
			}	
			
			bmData = new BitmapData(loader.content.width, loader.content.height);				
			bmData.draw(loader);			
						
			bitmapDataArr[currentIndex] = bmData
			dispatchEvent(new Event(Model.MODEL_CHANGE));
						
		}
		
		
					
						
		private function cleanUp():void {			
			bitmapDataArr.length = 0			
		}
		
		
		
		
		
		public function get imagePath():String { 
			_imagePath = String (xml.data.images.image[currentIndex].path)
			return _imagePath; 
		}
		
		
		
		
		
	}

}