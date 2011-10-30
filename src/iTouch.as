package
{
	import com.fullsizeBackgroundImage.fullsizeBackgroundImage;
	
	import flash.display.*;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.iTouch.*;
	import nl.iTouch.maze.Maze;
	import nl.iTouch.snake.Snake;
	import nl.iTouch.ui.Button1;
	import nl.iTouch.ui.Button2;
	import nl.iTouch.ui.Button3;
	
	
	
	
	[SWF(frameRate='24',backgroundColor='0xffffff', width="1280", height="1024")]
	public class iTouch extends Sprite
	{
		
		private var gh:GameHolder = new GameHolder();
		
		private var games:Array = [Snake, Maze];
		
		public function iTouch(){
			trace(stage)
			stage.align = "TL";
			stage.scaleMode = StageScaleMode.SHOW_ALL;

			

			addChild(gh);
			gh.addGame(games[Math.floor(Math.random()*games.length)]);
			gh.show();
			var tmp:Sprite = new Sprite();
			tmp.graphics.beginFill(0xFF0000);
			tmp.graphics.drawCircle(55,55,50);
			tmp.graphics.endFill();
			tmp = new iButton(tmp);
			addChild(tmp);
			tmp.addEventListener(MouseEvent.CLICK,hideGame);
		}
		public function hideGame(e:MouseEvent):void
		{
			gh.hide();
			gh.addGame(games[Math.floor(Math.random()*games.length)]);
			gh.show();
		}
	}
}