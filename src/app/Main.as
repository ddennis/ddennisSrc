package app 
{
	
	import app.util.Config;
	import app.view.MainView;
	import com.ddennis.display.shapes.Box;
	import com.ddennis.loading.LoadXML;
	import com.ddennis.mvc.AppModel;
	import com.ddennis.pages.PageAssets;
	import com.ddennis.pages.PageEvent;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Security;
	import flash.text.TextField;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	OverwriteManager.init(OverwriteManager.AUTO); 
	
	//TweenPlugin.activate ([AutoAlphaPlugin]); 
	
	
	/**
	 * ... app.Main
	 * @author ddennis.dk - aka fantastisk.dk/works aka meresukker.dk
	 */

	 
	public class Main extends MovieClip {
		
		
		private var xmlLoader:LoadXML;
		private var model:AppModel;
		private var mainView:MainView;
		
	
		private var languageXmlLoader:LoadXML;
			
	// flash vars ----------------
		public var languagePath:String 
		public var baseUrl:String 
	
		
		
		
		
		public function Main() {
					
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void {
			
			
			trace ("   MAIN documentklasse INIT - må ik kaldes ved test")
			
			
			Security.allowDomain("*");
			Security.allowDomain("www.youtube.com");
			Security.allowDomain("http://youtube.com");
			Security.allowDomain("http://s.ytimg.com");
			Security.allowDomain("http://i.ytimg.com");
			
			removeEventListener(Event.ADDED_TO_STAGE, init);					
			stage.align     = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE							
			validateFalshVar ()
			
		}
		
		
		private function validateFalshVar():void{
				
			
			if (!Config.flashvars) {
				
				trace ("   CONFIG IKKE SAT ")
				Config.flashvars = LoaderInfo(this.root.loaderInfo).parameters; 				
			}
			
			languagePath =  Config.flashvars['languagePath'] as String 	
			baseUrl =  Config.flashvars['baseUrl'] as String 	
			
			
			if (!baseUrl) {				
				baseUrl  = "feed.xml"
			}	

			if (!languagePath) {				
				languagePath  = "assets/language/da.xml"
			}
		
			loadConfigXml ()
			
			trace ("Main.as > languagePath  = "+languagePath)
			
			
			
			
		}
		
		
		
		
		private function loadConfigXml():void 	{
			xmlLoader = new LoadXML("feed.xml");
			xmlLoader.addEventListener(Event.COMPLETE, configXmlLoaded);
		}
		
		
		private function configXmlLoaded(e:Event):void {			
			languageXmlLoader = new LoadXML(languagePath);
			languageXmlLoader.addEventListener(Event.COMPLETE, languageLoaded);
			
		} 

		
		
		
		private function languageLoaded (e:Event):void {
			
			var k = this.root.loaderInfo.applicationDomain
			PageAssets.applicationDomain = k
			
			
			model = new AppModel;
			model.totalItems = xmlLoader.xml.pages.page.length ()
			model.mainXml = xmlLoader.xml			
			model.languageXml = languageXmlLoader.xml
			
					
			mainView = new MainView(model);
			stage.addChild(mainView);
			
			
		
			
			
			
		}
		
		
		
		
		
		
	}
	
}