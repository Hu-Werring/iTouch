package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SnakeGrid extends Sprite
	{
		
		
		public function SnakeGrid()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			for (var i:int = 0; i < 61; i++)
			{
				var lineH:GridLine = new GridLine();
				lineH.x = 22.5;
				lineH.y = 67.5 + (i*15);
				addChild(lineH);
				
				var lineV:GridLine = new GridLine();
				lineV.rotation = 90;
				lineV.x = 22.5 + (i*15);
				lineV.y = 52.5;
				addChild(lineV);
			}
		}
	}
}