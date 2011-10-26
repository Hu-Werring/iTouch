package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Snake extends Sprite
	{
		public var _wall:Array = new Array();
		public var _areaSize:uint;
		public var _gritSize:uint;
		
		public function Snake()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_gritSize = 16;
			_areaSize = 900; //== moet deelbaar zijn door grit size
			
			_wall['left'] = 25;
			_wall['right'] = 25 + _areaSize;
			_wall['up'] = 25;
			_wall['down'] = 25 + _areaSize;
		}
		
		
	}
}