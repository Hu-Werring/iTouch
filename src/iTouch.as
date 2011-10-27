package
{
	import flash.display.Sprite;
	import nl.iTouch.maze.Maze;
	import nl.iTouch.snake.Snake;
	
	//[SWF(frameRate='24',backgroundColor='0xffffff', width="1280", height="1024")]
	[SWF(frameRate='24',backgroundColor='0xffffff', width="1120", height="800")]
	public class iTouch extends Sprite
	{
		public function iTouch()
		{
			var MazeGame:Maze = new Maze(1120, 800);
			//MazeGame.width = 1120;
			//MazeGame.height = 800;
			addChild(MazeGame);
			//addChild(new Maze(stage.stageWidth, stage.stageHeight));
		}
	}
}
