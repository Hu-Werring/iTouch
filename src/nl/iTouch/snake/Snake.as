package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class Snake extends Sprite
	{
		private const _gridSize:uint = 20;
		private const _areaSize:uint = 900; //== moet deelbaar zijn door gridSize ==
		private const _snakeStartPoint:Point = new Point(440,440);//== beide punten moeten deelbaar zijn door gridSize
		
		public var _wall:Array = new Array();
		
		public var _gameTimer:Timer;
		
		//== snake variables ==
		public var snakeParts:Array = new Array();
		
		//== main class function ==
		public function Snake()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_wall['left'] = 25;
			_wall['right'] = 25 + _areaSize;
			_wall['up'] = 25;
			_wall['down'] = 25 + _areaSize;
			
			var firstSnakePart:SnakePart = new SnakePart();
			
			_gameTimer = new Timer(200);
			_gameTimer.addEventListener(TimerEvent.TIMER, play);
			_gameTimer.start();
			
		}
		
		public function play(te:TimerEvent):void
		{
			
		}
		
		public function stop(force:Boolean = false):void
		{
			
		}
		
		public function credits():void
		{
			
		}
		
		public function highscore():void
		{
			
		}
		
	}
}