 package com.ddennis.display.list {
	
	import com.ddennis.display.list.Item;
	import com.ddennis.mvc.AppView;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import flash.display.Sprite;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	//OverwriteManager.init (OverwriteManager.AUTO); 	
	//TweenPlugin.activate ([AutoAlphaPlugin]); 
	
	/**
	 * ... com.ddennis.display.containers.ItemHolder
	 * @author ddennis.dk aka meresukker.dk aka fantastisk.dk
	 */
	
	
	public class ItemList extends AppView{
		
		public static const ITEM_SELCTED:String = "itemSelected"
		
		
		public var currentItem:Item;
		public var oldCurrentItem:Item
		private var _dataSource:Object;
		private var totalItems:int;
		private var _itemHolder:Sprite;
		private var _itemClass:Class;
		private var _padding:Number = 0
		private var _xpos:Number = 0
		private var _ypos:Number = 0
		
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		private var _orientation:String;
		
		private var doPostion:Boolean;
		private var setData:Boolean;
		public var setButtonMode:Boolean = true
		public var _itemArr:Array;
		
		private var _disableOnSelect:Boolean
		
		public function ItemList( dataSource:Object , itemClass:Class, doPostion:Boolean = false, setData:Boolean = false, orientation:String = ItemList.VERTICAL) {
			
			_dataSource = dataSource
			_itemClass = itemClass
			_orientation  = orientation			
			totalItems = getTotalItems ()	
		
			this.doPostion = doPostion
			this.setData = setData
								
		}
			
		
		
		public function updateFeed(dataSource:Object, doPostion:Boolean = false, setData:Boolean = false):void {
			
				cleanUp ()			
				_dataSource = dataSource
				totalItems = getTotalItems ()	
				this.doPostion = doPostion
				this.setData = setData
				this.setButtonMode = setButtonMode
				
				makeListItems ()			
		}
		
		
		public function makeListItems(startIndex:int = 0, amount = null ):void { 
			
			
			if (amount == null) {
				amount = totalItems				
			} else {
				amount = Math.min(totalItems , startIndex + amount)
			}
		
			
			if (!_itemHolder) {
				_itemHolder = new Sprite ()
				_itemHolder.addEventListener(MouseEvent.CLICK, onSelect);
				
				addChild (_itemHolder)
			}
			
			_itemArr = new Array ()		
				
		
			for(var i:int = startIndex; i < amount; i++)	{

				var item:Item = new _itemClass( );	
				
				item.indexNum = i
				
				
				if (setButtonMode) {
					item.buttonMode = true
					item.mouseChildren = false
				}
			
				if (setData) {
					item.setData (_dataSource[i])						
				}
				if (doPostion) {				
					if (_orientation == VERTICAL) {
						
						item.x = _xpos
						item.y = _ypos
						_ypos = Math.round (_ypos + item.height + _padding)
						
					}else {
						
						item.x =_xpos
						item.y = _ypos
						_xpos =Math.round (_xpos + item.width + _padding)
					}
				}	
				
				_itemArr.push (item)				
				_itemHolder.addChild (item)
									
			}			
		}
		
		
		
		
			
		private function onSelect(e:MouseEvent):void {			
			var m:Item = e.target as Item	
			if (m is Item) {
				setCurrentItem (m)
			}			
		}
		
		
		
		/**
		 * @usage modtager index i itemArr
		 * @param	index i itemArr - sætter den valgte item som active
		 */
		
		
		public function setCurrentByIndexNum(index:int):void {
			
			if (index < itemArr.length ) {
				
				var mc:Item = itemArr[index] as Item
				setCurrentItem (mc)
				
			}
			
			
		}
		
		
		public function setCurrentItem(mc:Item):void {
			
			if (currentItem) {			
				currentItem.selected = false
				deActivate (currentItem)
				
				//currentItem.out ()
				//currentItem.active = false				
			}
			
			currentItem = mc
			currentItem.selected = true
			activate (currentItem)		
			
			//currentItem.over ()
			//currentItem.active = true			
		}
		
		
		
		
		public function deActivate(mc:Item):void {					
		}
			
		public function activate(mc:Item  ):void{			
		}
							
		
		public function cleanUp ():void {		
			
			var len:int = itemArr.length
			for (var i:int = 0; i < len; i++) {
				
				var item:Item = itemArr[i] as Item
				item.data = null
				item.cleanUp ()
				itemHolder.removeChild (item)				
				item = null
									
			}
			
			_itemArr.length = 0
		
		}
		
		
		
		
// ---- POSITION -----------------------------------		


		// denne funktion burde rykkes over i en static klasse - hor vi bare sender itemArr
		// så kunne vi have flere forskellige aligne funktioner liggerned
		public function repos(rowLength:int = 3 , spacing:int = 124, setRowCount:Boolean = false, rowNum:int = 0, setXpos:int = 0) {
					
			var len = _itemArr.length	
			
			_xpos = 0
			_ypos = 0			
			
			for (var i:int = 0; i < len; i++) {
				
			var mc:Item = _itemArr[i] as Item

		
			
				mc.x = _xpos
				mc.y = _ypos				
				_xpos = _xpos + mc.width + _padding +setXpos
				
				var isEven:Boolean = rowLength-1 == (i % rowLength)				
				if (isEven) {
					_ypos = _ypos +mc.height + spacing
					_xpos = 0
				
				}		
				}
			
			
		}		
		
// ---- GETTERS AND SETTERES -----------------------------------		
		


		public function fadeIn(time:Number = 1 , delayTime:Number = 10 ) {
					
			var len = _itemArr.length				
			for (var i:int = 0; i < len; i++) {
				
				var mc:Item = _itemArr[i] as Item	
				TweenLite.killTweensOf(mc)
				mc.alpha = 0
				TweenLite.to (mc , time, { alpha:1, delay:i/delayTime , ease:Expo.easeOut } );		
						
			}
			
		}
		
		
		public function fadeOut(time:Number = 1 , delayTime:Number = 10 ) {
					
			var len = _itemArr.length				
			for (var i:int = 0; i < len; i++) {
				
				var mc:Item = _itemArr[i] as Item
				TweenLite.killTweensOf(mc)
				
				if (time == 0) {
					
					mc.alpha = 0
				}else {
					
					TweenLite.to (mc , time, { alpha:0, delay:i/delayTime, ease:Expo.easeOut } );	
				}
				
					
						
			}
			
		}
		
	
		
		
		
		
// ---- GETTERS AND SETTERES -----------------------------------

		private function getTotalItems():int{
			if (typeof(_dataSource) == "xml") {	
			//	trace ("   = XML ")
				return _dataSource.length ()				
			}else {
				return  _dataSource.length
			}		
		}
		
		public function set ypos(value:Number):void {
			_ypos = value;
		}
		
		public function set xpos(value:Number):void {
			_xpos = value;
		}
		
		public function set padding(value:Number):void {
			_padding = value;
		}
		
		public function get itemArr():Array { return _itemArr; }
		
		public function set itemArr(value:Array):void {
			_itemArr = value;
		}
		
		public function get itemHolder():Sprite { return _itemHolder; }
		
		
		
		public function set disableOnSelect(value:Boolean):void {
			
			if (value) {
				_itemHolder.addEventListener(MouseEvent.CLICK, onSelect);
			}else {
				_itemHolder.removeEventListener(MouseEvent.CLICK, onSelect);
			}
			
			_disableOnSelect = value;
		}
		
		
		
	}
	
}