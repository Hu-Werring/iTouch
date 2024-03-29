package nl.iTouch.maze
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.TextField;
	import flash.utils.*;
	
	public class Grid extends MovieClip
	{
		public var gridWidth:int;
		public var gridHeight:int;
		
	 	public var cols:int; //Het aantal kolomen
		public var colWidth:int; //Breedte van 1 kolom
		public var colHeight:int; //Hoogte van 1 kolom
		
		public var rows:int; //Het aantal rijen
		public var rowWidth:int; //De breedte van 1 rij
		public var rowHeight:int; //De hoogte van 1 rij
		
		public var tiles:int; //Het aantal tegels
		public var tilesObj:Array; //Het object dat alle tegels bevat. LET OP. tegel 1 = index 0, tegel2 = index 1, etc
		public var tileWidth:int; //De breedte van een tegel
		public var tileHeight:int; //De hoogte van een tegel
		public var clickedTile:Object; 
		
		public var curRow:int = -1; //Houd de rijen aan wanneer het grid word neer gelegd.
		public var curCol:int;//Houd de colommen aan wanneer het grid word neer gelegd
		
		public var powerStartTile:int;
		public var powerEndTile:int;
		
		//Main functie. Geef hier de breedte en hoogte mee die het grid moet hebben, en hoeveel kolommen en rijen het grid moet hebben. Dit wordt vanzelf uitgerekend
		public function Grid(gWidth:int, gHeight:int, cols:int, rows:int)
		{
			
			this.gridWidth = gWidth;
			this.gridHeight = gHeight;
			
			this.cols = cols;
			this.colWidth = gWidth / cols; //Bereken de kolombreedte
			this.colHeight = gHeight;
			
			this.rows = rows;
			this.rowWidth = gWidth;
			this.rowHeight = gHeight / rows; //Bereken de rij hoogte
			
			this.tiles = cols * rows; //Bereken het aantal tegels
			this.tilesObj = new Array(this.tiles); //Maak een array met het aantal tegels
			this.tileWidth = this.colWidth;
			this.tileHeight = this.rowHeight;
			this.tilesObj.forEach(createTile); //Maak een grafische tegel en plaats deze op de stage.
		}
		
		//Verander een tegel
		public function setTile(tile:Number, content:*):void
		{
			content.width = 80;
			content.height = 80;
			content.x = 0;
			content.y = 0;
			this.tilesObj[tile].addChild(content);
		}
		
		public function setTileAttr(tile:Number, name:String, value:*):void
		{
			this.tilesObj[tile-1][name] = value;
		}
		
		//Kleur een specifieke tegel. (tile = indexnr) of tewel tile0=index0=tegel1, etc
		public function colorTile(tile:Number, color:uint, alpha:Number=1):void
		{
			var tmpsprite:Sprite = new Sprite();
			tmpsprite.graphics.beginFill(color, alpha);
			tmpsprite.graphics.drawRect(0,0,this.tilesObj[tile].width,this.tilesObj[tile].height);
			tmpsprite.graphics.endFill();
			this.setTile(tile,tmpsprite);
			/*
			this.tilesObj[tile].graphics.beginFill(color, alpha);
			this.tilesObj[tile].graphics.drawRect(0,0,this.tilesObj[tile].width,this.tilesObj[tile].height);
			this.tilesObj[tile].graphics.endFill();*/
		}
		
		//Geef een tegel terug. (VERANDEREN IN getTile)
		public function returnTile(tile:int, trueNr:Boolean=false):Tile
		{
			if(trueNr == true)
			{
				if(tile >= 0)
				{
					return this.tilesObj[tile];
				}
				else
				{
					return null;
				}
			}
			else
			{
				if(tile-1 >= 0)
				{
					return this.tilesObj[tile-1];
				}
				else
				{
					return null;
				}
			}
		}
		
		//Verander een tegel door middel van de coordinaten
		public function setTileByCord(col:int, row:int):void
		{
			//
		}
		
		public function setPowerStartTile(p:int):void
		{
			var tmpMc:TubeTile = new TubeTile(maze_bookCaseElectricPoint);
			//trace(tmpMc.TileNr);
			//tmpMc.hasTubeTile = true;
			this.powerStartTile = p;
			//this.setTile(p-1, tmpMc);
			this.tilesObj[p-1].setTubeTile(tmpMc);
			//this.setTileAttr(p-1, 'hasTubeTile', true);
			//this.tilesObj[p-1].addChild(tmpMc);
		}
		
		public function setPowerEndTile(p:int):void
		{
			this.powerEndTile = p;
			var tmpMc:TubeTile = new TubeTile(maze_port1);
			this.tilesObj[p-1].setTubeTile(tmpMc);
		}
		
		public function setBookCase(tiles:Array):void
		{
			for(var i:int=0;i<tiles.length;i++)
			{
				this.setTile(tiles[i]-1, new maze_bookCase());
				this.tilesObj[tiles[i]-1].solid = true;
				this.tilesObj[tiles[i]-1].hasTubeTile = false;
				this.tilesObj[tiles[i]-1].removeEventListener(MouseEvent.CLICK, tileClicked);
			}
		}
		
		//Verander elke tegel van een kolom in de gekozen content (Bijv. een plaatje)
		public function setColom(col:int, content:*):void
		{
			if(col/this.cols <= 1)
			{
				var startTile:int = col-1;
				trace(startTile);
				var endTile:int = (this.rows*this.cols) - (this.cols - startTile);
				for(var i:int=startTile;i<=endTile;i+=this.cols)
				{
					//this.colorTile(i, 0x00FF00, 1);
					this.setTile(i, new content());
					//this.tilesObj[i].addChild(content);
				}
			}
		}
		
		//Kleur een kolom in. kolom nr vanaf 1.
		public function setColomColor(col:int, color:uint, alpha:Number=1):void
		{
			if(col/this.cols <= 1)
			{
				var startTile:int = col-1;
				var endTile:int = (this.rows*this.cols) - (this.cols - startTile);
				for(var i:int=startTile;i<=endTile;i+=this.cols)
				{
					this.colorTile(i, color, alpha);
				}
			}
		}
		
		public function setRow(row:int, content:*):void
		{
			if(row/this.rows <= 1)
			{
				var startTile:int = (row-1)*this.cols;
				var endTile:int = startTile + cols;
				for(var i:int=startTile;i<endTile;i++)
				{
					this.setTile(i, new content());
				}
			}
		}
		
		//Kleur een rij in. rij nummer vanaf 1.
		public function setRowColor(row:int, color:uint, alpha:Number=1):void
		{
			if(row/this.rows <= 1)
			{
				var startTile:int = (row-1)*this.cols;
				var endTile:int = startTile + cols;
				for(var i:int=startTile;i<endTile;i++)
				{
					this.colorTile(i, color, alpha);
				}
			}
		}
		
		
		private function createTile(tile:*, index:uint, refArray:Array):void
		{
			var TileNr:int = index + 1; //Tegel nummer is altijd index + 1. Want tegel nr 1 = index 0, etc.
			var colIndex:int = (index % cols); //wanneer index gelijk of een vermenigvuldiging van cols is dan 0. anders index.
			if(colIndex == 0)
			{
				this.curRow++; //Wanneer index gelijk is aan cols of een meervoud ervan dan +1 zodat er weer vanaf x=0 wordt begonnen met tegels neerleggen.
				
			}
			
			//refArray[index] = new MovieClip(); //Maak tegel
			refArray[index] = new Tile(TileNr);
			refArray[index].graphics.beginFill(0xFFFFFF, 0); //Witte doorzichtige tegel.
			refArray[index].graphics.drawRect(0,0,tileWidth, tileHeight); //Geef in main functie berekende breedte en hoogte mee
			refArray[index].graphics.endFill();
			
			refArray[index].addEventListener(MouseEvent.CLICK, tileClicked);
			
			//Geef de tegel een breedte en hoogte. (Doe dit pas nadat de tegel is getekent anders werkt dit niet!
			refArray[index].width = tileWidth; 
			refArray[index].height = tileHeight;
			refArray[index].x = (tileWidth*colIndex);
			refArray[index].y = (tileHeight*this.curRow);
			addChild(refArray[index]);
		}
		
		public function tileClicked(e:MouseEvent):void
		{
			this.clickedTile = e.currentTarget;
			dispatchEvent(new Event('tileClicked'));
		}
		
		public function showTileNrs(tileNrs:Array=null, realNr:Boolean=false):void
		{
			for(var i:int=0;i<this.tilesObj.length;i++)
			{
				var txtBox:TextField = new TextField();
				if(realNr==true)
				{
					txtBox.text = 'Nr: '+i;
				}
				else
				{
					var nr:int = i+1;
					txtBox.text = 'Nr: '+nr;
				}
				this.tilesObj[i].addChild(txtBox);
			}
		}
		
		public function getSurroundingTiles(tileNr:int):Object
		{
			var tileLeft:Tile;
			var tileTop:Tile;
			var tileRight:Tile;
			var tileBottom:Tile;
			
			//bereken lefttile nr.
			if(tileNr == 1 || (tileNr-1)%this.cols == 0)
			{
				tileLeft = null;
			}
			else
			{
				tileLeft = this.returnTile(tileNr - 1);
			}
			
			//bereken lefttile nr.
			if(tileNr == 1 || tileNr%this.cols == 0)
			{
				tileRight = null;
			}
			else
			{
				tileRight = this.returnTile(tileNr + 1);
			}
			
			//bereken toptile nr.
			if(tileNr - this.cols > 0)
			{
				tileTop = this.returnTile(tileNr - this.cols);
			}
			else
			{
				tileTop = null;
			}
			
			//bereken bottomtile nr.
			if(tileNr + this.cols > this.tiles)
			{
				tileBottom = null;
			}
			else
			{
				tileBottom = this.returnTile(tileNr + this.cols);
			}
			
			var tmpObj:Object = {	'tileLeft':tileLeft, 
									'tileTop':tileTop, 
									'tileRight':tileRight, 
									'tileBottom':tileBottom};
			return tmpObj;
		}
	}
}
