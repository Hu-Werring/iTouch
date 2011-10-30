package nid.ui.controls.vkb 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class KeyBoardEvent extends Event 
	{
		
		public static const UPDATE:String = "update";
		public static const ENTER:String = "enter";
		
		public var char:String;
		public var obj:DisplayObject
		
		public function KeyBoardEvent(type:String,data:String="", bubbles:Boolean=false, cancelable:Boolean=false,parentObj:DisplayObject=null) 
		{ 
			super(type, bubbles, cancelable);
			char = data;
			obj = parentObj;
		} 
		
	}
	
}