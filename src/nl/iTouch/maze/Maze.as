package nl.iTouch.maze
{
	import flash.display.*;
	
	import nl.iTouch.*;
	
	public class Maze extends Sprite implements Game 
	{
		protected var lucas;
		protected var grid:nl.iTouch.maze.Grid;
		
		protected var _db:DataBase;
		
		public function Maze()
		{
			graphics.beginFill(0xFF0000);
			graphics.drawRect(0,0,100,100);
			graphics.endFill();
			//super();
			//_db = DataBase.getInstance;
			//this.grid = new Grid(500, 500, 10, 10);
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