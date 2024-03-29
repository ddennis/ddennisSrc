﻿package com.ddennis.utils{
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	/**
	 * getURL for ActionScript 3.0.  Similar 
	 * to getURL of ActionScript 2.0 in simplicity
	 * and ease. Errors are suppressed and traced
	 * to the output window.
	 */
	public function getURL(url:String, target:String = null){
		
		try {
			navigateToURL(new URLRequest(url), target);
		}catch(error:Error){
			trace("[getURL] "+error);
		}
		
	}
}