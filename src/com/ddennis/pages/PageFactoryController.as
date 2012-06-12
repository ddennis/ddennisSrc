package com.ddennis.pages {

	import com.ddennis.mvc.AppView;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import com.ddennis.pages.Page;

	/**
	* ...
	* @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	*/
	public class PageFactoryController extends AppView {
		public var currentPage:Page
		public var oldCurrentPage:Page

		private var _pageArr:Array;
		private var pageNode:Object;
		private var rootFolderPath:String = ""
		private var dataObj:Object 



		/**
		*
		* @param	pageNode - hele page XML noden med sti til klassen - model.mainXml.pages.page.@classReference
		* @param	dataObj - selve node med data(tekst og medier) for siden. Kan være model.mainXml.pages.page eller XML noder fra en text xml file
		* @example
		   var dataSourceClassRef = model.mainXml.pages.page.@classReference
		   var dataSource = model.mainXml.pages.page  - eller <page id="side">
		*/


		public function PageFactoryController( pageNode:Object , dataObj:Object , rootFolderPath:String = "" , autoStart:Boolean = false ) {

			this.rootFolderPath = rootFolderPath
			this.pageNode = pageNode
			this.dataObj = dataObj 

			var pageDataList:Dictionary = new Dictionary();
			pageArr = new Array()

			if ( autoStart) {
				makePages()
			}

		}


		//--------------------------------------------------------------------------------------------------------------	

		public function makePages():void {					

			var len:int
			if (typeof(pageNode) == "xml") {	
				len =  pageNode.length()
			} else {
				len = pageNode.length
			}				

			for (var i:int = 0; i < len; i++) {					
				var page:Page = new Page( pageNode[ i])
				page.indexNum = i				
				if (dataObj) {							
					page.setData( dataObj[ i]) // dette kan være både page node hvis den rummer text - eller content fra en text.xml fil
				}									
				pageArr.push( page )

			}
		}


		//--------------------------------------------------------------------------------------------------------------		


		private function buildPageByIndex():void {
			// noget funktionalitet så vi ikke behøver bygge siderne på en gang			
		}


		//--------------------------------------------------------------------------------------------------------------		


		override public function update( e:Event = null ):void {

			if ( currentPage) { // when called firstTime, there is no oldpage to remove
				oldCurrentPage = pageArr[model.oldCurrentIndex] as Page		
				deActivatePage( oldCurrentPage )
			}
			currentPage = pageArr[model.currentIndex] as Page			
			activatePage( currentPage )
		}


		//--------------------------------------------------------------------------------------------------------------	

		// Override please
		public function activatePage( page:Page ):void {
			trace ("PageFactoryController.as > activatePage ( page:Page ) ")
		}

		public function deActivatePage( page:Page ):void {
			trace ("PageFactoryController.as > deActivatePage ( page:Page ) ")
		}


		//--------------------------------------------------------------------------------------------------------------	

		public function get pageArr():Array {
			return _pageArr; }

		public function set pageArr( value:Array ):void {
			_pageArr = value;
		}

		//--------------------------------------------------------------------------------------------------------------			

	}

}