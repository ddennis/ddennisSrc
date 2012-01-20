package com.ddennis.loading {

	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.LoaderContext;
	/**
	 * ...
	 * @author ddennis.dk aka meresukker.dk aka fantastisk.dk - info@ddennis.dk
	 */
	
		/*
		// child SWF uses parent domain definitions
		// if defined there, otherwise its own
		var childDefinitions:LoaderContext = new LoaderContext();
		childDefinitions.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);

		
		
		// child SWF adds its unique definitions to
		// parent SWF; both SWFs share the same domain
		// child SWFs definitions do not overwrite parents
		var addedDefinitions:LoaderContext = new LoaderContext();
		addedDefinitions.applicationDomain = ApplicationDomain.currentDomain
						
		// child SWF domain is completely separate and
		// each SWF uses its own definitions
		var separateDefinitions:LoaderContext = new LoaderContext();
		separateDefinitions.applicationDomain = new ApplicationDomain();
		 */	 
	 
	 
	 
	public class LoadSwf extends Sprite implements ILoader {
		public var contentHolder
		private var loader:Loader;
		public var loaderinfo:LoaderInfo;
		public var isLoaded:Boolean = true
		public var appDomaine:ApplicationDomain;
		
		public function LoadSwf(url:String = "") {
			
			if (url != "") {
				load (url)
			}
	
		}
		
		
		
		
		public function load(url:String ):void {
			
			if (loader) {
				removeChild(contentHolder)
				loader.unloadAndStop(true)				
				contentHolder = null				
			}
			
			contentHolder = new MovieClip();
			addChild(contentHolder);
			
			var ldrContext:LoaderContext = new LoaderContext();
			ldrContext.checkPolicyFile = false
			
			
			appDomaine = new ApplicationDomain (ApplicationDomain.currentDomain)
			ldrContext.applicationDomain = appDomaine 

			//
			loader = new Loader();
			
			// Anti Cache
			var location_is_IDE:Boolean  = Boolean (Capabilities.playerType == 'External') 		
			if (location_is_IDE) {
								
			}else {				
				var cacheDate:Number = new Date ().getMilliseconds ()
				url = url+"?nocache=" + cacheDate
			}
			
			var req:URLRequest = new URLRequest(url);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS , loadProgress)
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR , IO_Error)
			
			loader.load(req,ldrContext );
			
		}
		
		private function IO_Error(e:IOErrorEvent):void {
			
			trace (" ----------  load IO  Error ")
		//	throw new Error ("sdfs")
		}
		
		private function loadProgress(e:ProgressEvent):void {
			dispatchEvent(e)
		}
		
		
		public function close():void {			
			//loader.unloadAndStop()			
			loader.close ()
		}
		
		public function unLoad():void {			
			loader.unloadAndStop()			
			
		}
		
		function loadComplete(e:Event):void {			
			loaderinfo = e.target as LoaderInfo;
			contentHolder = MovieClip(LoaderInfo(e.target).content) 
			
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS , loadProgress)
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR , IO_Error)
						
			addChild (contentHolder)
			dispatchEvent (e)		
			
		}

		
		/**			
			@param className: The full name of the class you wish to receive from the loaded SWF.
			@return A Class reference.
			@throws Error if method is called before the SWF has loaded.
		*/
			
		public function getClassByName(pathAndClassName:String):Class {
			return appDomaine.getDefinition(pathAndClassName) as Class;						
			
		}
		
		public function getNewClassByName(pathAndClassName:String):Object {						
			var myClass:Class = getClassByName (pathAndClassName) as Class				
			return new myClass ()
			
		}

		
		
	}

}