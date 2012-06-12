package com.ddennis.display.bitmap {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	OverwriteManager.init(OverwriteManager.AUTO); 
	
	//TweenPlugin.activate ([AutoAlphaPlugin]); 
	
	
	/**
	 * ... com.ddennis.display.bitmap.BitmapSlicer
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class BitmapSlicer extends MovieClip {
		
		
		private var sprite:Bitmap;
		private var sliceArr:Array;
		
		
		var w:Number;
		var h:Number;
		var rows:Number = 2;
		var cols:Number = 5;
		
		//var tiles:Vector.<Sprite> = new Vector.<Sprite>();
				
		var _tiles:Array = new Array();
		
		
		public function BitmapSlicer(sprite:Bitmap, sliceArr:Array ) {
			this.sliceArr = sliceArr;
			this.sprite = sprite;							
			draw ()				
		}
		
		
		
		private function draw():void {	
			
				w = sprite.width;
				h = sprite.height;
				
				var image:BitmapData = Bitmap(sprite).bitmapData;
				
				var tileWidth:int  = w / cols;
				var tileHeight:int = h / rows;
				
				var inc:int = 0;
				var pnt:Point = new Point();
				var rect:Rectangle = new Rectangle();
				
				//trace ("BitmapSlicer.as > sliceArr.length  = "+sliceArr.length)
				for (var i:int = 0; i < sliceArr.length; i++) {			
											
						 var slice:Rectangle = sliceArr[i] as Rectangle
						 var currTile:BitmapData= new BitmapData(slice.width, slice.height, true, 0x00000000);
						 rect.x = slice.x
						 rect.y = slice.y
						 currTile.copyPixels(image, slice, pnt, null, null, true);
						 var bit:Bitmap = new Bitmap(currTile, "auto", false);
						 var s:MovieClip = tiles[inc] = MovieClip(addChild(new MovieClip()));
						 						 
						 // offset them a little bit to show that they are in fact tiles.
						 s.x = slice.x +10//+ Math.random()*10 - 5;
						 s.y = slice.y//+ Math.random()*10 - 5;
						
						
						

						 s.addChild(bit);
						 inc++;
										
				}		
				
		}
		
		
		
		
		public function get tiles():Array { return _tiles; }
		
		public function set tiles(value:Array):void {
			_tiles = value;
		}
		
		/*
				
		private function draw():void {	
			
				w = sprite.width;
				h = sprite.height;
				
				var image:BitmapData = Bitmap(sprite).bitmapData;
				
				var tileWidth:int  = w / cols;
				var tileHeight:int = h / rows;
				
				var inc:int = 0;
				var pnt:Point = new Point();
				var rect:Rectangle = new Rectangle(0, 0, tileWidth, tileHeight);
				
				
				for (var i:int = 0; i < rows; i++) {
					
					
					for (var j:int = 0; j<cols; j ++){
						
						 var slice:Rectangle = sliceArr[i] as Rectangle
						 var currTile:BitmapData= new BitmapData(slice.width, slice.height, true, 0x00000000);
						 rect.x = slice.x
						 rect.y = slice.y
						 currTile.copyPixels(image, slice, pnt, null, null, true);
						 var bit:Bitmap = new Bitmap(currTile, "auto", false);
						 var s:Sprite = tiles[inc] = Sprite(addChild(new Sprite()));
						 						 
						 // offset them a little bit to show that they are in fact tiles.
						 s.x = slice.x //+ Math.random()*10 - 5;
						 s.y = slice.y//+ Math.random()*10 - 5;
						
						 s.addChild(bit);
						 inc++;
					}					
				}				
				
				
				var m = tiles[5]
				//trace ("BitmapSlicer.as > m  = "+m)
				m.y = 400
				
				
		}
		
		*/
		
		
		
		
		
		
		
		
		
		
		
	}
	
}