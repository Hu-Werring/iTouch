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
			
			stage.align = "TL";
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			//VirtualKeyBoard.getInstance().init(this);
			
			//addChild(new Interface());
			addChild(gh);
			//*
			var tmp:Sprite = new Sprite();
			tmp.graphics.beginFill(0xFF0000);
			tmp.graphics.drawCircle(30,30,25);
			tmp.graphics.endFill();
			tmp = new iButton(tmp);
			addChild(tmp);
			tmp.addEventListener(MouseEvent.CLICK,startMaze);
			var tmp2:Sprite = new Sprite();
			tmp2.graphics.beginFill(0xFF0000);
			tmp2.graphics.drawCircle(85,30,25);
			tmp2.graphics.endFill();
			tmp2 = new iButton(tmp2);
			addChild(tmp2);
			tmp2.addEventListener(MouseEvent.CLICK,startSnake);
			/* */
		}
		public function hideGame(e:MouseEvent):void
		{
			gh.hide();
			gh.addGame(games[Math.floor(Math.random()*games.length)]);
			gh.show();
		}
		
		public function startSnake(e:Event):void
		{
			if(gh.hasEventListener(GameHolder.GAME_INVISIBLE))	{
				gh.removeEventListener(GameHolder.GAME_INVISIBLE,startSnake);
				gh.removeEventListener(GameHolder.GAME_INVISIBLE,startMaze);
			}
			switch(gh.status)
			{
				case GameHolder.ONSTAGE:
				case GameHolder.GAME_INVISIBLE:
					gh.addGame(Snake);
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
		
		public function startMaze(e:Event):void
		{
			if(gh.hasEventListener(GameHolder.GAME_INVISIBLE))	{
				gh.removeEventListener(GameHolder.GAME_INVISIBLE,startSnake);
				gh.removeEventListener(GameHolder.GAME_INVISIBLE,startMaze);
			}
			switch(gh.status)
			{
				case GameHolder.ONSTAGE:
				case GameHolder.GAME_INVISIBLE:
					gh.addGame(Maze);
					gh.show();
					break;
				case GameHolder.GAME_VISIBLE:
						gh.hide();
						gh.addEventListener(GameHolder.GAME_INVISIBLE,startMaze);
					break;
				case GameHolder.CREATED:
					throw(new Error('First add GameHolder to stage before adding a game!'));
			}
		}
	}
}