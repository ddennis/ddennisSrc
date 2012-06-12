package app.view {
	
	import com.ddennis.mvc.AppModel;
	import flash.display.MovieClip;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	OverwriteManager.init(OverwriteManager.AUTO); 
	
	//TweenPlugin.activate ([AutoAlphaPlugin]); 
	
	
	/**
	 * ... app.view.MainView
	 * @author ddennis.dk -  aka fantastisk.dk/works  aka meresukker.dk
	 */
	public class MainView extends MovieClip {
		private var model:AppModel;
		
		public function MainView(model:AppModel) {
			this.model = model;
			
		}
		
	}
	
}