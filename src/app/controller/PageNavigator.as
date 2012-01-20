package app.controller	{
	


	import app.display.Preloader;
	import com.ddennis.display.shapes.Box;
	//import app.view.pages.TestAssets;

	import com.ddennis.pages.Page;
	import com.ddennis.pages.PageAssets;
	import com.ddennis.pages.PageEvent;
	import com.ddennis.pages.PageFactory;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	OverwriteManager.init(OverwriteManager.AUTO); 
	
	TweenPlugin.activate ([AutoAlphaPlugin]); 
	
	
	//TestAssets
	//Velkommen,   Kontakt,  swfSlider, ,  Premieberegning	
	//Intro 
	// Kundecenter
//	Kontakt
	
	
	
	/**
	 * ... app.view.PageNavigator
	 */
	
	public class PageNavigator extends PageFactory {
		private var preloader:Preloader;
	
		
	public function PageNavigator(classPaths , dataSource) {
			super (classPaths , dataSource)
			//makePages ()	// kaldes udefra 
			
			//var testBg:Box = new Box (830, 628)
			//testBg.alpha = .3
			//addChild (testBg)
			
			
			
		}
		
				
		
		
		
		override public function activatePage(page:Page):void {
								
			TweenLite.killTweensOf (page)	
			//page.alpha = 0
			addChild (page)				
			
			page.addEventListener(PageEvent.GOTO_PAGE, gotoPage)			
			//page.addEventListener(PageEvent.START_LOADING, showPreloader)			
			page.addEventListener(PageEvent.PAGE_LOADED, removePreloader)			
			//page.addEventListener(PageEvent.PAGE_LOADING, showLoadProgress) // kunne blive addet hvis vi modtager START_LOADING
												
			page.requestPage()	
			
			if (page.inited) {
				page.alpha = 0
				TweenLite.to (page, .6, { alpha:1, delay:.4 , ease:Strong.easeOut } );	
			}
		
		}
		
		
		
		private function removePreloader(e:PageEvent):void {			
			//removeChild (preloader)
			//TweenLite.to (preloader , .4, { autoAlpha:0, delay:0 , ease:Expo.easeOut } );			
			currentPage.alpha = 0
			TweenLite.to (currentPage, .4, { alpha:1, delay:.4 , ease:Strong.easeOut } );	
		}
		
		
		
		
		
		private function showPreloader(e:PageEvent):void {
		
			if (!preloader) {				
				preloader = new Preloader ()
				preloader.x = 290
				preloader.y = 150
				addChild (preloader)
				preloader.alpha = 0
				preloader.visible = false
			}
				
			preloader.reset()
			TweenLite.to (preloader , .4, { autoAlpha:1, delay:0 , ease:Expo.easeOut } );
			                    
		}
		
		
		
		
		private function showLoadProgress(e:PageEvent):void {	
			
			var p = currentPage.loadProgress
			preloader.loading (p)
			
		}
				 
		
		
		private function gotoPage(e:PageEvent):void {		
		
			var pageId = e.pageId
						
			if ( typeof( pageId) == "number") {				
				
			}else if ( typeof( pageId) is String) {			
				
				var v:int = model.languageXml.pages.page.(@id == pageId).childIndex ()				
				pageId = v				
			}
			
			model.setCurrentIndex(pageId)
			
		}
		
		
		
		
		override public function deActivatePage(page:Page):void {
	
			page.removeEventListener(PageEvent.GOTO_PAGE, gotoPage)
			page.removeEventListener(PageEvent.START_LOADING, showPreloader)			
			page.removeEventListener(PageEvent.PAGE_LOADED, removePreloader)			
			page.removeEventListener(PageEvent.PAGE_LOADING, showLoadProgress) // 
			
			//if (page.stage ) {
				removeChild (page)
			//}
							
			
		}
		
	}
	
}

