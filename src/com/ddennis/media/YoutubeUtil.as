package app.util {
	/**
	 * ...
	 * @author ddennis.dk aka meresukker.dk aka fantastisk.dk - info@ddennis.dk
	 */
	public class YoutubeUtil{
		
		/**
		 * returns id from full youtube url like - http://www.youtube.com/watch?v=fzzV9Uu7iIM<
		 */
			
			 
		public static function validateUrl(videoId:String):String  {
			
			var k = videoId.indexOf("youtube") != -1;
			
			if (k) {					
				var arr:Array = videoId.split ("=")				
			}else {				
				return videoId
			}				
			return arr[1]
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}

}