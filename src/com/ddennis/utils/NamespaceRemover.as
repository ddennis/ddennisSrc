package com.ddennis.utils {
	
	// ALl credits goes to this guy http://labs.alducente.com/2008/03/12/as3namespace-remover/
	
	public class NamespaceRemover{
		//Constructor
		public function NamespaceRemover(){}
		
		//PUBLIC FUNCTIONS
		public static function remove(xml:XML):XML{
			var attr:String = getAttributes(xml.@*);
			var theXML:XML = new XML("<"+xml.localName()+attr+"></"+xml.localName()+">");
			if(xml.elements().length() > 0){
				var a:Number;
				for(a=0;a<xml.elements().length();a++){
					var nsRemoved:XML = remove(xml.elements()[a]);
					theXML.appendChild(nsRemoved);
				}
			} else {
				theXML = xml;
			}
			return theXML;
		}
		
		//PRIVATE FUNCTIONS
		public static function getAttributes(attr:XMLList):String{
			var attrString:String = " ";
			if(attr.length() == 0){
				return attrString;
			}
			var b:Number;
			for(b=0;b<attr.length();b++){
				attrString += attr[b].localName()+"='"+attr[0]+"' ";
			}
			return attrString;
		}
	}
}