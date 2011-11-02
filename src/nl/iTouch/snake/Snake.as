package nl.iTouch.snake
{
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.ShaderFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import flashx.textLayout.formats.TextAlign;
	
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
		private const _timerStartSpeed:int = 250; //== begin snelheid van de gametimer
		
		//game variables ==
		private var _wall:Array = new Array();
		private var _boekenkasten:Array = new Array();
		private var _tafelsV:Array = new Array();
		private var _tafelsH:Array = new Array();
		private var _gameTimer:Timer;
		private var _counter:uint;
		private var _counterLenght:uint = 200;
		private var _studentTimer:Timer;
		private var _spawnRate:int = 1;
		private var _deelX:Array = new Array();
		private var _deelY:Array = new Array();
		private var _score:uint;
		private var _hints:Array = new Array();
		
		//== objecten ==
		private var gameArea:PlayAreaGraphic = new PlayAreaGraphic();
		private var student:Student = new Student();
		private var splashScreen:GameOverScreen = new GameOverScreen();
		private var timerBar:TimerBar = new TimerBar();
		private var scoreField:TextField = new TextField();
		private var hintField:TextField = new TextField();
		
		//== effecten variables ==

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
		private var hs:Highscore = new Highscore('Snake');
		
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
			
			_hints.push("Lucas is een boek aan het zoeken in de afdeling Studio"); //== blauw boven ==
			_hints.push("Lucas zoekt een boek in de afdeling Platform"); //== zilver boven ==
			_hints.push("Lucas is een boek aan het zoeken in de afdeling De Plaats"); //== oranje boven ==
			_hints.push("Lucas zoekt een boek in de afdeling het Lab"); //== rood boven ==
			
			_hints.push("Lucas is aan het werk bij de computers van Studio"); //== blauw onder ==
			_hints.push("Lucas is aan het werk aan de tafels van de afdeling Platform"); //== zilver onder ==
			_hints.push("Lucas is aan het werk bij de computers van De Plaats"); //== oranje onder ==
			_hints.push("Lucas is aan het werk bij de computers van Het Lab"); //== rood onder ==
			
			_hints.push("Lucas is op een andere student aan het wachten op het gang pad"); //== gangpad ==
			
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
			
			//== create background ==
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
			
			//== create tafels ==
			for(var j:int = 0;j<2;j++)
			{
				for(var k:int = 0;k<2;k++)
				{
					var tafelV:TafelVertical = new TafelVertical();
					tafelV.x = 105 + ((j*225)*2);
					tafelV.y = 585 + (k*195);
					addChild(tafelV);
					_tafelsV.push(tafelV);
				}
			}
			
			for(var l:int = 0;l<2;l++)
			{
				for(var m:int = 0;m<3;m++)
				{
					var tafelH:TafelHorizontal = new TafelHorizontal();
					tafelH.x = 300 + ((l*225)*2);
					tafelH.y = 570 + (m*135);
					addChild(tafelH);
					_tafelsH.push(tafelH);
				}
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
			
			//== create timer bar ==
			_counter = _counterLenght;
			timerBar.x = 975;
			timerBar.y = 300;
			addChild(timerBar);
			
			//== create scorefield ==
			var txtFrmtScore:TextFormat = new TextFormat("Avenir", 40,null,true);
			txtFrmtScore.align = TextAlign.RIGHT;
			
			scoreField.x = 975;
			scoreField.y = 60;
			scoreField.width = 270;
			scoreField.height = 90;
			scoreField.border = true;
			scoreField.defaultTextFormat = txtFrmtScore;
			scoreField.backgroundColor = 0xffffff;
			scoreField.text = String(_score);
			addChild(scoreField);
			
			hintField.x = 975;
			hintField.y = 350;
			hintField.width = 270;
			hintField.height = 135;
			hintField.border = true;
			hintField.wordWrap = true;
			var txtFrmtHint:TextFormat = new TextFormat("Avenir", 20,null,true);
			txtFrmtHint.align = TextAlign.JUSTIFY;
			hintField.defaultTextFormat = txtFrmtHint;
			
			hintField.backgroundColor = 0xffffff;
			//hintField.text = String(_score);
			addChild(hintField);
			
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownFunction);
			_gameTimer = new Timer(_timerStartSpeed);
			_gameTimer.addEventListener(TimerEvent.TIMER, moveSnake);
			
			//== student timer ==
			_studentTimer = new Timer(100);
			_studentTimer.addEventListener(TimerEvent.TIMER, pickUpCounter);
			
			//== test ==
			splashScreen.splash.addEventListener(MouseEvent.CLICK, splashScreenTouch);
			addChild(splashScreen);
		}
		
		public function moveSnake(te:TimerEvent):void
		{
			snakeMoveX = nextMoveX;
			snakeMoveY = nextMoveY;
			snakeRotation = nextRotation;
			
			var nX:int = snakeParts[0].x + snakeMoveX * _gridSize;
			var nY:int = snakeParts[0].y + snakeMoveY * _gridSize;
			var nR:int = 90;
			var collisionCheck:Boolean = false;
			//== collision check  met wall ==
			if (nX > (_wall['right'] + 15))
			{
				collisionCheck = true;
				//nX -= 15;
				gameOver();
			}
			else if (nX < _wall['left'])
			{
				collisionCheck = true;
				//nX += 15;
				gameOver();
			}
			else if (nY > _wall['down'] + 15)
			{
				collisionCheck = true;
				//nY -= 15;
				gameOver();
			}
			else if (nY < _wall['up'])
			{
				collisionCheck = true;
				//nY += 15;
				gameOver();
			}
			else if(hitTail(nX,nY))
			{
				collisionCheck = true;
				gameOver();
			}
			else if (hitBoekenKast(nX,nY))
			{
				collisionCheck = true;
				gameOver();
			}
			else if (hitTafel(nX,nY))
			{
				collisionCheck = true;
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
				
				if(_counterLenght >= 100)
				{
					_counterLenght -= 2;
				}
				
				//== score wordt hier opgetelt
				_score += ((snakeParts.length-1) * ((_counter/10)/4))*5;
				scoreField.text = String(int(_score));
				trace(_score);
			}
			
			placeTail();
			
			if(collisionCheck != true)
			{
				snakeParts[0].x = nX;
				snakeParts[0].y = nY;
				snakeParts[0].rotation = snakeRotation;
				if(snakeParts[1] != undefined) snakeParts[1].rotation = snakeRotation;
			}
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
				if(_gameTimer.running == false)
				{
					removeChild(splashScreen);
				}
				
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
			_counter = _counterLenght;;
			
			var nX:int = Math.floor(Math.random() * (_wall['right'] - _wall['left']) / _gridSize) * _gridSize + _wall['left'];
			var nY:int = Math.floor(Math.random() * (_wall['down'] - _wall['up']) / _gridSize) * _gridSize + _wall['up'];
			var nR:int = Math.random()*3;
			
			var kast:BoekenKast;
			var tafelH:TafelHorizontal;
			var tafelV:TafelVertical;
			
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
					//trace ("nx",nX, 'kast',kast.kastParts[k].x+kast.x,'ny',nY,'kast',kast.kastParts[k].y+kast.y);
					
				}
				if(error) break;
			}
			
			for(var l:uint=0;l<_tafelsV.length;l++)
			{ 
				
				tafelV = _tafelsV[l] as TafelVertical;
				for (var m:int =0; m<tafelV.tafelParts.length; m++){
					//trace("kast =",j,"| x",kast.kastParts[k].x+kast.x,"| y",kast.kastParts[k].y+kast.y);
					if ((nX == tafelV.tafelParts[m].x+tafelV.x) && (nY == tafelV.tafelParts[m].y+tafelV.y))
					{
						error  = true;
						
						placeStudent();
						break;
					}
					//trace ("nx",nX, 'kast',kast.kastParts[k].x+kast.x,'ny',nY,'kast',kast.kastParts[k].y+kast.y);
					
				}
				if(error) break;
			}
			
			for(var n:uint=0;n<_tafelsH.length;n++)
			{ 
				
				tafelH = _tafelsH[n] as TafelHorizontal;
				for (var p:int =0; p<tafelH.tafelParts.length; p++){
					//trace("kast =",j,"| x",kast.kastParts[k].x+kast.x,"| y",kast.kastParts[k].y+kast.y);
					if ((nX == tafelH.tafelParts[p].x+tafelH.x) && (nY == tafelH.tafelParts[p].y+tafelH.y))
					{
						error  = true;
								
						placeStudent();
						break;
					}
					//trace ("nx",nX, 'tafelH',tafelH.tafelParts[p].x+tafelH.x,'ny',nY,'tafelH',tafelH.tafelParts[p].y+tafelH.y);
					
				}
				if(error) break;
			}
			
			if(!error)
			{
				student.x = nX;
				student.y = nY;
				student.rotation = 90 * nR;
				
				if ((student.y > _deelY[0]) && (student.y < _deelY[1]))
				{
					if ((student.x > _deelX[0]) && (student.x < _deelX[1]))
					{
						hintField.text = _hints[0];
					}
					else if ((student.x > _deelX[1]) && (student.x < _deelX[2]))
					{
						hintField.text = _hints[1];
					}
					else if ((student.x > _deelX[2]) && (student.x < _deelX[3]))
					{
						hintField.text = _hints[2];
					}
					else if ((student.x > _deelX[3]) && (student.x < _deelX[4]))
					{
						hintField.text = _hints[3];
					}
				}
				else if ((student.y > _deelY[1]) && (student.y < _deelY[2]))
				{
					hintField.text = _hints[8];
				}
				else if ((student.y > _deelY[2]) && (student.y < _deelY[3]))
				{
					if ((student.x > _deelX[0]) && (student.x < _deelX[1]))
					{
						hintField.text = _hints[4];
					}
					else if ((student.x > _deelX[1]) && (student.x < _deelX[2]))
					{
						hintField.text = _hints[5];
					}
					else if ((student.x > _deelX[2]) && (student.x < _deelX[3]))
					{
						hintField.text = _hints[6];
					}
					else if ((student.x > _deelX[3]) && (student.x < _deelX[4]))
					{
						hintField.text = _hints[7];
					}
				}
			}
		}
		
		public function gameOver():void
		{
			splashScreen = new GameOverScreen();
			splashScreen.splash.addEventListener(MouseEvent.CLICK, splashScreenTouch);
			addChild(splashScreen);
			
			
			var submit:Sprite = hs.submitHS(_score);
			submit.x = (stage.stageWidth-submit.width)/2;
			submit.y = (stage.stageHeight-submit.height)/2;
			addChild(submit);
			
			_studentTimer.stop();
			_gameTimer.stop();
		}
		
		public function play():void
		{
			if (!_gameTimer.running)
			{
				resetSnake();
				_studentTimer.start();
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
			
			_score = 0;
			
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
		
		public function splashScreenTouch(me:MouseEvent):void
		{
			if(_gameTimer.running == false)
			{
				splashScreen.deleteMe();
			}
		}
		
		public function hitTail(nX:int,nY:int):Boolean
		{
			for(var i:int=1;i<snakeParts.length;i++) {
				if ((nX == snakeParts[i].x) && (nY == snakeParts[i].y)) {
					return true;
				}
			}
			return false;
		}
		
		public function hitBoekenKast(nX:int,nY:int):Boolean
		{
			var kast:BoekenKast;
			for(var j:uint=0;j<_boekenkasten.length;j++)
			{ 
				
				kast = _boekenkasten[j] as BoekenKast;
				for (var k:int =0; k<kast.kastParts.length; k++){
					//trace("kast =",j,"| x",kast.kastParts[k].x+kast.x,"| y",kast.kastParts[k].y+kast.y);
					if ((nX == (kast.kastParts[k].x+kast.x)) && (nY == (kast.kastParts[k].y+kast.y)))
					{
						return true;
					}
				}
			}
			
			return false;
		}
		
		public function hitTafel(nX:int,nY:int):Boolean
		{
			var tafelV:TafelVertical;
			for(var j:uint=0;j<_tafelsV.length;j++)
			{ 
				tafelV = _tafelsV[j] as TafelVertical;
				for (var k:int =0; k<tafelV.tafelParts.length; k++){
					//trace("kast =",j,"| x",kast.kastParts[k].x+kast.x,"| y",kast.kastParts[k].y+kast.y);
					if ((nX == (tafelV.tafelParts[k].x+tafelV.x)) && (nY == (tafelV.tafelParts[k].y+tafelV.y)))
					{
						return true;
					}
				}
			}
			
			var tafelH:TafelHorizontal;
			for(var l:uint=0;l<_tafelsH.length;l++)
			{ 
				tafelH = _tafelsH[l] as TafelHorizontal;
				for (var m:int = 0 ; m < tafelH.tafelParts.length; m++){
					//trace("kast =",j,"| x",kast.kastParts[k].x+kast.x,"| y",kast.kastParts[k].y+kast.y);
					if ((nX == (tafelH.tafelParts[m].x+tafelH.x)) && (nY == (tafelH.tafelParts[m].y+tafelH.y)))
					{
						return true;
					}
				}
			}
			
			return false;
		}
		
		public function pickUpCounter(te:TimerEvent):void
		{
			_counter--;
			
			if(_counter == 0)
			{
				placeStudent();
			}
			
			timerBar.scaleX = _counter/_counterLenght;
		}
	}
}
