package com.ddennis.display
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author Josh Chernoff | josh@gfxcomplex.com
	 * @version .01
	 * @usage FullScreenImage will take any displayObject and scale it in a number of ways to fit the whole screen
	 * @example var image:FullScreenImage = new FullScreenImage(bitmapSmoothing = false); // Note crossdomain.xml file maybe needed for bitmapSmoothing
	 * @link http://gfxcomlpex.com/labs/full-screen-image
	 */
	
	public class FullScreenImage extends MovieClip
	{
		private var _bitmapSmoothing:Boolean
		private var _contentHolder:Sprite;		
		private var initStage:Boolean = false;
		private var initLoad:Boolean = false;		
		private var _align:String;
			
		public function FullScreenImage(url:String, align:String = "TL", bitmapSmoothing = false) 
		{
			
			var loader:Loader = new Loader();
			var loaderContext:LoaderContext = new LoaderContext(bitmapSmoothing);			
			_align = align;			
			_bitmapSmoothing = bitmapSmoothing;
			
			configureListeners(loader.contentLoaderInfo);
	
			loader.load(new URLRequest(url), loaderContext);			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			
		}
		
		
		//STAGE EVENTS				
		private function onAddedToStage(e:Event):void 
		{
			initStage = true;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;			
			stage.addEventListener(Event.RESIZE, onStageResize); //listen to stage for scale chages.			
			onStageResize(null); //initlize iamge scaling.			
			if (initLoad && initStage){
				onStageResize(null);
			}
		}
		
		private function onStageResize(e:Event):void 
		{
			if (  _contentHolder is Sprite) {
				
				var sH:Number = stage.stageHeight;
				var sW:Number = stage.stageWidth;
								
				var image:DisplayObject;

				
				switch(_align) {
					
					case "TL":						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
						break;
					case "T":
						image = _contentHolder.getChildAt(0);
						image.x = -(image.width >> 1);
						_contentHolder.x = sW >> 1;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
						break;
					case "TR":
						image = _contentHolder.getChildAt(0);
						image.x = -(image.width);
						_contentHolder.x = sW;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
						break;	
					case "CL":
						image = _contentHolder.getChildAt(0);
						image.y = -(image.height >> 1);
						_contentHolder.y = sH >> 1;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
						break;	
						
					case "C":
						image = _contentHolder.getChildAt(0);
						image.y = -(image.height >> 1);
						image.x = -(image.width >> 1);
						
						_contentHolder.y = sH >> 1;
						_contentHolder.x = sW >> 1;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
						break;
					case "CR":
						image = _contentHolder.getChildAt(0);
						image.y = -(image.height >> 1);
						image.x = -(image.width);
						
						_contentHolder.y = sH >> 1;
						_contentHolder.x = sW;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
						break;
					case "BL":
						image = _contentHolder.getChildAt(0);
						image.y = -(image.height);
						
						_contentHolder.y = sH;
												
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
						break;
					case "B":
						image = _contentHolder.getChildAt(0);
						image.y = -(image.height);
						image.x = -(image.width >> 1);
						
						_contentHolder.y = sH;
						_contentHolder.x = sW >> 1;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
						break;						
					case "BR":
						image = _contentHolder.getChildAt(0);
						image.y = -(image.height);
						image.x = -(image.width);
						
						_contentHolder.y = sH;
						_contentHolder.x = sW;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
						break;
						
						
				}
				
			}			
		}
		
		//LOADER EVENTS
		private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, onLoadComplete);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(Event.INIT, initHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
           
        }
		private function onLoadComplete(e:Event):void 
		{
			initLoad = true;
			
			_contentHolder = new Sprite();
			addChild(_contentHolder);
			
			if(_bitmapSmoothing){
				this.dispatchEvent(e);
				var bitmap:Bitmap = e.target.loader.content as Bitmap;
				bitmap.smoothing = _bitmapSmoothing;				
				_contentHolder.addChild(bitmap);
				
			}else {
				_contentHolder.addChild(e.target.loader as Loader);
				
			}
			
			if (initLoad && initStage){
				onStageResize(null);
			}
			
		}
		private function progressHandler(event:ProgressEvent):void 
		{
			dispatchEvent(event);
		}
        private function httpStatusHandler(event:HTTPStatusEvent):void {
            dispatchEvent(event);
        }
        private function initHandler(event:Event):void {
			dispatchEvent(event);
        }
        private function ioErrorHandler(event:IOErrorEvent):void {
            dispatchEvent(event);
        }
        private function openHandler(event:Event):void {
            dispatchEvent(event);
        }
	}	
}