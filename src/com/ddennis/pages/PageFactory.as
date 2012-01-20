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
	public class PageFactory extends AppView{
		public var currentPage:Page
		public var oldCurrentPage:Page
		
		private var _pageArr:Array;
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
			
			 
		public function PageFactory(pageNode:Object, dataObj:Object  , rootFolderPath:String = "") {
			
			this.rootFolderPath = rootFolderPath
			this.pageNode = pageNode
			this.dataObj = dataObj 
			
			var pageDataList:Dictionary = new Dictionary();
			
			pageArr = new Array ()	// så den kan bruges, når vi ikke genere alle klasse fra start
					
			//PageAssets.applicationDomain = k
			
		}
		

			
		
		public function makePages():void {					
						
			var len:int
			if (typeof(pageNode) == "xml") {	
				len =  pageNode.length ()						
			}else {
				len = pageNode.length
			}				

			trace ("------PageFactory CREATED --------------")
			for (var i:int = 0; i < len; i++) {
				
			trace ("PageFactory.as>  = " + pageNode[i].@classReference)				
		
				var page:Page = new Page (pageNode[i])
				page.indexNum = i
					
				
				if (dataObj) {		
					
					page.setData (dataObj[i]) // dette kan være både page node hvis den rummer text - eller content fra en text.xml fil
				}				
				
				pageArr.push (page)						
				
			}
				trace ("------PageFactory DONE --------------")
				trace ("   ")
		}
		
		
		/*
		public function makePages():void {					
						
			var len:int
			if (typeof(stringPageArr) == "xml") {	
				len =  stringPageArr.length ()				
				
			}else {
				len = _dataSource.length
			}				

			trace ("------PageFactory CREATED --------------")
			for (var i:int = 0; i < len; i++) {
				
				trace ("PageFactory.as>  = " + stringPageArr[i])
				
				var item:String = stringPageArr[i]				
				var classPath:String = rootFolderPath + item
				var classType:Class = getDefinitionByName(classPath) as Class;
				var page:Page = new classType() as Page
				page.indexNum = i
										
				if (dataSource) {					
					page.setData(dataSource[i])
				}				
				
				pageArr.push (page)										
			}			
		}
		*/
		
		
		
		
		private function buildPageByIndex():void {
			
			// noget funktionalitet så vi ikke behøver bygge siderne på en gang
			
		}
		
		
		/*
		
		public function setCurrentByIndexNum(index:int):void {								
			if (index < pageArr.length -1) {												
				var mc:Page = pageArr[index] as Page
				setCurrentItem (mc)		
			}		
		}
						
				
		public function setCurrentItem(page:Page):void {					
			model.setCurrentIndex (page.indexNum)		
		}
		*/
		
		
		
		override public function update(e:Event = null):void {
			
			if (currentPage) { // when called firstTime, there is no oldpage to remove
				oldCurrentPage = pageArr[model.oldCurrentIndex] as Page		
				deActivatePage (oldCurrentPage)	
			}
							
			currentPage = pageArr[model.currentIndex] as Page			
			activatePage (currentPage)
						
		}
		
		
		
		
		// Override please
		public function activatePage(page:Page):void{
			
		}
		
		public function deActivatePage(page:Page):void{
			
		}
				
		
		
		public function get pageArr():Array { return _pageArr; }
		
		public function set pageArr(value:Array):void {
			_pageArr = value;
		}
		
				
	
		
		
		
		
		
	}

}