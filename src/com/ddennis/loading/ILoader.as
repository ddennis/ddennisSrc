package com.ddennis.loading {
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public interface ILoader {
		
		function load(path:String ):void
		function close():void
		
	}
	
}