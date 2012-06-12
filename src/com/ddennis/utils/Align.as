package com.ddennis.utils {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	/**
	 * ...
	 * @author ddennis.dk aka meresukker.dk aka fantastisk.dk
	 */
	public class Align{
		
		public function Align() {
			
		}
					
				
		public static function centerTo(centerTo:Object , centerThis:DisplayObject  ):void {
			
		
			if (centerTo == centerTo as Stage) {				
				centerThis.x = centerTo.stageWidth*.5 - centerThis.width*.5;
				centerThis.y = centerTo.stageHeight *.5 - centerThis.height*.5
				
			}else {
				
				centerThis.x= DisplayObject(centerTo).x+DisplayObject(centerTo).width/2;
				centerThis.y = DisplayObject(centerTo).y + DisplayObject(centerTo).height / 2;				
			}
		}
				
		
		public static function centerX(centerTo:Object , centerThis:DisplayObject  ):void {
			
		
			if (centerTo == centerTo as Stage) {				
				centerThis.x = centerTo.stageWidth*.5 - centerThis.width*.5;							
			}else {				
				centerThis.x= DisplayObject(centerTo).x+DisplayObject(centerTo).width/2;
							
			}
		}
		
		
		
		
	}

}