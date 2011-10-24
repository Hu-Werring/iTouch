package nl.iTouch.maze
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.*;

	public class Grid extends MovieClip
	{
		public var gridWidth:int;
		public var gridHeight:int;
		
		protected var cols:int;
		protected var colWidth:int;
		protected var colHeight:int;
		
		protected var rows:int;
		protected var rowWidth:int;
		protected var rowHeight:int;
		
		protected var tiles:int;
		protected var tilesObj:Array;
		protected var tileWidth:int;
		protected var tileHeight:int;
		
		public function Grid(gWidth:int, gHeight:int, cols:int, rows:int)
		{
			this.gridWidth = gWidth;
			this.gridHeight = gHeight;
			
			this.cols = cols;
			this.colWidth = gWidth / cols;
			this.colHeight = gHeight;
			
			this.rows = rows;
			this.rowWidth = gWidth;
			this.rowHeight = gHeight / rows;
			
			this.tiles = cols * rows;
			this.tilesObj = new Array(this.tiles);
			this.tileWidth = this.colWidth;
			this.tileHeight = this.rowHeight;
			
			this.tilesObj.forEach(createTile);			
		}
		
		public function setTile(tile:Number):void
		{
			
		}
		
		public function setTileByCord(col:int, row:int):void
		{
			
		}
		
		private function createTile(tile:*, index:uint, refArray:Array):void
		{
						
		}
	}
}