
package com.ddennis.display.text {
	
	import flash.display.Sprite;
    import flash.text.TextField; 
	import flash.text.TextFieldAutoSize;
	
	
	 
public class TextBox extends Sprite {
	
	public var myTextField:TextField = new TextField(); 
	
	public function TextBox(xValue:Number = 0,yValue:Number = 0, widthValue:Number = 250)
	{		
	myTextField.x = xValue;
	myTextField.y = yValue;
	myTextField.width = widthValue;

	myTextField.autoSize = "none";
	myTextField.multiline = true;
	myTextField.wordWrap = true;
	
	}
	
	
	
	
	public function appendTxt(v:String):void {
		
		myTextField.appendText (v)
		this.addChild(myTextField);
	}
	
	
	public function set textString(textString:String):void{
			//myTextField.alpha = 0;
			myTextField.text = textString;
			this.addChild(myTextField);
			//Tweener.addTween(myTextField,{alpha:1, time:1.2, transition:"easeOutExpo"});
	}
	
	private function getFieldSize(){
		
	}
	
	
}

}

