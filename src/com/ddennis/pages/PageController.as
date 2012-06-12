package com.ddennis.pages	{

	
	import com.ddennis.display.shapes.Box;
	import com.ddennis.mvc.AppView;
	import com.ddennis.pages.PageFactoryController;
	//import app.view.pages.TestAssets;

	import com.ddennis.pages.Page;
	import com.ddennis.pages.PageAssets;
	import com.ddennis.pages.PageEvent;

	import flash.display.MovieClip;
	import flash.events.Event;
	

	
	/**
	 * ... app.view.PageNavigator
	 */
	
	public class PageController extends AppView {
		private var _pageArr:Array;
		private var pageFactory:PageFactory;
		
		public var currentPage:Page
		public var oldCurrentPage:Page	
	
		
		/**
		 * 
		 * @param	classPaths - XMLnode with attributes swfPath and classReference
		 * @param	dataSource
		 */
		public function PageController(classPaths , dataSource) {
		
			pageFactory = new PageFactory (classPaths , dataSource)			
			//var pageDataList:Dictionary = new Dictionary();		
						
		}
		
		
		public function buildPages():void {
			_pageArr = pageFactory.makePages () // retsun array with page.as
		}
		
		override public function update(e:Event = null):void {
			
			if (currentPage) { // when called firstTime, there is no oldpage to remove
				oldCurrentPage = _pageArr[model.oldCurrentIndex] as Page		
				deActivatePage (oldCurrentPage)	
			}							
			currentPage = _pageArr[model.currentIndex] as Page			
			activatePage (currentPage)						
			
		}
		
		
		
		public function activatePage(page:Page):void {
								
			addChild (page)				
			
			// So each page can navigate to other pages
			page.addEventListener(PageEvent.GOTO_PAGE, gotoPage)			
			
								
			if (!page.inited) {
				page.addEventListener(PageEvent.START_LOADING, showPreloader)				
				page.addEventListener(PageEvent.PAGE_LOADED, removePreloader)				
				page.addEventListener(PageEvent.PAGE_LOADING, pageLoadProgress) // kunne blive addet hvis vi modtager START_LOADING	
				
			}else {
				
				//page.alpha = 0
				//TweenLite.to (page, .6, { alpha:1, delay:.4 , ease:Strong.easeOut } );	
			}
			
			page.requestPage()	
		
		}
		
		
		
		private function removePreloader(e:PageEvent):void {			
						
			//currentPage.alpha = 0
			//TweenLite.to (currentPage, .4, { alpha:1, delay:.4 , ease:Strong.easeOut } );	
		}
		
		
		
		
		/**
		 * 
		 * @param	override
		 */
		public function showPreloader(e:PageEvent):void {
		
			//if (!preloader) {	
				/*
				preloader = new Preloader ()
				preloader.x = 290
				preloader.y = 150
				addChild (preloader)
				preloader.alpha = 0
				preloader.visible = false
				*/
			//}
				
			//preloader.reset()
			//TweenLite.to (preloader , .4, { autoAlpha:1, delay:0 , ease:Expo.easeOut } );
			                  
		}
		
		
		
		
		public function pageLoadProgress(e:PageEvent):void {				
			//var p = currentPage.loadProgress
			//pageLoadProgress ()
			//preloader.loading (p)			
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
		
		
		
		
		public function deActivatePage(page:Page):void {
	
			page.removeEventListener(PageEvent.GOTO_PAGE, gotoPage)
			page.removeEventListener(PageEvent.START_LOADING, showPreloader)			
			page.removeEventListener(PageEvent.PAGE_LOADED, removePreloader)			
			page.removeEventListener(PageEvent.PAGE_LOADING, pageLoadProgress) // 
			
			//if (page.stage ) {
			removeChild (page)
			//}
							
			
		}
		
		public function get pageArr():Array { return _pageArr; }
		
	}
	
}

