package com.ddennis.display{
	
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class OffsetResize extends Sprite{
		
		public static const MAX:String="max";
		public static const MIN:String="min";
		private var _offsetType:String;
		
		public function OffsetResize($child:DisplayObject,$offsetType:String="max"):void{
			_offsetType=$offsetType;
			addChild($child);
			if(stage) init();
			else addEventListener(Event.ADDED_TO_STAGE,init);
			addEventListener(Event.REMOVED_FROM_STAGE,end);
		}
		
		private function init(e:Event=null):void{
			stage.addEventListener(Event.RESIZE,stageResize);
			stageResize();
		}
		
		private function stageResize(e:Event=null):void{
			var px:Number=stage.stageWidth/width;
			var py:Number=stage.stageHeight/height;
			var div:Number=_offsetType=="max"?Math.max(px,py):Math.min(px,py);
			width*=div;
			height*=div;
			x=(stage.stageWidth/2)-(width/2);
			y=(stage.stageHeight/2)-(height/2);
		}
		
		private function end(e:Event):void{
			stage.removeEventListener(Event.RESIZE,stageResize);
		}
		
		public function set offsetType(type:String):void{
			_offsetType=type;
			if(stage) stageResize();
		}
		
		public function get offsetType():String{ return _offsetType; }
	}	
}