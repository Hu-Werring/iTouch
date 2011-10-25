package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Snake extends Sprite
	{
		public var _wall:Array = new Array();
		
		public function Snake()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_wall['left'] = 25;
			_wall['right'] = 925;
			_wall['up'] = 25;
			_wall['down'] = 925;
		}
	}
}