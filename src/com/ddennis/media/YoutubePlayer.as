package com.ddennis.media
{
	
	import app.util.YoutubeUtil;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import flash.system.Security;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	// modifyied by ddennis.dk & jacob
	
	public class YoutubePlayer extends MovieClip {
		
		// EVENTS
		public static const IS_CUED:String = "isCued"
		public static const PLAYER_IS_READY:String = "playerIsReady"
		public static const ON_STATE_CHANGE:String = "onStateChange"
		
		// PLAYER STATUS
		
		
		public static const UNSTARTD:String = "unstarted"
		public static const ENDED:String = "ended"
		public static const PLAYING:String = "playing"
		public static const PAUSED:String = "paused"
		public static const BUFFERING:String = "bufferring"
		
		
		public var _videoHeight:int;
		public var _videoWidth:int;
	
		private var _currentTime:int;	
		public var totalTime:String;		
		
		public var player:Object; //the object wich will have the player loaded to
		private var loader:Loader; //the loader wich will load the player
		private var id:String; //the video's id
		public var playerStatus:String; //returns the players current playing status
		private var progressRatio:Number; //returns the ratio difference between the bytes loaded and the bytes total, from 0 to 1, (usefull for the progress bar)
		private var fullnessRatio:Number; //returns the ratio difference between the playhead and the total seconds, from 0 to 1, (usefull for the fullness bar)
		public var ismuted:Boolean; // returns true if player is muted
		private var cuedEvent:Event;
		public var playerLoaded:Boolean = false
		public var isInited:Boolean = false
		
		private var _position:Number
		private var _duration:Number
		private var _gotoVideotime:Number 		
		public var contentHolder:Sprite;
		
		//when instanced we need the video's id passed to it
		public function YoutubePlayer(videoId:String = "", videoWidth:int = 300 , videoHeight:int = 200) {
										
			Security.allowDomain("*");
			Security.allowDomain("http://www.youtube.com");
			Security.allowDomain("http://youtube.com");
			Security.allowDomain("http://s.ytimg.com");
			Security.allowDomain("http://i.ytimg.com");
			
			contentHolder = new Sprite ()
			addChild (contentHolder )
		
			
			cuedEvent = new Event(YoutubePlayer.IS_CUED)
						
			if (videoId == "") {
				
			}else {
				loadIt (videoId , videoWidth , videoHeight)
			}
			
		}
		
		
		
		
		
		public function loadIt(videoId:String = "", videoWidth:int = 595 , videoHeight:int = 341 ):void {
			
			this.id  = YoutubeUtil.validateUrl(videoId)
			
			this._videoWidth = videoWidth;
			this._videoHeight = videoHeight;
				 			
			loader = new Loader(); //instanciates the loader		
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit); //After loading, calls onLoaderInit
			loader.load(new URLRequest("http://www.youtube.com/apiplayer?version=3")); //starts loading process
		
		}
		
	
		
		
		
		private function onLoaderInit(event:Event):void {
			
			isInited = true
				
			contentHolder.addChild(loader); //adds the loader to stage 
			loader.content.addEventListener("onReady", onPlayerReady); //called when the player is ready
			loader.content.addEventListener("onError", onPlayerError); //called when the player has errors
			loader.content.addEventListener(YoutubePlayer.ON_STATE_CHANGE, onPlayerStateChange); //called when the playing state is changed
		
		}
		
		
			
			
		private function onPlayerReady(event:Event):void {
			playerLoaded = true
			
			player = loader.content; //sets the player
			player.setSize(_videoWidth, _videoHeight); //sets the dispplay size
			//player.loadVideoById(id) //loads the video by the id
			player.cueVideoById(id);
						
			dispatchEvent (new Event (YoutubePlayer.PLAYER_IS_READY))
			
			contentHolder.addEventListener(MouseEvent.CLICK, playVideoForFirstTime)
			
			dispatchEvent(new Event(Event.COMPLETE))
			//playPauseBtn.addEventListener(MouseEvent.CLICK, pauseVideo);
			//muteBtn.addEventListener(MouseEvent.CLICK, muteVideo);
			//largeStartBtn.addEventListener(MouseEvent.CLICK, playVideoForFirstTime);
					
			//playPauseBtn.gotoAndStop(1);
			//muteBtn.gotoAndStop(1);
			
		}
		
		
		public function playVideo(id:String = "" ):void {
					
			var s:String = YoutubeUtil.validateUrl(id)					

			if (!isInited) {
				loadIt (s, _videoWidth , _videoHeight )
				return 
			}
			
			
			if (playerLoaded && id != "") {				
						
				
				player.loadVideoById(s) 
				
			}else {
				
				player.playVideo()	
				
			}
								
		}
		
		
		
		private function playVideoForFirstTime(e:MouseEvent):void{
			//largeStartBtn.alpha = 0;
			//player.loadVideoById(id) 
			contentHolder.removeEventListener(MouseEvent.CLICK, playVideoForFirstTime)
			
		
		}

		
		
		private function onPlayerError(event:Event):void {
			trace("player error:", Object(event).data);
		}

		private function onPlayerStateChange(event:Event):void {
			//trace("player state:", Object(event).data);
			updatePlayer ()
			dispatchEvent(event)
			
		}
		
	
			
		
		
		public function pauseVideo(e:MouseEvent=null) {
		
			if (playerStatus == "paused"){
				playVideo();
				//playPauseBtn.gotoAndStop(1);
			}else {
				//playPauseBtn.gotoAndStop(2);
				player.pauseVideo()
			}
			
		}
		
		public function stopVideo() {
			
			if (player) {
			
				player.stopVideo()
			}
			
		}
		
		public function muteVideo(e:MouseEvent = null) {
	 
			if (ismuted) {
				//muteBtn.gotoAndStop(1);
				unmuteVideo();
				
			}else {
				player.mute()
				//muteBtn.gotoAndStop(2);
			}
		
		}
		
		
		
		
		public function unmuteVideo() {
			player.unMute()
		}
	
		
		
		
		public function videoTimeConvert(tempNum) {
			var minutes = Math.floor(tempNum / 60);
			var seconds = Math.round(tempNum - (minutes * 60));
							
			if (seconds < 10){
				seconds = "0" + seconds;
			}
			if (minutes < 10){
				minutes = "0" + minutes;
			}
				
			var ret:String;		
			totalTime = minutes + ":" + seconds;
			
			return ret;
		}
		
		
		
		
		
		public function currentPlayingTime(value) {
			var minutes = Math.floor(value / 60);
			var seconds = Math.round(value - (minutes * 60));
			
			if (seconds < 10){
				seconds = "0" + seconds;
			}
			if (minutes < 10){
				minutes = "0" + minutes;
			}
				
			var currentTime:String;		
			currentTime = minutes + ":" + seconds;
			
			
		
		}
		
		
		
		public function disableEvents():void {
			contentHolder.mouseEnabled = false
			contentHolder.mouseChildren = false
		}
		
		
		public function enableEvents():void {
			contentHolder.mouseEnabled = true
			contentHolder.mouseChildren = true
		}
		
		/** 
		* 
		* 	Dennis states er som følger, er tilføjet nedefor. 
		*   unstarted (-1), ended (0), playing (1), paused (2), buffering (3), video cued (5).
		* 
		**/
		
		public function updatePlayer() {
			
			
			//ismuted = player.isMuted() //returns true if muted
			
			//progressRatio = player.getVideoBytesLoaded() / player.getVideoBytesTotal()
			//fullnessRatio = player.getCurrentTime() / player.getDuration()
			//currentTime = player.getCurrentTime();
			
			//videoTimeConvert(player.getDuration())
			//currentPlayingTime(currentTime);
				
			switch(Number ( player.getPlayerState()  )) {
				
				case -1:			
				
					playerStatus = UNSTARTD					
					dispatchEvent(new Event(YoutubePlayer.UNSTARTD))
					break;
					
				case 0:
					
					playerStatus = ENDED
					dispatchEvent(new Event(YoutubePlayer.ENDED))
					break;
					
				case 1:
					
					playerStatus = PLAYING	
						
					
					dispatchEvent(new Event(YoutubePlayer.PLAYING))
					break;
					
				case 2:
					
					playerStatus = PAUSED
					dispatchEvent(new Event(YoutubePlayer.PAUSED))
					
					break;
					
				case 3:
					
					playerStatus = BUFFERING
					dispatchEvent(new Event(YoutubePlayer.BUFFERING))
					break;
										
				case 5:
									
					playerStatus = IS_CUED					
					dispatchEvent (cuedEvent)
					break;
					
			}
			
		}
		
	
		
		public function get currentTime():int { return _currentTime; }
		
		public function get position():Number { 		
		
			return player.getCurrentTime() / player.getDuration()
					
		}
		
		public function get duration():Number { 
			
			return player.getDuration() 
			
		}
		
		public function set gotoVideotime(value:Number):void {
			
			player.seekTo(value , true)
			
		}
		
		
		
	}
	
}