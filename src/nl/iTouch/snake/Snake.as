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
		//== constante waardes ==
		private const _gridSize:uint = 15;
		private const _areaSize:uint = 900; //== moet deelbaar zijn door gridSize ==
		private const _snakeStartPoint:Point = new Point(465,465);//== beide punten moeten deelbaar zijn door gridSize (of 0)
		private const _timerStartSpeed:int = 200; //== begin snelheid van de gametimer
		
		//game variables ==
		private var _wall:Array = new Array();
		private var _gameTimer:Timer;
		private var _spawnRate:int = 1;
		private var book:Book = new Book();
		
		//== snake variables ==
		private var snakeParts:Array = new Array();
		private var snakeMoveX:Number = 1;
		private var snakeMoveY:Number = 0;
		private var snakeRotation:Number = 90;
		private var nextMoveX:Number = 1;
		private var nextMoveY:Number = 0;
		private var nextRotation:Number = 90;
		
		//== main class function ==
		public function Snake()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_wall['left'] = 15;
			_wall['right'] = 15 + _areaSize;
			_wall['up'] = 15;
			_wall['down'] = 15 + _areaSize;
			
			//== create first part of the snake ==
			var firstSnakePart:SnakePart = new SnakePart();
			firstSnakePart.x = _snakeStartPoint.x;
			firstSnakePart.y = _snakeStartPoint.y;
			snakeParts.push(firstSnakePart);
			addChild(firstSnakePart);
			
			//== create book en set to random position ==
			addChild(book);
			placeBook();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownFunction);
			_gameTimer = new Timer(_timerStartSpeed);
			_gameTimer.addEventListener(TimerEvent.TIMER, moveSnake);
			_gameTimer.start();
			
		}
		
		public function moveSnake(te:TimerEvent):void
		{
			snakeMoveX = nextMoveX;
			snakeMoveY = nextMoveY;
			snakeRotation = nextRotation;
			
			var nX:Number = snakeParts[0].x + snakeMoveX * _gridSize;
			var nY:Number = snakeParts[0].y + snakeMoveY * _gridSize;
			var nR:Number = 90;
			
			if((nX == book.x) && (nY == book.y))
			{
				placeBook();
				
				if (snakeParts.length-1 >= 5)
				{
					_spawnRate = 2;	
				}
				
				newSnakePart();
				
				if (_gameTimer.delay > 44)
				{
					_gameTimer.delay -= 2;
				}
				
				//== score wordt hier opgetelt
			}
			
			placeTail();
			
			snakeParts[0].x = nX;
			snakeParts[0].y = nY;
			snakeParts[0].rotation = snakeRotation;
		}
		
		public function keyDownFunction(ke:KeyboardEvent):void
		{
			if(ke.keyCode == 37) //== links
			{
				if (snakeMoveX != 1)
				{
					nextMoveX = -1;
					nextMoveY = 0;
					nextRotation = -90;
				}
			} 
			else if(ke.keyCode == 39) //== rechts
			{
				if (snakeMoveX != -1)
				{
					nextMoveX = 1;
					nextMoveY = 0;
					nextRotation = 90;
				}
			}
			else if(ke.keyCode == 38) //== omhoog
			{
				if (snakeMoveY != 1)
				{	
					nextMoveX = 0;
					nextMoveY = -1;
					nextRotation = 0;
				}
			}
			else if(ke.keyCode == 40) //== omlaag
			{
				if (snakeMoveY != -1)
				{
					nextMoveX = 0;
					nextMoveY = 1;
					nextRotation = 180;
				}
			}
		}
		
		public function newSnakePart():void
		{
			for (var i:int=0;i<_spawnRate;i++)
			{
				var newPart:SnakePart = new SnakePart();
				addChild(newPart);
				snakeParts.push(newPart);
			}
		}
		
		public function placeTail():void
		{
			for (var i:int = snakeParts.length-1;i>0;i--)
			{
				snakeParts[i].x = snakeParts[i-1].x;
				snakeParts[i].y = snakeParts[i-1].y;
				snakeParts[i].rotation = snakeParts[i-1].rotation;
			}
		}
		
		public function placeBook():void
		{
			var nX:int = Math.floor(Math.random() * (_wall['right'] - _wall['left']) / _gridSize) * _gridSize + _gridSize;
			var nY:int = Math.floor(Math.random() * (_wall['down'] - _wall['up']) / _gridSize) * _gridSize + _gridSize;
			
			book.x = nX;
			book.y = nY;
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