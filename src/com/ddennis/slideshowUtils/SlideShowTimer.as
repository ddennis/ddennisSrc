package com.ddennis.slideshowUtils {
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class SlideShowTimer extends EventDispatcher{
		private var theTimer:Timer;
		private var _useProgress:Boolean;
	
		
		
		/**
		 * 
		 * @param	slideTimer skal være i sekunder
		 * @param	useProgress - hvis der skal dispatches imens timer tikker - kan bruges til piechart
		 */
		
		public function SlideShowTimer(slideTime:Number, useTheProgress:Boolean = false ) {
		
			this.useProgress = useTheProgress;			
					
			theTimer = new Timer (getDelayTime (slideTime), 72 )
			theTimer.addEventListener(TimerEvent.TIMER_COMPLETE , timerComplete)
			
			if (_useProgress) {
			
				theTimer.addEventListener(TimerEvent.TIMER, tickTack)
			}			
		}
		
		
		
		
		private function getDelayTime(v:Number ):Number  {
			
			return  ( v*1000  ) /72 // giver helt tal	
			
		}
		
		
		
		public function changeProbs(slideTime:Number , repeat:int = 1):void {
			var t:int =  ( slideTime * 1000  ) / 72 // giver helt tal		
			theTimer.delay = t
			theTimer.delay = repeat
			
		}
		
		
		
		
		private function timerComplete(e:TimerEvent):void {
			
			
			dispatchEvent (e)
		}
				
		private function tickTack(e:TimerEvent):void {
			dispatchEvent(e)		
		
		}
		
		public function pause():void {
			stop()
		}
		
		public function stop():void {
			theTimer.stop()			
		}
		
		
		public function start():void {
			
			theTimer.start()
		}
		
		
		
		public function restart(v:Number = 0):void {	
			
			if (v != 0) {			
				theTimer.delay = getDelayTime(v)
			}
						
			theTimer.reset ()
			theTimer.start ()			
		}
		
		
		
		
		public function cleanUp():void {
			theTimer.removeEventListener(TimerEvent.TIMER_COMPLETE , timerComplete)
			
			if (useProgress) {
				theTimer.removeEventListener(TimerEvent.TIMER, tickTack)
			}
			
		}
		
		
		
		public function get useProgress():Boolean { return _useProgress; }
		
		public function set useProgress(value:Boolean):void {
			_useProgress = value;			
		}
		
		
		
	}

}