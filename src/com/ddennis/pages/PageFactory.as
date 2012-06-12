package com.ddennis.pages {
	
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import com.ddennis.pages.Page;
	
	/**
	 * ...
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */
	public class PageFactory {
		public var currentPage:Page
		public var oldCurrentPage:Page
		
		
		private var pageNode:Object;
		private var rootFolderPath:String = ""
		private var dataObj:Object 
		private var firstTime:Boolean = true;
					
		/**
		 * 
		 * @param	pageNode - hele page XML noden med sti til klassen - model.mainXml.pages.page.@classReference
		 * @param	dataObj - selve node med data(tekst og medier) for siden. Kan være model.mainXml.pages.page eller XML noder fra en text xml file 
		 * @example 
			var dataSourceClassRef = model.mainXml.pages.page.@classReference
			var dataSource = model.mainXml.pages.page  - eller <page id="side">	
		 */
			
			 
		public function PageFactory(pageNode:Object, dataObj:Object  , autoStart:Boolean = false) {			
			this.rootFolderPath = rootFolderPath
			this.pageNode = pageNode
			this.dataObj = dataObj 				
		}
		
		
	//##########################################################################################################
	

		public function makePages():Array  {					
			
			var pageArr:Array  = new Array ()	
			
			var len:int
			if (typeof(pageNode) == "xml") {	
				len =  pageNode.length ()						
			}else {
				len = pageNode.length
			}				
			
			for (var i:int = 0; i < len; i++) {					
				var page:Page = new Page (pageNode[i])
				page.indexNum = i				
				if (dataObj) {							
					page.setData (dataObj[i]) // dette kan være både page node hvis den rummer text - eller content fra en text.xml fil
				}									
				pageArr.push (page)						
					
			}		
			
			return pageArr
			
		}
		
		
	//##########################################################################################################	
	
		/**
		 * To be implemented
		 */
		
		private function buildPageByIndex():void {			
			
		}
				
		

		
	}

}