package
{
	
	import flash.display.*;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	import flashx.textLayout.elements.InlineGraphicElement;
	
	import nid.ui.controls.VirtualKeyBoard;
	
	import nl.iTouch.*;
	import nl.iTouch.eyecatcher.Eyecatcher;
	import nl.iTouch.guessgame.GuessGame;
	import nl.iTouch.maze.Maze;
	import nl.iTouch.snake.Snake;
	import nl.iTouch.ui.Button1;
	import nl.iTouch.ui.Button2;
	import nl.iTouch.ui.Button3;
	import nl.iTouch.ui.Interface;
	
	
	
	[SWF(frameRate='24',backgroundColor='0xffffff', width="1280", height="1024")]
	public class iTouch extends Sprite
	{
		
		private var gh:GameHolder = new GameHolder();
		
		private var games:Array = [Snake, Maze];
		
		private var _lastClick:int =0;
		
		private var eyeCatcher:Eyecatcher = new Eyecatcher();
		
		public function iTouch(){
			
			//Mouse.hide();
			stage.displayState = StageDisplayState.FULL_SCREEN;
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			VirtualKeyBoard.getInstance().init(this);
			
			var gui:Interface = new Interface();
			
			

			
			
			addChild(gui);
			addChild(gh);
			addChild(eyeCatcher);
			var test:Credits = new Credits();
			//addChild(test);			
			
		
			
			gui.addEventListener(Interface.START_SNAKE,startSnake);
			gui.addEventListener(Interface.START_MAZE,startMaze);
			gui.addEventListener(Interface.START_GUESS,startGuess);
			gui.addEventListener(Interface.START_CREDITS,startCredits);

			
			gh.addEventListener(MouseEvent.CLICK,clickUpdate);
			eyeCatcher.addEventListener('CLICKED_EYECATCHER',clickUpdate);
			
			eyeCatcher.addEventListener('CLICKED_EYECATCHER',killTheEye);
			gui.addEventListener(MouseEvent.CLICK,clickUpdate);
			
			var timer:Timer = new Timer(30000);
			timer.addEventListener(TimerEvent.TIMER,tick);
			timer.start();
		}
		
		private function killTheEye(e:Event):void
		{
			eyeCatcher.hide();
		}
		
		private function tick(e:TimerEvent):void
		{
			var currentTime:int = new Date().getTime()/1000;
			if(currentTime - _lastClick > 30){
				eyeCatcher.show();
			}
		}
		
		public function startGame(game:Class):void
		{
			if(gh.hasEventListener(GameHolder.GAME_INVISIBLE))	{
				gh.removeEventListener(GameHolder.GAME_INVISIBLE,startSnake);
				gh.removeEventListener(GameHolder.GAME_INVISIBLE,startMaze);
				gh.removeEventListener(GameHolder.GAME_INVISIBLE,startGuess);
			}
			switch(gh.status)
			{
				case GameHolder.ONSTAGE:
				case GameHolder.GAME_INVISIBLE:
					gh.addGame(game);
					gh.show();
					break;
				case GameHolder.GAME_VISIBLE:
					gh.hide();
					gh.addEventListener(GameHolder.GAME_INVISIBLE,startSnake);
					break;
				case GameHolder.CREATED:
					throw(new Error('First add GameHolder to stage before adding a game!'));
			}				
		}
		
		private function clickUpdate(e:Event):void
		{
			_lastClick = new Date().getTime()/1000;
		}
		public function startSnake(e:Event):void
		{
			startGame(Snake);
		}
		
		public function startMaze(e:Event):void
		{
			startGame(Maze);
		}
		public function startGuess(e:Event):void
		{
			startGame(GuessGame);
		}
		public function startCredits(e:Event):void
		{
			startGame(Credits);
		}
	}
}
