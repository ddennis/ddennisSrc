package com.ddennis.loading {
	
	import com.ddennis.loading.ILoader;
	import com.video23.VideoPlayer;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	OverwriteManager.init(OverwriteManager.AUTO); 
	
	//TweenPlugin.activate ([AutoAlphaPlugin]); 
	
	
	/**
	 * ... app.mediaComponent.display.VideoLoader
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class VideoLoader extends VideoPlayer implements ILoader {
		
		public function VideoLoader() {	
			
			//super(						
		}
		
		
		
		
		public function load(path:String ):void {	
			this.addEventListener(VideoPlayer.VIDEO_STARTED , videoLoaded)
			play(path)			
		}
		
		
		
		private function videoLoaded(e:Event):void {
			this.removeEventListener(VideoPlayer.VIDEO_STARTED , videoLoaded)
			dispatchEvent(new Event(Event.COMPLETE))
			
		}
		
	
		
		
	}
	
}