package nl.iTouch.maze
{
	import flash.display.*;
	import flash.display.Stage;
	
	import nl.iTouch.*;
	
	public class Maze extends Sprite implements Game 
	{
		protected var lucas;
		protected var grid:nl.iTouch.maze.Grid;
		
		protected var _db:DataBase;
		
		public function Maze(mazeWidth:int, mazeHeight:int)
		{
			//this.width = mazeWidth;
			//this.height = mazeHeight;
			
			//this.graphics.beginFill(0xFF0000);
			//this.graphics.drawRect(0,0,100,100);
			//this.graphics.endFill();
			
			//_db = DataBase.getInstance;
			this.grid = new Grid(mazeWidth, mazeHeight, 14, 10);
			//makeBookShelves(this.grid);
			this.grid.setColomColor(1, 0x886644);
			
			this.grid.setColomColor(2, 0x2244FF);
			this.grid.setColomColor(3, 0x2244FF);
			this.grid.setColomColor(4, 0x2244FF);
			
			this.grid.setColomColor(5, 0x886644);
			
			this.grid.setColomColor(6, 0xEEEEEE);
			this.grid.setColomColor(7, 0xEEEEEE);
			
			this.grid.setColomColor(8, 0x886644);

			this.grid.setColomColor(9, 0xFF9933);
			this.grid.setColomColor(10, 0xFF9933);
			
			this.grid.setColomColor(11, 0x886644);
			
			this.grid.setColomColor(12, 0xFF0000);
			this.grid.setColomColor(13, 0xFF0000);
			
			this.grid.setColomColor(14, 0x886644);

			this.grid.setRowColor(5, 0x555555);
			this.grid.setRowColor(6, 0x555555);
			addChild(this.grid);
		}
		
		private function makeBookShelves(G:Grid):void
		{
			var bookshelveArray:Array = new Array( 	  0,	  3,	  6,	  9,	 13,
				14,	 17, 	 20, 	 23,	 27,
				28,	 31,	 34, 	 37, 	 41,
				42,	 45,	 48, 	 51, 	 55,
				
				84,	 87,	 90, 	 93, 	 97,
				98,	101,	104,	107,	111,
				112,	115,	118,	121,	125,
				126,	129,	132,	135,	139);
			
			/*var bookshelveArray:Array = new Array( 	  1,	  4,	  7,	 10,	 14,
			15,	 18, 	 21, 	 24,	 28,
			29,	 32,	 35, 	 38, 	 42,
			43,	 46,	 49, 	 52, 	 56,
			
			85,	 88,	 91, 	 94, 	 98,
			99,	102,	105,	108,	112,
			113,	116,	119,	122,	126,
			127,	130,	133,	136,	139);*/
			
			bookshelveArray.forEach(setBookShelveTile);
			
		}
		
		private function setBookShelveTile(tileNr:int, index:uint, refArray:Array):void
		{
			this.grid.colorTile(tileNr,0x886644);
			
			/*
			var curTileNr:int = tileNr;
			var curTile:MovieClip = this.grid.returnTile(curTileNr);
			curTile.graphics.beginFill(0x886644);
			curTile.graphics.drawRect(0,0,curTile.width, curTile.height);
			curTile.graphics.endFill();
			
			//tile.graphics.beginFill(0x555555);
			//tile.graphics.drawRect(0,0, tile.width, tile.height);
			//tile.graphics.endFill();*/
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