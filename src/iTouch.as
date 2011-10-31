package
{
	import com.fullsizeBackgroundImage.fullsizeBackgroundImage;
	
	import flash.display.*;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
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
		
		public function iTouch(){
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			VirtualKeyBoard.getInstance().init(this);
			
			var gui:Interface = new Interface();
			
		//	addChild(gui);
		//	addChild(gh);
			var test:Eyecatcher = new Eyecatcher();
			addChild(test);
			gui.addEventListener(Interface.START_SNAKE,startSnake);
			gui.addEventListener(Interface.START_MAZE,startMaze);
			gui.addEventListener(Interface.START_GUESS,startGuess);
			//*
			var hs:Highscore = new Highscore('TestGame');
			/*
			hs.submit("Qaz",0xFFFFFF*Math.random());
			hs.submit("Wsx",0xFFFFFF*Math.random());
			hs.submit("Edc",0xFFFFFF*Math.random());
			hs.submit("Rfv",0xFFFFFF*Math.random());
			hs.submit("Tgb",0xFFFFFF*Math.random());
			hs.submit("Yhn",0xFFFFFF*Math.random());
			hs.submit("Ujm",0xFFFFFF*Math.random());
			hs.submit("Ik,",0xFFFFFF*Math.random());
			hs.submit("Ol.",0xFFFFFF*Math.random());
			hs.submit("P;/",0xFFFFFF*Math.random());
			addChild(hs.highScoreList());
			/* */
			addChild(hs.submitHS(Math.random()*0xFFFFFF));
			/* */
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
	}
}