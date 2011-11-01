package nl.iTouch.maze
{
	import com.greensock.TweenLite;
	
	import flash.display.*;
	import flash.display.Stage;
	import flash.events.*;
	import flash.geom.Point;
	
	import nl.iTouch.*;

	
	public class Maze extends Sprite implements Game 
	{
		protected var lucas:Lucas; //Bevat het Lucas object
		protected var grid:nl.iTouch.maze.Grid; //Bevat het grid object. (Zo aanroepen anders wordt de flash functie grid gebruikt).
		protected var Control:nl.iTouch.maze.Controls //Bevat het controls object;
		
		protected var _db:DataBase;
		
		public function Maze()
		{
			
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			//this.width = mazeWidth;
			//this.height = mazeHeight;
			/*
			this.graphics.beginFill(0xFF0000);
			this.graphics.drawRect(0,0,100,100);
			this.graphics.endFill();
			*/
			//_db = DataBase.getInstance;
			
			//Plaats het spel in de linker bovenhoek van de game area.
			this.x = 0; 
			this.y = 0;
			
			//maak een nieuw grid en plaats deze links boven in het spel.
			this.grid = new Grid(1120, 800, 14, 10);
			this.grid.x = 0;
			this.grid.y = 0;
			
			//Kleur de grid tegels in zodat er een mediatheek formaat ontstaat, en voeg toe.
			colorGrid(this.grid);
			addChild(this.grid);
			//this.grid.showTileNrs();
			this.grid.addEventListener('tileClicked', placeTubeTile); 
			
			//Maak een instance van controls en voeg toe aan stage.
			this.Control = new Controls();
			addChild(this.Control);
			
			//Maak lucas en zet op het veld.
			this.lucas = new Lucas(129, 84, 10);
			this.lucas.setGridTiles(this.grid.tilesObj);
			addChild(this.lucas);
			drawPath();
		}

		private function placeTubeTile(e:Event):void
		{
				var tmpMc:MovieClip = this.Control.tubeTilesOrder.shift();
				tmpMc.width = 80;
				tmpMc.width = 80;
				TweenLite.killTweensOf(tmpMc);
				tmpMc.x = this.grid.clickedTile.x;
				tmpMc.y = this.grid.clickedTile.y;
				tmpMc.tileNr = this.grid.clickedTile.tileNr;
				tmpMc.alpha = 0.5;
				this.grid.clickedTile.removeEventListener(MouseEvent.CLICK, this.grid.tileClicked);
				//this.grid.colorTile(this.grid.clickedTile.tileNr, 0xFFFFFF);
				this.grid.setTile(this.grid.clickedTile.tileNr, tmpMc);
				this.Control.addTubeTile();
		}
		
		private function drawPath():void
		{
			var startTile = this.grid.tilesObj[this.lucas.pathStartTile-1];
			
			var tempMc:Sprite = new Sprite();
			tempMc.graphics.lineStyle(5, 0x444444,1,false,"normal",null, JointStyle.ROUND);
			tempMc.graphics.moveTo(startTile.x + (startTile.width/2), startTile.y + (startTile.height/2));
			//tempMc.graphics.lineTo(this.grid.tilesObj[this.lucas.pathStartTile].x+10, this.grid.tilesObj[this.lucas.pathStartTile].y+100);
			//tempMc.graphics.curveTo(startTile.x + (startTile.width/2), startTile.y - (startTile.height/2), startTile.x + startTile.width, startTile.y - (startTile.height/2));
				
			for(var i:int=0;i<this.lucas.path.length-1;i++)
			{
				if(i==0){ continue }
				var curTile = this.grid.tilesObj[this.lucas.path[i]-1];
				var prevTile = this.grid.tilesObj[this.lucas.path[i-1]-1];
				var nextTile = this.grid.tilesObj[this.lucas.path[i+1]-1];
				var fromPoint:Point = new Point(curTile.x + (curTile.width / 2), curTile.y + (curTile.height/2));
				var toPoint:Point = new Point(nextTile.x + (nextTile.width / 2), nextTile.y + (nextTile.height/2));
				
				//tempMc.graphics.moveTo(fromPoint.x, fromPoint.y);
				tempMc.graphics.lineTo(toPoint.x, toPoint.y);
			
				
			}
			
			addChild(tempMc);
		}
		
		//Kleur het grid in zodat het een mediatheek lijkt.
		private function colorGrid(G:Grid):void
		{
			//Teken de boekenkasten
			G.setColomColor(1, 0x886644);
			G.setColomColor(5, 0x886644);
			G.setColomColor(8, 0x886644);
			G.setColomColor(11, 0x886644);
			G.setColomColor(14, 0x886644);
			
			G.setBookCase(new Array(1,15,29,43, 5,19,33,47, 8,22,36,50, 11,25,39,53, 14,28,42,56, 
									85,99,113,127, 89,103,117,131, 92,106,120,134, 95,109,123,137, 98,112,126,140));
			
			//Teken blauwe ruimte
			G.setColomColor(2, 0x2244FF, 0.5);
			G.setColomColor(3, 0x2244FF, 0.5);
			G.setColomColor(4, 0x2244FF, 0.5);
			
			//Teken zilvere ruimte
			G.setColomColor(6, 0xDDDDDD, 0.5);
			G.setColomColor(7, 0xDDDDDD, 0.5);
			
			//Teken oranje ruimte
			G.setColomColor(9, 0xFF9933, 0.5);
			G.setColomColor(10, 0xFF9933, 0.5);
			
			//Teken rode ruimte
			G.setColomColor(12, 0xFF0000, 0.5);
			G.setColomColor(13, 0xFF0000, 0.5);

			//Teken gangpad
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