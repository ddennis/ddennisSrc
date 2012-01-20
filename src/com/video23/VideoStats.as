package com.video23 {
	import com.ddennis.loading.LoadXML;
	import com.video23.VideoPlayer;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */

	 public class VideoStats {
		 public var photoId:String 
		 public var startTime:String = "0"
		 public var endVideoTime:String 
		
		
		private var videoPlayer:VideoPlayer;
		private var domaine:String;
		
		/**
		 *
		 * @usage 	vpPlayer = new VideoPlayer ()				
		 *			var vpStats:VideoStats = new VideoStats (vpPlayer, "http://ddennis.23video.com")
		 * 			Her efter burde den selv registrere start og stop
		 * 
		 * 
		 * @param	videoPlayer - instance of VideoPlayer
		 * @param	domaine - full 23video domaine - like http://ddennis.23video.com 
		 */
		
		
		public function VideoStats(videoPlayer:VideoPlayer , domaine:String) {
									
			if (domaine == null || domaine== ""){					
				trace (" DOMAINE MUST BE SPECIFIED TO USE ")
				return
			}
						
			this.domaine = domaine			
			this.videoPlayer = videoPlayer							
			videoPlayer.addEventListener(VideoPlayer.VIDEO_CHANGE, reportPlayTime) 
			videoPlayer.addEventListener(VideoPlayer.VIDEO_STARTED, onStarted) 
			
		}
		
		
		
		
		private function onStarted(e:Event):void {					
			photoId = getIdFromUrl (videoPlayer.URLMovie)				
			reportPlayTime ()			
		}
		
		
		
		/**
		 * We must report both when starting and when stopping/Changing
		 * @param e
		 */
		
		
		public function reportPlayTime(e:Event = null):void {					
			
			trace ("   //////////////////////////////////")
			trace ("VideoStats.as > photoId  = "+photoId)
			trace ("   /////////////////////////////////// ")
						
			if (!photoId) {
				trace ("   PLAYING VIDEO WHITH NO ID ")
				return
			}
			
			endVideoTime = String ( videoPlayer.timeInSeconds  )
									
			var url:String = domaine + "/api/analytics/report/play?photo_id=" + photoId + "&time_start=" + startTime + "&time_end=" + endVideoTime
							
			trace ("VideoStats.as > url  = "+url)
			var reportRequest:URLRequest = new URLRequest(url);
			var reportLoader:URLLoader = new URLLoader();
			reportLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function(event:SecurityErrorEvent):void {});
			reportLoader.addEventListener(IOErrorEvent.IO_ERROR, function httpStatusHandler(e:Event):void {});
			reportLoader.addEventListener(Event.COMPLETE , evnetReported)
			reportLoader.load(reportRequest);	
		}
		
		
		
		
				
		private function getIdFromUrl(s:String):String {		
			var aa:Array = s.split("/")				
			return aa[4] as String 
			
		}
			
		
		
		
		
		private function evnetReported(e:Event):void {			
				var kk = e.target.data  
				trace (kk)
				
		}
		
		
		
	}

}