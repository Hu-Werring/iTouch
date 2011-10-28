package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Tafels extends Sprite
	{
		private var _switchRotation:Boolean;
		
		public function Tafels(s:Boolean = false)
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
			_switchRotation = s;
		}
		
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			switch (_switchRotation)
			{
				case true:
					drawTafelHorizontaal();
					break;
				
				case true:
					drawTafelVerticaal();
					break;
			}
		}
		
		public function drawTafelHorizontaal():void
		{
			
		}
		
		public function drawTafelVerticaal():void
		{
			
		}
	}
}