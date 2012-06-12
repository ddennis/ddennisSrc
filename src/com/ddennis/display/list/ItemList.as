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
		private var _disableOnSelect:Boolean
		
		public var setButtonMode:Boolean = true
		public var _itemArr:Array;	
		public var reposToRow:Boolean = false
		public var reposToRowLength:int = 5
		public var reposToRowSpacing:int = 20
		
		public var _reposIndividualXpos:int = 0
		public var _reposIndividualYpos:int = 0	
		
		public var doFadeIn:Boolean = false
		public var doFadeOut:Boolean = false
		
		
		/**
		 * 
		 * @param	dataSource
		 * @param	itemClass
		 * @param	doPostion
		 * @param	setData
		 * @param	orientation
		 * 
		 * @usage exsample of usage 
		 * 	padding = 1
			reposToRow = true
			reposToRowLength = 3
			reposToRowSpacing = 1
			doFadeIn = true
			makeListItems()
		 */
		
		
		
		public function ItemList( dataSource:Object , itemClass:Class, doPostion:Boolean = false, setData:Boolean = false, orientation:String = ItemList.VERTICAL) {			
			_dataSource = dataSource
			_itemClass = itemClass
			_orientation  = orientation			
			totalItems = getTotalItems ()		
			this.doPostion = doPostion
			this.setData = setData								
		}
			
//------------------------------------------------------------------------------------------------------------------------------------------------------------------				
		
		public function updateFeed(dataSource:Object, doPostion:Boolean = false, setData:Boolean = false):void {			
			
				cleanUp ()			
				_dataSource = dataSource
				totalItems = getTotalItems ()	
				this.doPostion = doPostion
				this.setData = setData
				this.setButtonMode = setButtonMode
				
				makeListItems ()			
		}
		
//--------------------------------------------------------------------------------------------------------------		
		
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
			
			_reposIndividualXpos = 0
			_reposIndividualYpos = 0
		
			for(var i:int = startIndex; i < amount; i++)	{
				var item:Item = new _itemClass();					
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
				
				if (reposToRow) {
					reposIndividual(i, item)
				}
				
				
			}			
		}
		
		
//--------------------------------------------------------------------------------------------------------------			
		
		
		private function onSelect(e:MouseEvent):void {			
			var m:Item = e.target as Item	
			if (m is Item) {
				setCurrentItem (m)
			}			
		}
		
//--------------------------------------------------------------------------------------------------------------				
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

//--------------------------------------------------------------------------------------------------------------		
		
		public function setCurrentItem(mc:Item):void {
			
			if (currentItem) {			
				currentItem.selected = false
				deActivate (currentItem)				
			}
			
			currentItem = mc
			currentItem.selected = true
			activate (currentItem)				
		}
		
//--------------------------------------------------------------------------------------------------------------		
		
		
		public function deActivate(mc:Item):void {	
			throw new Error ("Override venligst")
		}
			
		public function activate(mc:Item  ):void {			
			throw new Error ("Override venligst")
		}
							
//--------------------------------------------------------------------------------------------------------------		


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


		// Burdes flyttes til enstatic klasse 		
		public function repos(rowLength:int = 5 , spacing:int = 124, setXpos:int = 0) {					
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
		
		
		private function reposIndividual (index:int, mc:Item ):void {
									
				mc.x = _reposIndividualXpos
				mc.y = _reposIndividualYpos				
				_reposIndividualXpos = _reposIndividualXpos + mc.width + _padding				
				
				var isEven:Boolean = reposToRowLength-1 == (index % reposToRowLength)				
				if (isEven) {
					_reposIndividualYpos = _reposIndividualYpos +mc.height + reposToRowSpacing
					_reposIndividualXpos = 0				
				}
				
			if (doFadeIn) {
				TweenLite.killTweensOf (mc)
				mc.alpha = 0				
				TweenLite.to (mc , .5, { alpha:1, delay:index/10 , ease:Expo.easeOut } );
			}
				
			if (doFadeOut) {
				TweenLite.killTweensOf (mc)
				TweenLite.to (mc , .5, { alpha:0, delay:index/10 , ease:Expo.easeOut } );
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