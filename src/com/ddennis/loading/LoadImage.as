package com.ddennis.loading {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class LoadImage extends Sprite implements ILoader{
		
		
		
		public var contentHolder:Sprite;

		private var loader:Loader;
		private var loaderContext:LoaderContext;
		private var bitmapSmoothing:Boolean;
		private var isLoading:Boolean = false
		
		public function LoadImage(url:String = "", bitmapSmoothing = false)  {
			
			loader = new Loader();							
			//loader.close ()
			
			contentHolder = new Sprite();
			addChild(contentHolder);
			
			if (url != "") {
				loadImage (url , bitmapSmoothing)
			}						
		}
		
		
		public function load(path:String ):void {
			loadImage (path)
		}
		
		
		
		public function loadImage(url:String , smothing:Boolean = false):void {
						
			if (isLoading) {
				//loader.close ()		
			}
			
			this.bitmapSmoothing = smothing
			loaderContext = new LoaderContext(bitmapSmoothing);	
			
			configureListeners(loader.contentLoaderInfo);
			loader.load(new URLRequest(url), loaderContext);			
			isLoading = true
			
		}
		
		public function close():void {
			
		}
		
		
		private function onLoadComplete(e:Event):void {
								
			isLoading = false						
			
			if(bitmapSmoothing){
				//this.dispatchEvent(e);
				var bitmap:Bitmap = e.target.loader.content as Bitmap;
				bitmap.smoothing = bitmapSmoothing;				
				contentHolder.addChild(bitmap);
				
			}else {
				contentHolder.addChild(e.target.loader as Loader);
				
			}
			
			dispatchEvent(e)
						
		}
		
		
			private function configureListeners(dispatcher:IEventDispatcher):void {
		
				dispatcher.addEventListener(Event.COMPLETE, onLoadComplete);
				dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				/*
				dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				dispatcher.addEventListener(Event.INIT, initHandler);
				dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				dispatcher.addEventListener(Event.OPEN, openHandler);
				
			   */
			}
			
			private function progressHandler(e:Event):void {
				dispatchEvent (e)
			}
			
		
	}

}