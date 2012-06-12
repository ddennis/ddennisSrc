package com.ddennis.pages
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	import flash.text.Font;

	public class PageAssets	{
		
		public static var applicationDomain:ApplicationDomain;
		
		
		public static function getMC(className:String):MovieClip {
			 var myClass:Class = applicationDomain.getDefinition(className) as Class;
			 return new myClass();
		}
			
		
		public static function getSprite(className:String):Sprite {			
			 var myClass:Class =applicationDomain.getDefinition(className) as Class;
			 return new myClass();
		}
		
		
		public static function getFont(fontName:String):* {			
			//var myFont  = applicationDomain.getDefinition(fontName) 		 
			//return new myFont();
		}
				
		
		public static function getDisplayObj(className:String):DisplayObject {			
			 var myClass:Class = applicationDomain.getDefinition(className) as Class;
			 return new myClass();
		}
		
		
	}
}