package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class GameOverScreen extends Sprite
	{
		public function GameOverScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var s:GameOverBackground = new GameOverBackground();
			s.alpha = 0.9;
			addChild(s);
		}
	}
}