package nl.iTouch.maze
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
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
		
		public var curRow:int = -1; //Houd de rijen aan wanneer het grid word neer gelegd.
		public var curCol:int;//Houd de colommen aan wanneer het grid word neer gelegd
		
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
			this.tilesObj[tile] = content;
		}
		
		//Kleur een specifieke tegel. (tile = indexnr) of tewel tile0=index0=tegel1, etc
		public function colorTile(tile:Number, color:uint, alpha=1):void
		{
			this.tilesObj[tile].graphics.beginFill(color, alpha);
			this.tilesObj[tile].graphics.drawRect(0,0,this.tilesObj[tile].width,this.tilesObj[tile].height);
			this.tilesObj[tile].graphics.endFill();
		}
		
		//Geef een tegel terug. (VERANDEREN IN getTile)
		public function returnTile(tile:int):MovieClip
		{
			return this.tilesObj[tile];
		}
		
		//Verander een tegel door middel van de coordinaten
		public function setTileByCord(col:int, row:int):void
		{
			//
		}
		
		//Verander elke tegel van een kolom in de gekozen content (Bijv. een plaatje)
		public function setColom(col:int, content:*):void
		{
			if(col/this.cols <= 1)
			{
				var startTile:int = col-1;
				var endTile:int = (this.rows*this.cols) - (this.cols - startTile);
				for(var i:int=startTile;i<=endTile;i+=this.cols)
				{
					this.setTile(i, content);
				}
			}
		}
		
		//Kleur een kolom in. kolom nr vanaf 1.
		public function setColomColor(col:int, color:uint, alpha=1):void
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
		
		//Kleur een rij in. rij nummer vanaf 1.
		public function setRowColor(row:int, color:uint, alpha=1):void
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
			
			refArray[index] = new MovieClip(); //Maak tegel
			refArray[index].graphics.beginFill(0xFFFFFF, 0); //Witte doorzichtige tegel.
			refArray[index].graphics.drawRect(0,0,tileWidth, tileHeight); //Geef in main functie berekende breedte en hoogte mee
			refArray[index].graphics.endFill();
			
			//Geef de tegel een breedte en hoogte. (Doe dit pas nadat de tegel is getekent anders werkt dit niet!
			refArray[index].width = tileWidth; 
			refArray[index].height = tileHeight;
			refArray[index].x = (tileWidth*colIndex);
			refArray[index].y = (tileHeight*this.curRow);
			addChild(refArray[index]);
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
	}
}