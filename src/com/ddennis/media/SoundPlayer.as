package com.ddennis.media {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Dennis Christoffersen- ddennis.dk aka meresukker.dk
	 */
	
	public class SoundPlayer extends MovieClip {
		
		public static const READY:String = "ready";	
		
		private var _url:String;
		public var playBarClip:MovieClip
		public var playBar:MovieClip
		public var playPauseBtn:MovieClip
		public var muteUnmuteBtn:MovieClip
		private var pbarlength:Number
		private var song:Sound
		private var sc:SoundChannel
		public var position:Number;
		public var songLoaded:Boolean = false
		private var soundError:Boolean = false
		public var autoPlay:Boolean = false
		public var _isMuted:Boolean = false
		public var isPlaying:Boolean = false
		private var scrubber:MovieClip;
		private var isScrubbing:Boolean = false
		private var isFinished:Boolean;
		private var soundLoadProgress;
		private var songLength;
		private var timeClip:MovieClip;
		private var volValue:Number;
		private var isMuted:Boolean;
		private var _volume:Number 
		private var sndTransform:SoundTransform;
		
	
		
		
		public function SoundPlayer() {
							
		}
		
		

		
		
		
		
		
		
		public function playUrl(url:String):void {
					
			_url = url				
			loadSong()	
			_isMuted = isMuted;
		}
	
				
		
		
		
		public function loadSong():void {
											
			song = new Sound();
			//song.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			
			
		//	song.addEventListener(ProgressEvent.PROGRESS, _songLoadProgress)
			song.addEventListener(Event.COMPLETE, soundLoadComplete)
					
			//channel.soundTransform = (mute_mc.isMute)? new SoundTransform(0) : sndTrans;
									
			
			song.load(new URLRequest(_url));					
		
								
			isPlaying = true 
			sc = song.play (0,999)
			sndTransform = sc.soundTransform;
			sc.addEventListener(Event.SOUND_COMPLETE, soundFinished)
			
			
			
		}
	
		
		
		
		public function playTheSound():void {			
			
			isPlaying = true
			isFinished = false			
			sc = song.play (position)
			sc.addEventListener(Event.SOUND_COMPLETE, soundFinished)
			//this.addEventListener(Event.ENTER_FRAME, enterFrame)
			playPauseBtn.gotoAndStop (1)
			
			
		}
		
		
		
		
		
		
	
		private function enterFrame(e:Event):void {
											
			songLength = song.length / soundLoadProgress
			var k = sc.position / songLength			
			var p = k * (pbarlength )
			
			
			timeClip.txt.text = formatTime(sc.position) + "/" + formatTime(songLength)
			
			//trace ("sc.position * soundLoadProgress  = "+sc.position * soundLoadProgress)
			//trace ("soundLoadProgress  = " + soundLoadProgress)
			//trace ("  k = " + k / 1)
			
						
			if (isScrubbing ) {
				
				scrubber.x = Clamp(playBarClip.loadbar.x , playBarClip.mouseX , playBarClip.loadbar.width-5)
				//setScrubTime = ( pyroInstance.duration / pbarlength ) * playBarClip.scrubber.x
				
			}else {		
				
				scrubber.x = p
				
			}			
		}
		
		
		
		
		
		public function formatTime(time:Number):String  {
			var min:String = Math.floor(time/60000).toString();
			var sec:String = (Math.floor((time/1000)%60) < 10)? "0" + Math.floor((time/1000)%60).toString() : Math.floor((time/1000)%60).toString();

			return(min+":"+sec);
		}
		
		
		
		
		private function startScrubbing(e:MouseEvent):void {
				
			if (isFinished) {
				return
			}			
		
			stage.addEventListener(MouseEvent.MOUSE_UP , stopScrubbing)
			isScrubbing = true
			sc.stop ()
			isPlaying = false	
						
		}
		
		
		
		
		private function stopScrubbing(e:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP , stopScrubbing)
			isScrubbing = false				
			position = ( songLength / pbarlength ) * scrubber.x
			playTheSound ()
			
		}
		
		
		
		
		
		
		
	
		private function soundFinished(e:Event):void {
					
			isFinished = true					
			isPlaying = false
			position = 0
					
					
		}
		
		
		
		
		private function _songLoadProgress(e:ProgressEvent):void {
								
			soundLoadProgress = (e.bytesLoaded / e.bytesTotal)			
			
						
		}
		
		
		
		
		private function soundLoadComplete(e:Event):void {
			
			songLoaded = true
			song.removeEventListener(ProgressEvent.PROGRESS, _songLoadProgress)	
		
		}
		
		
			
		
		private function ioErrorHandler(event:Event):void {			
			soundError = true
			trace("ioErrorHandler: " + event);
		}
		
		
		
		public function stopAllSounds(e:MouseEvent = null):void {
			sc.stop();
		}
		
		private function playPauseHandler(e:MouseEvent):void {
			
			/*
			if (isFinished) {
					scrubber.addEventListener(MouseEvent.MOUSE_DOWN, startScrubbing)				
			}
			
			if (isPlaying == true) {
				sc.removeEventListener(Event.SOUND_COMPLETE, soundFinished)
				this.removeEventListener(Event.ENTER_FRAME, enterFrame)	
				isPlaying = false
				position = sc.position;
				sc.stop();
				playPauseBtn.gotoAndStop (2)
				return	
				
			}else {
				
				playTheSound ()
				//sc = song.play(position);
				
			}		
			*/
		}
		
		
		
		
		
		
		
		public function muteUnmute(e:MouseEvent=null):void {
			
			// var vol: Number = volume_mc.slider_mc.x / 100; 

				
				if (sndTransform.volume == 1) {					
					sndTransform.volume = 0
					_isMuted = true;
					
					//muteUnmuteBtn.gotoAndStop (2)
					
				}else {
					
					_isMuted = false;
					sndTransform.volume = 1
					//muteUnmuteBtn.gotoAndStop (1)
				}
				
				sc.soundTransform = sndTransform;		
								 
		 }
			 
		 
		 
 		

		
		
		
		public function cleanUp():void {
			/*
	
			
			sc.stop();			
			
			__controls.removeEventListener(SoundTools.VOLUME_UPDATE , setVolume)
			//muteUnmuteBtn.removeEventListener(MouseEvent.CLICK , muteUnmute)
			playPauseBtn.removeEventListener(MouseEvent.CLICK , playPauseHandler)
			this.removeEventListener(Event.ENTER_FRAME, enterFrame)				
			sc.removeEventListener(Event.SOUND_COMPLETE, soundFinished);	
			song.removeEventListener(ProgressEvent.PROGRESS, _songLoadProgress)
			
			
							
			// hvis den stadig er igange med at blive loadet
			if (songLoaded == false ) {				
					song.close ()
			}
			
			if (soundError != true) {
							
				sc = null
				song = null
			
			}			
			*/			
		}
		
		
		
		function Clamp(low, value, high) {			
			return Math.min(Math.max(value, low), high);
		}
		
		
		
		public function get volume():Number { return _volume; }
		
		public function set volume(value:Number):void {
			
			if (_isMuted) {
				
				
			}else {					
				sndTransform.volume = value
				_volume = value
				sc.soundTransform = sndTransform;					
			}
			
		}
		
		
		
		
	}
	
}