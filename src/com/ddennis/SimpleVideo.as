package com.ddennis {

	import flash.display.*;
	import flash.net.*;
	import flash.media.Video;
	import flash.events.*;
	//import flash.events.MouseEvent;
	//import flash.net.URLRequest;
	
public class SimpleVideo extends Sprite {

		private var _vidConnection:NetConnection;
		private var _vidStream:NetStream;
		private var _vid:Video;
		private var _vidURL:String;
		private var _vidPlaying:Boolean;
		private var _infoClient:Object;
		private var _playBtn:Sprite;
		private var _pauseBtn:Sprite;
		private var _stopBtn:Sprite;
	
	public function SimpleVideo() {
	
		

			_vidConnection = new NetConnection();
			_vidConnection.connect(null);
			_vidStream = new NetStream(_vidConnection);
			
		//	_vidStream.addEventListener(
	
			_vid = new Video();
			_vid.attachNetStream(_vidStream);
						
			addChild(_vid);
			_vid.width = 350;
			_vid.height = 250;
			_vid.smoothing = true;
	
		}
		
		
		public function playIt (s:String ):void {
			
			_vidStream.play(s);
			
			
		}
		
		
		public function stopIt ():void {
			
			
			_vidStream.close ()
		}
		
		
		
	}

}

