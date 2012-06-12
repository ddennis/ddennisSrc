package com.ddennis.slideshowUtils {
	import com.ddennis.display.list.Item;
	import com.ddennis.display.list.ItemList;
	import flash.events.Event;
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class SimpleMenu extends ItemList{
		private var newMc:Item;
		private var oldMc:Item;
		
		
		
		
		public function SimpleMenu (xmlList:XMLList, menuItem:Class, pad:int = 8) {			
			
			super (xmlList, pagingItem, true, false, ItemList.HORIZONTAL)
			padding = pad
			makeListItems()			
			
		}
		
				
		
		override public function activate(mc:Item):void {			
			model.setCurrentIndex(mc.indexNum)			 
		}
			
		
		
		override public function update(event:Event = null):void {
			
			if (newMc) {
				oldMc = itemArr[model.oldCurrentIndex] as Item		
				setDeactive (oldMc)			
			}
			
			newMc = itemArr[model.currentIndex] as Item
			setActive (newMc)
			
									
			
		}
		
		
		
		public function setDeactive(mc:Item):void {			
			
		}
			
		
		
		public function setActive(mc:Item):void{									
					
		}
		
		
	}

}