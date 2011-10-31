package nl.iTouch.snake
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import nl.iTouch.DataBase;
	import nl.iTouch.Game;
	import nl.iTouch.Highscore;
	import nl.iTouch.iButton;
	
	public class Snake extends Sprite implements Game
	{
		//== constante waardes ==
		private const _gridSize:uint = 15;
		private const _areaSize:uint = 885; //== moet deelbaar zijn door gridSize ==
		private const _snakeStartPoint:Point = new Point(465,510);//== beide punten moeten deelbaar zijn door gridSize (of 0)
		private const _timerStartSpeed:int = 200; //== begin snelheid van de gametimer
		
		//game variables ==
		private var _wall:Array = new Array();
		private var _boekenkasten:Array = new Array();
		private var _gameTimer:Timer;
		private var _spawnRate:int = 1;
		private var _deelX:Array = new Array();
		private var _deelY:Array = new Array();
		
		//== objecten ==
		private var gameArea:PlayAreaGraphic = new PlayAreaGraphic();
		private var student:Student = new Student();
		private var gOscreen:GameOverScreen = new GameOverScreen();

		//== snake variables ==
		private var snakeParts:Array = new Array();
		private var snakeMoveX:int = 1;
		private var snakeMoveY:int = 0;
		private var snakeRotation:int = 90;
		private var nextMoveX:int = 1;
		private var nextMoveY:int = 0;
		private var nextRotation:int = 90;
		
		//== highscore + DB varables/objecten ==
		private var db:DataBase = DataBase.getInstance;
		private var hs:Highscore;
		
		//== main class function ==
		public function Snake()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			/*hs = new Highscore('snake');
			hs.highScoreList()
				
			var list:Sprite = hs.highScoreList();
			addChild(list);*/
			
			_deelX.push(2 * _gridSize - (_gridSize/2));
			_deelX.push(17 * _gridSize - (_gridSize/2));
			_deelX.push(32 * _gridSize - (_gridSize/2));
			_deelX.push(47 * _gridSize - (_gridSize/2));
			_deelX.push(63 * _gridSize - (_gridSize/2));
			
			_deelY.push(4 * _gridSize - (_gridSize/2));
			_deelY.push(32 * _gridSize - (_gridSize/2));
			_deelY.push(37 * _gridSize - (_gridSize/2));
			_deelY.push(63 * _gridSize - (_gridSize/2));
			
			_wall['left'] = 30; //== moet deelbaar zijn door _gridsize
			_wall['right'] = 30 + _areaSize; //== moet deelbaar zijn door _gridsize
			_wall['up'] = 60; //== moet deelbaar zijn door _gridsize
			_wall['down'] = 60 + _areaSize; //== moet deelbaar zijn door _gridsize
			
			//== create buttons ==
			var btnUp:ButtonArrow = new ButtonArrow();
			btnUp.x = 1115;
			btnUp.y = 740;
			btnUp.rotation = 0;
			btnUp.addEventListener(MouseEvent.CLICK,buttonUp);
			addChild(new iButton(btnUp));
			
			var btnDown:ButtonArrow = new ButtonArrow();
			btnDown.x = 1115;
			btnDown.y = 930;
			btnDown.rotation = 180;
			btnDown.addEventListener(MouseEvent.CLICK,buttonDown);
			addChild(new iButton(btnDown));
			
			var btnLeft:ButtonArrow = new ButtonArrow();
			btnLeft.x = 1020;
			btnLeft.y = 835;
			btnLeft.rotation = -90;
			btnLeft.addEventListener(MouseEvent.CLICK,buttonLeft);
			addChild(new iButton(btnLeft));
			
			var btnRight:ButtonArrow = new ButtonArrow();
			btnRight.x = 1210;
			btnRight.y = 835;
			btnRight.rotation = 90;
			btnRight.addEventListener(MouseEvent.CLICK,buttonRight);
			addChild(new iButton(btnRight));
			
			//== create grid raster ==
			var background:SnakeBackground = new SnakeBackground();
			addChild(background);
			
			//== Create boeken kasten ==
			for(var i:int = 1;i <= 3; i++)
			{
				var bk:BoekenKast = new BoekenKast();
				bk.x = i*210+((i-1)*15);
				bk.y = 120;
				addChild(bk);
				_boekenkasten.push(bk);
			}
			
			//== create gamearea sprite ==
			gameArea.x = _wall['left'] - (_gridSize/2);
			gameArea.y = _wall['up'] - (_gridSize/2);
			addChild(gameArea);
			
			//== create first part of the snake ==
			var firstSnakePart:SnakePart = new SnakePart();
			firstSnakePart.x = _snakeStartPoint.x;
			firstSnakePart.y = _snakeStartPoint.y;
			snakeParts.push(firstSnakePart);
			addChild(firstSnakePart);
			
			//== create book en set to random position ==
			addChild(student);
			student.visible = false;
			placeStudent();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownFunction);
			_gameTimer = new Timer(_timerStartSpeed);
			_gameTimer.addEventListener(TimerEvent.TIMER, moveSnake);
			
			//== test ==
			gOscreen.x = 22.5;
			gOscreen.y = 52.5;
			addChild(gOscreen);
		}
		
		public function moveSnake(te:TimerEvent):void
		{
			snakeMoveX = nextMoveX;
			snakeMoveY = nextMoveY;
			snakeRotation = nextRotation;
			
			var nX:Number = snakeParts[0].x + snakeMoveX * _gridSize;
			var nY:Number = snakeParts[0].y + snakeMoveY * _gridSize;
			var nR:Number = 90;
			
			//== collision check  met wall ==
			if (nX > _wall['right'] + 15)
			{
				nX -= 15;
				gameOver();
			}
			else if (nX < _wall['left'])
			{
				nX += 15;
				gameOver();
			}
			else if (nY > _wall['down'] + 15)
			{
				nY -= 15;
				gameOver();
			}
			else if (nY < _wall['up'])
			{
				nY += 15;
				gameOver();
			}
			
			//== collision check met student ==
			if((nX == student.x) && (nY == student.y))
			{
				placeStudent();
				
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
				//== TODO ==
			}
			
			placeTail();
			
			//trace(snakeParts[0].x,snakeParts[0].y);
			snakeParts[0].x = nX;
			snakeParts[0].y = nY;
			snakeParts[0].rotation = snakeRotation;
			if(snakeParts[1] != undefined) snakeParts[1].rotation = snakeRotation;
			
			//== check if snake is in same area as student ==
			if (checkPlaceY() >= 1)
			{
				if (checkPlaceX())
				{
					//student.alpha = 1;
					student.visible = true;
				}
				else
				{
					//student.alpha = 0.5;
					student.visible = false;
				}
			}
			else if(checkPlaceY() == 2)
			{
				student.visible = true;
			}
			else
			{
				//student.alpha = 0.5;
				student.visible = false;
			}
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
			else if(ke.keyCode == 32) //== spatie
			{
				removeChild(gOscreen);
				play();
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
		
		public function placeStudent():void
		{
			var nX:int = Math.floor(Math.random() * (_wall['right'] - _wall['left']) / _gridSize) * _gridSize + _wall['left'];
			var nY:int = Math.floor(Math.random() * (_wall['down'] - _wall['up']) / _gridSize) * _gridSize + _wall['up'];
			var nR:int = Math.random()*3;
			
			var kast:BoekenKast
			var error:Boolean = false;
			for(var j:uint=0;j<_boekenkasten.length;j++)
			{ 
				
				kast = _boekenkasten[j] as BoekenKast;
				for (var k:int =0; k<kast.kastParts.length; k++){
					//trace("kast =",j,"| x",kast.kastParts[k].x+kast.x,"| y",kast.kastParts[k].y+kast.y);
					if ((nX == kast.kastParts[k].x+kast.x) && (nY == kast.kastParts[k].y+kast.y))
					{
						error  = true;
						/*nX = Math.floor(Math.random() * (_wall['right'] - _wall['left']) / _gridSize) * _gridSize + _wall['left'];
						nY = Math.floor(Math.random() * (_wall['down'] - _wall['up']) / _gridSize) * _gridSize + _wall['up'];
						nR = Math.random()*3;
						*/
						
						
						placeStudent();
						break;
					}
					trace ("nx",nX, 'kast',kast.kastParts[k].x+kast.x,'ny',nY,'kast',kast.kastParts[k].y+kast.y);
					
				}
				if(error) break;
			}
			
			if(!error)
			{
			student.x = nX;
			student.y = nY;
			student.rotation = 90 * nR;
			}
		}
		
		public function gameOver():void
		{
			
			_gameTimer.stop();
		}
		
		public function play():void
		{
			if (!_gameTimer.running)
			{
				resetSnake();
				_gameTimer.start();
			}
		}
		
		public function stop(force:Boolean = false):void
		{
			_gameTimer.stop();
		}
		
		public function credits():void
		{
			
		}
		
		public function highscore():void
		{
			
		}
		
		public function resetSnake():void
		{
			snakeParts[0].x = _snakeStartPoint.x;
			snakeParts[0].y = _snakeStartPoint.y;
			
			nextMoveX = 1;
			nextMoveY = 0;
			nextRotation = 90;
			
			placeStudent();
			
			while(snakeParts.length>1)
			{
				removeChild(snakeParts.pop());
			}
		}
		
		public function checkPlaceX():Boolean
		{
			var check:Boolean;
			
			if ((snakeParts[0].x > _deelX[0]) && (snakeParts[0].x < _deelX[1]) && (student.x > _deelX[0]) && (student.x < _deelX[1]))
			{
				check = true;
			}
			else if ((snakeParts[0].x > _deelX[1]) && (snakeParts[0].x < _deelX[2]) && (student.x > _deelX[1]) && (student.x < _deelX[2]))
			{
				check = true;
			}
			else if ((snakeParts[0].x > _deelX[2]) && (snakeParts[0].x < _deelX[3]) && (student.x > _deelX[2]) && (student.x < _deelX[3]))
			{
				check = true;
			}
			else if ((snakeParts[0].x > _deelX[3]) && (snakeParts[0].x < _deelX[4]) && (student.x > _deelX[3]) && (student.x < _deelX[4]))
			{
				check = true;
			}
			else
			{
				check = false;
			}
			
			return check;
		}
		
		public function checkPlaceY():uint
		{
			var check:uint;
			
			if ((snakeParts[0].y > _deelY[0]) && (snakeParts[0].y < _deelY[1]) && (student.y > _deelY[0]) && (student.y < _deelY[1]))
			{
				check = 1;
			}
			else if ((snakeParts[0].y > _deelY[1]) && (snakeParts[0].y < _deelY[2]) && (student.y > _deelY[1]) && (student.y < _deelY[2]))
			{
				check = 2;
			}
			else if ((snakeParts[0].y > _deelY[2]) && (snakeParts[0].y < _deelY[3]) && (student.y > _deelY[2]) && (student.y < _deelY[3]))
			{
				check = 1;
			}
			else
			{
				check = 0;
			}
			
			return check;
		}
		
		public function buttonUp(me:MouseEvent):void
		{
			if (snakeMoveY != 1)
			{	
				nextMoveX = 0;
				nextMoveY = -1;
				nextRotation = 0;
			}
		}
		
		public function buttonDown(me:MouseEvent):void
		{
			if (snakeMoveY != -1)
			{
				nextMoveX = 0;
				nextMoveY = 1;
				nextRotation = 180;
			}
		}
		
		public function buttonLeft(me:MouseEvent):void
		{
			if (snakeMoveX != 1)
			{
				nextMoveX = -1;
				nextMoveY = 0;
				nextRotation = -90;
			}
		}
		
		public function buttonRight(me:MouseEvent):void
		{
			if (snakeMoveX != -1)
			{
				nextMoveX = 1;
				nextMoveY = 0;
				nextRotation = 90;
			}
		}
	}
}
