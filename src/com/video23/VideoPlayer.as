
package com.video23 {
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.display.StageDisplayState;
	import flash.display.MovieClip;
	import flash.geom.Rectangle; 
	import flash.media.Video;
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.net.SharedObject;
	import flash.utils.Timer;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.None;
	import flash.display.StageAlign;
	
	

	
	public class VideoPlayer extends VideoBase {		
			
		private var _URLMovie:String;
		private var _RMTPaddress:String;
		private var _error:String = "";	
		private var _progressBar:MovieClip;	
	
	
		
		private var _duration:Number = 0;
		private var _isMovieLoaded:Boolean = false;
		
		
		private const PROGRESS_UPDATE_DELAY:int = 100;
		private var VPS:SharedObject = SharedObject.getLocal("playerSettings");
		//private var _timeProgress:Timer = new Timer(PROGRESS_UPDATE_DELAY);
		private var _stopped:Boolean = false;
		private var _buffering:Boolean = false;
		private var _useStreaming:Boolean = false;
		private var _posY:Number = 0;
		private var _posX:Number = 0;
		private var _stageWidthValue:Number;
		private var _height:Number
		private var _width:Number 	
		private var _loadingProgress:Number 
		private var _playProgress:Number 
		
		
		public static const PLAYING				:String			= "playing"; 			// when buffer is full
		public static const BUFFERING			:String			= "buffering";  		// When buffer is empty
		public static const VIDEO_STOPPED		:String			= "videoStopped";		
		public static const VIDEO_STARTED		:String			= "videoStarted";
		public static const VIDEO_COMPLETED		:String			= "videoCompleted";
		public static const VIDEO_CHANGE		:String			= "videoChanged";
		//public static const VIDEO_COMPLETED		:String			= "video";
		
		
		
		/// public properties
		public var contentHolder:Sprite 			// holds 	
		public var autoPlay:Boolean = false;		// play video as soon as loaded
		public var autoResize:Boolean = true;		// auto resize as video's original size
		public var displayHours:Boolean = false;	// display hours in length and progress
		//public var width:Number = 0;				// video width (valid if autoResize = false)
		//public var height:Number = 0;				// video height (valid if autoResize = false)
		public var ProgressBar:MovieClip = null;	// set the progressbar movieclip - if any
		public var LoadBar:MovieClip = null;		// set the loadbar movieclip - if any
		public var ProgressTime:Object = null;		// set the progress time
		public var isPlaying:Boolean = false;		
		private var _timeInSeconds:Number 
		
		
		
		
		
		/**
		 * @usage var p:String  = "http://ddennis.23video.com/889267/960015/adef4ccb213fcc14bc678589e6ff5855/video_medium/download-video.mp4"			
			vpPlayer = new VideoPlayer ()				
			var vpStats:VideoStats = new VideoStats (vpPlayer, "http://ddennis.23video.com")			
			vpPlayer.play (p)			
		 * 
		 * 
		 * 
		 * @param	URLMovie
		 * @param	_Width
		 * @param	_Height
		 */
		
		

		/// class constructor
		public function VideoPlayer(URLMovie:String = "", _Width:Number = undefined, _Height:Number = undefined) {			
			
			_URLMovie = URLMovie;
			
			this._width  =  _Width
			this._height =  _Height
			
			validateSpecifiedSize ()	
			
			connectStream () // skal kaldes før vi addChild (_video)
			
			contentHolder = new Sprite ()
			addChild(contentHolder)		
			contentHolder.addChild(_video)
			
			
			if (_URLMovie != "") {				
				play()
			}			
									
		}
			
		
		/**
		 * @usage 
		 * @param	url - plays url, if  play() - current url is replayed
		 */
		public function play(url:String = "" ):void {	
			
			if (url == "") {
				_videoStream.play(_URLMovie)				
				return
			}			
			
			
			if (isPlaying == true && url != _URLMovie) {				
				dispatchEvent(new Event(VideoPlayer.VIDEO_CHANGE));					
			}	
					
			
			_URLMovie = url
			_videoStream.play(_URLMovie);
			
			trace ("::::: TJECK OM VI LOADER MED ANTI cache ")
			//_videoStream.play(_URLMovie+"?noCache="+new Date().getMilliseconds());
			
		}
		
				
		
		
		
		
		public function resume():void{
			_videoStream.resume();
		}
		
			
		/**
		 * stops video - 
		 */
		public function stopVideo():void	{			
			_videoStream.pause();
		    _videoStream.seek(0);
			isPlaying = false
			dispatchEvent(new Event(VideoPlayer.VIDEO_STOPPED));
			dispatchEvent(new Event(VideoPlayer.VIDEO_COMPLETED));			
		}		
		
		
		public function close ():void {
			trace ("   //////////////////////////////////// ")
			trace ("VideoPlayer.as > close  = ")
			stopVideo()  			
			_videoStream.play(false)
			
		}
		
		
		
		public function pause():void {	
			trace ("VideoPlayer.as > stopped  = "+stopped)
			if (stopped) {				
				play()				
			}else {
				_videoStream.pause();
			}
			
		}
		
		
		public function pauseToggle():void {	
		
	
			if (stopped) {				
				trace ("   PLAY AGAIN pause ")
				play ()
				
				return 
			}
			
			_videoStream.togglePause();
			if (isPlaying) {
				isPlaying = false
			}else {
				isPlaying = true
			}			
		}
		
		
		
		public function muteToggle():Boolean {
			
			if (volume != 0) {
				
				volume = 0
				return false
				
			}else {
				
				volume = DEFAULT_VOLUME
				return true
			}
	
		}
		
		
		
		
		public function FullScreen():void {  
			trace ("VideoPlayer.as > contentHolder.stage.displayState  = " + contentHolder.stage.displayState)
			
			switch(contentHolder.stage.displayState){
			
			case "normal":
			contentHolder.stage.displayState = StageDisplayState.FULL_SCREEN;
			break;
			
			case "fullScreen":
			contentHolder.stage.displayState = StageDisplayState.NORMAL;
			break;

			default :
			trace("trouble with fullscreen");
			}	  
        }
		
		
		
		
		
		/// return error description, if any
		public function Errors():String{
			return _error;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Helper functions
		
		
		/// convert the time to 00:00:00
		public function videoTimeConvert(myTime):String 
		{
			var tempNum = myTime;
			var minutes = Math.floor(tempNum / 60);
			var seconds = Math.round(tempNum - (minutes * 60));
			if (displayHours)
				var hours = Math.floor(minutes / 60);			
			if (seconds < 10)
				seconds = "0" + seconds;
			if (minutes < 10)
				minutes = "0" + minutes;
			if (displayHours){
				if (hours < 10) 
					hours = "0" + hours;
			}
		
			var ret:String;
			
			if (displayHours)
				ret = hours + ":" + minutes + ":" + seconds;
			else
				ret = minutes + ":" + seconds;
		
			return ret;
		}
		
		
		
		
		/// movie's main status handler
		override public function videoStatusHandler(event:NetStatusEvent):void {
			
			trace ("VideoPlayer.as > --- = " + event.info.code)
						
			switch (event.info.code) {
				
			case "NetConnection.Connect.Success":
				//connectStream();
				// start timer for updating progress bar
				//_timeProgress.addEventListener(TimerEvent.TIMER, videoPlaying);
				//_timeProgress.start();
				// auto play
				//if (autoPlay && _isMovieLoaded)
					//this.Play();
				break;
				
			case "NetStream.Play.StreamNotFound":			
				_error = "Stream not found: " + _URLMovie;
				break;
				
				
				
	        case "NetStream.Play.Start": 
    	       // trace("Start [" + _videoStream.time.toFixed(3) + " seconds]");			
				dispatchEvent(new Event(VideoPlayer.VIDEO_STARTED));				
				isPlaying = true	
				_stopped = false
				_buffering = true;
        	    break; 
				
				
	        case "NetStream.Play.Stop": 
    	        //trace("Stop [" + _videoStream.time.toFixed(3) + " seconds]"); 				
				isPlaying = false								
				_stopped = true;
				_buffering = false;
				
				dispatchEvent(new Event(VideoPlayer.VIDEO_STOPPED));
				dispatchEvent(new Event(VideoPlayer.VIDEO_COMPLETED));
        	    break; 
			
			case "NetStream.Buffer.Empty":
				if (_useStreaming && !_stopped)	{
					_buffering = true;
					dispatchEvent(new Event(VideoPlayer.BUFFERING));
				}
				break;
				
			case "NetStream.Buffer.Full":

				if (!_useStreaming && _buffering) {
						
					_buffering = false;
					dispatchEvent(new Event(VideoPlayer.PLAYING));
				}
				break;
							
				
			}
		}


		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//----- GETTERS AND SETTERS ------------------------------------------------------------------------------------------		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		public function get URLMovie():String { return _URLMovie; }
		
		
		public function set URLMovie(url:String):void {
			
			_URLMovie = url;
			/*
			if (_URLMovie != null){
				_RMTPaddress = GetRMTPaddress(_URLMovie);
				_videoConnection.connect(_RMTPaddress);
			}
			else{
				_videoConnection.connect(null);
			}*/
		}

		
		
		
		//
		public function set stageWidthValue(n:Number):void{
			_stageWidthValue = n;
		}
		
				
		
		
		
		
		/// set audio volume
		public function set volume(vol:Number):void
		{
			if (soundTrasf != null){
				soundTrasf.volume = vol;
				_videoStream.soundTransform = soundTrasf;
			}
			// cache the volume in the flash cookie
			//VPS.data.playerVolume = vol;
			//VPS.flush();
		}
		
		
		
		
		/// get audio volume
		public function get volume():Number
		{
			var vol:Number = 0;
			if (soundTrasf != null)
				vol = soundTrasf.volume;
			return vol;
		}
			
		
		
		
		
		
		
		/// get the movie duration (after loaded)
		public function get Duration():Number{
			return _duration;
		}
		
		
		/**
		 * @param seconds
		 */
		
		
		public function seek(seekTrack:Number):void	{
			if (!_stopped){
				if (_videoStream && seekTrack <= (_duration - 0.5))
				trace(seekTrack+" seekTrack")
					_videoStream.seek(seekTrack);
			}
		}
		

		/// check if it's streaming or not
		public function get IsStreaming():Boolean{
			return _useStreaming;
		}
		
		public function get timeInSeconds():Number { 		
			return int ( _videoStream.time  )			
		}
		
		public function get playProgress():Number { 	
	
			return  _videoStream.time  / Math.max(.1 , _duration) // if _duration is = 0.  _videoStream.time/_duration = NaN - therefore we set it minimum =.1
			
		}
		
		public function get loadingProgress():Number { 
							
			return  ( _videoStream.bytesLoaded ) / _videoStream.bytesTotal
						
		}
		
		public function get stopped():Boolean { return _stopped; }
		
	
		
		
			
	
		
        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
			_error = "SecurityErrorHandler: " + event;
        }
		
		

		public function onMetaData(info:Object):void {
			
			if (autoResize)	{
					
					_video.width  =  info.width;
					_video.height =  info.height;
					//dispatchEvent(new Event("gotSize"));
					
					//Shows the GUI
					//dispatchEvent(new Event("isConnected"));					
			}else {
				
				// sets video to specific height
				_video.width =  _width
				_video.height = _height
							
			}
					
				_duration = info.duration;
		
		}
		
				
		
		
		private function validateSpecifiedSize():void {						
			if (isNaN(_width) != true  &&  isNaN(_height) != true) {
				autoResize = false
			}			
		}
		
		
		
	
		
		
		
	
		private function videoPlaying(event:TimerEvent):void {
			
			
			/*
			// show loading progress bar
			if (!_isMovieLoaded)
			{
				var percentLoaded:Number = Math.floor((_videoStream.bytesLoaded * 100) / _videoStream.bytesTotal);
				if (percentLoaded >= 100)
				{
					_isMovieLoaded = true;
					if (this.LoadBar != null)
						this.LoadBar.width = _stageWidthValue-205;
				}
				else
				{
					if (this.LoadBar != null && !_isMovieLoaded)
						var widthValue:Number = (percentLoaded *_stageWidthValue)/100;
						var andetValue:Number = (percentLoaded * 205)/100;
						this.LoadBar.width =  widthValue-andetValue;
				}
			}

			// show playing progress bar and time
			var percent:Number = Math.floor((_videoStream.time * 100) / Math.floor(_duration));
			if (!isNaN(percent))
			{
				if (this.ProgressBar != null && percent <= 100)
					var widthValue1:Number = (percent *_stageWidthValue)/100;
					var andetValue1:Number = (percent * 205)/100;
					this.ProgressBar.width =  widthValue1-andetValue1;
				if (this.ProgressTime != null)
					this.ProgressTime.text = videoTimeConvert(_videoStream.time) + " / " + videoTimeConvert(_duration);
			}	*/
		}
		
		
		
		
		
		
		/// get the rtmp:// address and extract path and movie name
		private function GetRMTPaddress(movie:String):String
		{
			// if not starting with rmtp:, case insensitive, exit
			if (_URLMovie.search(new RegExp(/rtmp:/i)) == -1)
				return null;

			// extract the path and movie name suitable for streaming
			var ret:String = null;
			var pos:int = movie.lastIndexOf("/");
			if (pos > 0)
			{
				ret = movie.substr(0, pos);
				_URLMovie = movie.substr(pos + 1);
				_useStreaming = true;
			}
			
			return ret;
		}
	
	}

}