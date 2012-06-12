package com.video23 {
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class VideoBase extends Sprite{
		
		public var _video:Video 
		public var _videoConnection:NetConnection 
		public var _videoStream:NetStream;
		private const BUFFER_TIME:int = 3;
		public var soundTrasf:SoundTransform;
		public var DEFAULT_VOLUME:Number = 1;
				
		public function VideoBase() {
			
					
		}		
		
				
		public function connectStream():void {			
			
			_video = new Video ()
			addChild (_video)
			
			_videoConnection = new NetConnection();
			//_videoConnection.addEventListener(NetStatusEvent.NET_STATUS, videoStatusHandler);
			//_videoConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			//_videoConnection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			_videoConnection.connect(null)
								
			_videoStream = new NetStream(_videoConnection);
			_videoStream.addEventListener(NetStatusEvent.NET_STATUS, videoStatusHandler);
			_videoStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			_videoStream.bufferTime = BUFFER_TIME;
			_videoStream.client = this;
			
			
			soundTrasf = new SoundTransform();
			soundTrasf.volume = DEFAULT_VOLUME;
			_videoStream.soundTransform = soundTrasf;
					
			_video.attachNetStream(_videoStream);
			
			//_soundTrasf = new SoundTransform();		
			
			//_video.smoothing = _smoothing;
			//if (_deblocking) _video.deblocking = _deblocking;
			//_nStream.soundTransform	= new SoundTransform(_volume, 0);
			//_nStream.addEventListener(NetStatusEvent.NET_STATUS, onStreamStatus, captureEvents, eventsPriority, useWeakReferences);
			//_nStream.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, captureEvents, eventsPriority, useWeakReferences);
			//_nStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler, captureEvents, eventsPriority, useWeakReferences);
      
			
			
		}
		
		
		 public function onXMPData(infoObject:Object):void { 
			 trace ("VideoBase.as > onXMPData ------- ")
			 
		 }
		
		
		
		public function asyncErrorHandler(e:AsyncErrorEvent):void {
			trace("asyncErrorHandler: " + e.text);
		}
		
		
		public function videoStatusHandler(e:NetStatusEvent):void {
			
		}
		
		
	}

}