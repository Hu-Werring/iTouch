package nl.iTouch.maze
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.*;
	
	public class Grid extends MovieClip
	{
		public var gridWidth:int;
		public var gridHeight:int;
		
		public var cols:int;
		public var colWidth:int;
		public var colHeight:int;
		
		public var rows:int;
		public var rowWidth:int;
		public var rowHeight:int;
		
		public var tiles:int;
		public var tilesObj:Array;
		public var tileWidth:int;
		public var tileHeight:int;
		
		public var curRow:int = -1;
		public var curCol:int;
		
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
		
		public function colorTile(tile:Number, color):void
		{
			this.tilesObj[tile].graphics.beginFill(color);
			this.tilesObj[tile].graphics.drawRect(0,0,this.tilesObj[tile].width,this.tilesObj[tile].height);
			this.tilesObj[tile].graphics.endFill();
		}
		
		public function returnTile(tile:int):MovieClip
		{
			return this.tilesObj[tile];
		}
		
		public function setTileByCord(col:int, row:int):void
		{
			
		}
		
		public function setColom(col:int, content:*):void
		{
			if(col/this.cols <= 1)
			{
				var startTile:int = col-1;
				var endTile:int = startTile + (this.rows*this.cols);
				var tmpSP = new Sprite();

				this.colorTile(startTile,0x00FF00);
				/*for(var i:int=startTile; i < endTile;i++)
				{
					//
				}*/
			}
		}
		
		public function setColomColor(col:int, color):void
		{
			if(col/this.cols <= 1)
			{
				var startTile:int = col-1;
				var endTile:int = (this.rows*this.cols) - (this.cols - startTile);
				for(var i:int=startTile;i<=endTile;i+=this.cols)
				{
					this.colorTile(i, color);
				}
			}
		}
		
		public function setRowColor(row:int, color):void
		{
			if(row/this.rows <= 1)
			{
				var startTile:int = (row-1)*this.cols;
				var endTile:int = startTile + cols;
				for(var i:int=startTile;i<endTile;i++)
				{
					this.colorTile(i, color);
				}
			}
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