package app {
	

	import app.util.Config;
	import com.ddennis.display.FullScreenImage;
	import com.ddennis.loading.SitePreloader;
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	//OverwriteManager.init (OverwriteManager.AUTO); 	
	//TweenPlugin.activate ([AutoAlphaPlugin]); 
	
	/**
	 * ... app.AppPreloader
	 * @author ddennis.dk aka meresukker.dk aka fantastisk.dk - info@ddennis.dk
	 */
	
	
	public class AppPreloader extends SitePreloader{
		
		
		public var preloaderMc:MovieClip
		
		
		public function AppPreloader() {
												
			loadFile ("mainSite.swf")			
			stageResize(null)
			
			Config.flashvars = LoaderInfo(this.root.loaderInfo).parameters; 	
			
			
		}
		
		
		
		
		override public function swfLoadedd(mc:DisplayObject):void {
			
			var bgImage:FullScreenImage = new FullScreenImage("assets/images/bgImage.jpg")
			stage.addChild (bgImage)
			
			stage.addChild (mc)	
			TweenLite.to (preloaderMc, .6, { alpha:0, delay:0 , ease:Expo.easeOut, onComplete:removeIt } );
		
		

		}
		
		
		
		private function removeIt():void {
			
			preloaderMc.stop ()
			removeChild (preloaderMc)
			
		}
		
		
		override public function _loadingData(evt:ProgressEvent):void {
			super._loadingData(evt);
			///preloaderMc.bar.scaleX =  _loadPercent 
			preloaderMc.txt.text = String  ( Math.round( _loadPercent *100   ) +"%" )
		//	trace ("AppPreloader.as > _loadPercent   = "+_loadPercent )
			
		}
		
		
		override public function stageResize(e:Event):void {
			//super.stageResize(e);
			preloaderMc.x = stage.stageWidth *.5 - preloaderMc.width*.5
			preloaderMc.y = stage.stageHeight*.5 - preloaderMc.height*.5
			
			
		}
		
		
	}
	
}