package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class TafelVertical extends Sprite
	{
		private const _lenght:uint = 5;
		private const _height:uint = 9;
		
		public var tafelParts:Array = new Array();
		
		public function TafelVertical()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			drawTafel();
		}
		
		public function drawTafel():void
		{
			for (var j:uint = 0; j < 9;j++)
			{
				for(var i:int = 0; i < 5; i++)
				{
					var t:TafelFill = new TafelFill();;
					t.x = i * 15;
					t.y = j * 15;
					addChild(t);
					tafelParts.push(t);
				}
			}
		}
	}
}