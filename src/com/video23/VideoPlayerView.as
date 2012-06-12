package com.video23 {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class VideoPlayerView extends VideoPlayer{
		private var progressTick:Timer;
		
		public function VideoPlayerView(loadBar:Sprite , playProgressBar:Sprite) {
			
			super(url)
			progressTick = new Timer(100)
			progressTick.addEventListener(TimerEvent.TIMER, onProgressTick)
			this.addEventListener(VideoPlayer.VIDEO_STOPPED, videoStopped)
		}
		
		
		
		
		
		private function onProgressTick(e:TimerEvent):void {
				
			trace ("   = " + loadingProgress)
						
		}
		
		
		
		private function videoStopped(e:Event):void {
			progressTick.reset()
			progressTick.stop ()
		}
			
		
		override public function play(url:String = ""):void {
			super.play(url);			
			progressTick.start ()			
			
		}
		
		
		/**
		 * @usage return between 0-100 
		 */
		
		override public function get playProgress():Number { 
			return super.playProgress; 
			
		}
		
		
		
		
		
		
		
		
		
		
		
	}

}