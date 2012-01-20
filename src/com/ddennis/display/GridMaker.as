package com.ddennis.display {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ddennis
	 */
	public class GridMaker extends MovieClip {
		
		private var sw:Number
		private var sh:Number
		public var _container:MovieClip
		private var GridArray:Array;
		
		public var intervalsAmount:Number = 15 // mange intervaller der skla være
		public var columnsAmount:Number = 3 // hvor mange colonner der er per interval
		
		public function GridMaker(container) {
			
			_container = container			
			addEventListener(Event.ADDED_TO_STAGE , onStage)			
		}
		
		
		
		private function onStage(e:Event):void {
			
			//gridArray = new Array ()
			trace ("   =jjjjjjjj ")
			
			sh = stage.stageHeight
			sw = stage.stageWidth			
			
			var xpos = 0
			var ypos = 0
			var arrNum:Number = 0
			
		
		
			while (_container.width  < intervalsAmount ) {
							
				var item:gridItem = new gridItem ()	
				item.x = xpos
				item.y = ypos
				
				ypos = ypos + item.height		 
								
				
				if (item.y + item.height > sh) {
					
					//gridArray[arrNum].push (hArr)						
					//var hArr:Array = new Array ()	
					
					arrNum = arrNum + 1				
					
					xpos = xpos + item.width				
					ypos = 0
				}
							
				_container.addChild(item)
				
				
			}
				
		}
			
			
			
			
			
			
	
		
		/*
		private function onStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			//var item:gridItem = new gridItem ()		
			sh= stage.stageHeight
			sw= stage.stageWidth
			
			
			var tempItem:gridItem = new gridItem ()		

			trace ("  sw = "+sw)
			trace ("  sh = "+sh)
			
			var itemAmountWidth:Number = sw  / tempItem.width
			var itemAmountHeight:Number = sh  / tempItem.height
			var itemAmount =  itemAmountWidth * itemAmountHeight
			
			
			var xpos = 0
			var ypos = 0
			
			for (var i:int = 0; i < itemAmount; i++) {
				
				var item:gridItem = new gridItem ()	
				item.x = xpos
				item.y = ypos
				xpos = xpos + item.width
				
				var k = item.x + item.width 
				if (item.x + item.width > sw) {
					
					ypos = ypos + item.height
					xpos = 0
				}
							
				_container.addChild(item)
			}
			
			
			
			
			
			
			
		}
		*/
		
		public function init ():void {
			
			

			
			//var item:gridItem = new gridItem ()		
		///	addChild (item)
			
			
		}
		
	}
	
}