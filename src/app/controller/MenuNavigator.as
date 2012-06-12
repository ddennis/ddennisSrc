package app.controller {
	
	import com.ddennis.display.list.Item;
	import com.ddennis.display.list.ItemList;	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	OverwriteManager.init(OverwriteManager.AUTO); 
	
	//TweenPlugin.activate ([AutoAlphaPlugin]); 
	
	
	/**
	 * ... app.controller.MenuNavigator
	 * @author ddennis.dk aka fantastisk.dk aka meresukker.dk
	 */
	public class MenuNavigator extends ItemList {
		
		
		private var newMc:Item;
		private var oldMc:Item
		
		
		public function MenuNavigator(dataSource:XMLList) {
					
			super (xmlList, **, ** , **, ItemList.HORIZONTAL)
			
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
			// selected animtion
		}
			
		
		
		public function setActive(mc:Item):void{									
				// deSelected animtion	
		}
		
		
		
		
		
		
		
		
		
	}
	
}