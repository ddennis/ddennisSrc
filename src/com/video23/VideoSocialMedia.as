package com.video23{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class VideoSocialMedia extends MovieClip{
		public var facebookIcon:MovieClip;
		public var twitterIcon:MovieClip;
	
		
		
		public function VideoSocialMedia(facebookIcon:MovieClip , twitterIcon:MovieClip) {
			
			this.facebookIcon = facebookIcon
			facebookIcon.addEventListener(MouseEvent.CLICK , facebookClick )
			addChild (facebookIcon)
			
			
			this.twitterIcon = twitterIcon
			twitterIcon.addEventListener (MouseEvent.CLICK , twitterClick)
			addChild (twitterIcon)
					
		}
		
		
		
		
		private function facebookClick(e:MouseEvent):void {
			
			var u:String = "http://www.facebook.com/sharer.php?t=TEST TEKST&u=http://www.google.com"
			gotoLink (u)
		}
		
		
		
		
		private function twitterClick(e:MouseEvent):void {
		
			//http://twitter.com/?status=Jul+med+J.R+-+24.+december+S%C3%85+BLEV+DET+ALLIGEVEL+JUL...+http%3a%2f%2fvideo.dis-play.dk%2fvideo%2f926686
			
			var u:String = "http://twitter.com/?status=TEST TEKST "
			gotoLink (u)
		}
		
		
		private function gotoLink(url:String):void {
					
			var request:URLRequest = new URLRequest(url);
			try {
			  navigateToURL(request, '_blank'); // second argument is target
			} catch (e:Error) {
			  trace("Error occurred!");
			}
			
		}
		
		
		
		
	}

}