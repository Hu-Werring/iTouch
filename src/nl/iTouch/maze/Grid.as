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
		
		private var curRow:int = -1;
		private var curCol:int;
		
		public function Grid(gWidth:int, gHeight:int, cols:int, rows:int)
		{
			this.gridWidth = gWidth;
			this.gridHeight = gHeight;
			//this.width = gWidth;
			//this.height = gHeight;
			
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
			
			/*
			var testmc:MovieClip = new MovieClip();
			
			testmc.graphics.beginFill(0xFF0000);
			testmc.graphics.drawRect(0,0,100,100);
			testmc.graphics.endFill();
			addChild(testmc);
			
			var testmc2:MovieClip = new MovieClip();
			testmc2.graphics.beginFill(0xFFFF00);
			testmc2.graphics.drawRect(testmc.width,testmc.height, testmc.width,testmc.height);
			testmc2.graphics.endFill();
			addChild(testmc2);
			*/
			
			this.tilesObj.forEach(createTile);
		}
		
		public function setTile(tile:Number, content:*):void
		{
			this.tilesObj[tile] = content;
		}
		
		public function returnTile(tile:int):MovieClip
		{
			return this.tilesObj[tile];
		}
		
		public function setTileByCord(col:int, row:int):void
		{
			
		}
		
		public function setColom(col:int, content)
		{
			
		}
		
		private function createTile(tile:*, index:uint, refArray:Array):void
		{
			var TileNr:int = index + 1;
			//var colIndex:int = ((index*10) / rows);
			var colIndex:int = (index % cols);
			//var rowIndex:int = (index % cols);
			
			if(colIndex == 0)
			{
				this.curRow++;
				
			}
			
			refArray[index] = new MovieClip();
			
			/*var rTile:MovieClip = this.returnTile(index);
			
			rTile.x = (tileWidth*colIndex);
			rTile.y = (tileHeight*this.curRow);
			rTile.width = tileWidth;
			rTile.height = tileHeight;
			
			rTile.graphics.beginFill(Math.random() * 0x00FF00);
			rTile.graphics.drawRect(rTile.x,rTile.y,tileWidth, tileHeight);
			rTile.graphics.endFill();
			this.setTile(index,rTile);
			
			//addChild(this.returnTile(index));*/
			
			
			refArray[index].graphics.beginFill(Math.random() * 0x00FF00);
			//refArray[index].graphics.drawRect((tileWidth*colIndex),(tileHeight*this.curRow),tileWidth, tileHeight);
			refArray[index].graphics.drawRect(0,0,tileWidth, tileHeight);
			refArray[index].graphics.endFill();
			refArray[index].width = tileWidth;
			refArray[index].height = tileHeight;
			refArray[index].x = (tileWidth*colIndex);
			refArray[index].y = (tileHeight*this.curRow);
			addChild(refArray[index]);
			
			//refArray[index].x = (tileWidth*colIndex);
			//refArray[index].y = (tileHeight*this.curRow);
			//refArray[index].width = tileWidth;
			//refArray[index].height = tileHeight;*/
			/*
			refArray[index].graphics.beginFill(Math.random() * 0x00FF00);
			//refArray[index].graphics.drawRect(0,0,tileWidth, tileHeight);
			refArray[index].graphics.drawRect((tileWidth*colIndex),(tileHeight*this.curRow),tileWidth, tileHeight);
			refArray[index].graphics.endFill();
			addChild(refArray[index]);*/
		}
	}
}