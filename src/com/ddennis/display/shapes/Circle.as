package com.ddennis.display.shapes{


	import flash.display.Sprite;

	public class Circle extends Sprite {
		
		public function Circle(radius:Number , color:uint = 0xFFFFFF ) {
			var shape:Sprite = new Sprite();
			addChild(shape);
			
			shape.graphics.lineStyle(0, 0, 0);
			shape.graphics.beginFill(color);
			shape.graphics.drawCircle(radius, radius, radius);
			shape.graphics.endFill();
		}
		
	}
}
