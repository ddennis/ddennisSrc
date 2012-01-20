package com.ddennis.display.interactive{
		

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	
	public class DragAndThrow extends MovieClip	{
		
		public static const MOVING:String = "moving"
		
		//private var ball:Ball;
		private var vx:Number;
		private var vy:Number;
		private var bounce:Number = -0.1;
		private var gravity:Number = 0;
		private var oldX:Number;
		private var oldY:Number;
		public var _content:Sprite
		
		private var dragOutside:Number = 100
		
		
		public function DragAndThrow(content:Sprite ) {
			
			_content = content
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			init();
		}
		
		private function init():void {
			
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align=StageAlign.TOP_LEFT;
		
			//ball = new Ball();
			//ball.x = stage.stageWidth / 2;
			//ball.y = stage.stageHeight / 2;
			//vx = Math.random() * 10 - 5;
			//vy = -10;
			//addChild(ball);

			_content.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			//this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void	{
			
			vy = vy*.8
			vx = vx*.8
			//_content.x +=  vx
			//_content.y +=  vy
			
			_content.x += Math.round(vx)
			_content.y +=Math.round( vy)	
		
			var left:Number =  - _content.width // stage.stageWidth -  _content.width		
			var right:Number = 40
			
			// vi bruger denne fordi moviclieppet er peger op ad. altså y pos er positiv istedet fro nagativ som normalt
			var top:Number = 100
			var bottom:Number =  0// stage.stageHeight - _content.height
			
			// Standard movieclip med 0,0 i venstre hjørne og content placeret til højre og nede
			//var top:Number = 0
			//var bottom:Number =   stage.stageHeight - _content.height
			
			
			if (_content.x  > right) {		
				//trace ("   =ddddddddddd "+right)
				//_content.x = right 
				
				vx =  - 2
				_content.x += Math.round(vx*10)
				
			}
			
			
			else if (_content.x  < left) {
				//		trace ("   =hhhhhhhhh "+left)
												
				vx = 2	
				_content.x += Math.round(vx * 10)
			
					
				
			}
			
			
			if (_content.y  < bottom) {
				//trace ("   = bottom")
				//_content.y = bottom 
				//vy *= bounce;
				//vy =  2
			//	_content.y += Math.round(vy*10)
			}
			
			
			else if (_content.y  > top) {
				//trace ("  top = "+top)
			//	vy = -2
			//	_content.y += Math.round(vy*10)
			
				//_content.y = top 
				//vy *= bounce;
			}
				
			trace ("   tick")
			dispatchEvent(new Event(DragAndThrow.MOVING))
			if (Math.round(vx * 10) == 0) {
				removeEventListener(Event.ENTER_FRAME, onEnterFrame)
				
				if (Math.round(vy * 10) == 0) {
					trace ("  ----------------- ")
					
				}
			}
		
			
		}
		
		public function onMouseDown(event:MouseEvent):void	{
			
			//trace ("   content.x = " + _content )
			trace ("   ---------------------- ")
			//trace ("   content.y = "+_content.y )
			
			oldX = _content.x;
			oldY = _content.y;
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);					
			
			var left:Number=  - _content.width + (stage.stageWidth - 20)
			var top:Number= _content.y
			
			var right:Number= 0;
			var bottom:Number= _content.y
			
			var myWidth:Number = right - left;					
			var myHeight:Number = bottom - top;
													
			var boundRect:Rectangle = new Rectangle(left, top, myWidth, myHeight);				
		
			
			
			_content.startDrag(false , boundRect);
			
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.addEventListener(Event.ENTER_FRAME, trackVelocity);
			
		}
		
		
		public function onMouseUp(event:MouseEvent):void {
			
			
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_content.stopDrag();
			
			this.removeEventListener(Event.ENTER_FRAME, trackVelocity);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		
		private function trackVelocity(event:Event):void{
			vx = _content.x - oldX;
			vy = _content.y - oldY;
			oldX = _content.x;
			oldY = _content.y;
			
			dispatchEvent(new Event(DragAndThrow.MOVING))	
		}
		
		
	}
}
