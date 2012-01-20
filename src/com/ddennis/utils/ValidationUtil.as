package com.ddennis.utils {
	/**
	 * ...
	 * @author ddennis.dk aka meresukker.dk aka fantastisk.dk
	 */
	public class ValidationUtil{
		
		
		
		public function ValidationUtil() {
						
		}		
		
		public static function isEmail(email:String):Boolean {
			var pattern:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
			return email.match(pattern) != null;
		}
		
		
		
	}

}