package com.ddennis.loading {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class MedieLoadEvent extends Event {
		
		public static const DATA_LOADED:String = "dataLoaded"
		
		
		public function MedieLoadEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event { 
			return new MedieLoadEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("MedieLoadEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}