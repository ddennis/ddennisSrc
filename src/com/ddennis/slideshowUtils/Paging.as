package com.ddennis.slideshowUtils {
	import com.ddennis.display.list.Item;
	import com.ddennis.display.list.ItemList;
	import flash.events.Event;
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class Paging extends ItemList{
		
		public function Paging (xmlList:XMLList, pagingItem:Class, pad:int = 8) {			
			
			super (xmlList, pagingItem, true, false, ItemList.HORIZONTAL)
			padding = pad
			makeListItems()			
			
		}
		
				
		
		override public function activate(mc:Item):void {			
			model.setCurrentIndex(mc.indexNum)			 
		}
			
		
		override public function update(event:Event = null):void {
			
			var newMc:Item = itemArr[model.currentIndex] as Item
			setActive (newMc)
			
			var mc:Item = itemArr[model.oldCurrentIndex] as Item		
			setDeactive (mc)										
			
		}
		
		
		
		
		public function setDeactive(mc:Item):void {			
			
		}
			
		
		
		public function setActive(mc:Item):void{									
					
		}
		
		
	}

}