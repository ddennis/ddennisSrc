package com.ddennis.display.shapes {

	import flash.display.Sprite

	public class Box extends Sprite {
		private var b:Sprite;
	
	
		public function Box(w:Number = 100, h:Number = 100, c:Number = 0x00FF00, a:Number = 1 ) {
			super();
			
			b = new Sprite()
			
			draw(w, h, c, a)
			addChild(b)
		}


		
		public function draw(w:Number, h:Number, color:Number= 0x00FF00 , a:Number = 1):void {

			b.graphics.clear ()
			b.graphics.beginFill(color, a)
			b.graphics.drawRect(0,0,w,h)
			b.graphics.endFill()
			

		}

	}


}