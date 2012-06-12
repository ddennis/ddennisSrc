

package com.ddennis.display.shapes {

import flash.display.Graphics;
import flash.display.Sprite



public class BoxRounded extends Sprite {
	private var b:Sprite;
	
	
		public function BoxRounded(w:Number = 100, h:Number = 100, radius:Number  = .4,  c:Number = 0x00FF00) {
			super();
			b = new Sprite()	
		
			draw(w, h, radius, c)
			addChild(b)
		}


		
		public function draw(w:Number, h:Number, radius:Number , color:Number = 0x00FF00):void {

			b.graphics.clear ()
			b.graphics.beginFill(color)				
			b.graphics.drawRoundRect(0, 0, w, h, radius);
			b.graphics.endFill()	
	
		}

	}


}