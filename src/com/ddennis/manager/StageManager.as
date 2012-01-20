package com.ddennis.manager{
	
	
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	//OverwriteManager.init (OverwriteManager.AUTO); 	
	//TweenPlugin.activate ([AutoAlphaPlugin]); 
	
	/**
	 * ... com.graph.viewControllers.viewController
	 * @author ddennis.dk aka meresukker.dk aka fantastisk.dk
	 */
	
	
	public class StageManager extends Sprite{
		
		
		
		public function StageManager () {				
			 
			stage.align     = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE			
			stage.addEventListener(Event.RESIZE , onResize)
						
		}
		
		
		
		public function onResize(e:Event):void {
			
		}
		
		
	
	}
	
}