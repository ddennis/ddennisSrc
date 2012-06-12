package com.ddennis.display.list {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/*
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	//OverwriteManager.init (OverwriteManager.AUTO); 	
	//TweenPlugin.activate ([AutoAlphaPlugin]); 
	*/
	/**
	 * ... com.ddennis.display.ListItem
	 * @author ddennis.dk aka meresukker.dk aka fantastisk.dk
	 */
	
	
	public class Item extends MovieClip {
		
		public var data:Object;		
		public var indexNum:int
		private var _selected:Boolean = false
		
		
		
		public function Item() {	
			//this.data = data
			
		}
		
		
		public function setData(d:Object):void {
			
		}
				
		
		
		public function setListener():void {
			//trace ("Item.as > setListener  = ")
			this.addEventListener(MouseEvent.MOUSE_OVER , over)
			this.addEventListener(MouseEvent.MOUSE_OUT , out)
		}
				
		
		
		
		public function out(e:MouseEvent = null):void {
		
		}		
			
		public function over(e:MouseEvent = null):void {
	
		}
			
			
		
		
		
		public function cleanUp ():void{		
			this.removeEventListener(MouseEvent.MOUSE_OVER , over)
			this.removeEventListener(MouseEvent.MOUSE_OUT , out)	
			
			
		}
		
		
		
		public function get selected():Boolean { return _selected; }
		
		
		public function set selected(value:Boolean):void {
			if (value) {
				over ()
			}else {
				out()
			}
			_selected = value;
		}
		
		
	}
	
}