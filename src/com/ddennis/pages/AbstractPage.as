package com.ddennis.pages {
	
	import com.ddennis.display.shapes.Box;	
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class AbstractPage extends MovieClip{				
			
		public var data:Object;		
		public var indexNum:int
		public var text:XML
	
	
	//##########################################################################################################
	
		
		public function AbstractPage() {			
			//var testBg:Box = new Box (725, 532)
			//testBg.mouseEnabled = false
			//testBg.alpha = .1
			//addChildAt (testBg, 0)			
		}
		
	
	//##########################################################################################################
	
		
		public function setData(data:Object):void {
			this.data = data;			
			trace ("AbstractPage.as > data  = "+data)
			
		}
	
		
	//##########################################################################################################
		
	
		public function cleanUp():void {			
			throw  new Error ("CLEAN UP - OVERRIDE DENNE FUNKTION I HVER SIDE")
			
		}
	
	//##########################################################################################################


		public function activatePage():void {						
			throw  new Error ("ACTIVATE_PAGE - OVERRIDE DENNE FUNKTION I HVER SIDE")			
		}

		
	//##########################################################################################################

		
	}

}