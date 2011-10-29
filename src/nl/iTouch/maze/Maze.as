package nl.iTouch.maze
{
	import flash.display.*;
	import flash.display.Stage;
	
	import nl.iTouch.*;
	
	public class Maze extends Sprite implements Game 
	{
		protected var lucas:Lucas;
		protected var grid:nl.iTouch.maze.Grid;
		protected var Control:nl.iTouch.maze.Controls;
		
		protected var _db:DataBase;
		
		public function Maze(mazeWidth:int, mazeHeight:int)
		{
			//this.width = mazeWidth;
			//this.height = mazeHeight;
			/*
			this.graphics.beginFill(0xFF0000);
			this.graphics.drawRect(0,0,100,100);
			this.graphics.endFill();
			*/
			//_db = DataBase.getInstance;
	
			this.x = 0;
			this.y = 0;
			this.grid = new Grid(mazeWidth, mazeHeight, 14, 10);
			this.grid.x = 0;
			this.grid.y = 0;
			trace(this.grid.x);
			trace(grid.tilesObj[0].x);
			trace(this.x);
			colorGrid(this.grid);
			addChild(this.grid);
			
			this.Control = new Controls();
			addChild(this.Control);
		}
		
		private function colorGrid(G:Grid):void
		{
			G.setColomColor(1, 0x886644);
			G.setColomColor(2, 0x2244FF);
			G.setColomColor(3, 0x2244FF);
			G.setColomColor(4, 0x2244FF);
			G.setColomColor(5, 0x886644);
			G.setColomColor(6, 0xDDDDDD);
			G.setColomColor(7, 0xDDDDDD);
			G.setColomColor(8, 0x886644);
			G.setColomColor(9, 0xFF9933);
			G.setColomColor(10, 0xFF9933);
			G.setColomColor(11, 0x886644);
			G.setColomColor(12, 0xFF0000);
			G.setColomColor(13, 0xFF0000);
			G.setColomColor(14, 0x886644);

			G.setRowColor(5, 0x555555);
			G.setRowColor(6, 0x555555);
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