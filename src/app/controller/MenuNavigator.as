package app.controller {
	
	import app.ui.MenuBtn;
	import com.ddennis.display.list.Item;
	import com.ddennis.display.list.ItemList;	
	import com.ddennis.display.shapes.Box;
	import com.ddennis.mvc.AppModel;
	import com.ddennis.utils.URLNavigator;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	OverwriteManager.init(OverwriteManager.AUTO); 
	
	//TweenPlugin.activate ([AutoAlphaPlugin]); 
	
	
	/**
	 * ... app.controller.MenuNavigator
	 * @author Dennis 
	 */
	public class MenuNavigator extends ItemList {
		
		public var oldMc:Item;
		public var newMc:Item;
	
		
		public var produkt:MovieClip
		public var beats:MovieClip
		public var reviews:MovieClip
		public var butik:MovieClip
		public var club:MovieClip
		
		
	
		//btnArrClip[0] =
		//btnArrClip[0] =
		
		// små ikoner placering
		/*
		62, 118		
		73, 243
		59, 355
		900, 163
		928, 265
		*/
		
		var smallPosXArr:Array = new Array (0, -109, -108, 737, 713, -60, 759)
		var smallPosYArr:Array = new Array (0, -7, 114, -8, 226, 227,  112)
		
		
		
		var bigPosXArr:Array = new Array (0 ,167, -64, 490, 756, -90, 731)
		var bigPosYArr:Array = new Array (0,-174,-50, -178, 135, 139, -36)
		private var firstTime:Boolean = true
		
		private var isBigState:Boolean = true	
		
		private var testing:Boolean = false
		private var testSelected:MovieClip;
		private var _xmlListe:XMLList;
		
		
		public function MenuNavigator(xmlListe:XMLList, model:AppModel) {
			
			super (xmlListe, MenuBtn, false, true, ItemList.HORIZONTAL)
					_xmlListe = xmlListe;
					
			padding = 2
			makeListItems()	
					
		
			
		 					
					
			itemHolder.tabEnabled = false
			itemHolder.tabIndex = 1
						
			// Flyttet ind i MenuBtn klassen fordi shoadow også ligger u itemHOlder
			//itemHolder.addEventListener(MouseEvent.MOUSE_OVER , itemOver)
			//itemHolder.addEventListener(MouseEvent.MOUSE_OUT, itemOut)
			
			
			
			itemHolder.addEventListener(MouseEvent.MOUSE_OVER , itemOver)
			itemHolder.addEventListener(MouseEvent.MOUSE_OUT , itemOut)
			
			//itemHolder.addEventListener(MouseEvent.MOUSE_DOWN , itemDown)
					
			setIconBigState ()
						
		}
		
		
		
		
		
		private function itemDown(e:MouseEvent):void {
			
				 var m = e.target as MenuBtn		
				 
				testSelected= m.btnClip
				itemHolder.addEventListener(MouseEvent.MOUSE_UP , itemUp)
				this.addEventListener(Event.ENTER_FRAME , tick)
				testSelected.startDrag ()
			
		}
		
		
		
		
		
		private function tick(e:Event):void {
			trace ("   ----------------------- ")
			trace ("  x = "+testSelected.x)
			trace ("  y = "+testSelected.y)
		}
		
		private function itemUp(e:MouseEvent):void {
			this.removeEventListener(Event.ENTER_FRAME , tick)
			itemHolder.removeEventListener(MouseEvent.MOUSE_UP , itemUp)
			testSelected.stopDrag ()			
		}
		
		
		
		
		private function setIconSmallState():void{
			isBigState = false
			
			var len:int = itemArr.length 
			for (var i:int = 0; i < len; i++) {
				var item:MenuBtn = itemArr[i] as MenuBtn
				if (i == 0 ) {
					
				}else {							
					
					item.btnClip.x = int ( smallPosXArr[i])
					item.btnClip.y = int ( smallPosYArr[i])
					//item.btnClip.gotoAndStop (2)
					
					item.btnClip.gotoIntroSmall()
					TweenLite.to (item , .6, { alpha:1, delay:i/20 , ease:Expo.easeOut } );	
				}
			}
		}
		
		private function setIconBigState():void{
				isBigState = true
			var len:int = itemArr.length 
			for (var i:int = 0; i < len; i++) {
				var item:MenuBtn = itemArr[i] as MenuBtn
				if (i == 0 ) {
					
				}else {	
					
					item.btnClip.x = int ( bigPosXArr[i])
					item.btnClip.y = int ( bigPosYArr[i])
					item.btnClip.gotoAndPlay (2)
					TweenLite.to (item , .6, { alpha:1, delay:i/20 , ease:Expo.easeOut } );	
				}
			}
		}
				
		
		
		private function itemOut(e:MouseEvent):void {
			var m:MenuBtn = e.target as MenuBtn			
				
			if (testing) {
				m.alpha = 1
				return 
			}
			
			
			if (isBigState) {
				m.btnClip.gotoOutBig ()
			}else {
				m.btnClip.gotoOutSmall ()
			}
			
			
			
		}
		
		
		
		
		private function itemOver(e:MouseEvent):void {
			var m:MenuBtn = e.target as MenuBtn
			
			if (testing) {
				m.alpha = .6
				return 
			}
			
			if (isBigState) {
				m.btnClip.gotoInBig ()	
			}else {
				m.btnClip.gotoInSmall ()
			}
			
		}
		
		
		
	
				
		
		
		
		override public function activate(mc:Item):void {
									
			if (mc.indexNum == 5) {
				
				ExternalInterface.call("showEclubSubscription");
				model.setCurrentIndex (mc.indexNum)
				//var temp = String(_xmlListe.url);
			
			 //  URLNavigator.ChangePage(temp, "_blank")
			}else {
				
				ExternalInterface.call("hideEclubSubscription");
				model.setCurrentIndex (mc.indexNum)
			}
			var adfTracking  = String(_xmlListe.adfTracking[mc.indexNum]);
			var adfCampaingId = String(_xmlListe.adfCampaignId[mc.indexNum]);
			var analytics = String(_xmlListe.analyticsTracking[mc.indexNum]);
			
			var tempConvert:int = mc.indexNum;
			trace ("MenuNavigator.as > mc.indexNum  = " + analytics)
			
				trace ("   tracking = "+adfTracking)
			if (mc.indexNum == 0) {		
				ExternalInterface.call("DoTrackingGoogle", 'HTC Sensation Beats | Frontpage');
				ExternalInterface.call("Adform.Tracking.Track", adfCampaingId, adfTracking, '');		
			}
			ExternalInterface.call("Adform.Tracking.Track", adfCampaingId, adfTracking, '');
			ExternalInterface.call("DoTracking", analytics);
			trace ("MenuNavigator.as > analytics  = "+analytics)
			
		}
		
		
		
		
		private function gotoBigState():void{
			setIconBigState ()
		}
			
		
		
		private function gotoSmallState():void{
			setIconSmallState ()
		}
		
	
		
		
	
		override public function update(event:Event = null):void 	{
			
			if (newMc) {
				oldMc = itemArr[model.oldCurrentIndex] as Item		
				setDeactive (oldMc)			
			}
			
			
			newMc = itemArr[model.currentIndex] as Item
			setActive (newMc)
					
			
			if (model.currentIndex == 0) {		
								
				if (firstTime) {
					firstTime = false
					return 
				}
				
				fadeOut(.2)
				TweenLite.delayedCall (1 , gotoBigState)
				
			}else {
				
				if (model.oldCurrentIndex == 0) {
													
					fadeOut(.2)
					TweenLite.delayedCall (1 , gotoSmallState)
					//setIconSmallState ()	
				}
			}
			
			
		}
		
	
		
		
		public function setActive(mc:Item):void {	
			var m:MenuBtn = mc as MenuBtn	
			m.selected = true
			
			
		}
				
		
		
		public function setDeactive(mc:Item):void {			
			
			var m:MenuBtn = mc as MenuBtn	
			m.selected = false;
			
		
		}
		
	}
	
	
	
}





















