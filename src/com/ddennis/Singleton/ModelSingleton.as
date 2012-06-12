package com.ddennis.singleton {
	
	
	import flash.display.MovieClip;
	import flash.events.EventDispatcher
	import flash.events.Event
	import flash.text.StyleSheet;
	import flash.text.TextField;
	
   
   public class ModelSingleton extends EventDispatcher {
	   
	   
      private static var instance:ModelSingleton;
      private static var allowInstantiation:Boolean;    
  
	  public var baseUrl:String
	
	  
      public static function getInstance():ModelSingleton {
		  		  
         if (instance == null) {
            allowInstantiation = true;
            instance = new ModelSingleton();
			allowInstantiation = false;
			
			// init other models			
					
          }
		    return instance;
       }
	   
	 	         
	   
      public function ModelSingleton():void {
         if (!allowInstantiation) {
            throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
          }	 		  
       }
	   	   
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
		
	
	
		
		
		
	   
    }
}