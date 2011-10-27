package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.*
	
	import nl.iTouch.maze.Maze;
	import nl.iTouch.snake.Snake;
	
	import org.osmf.layout.ScaleMode;
	
	
	[SWF(frameRate='24',backgroundColor='0xffffff', width="1280", height="1024")]
	public class iTouch extends Sprite
	{
		public function iTouch()
		{	
			stage.align = StageAlign.TOP_LEFT;	
			//stage.displayState = StageDisplayState.FULL_SCREEN;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var mazeGame:Maze = new Maze(1120, 800);
			//MazeGame.width = 1120;
			//MazeGame.height = 800;
			addChild(mazeGame);
			//addChild(new Maze(stage.stageWidth, stage.stageHeight));
		}
	}
}
