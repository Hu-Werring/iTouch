package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class Snake extends Sprite
	{
		private const _gridSize:uint = 15;
		private const _areaSize:uint = 900; //== moet deelbaar zijn door gridSize ==
		private const _snakeStartPoint:Point = new Point(440,440);//== beide punten moeten deelbaar zijn door gridSize
		private const _timerStartSpeed:int = 200; //== begin snelheid van de gametimer
		
		private var _wall:Array = new Array();
		private var _gameTimer:Timer;
		
		private var 
		
		//== snake variables ==
		private var snakeParts:Array = new Array();
		private var snakeMoveX:Number = 1;
		private var snakeMoveY:Number = 0;
		private var nextMoveX:Number = 1;
		private var nextMoveY:Number = 0;
		
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
			
			//== create first part of the snake ==
			var firstSnakePart:SnakePart = new SnakePart();
			firstSnakePart.x = _snakeStartPoint.x;
			firstSnakePart.y = _snakeStartPoint.y;
			snakeParts.push(firstSnakePart);
			addChild(firstSnakePart);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownFunction);
			_gameTimer = new Timer(_timerStartSpeed);
			_gameTimer.addEventListener(TimerEvent.TIMER, moveSnake);
			_gameTimer.start();
			
		}
		
		public function moveSnake(te:TimerEvent):void
		{
			snakeMoveX = nextMoveX;
			snakeMoveY = nextMoveY;
			
			var nX:Number = snakeParts[0].x + snakeMoveX * _gridSize;
			var nY:Number = snakeParts[0].y + snakeMoveY * _gridSize;
			
			snakeParts[0].x = nX;
			snakeParts[0].y = nY;
		}
		
		public function keyDownFunction(ke:KeyboardEvent):void
		{
			if(ke.keyCode == 37) //== links
			{
				if (snakeMoveX != 1)
				{
					nextMoveX = -1;
					nextMoveY = 0;
				}
			} 
			else if(ke.keyCode == 39) //== rechts
			{
				if (snakeMoveX != -1)
				{
					nextMoveX = 1;
					nextMoveY = 0;
				}
			}
			else if(ke.keyCode == 38) //== omhoog
			{
				if (snakeMoveY != 1)
				{	
					nextMoveX = 0;
					nextMoveY = -1;
				}
			}
			else if(ke.keyCode == 40) //== omlaag
			{
				if (snakeMoveY != -1)
				{
					nextMoveX = 0;
					nextMoveY = 1;
				}
			}
		}
		
		public function newSnakePart():void
		{
			var newPart:SnakePart = new SnakePart();
			addChild(newPart);
			snakeParts.push(newPart);
		}
		
		public function placeTail():void
		{
			for (var i:int = snakeParts.length-1;i>0;i--)
			{
				snakeParts[i].x = snakeParts[i-1].x;
				snakeParts[i].y = snakeParts[i-1].y;
			}
		}
		
		public function gameOver():void
		{
			_gameTimer.stop();
		}
		
		public function play():void
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