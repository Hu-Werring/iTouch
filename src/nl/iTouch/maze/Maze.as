package nl.iTouch.maze
{
	import com.greensock.TweenLite;
	
	import flash.display.*;
	import flash.display.Stage;
	import flash.events.*;
	import flash.geom.Point;
	import flash.utils.*;
	
	import nl.iTouch.*;

	
	public class Maze extends Sprite implements Game 
	{
		protected var lucas:Lucas; //Bevat het Lucas object
		protected var grid:nl.iTouch.maze.Grid; //Bevat het grid object. (Zo aanroepen anders wordt de flash functie grid gebruikt).
		protected var Control:nl.iTouch.maze.Controls //Bevat het controls object;
		private var _hs:Highscore = new Highscore('MazeGame');
		private var score:int = 0;
		private var beginTime:uint;
		private var bonusPoints:int = 1000; //30 seconden
			
		protected var _db:DataBase;
		
		public function Maze()
		{
			
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			beginTime = getTimer();
			//this.width = mazeWidth;
			//this.height = mazeHeight;
			
			this.graphics.beginFill(0x333333);
			this.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			this.graphics.endFill();
			
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
			this.grid.showTileNrs();
			this.grid.addEventListener('tileClicked', placeTubeTile); 
			this.grid.setPowerStartTile(29);
			this.grid.setPowerEndTile(56);
			this.grid.setTile(98-1, new maze_port2());
			
			//Maak een instance van controls en voeg toe aan stage.
			this.Control = new Controls();
			addChild(this.Control);
			
			//Maak lucas en zet op het veld.
			this.lucas = new Lucas(129, 84, 10);
			this.lucas.setGridTiles(this.grid.tilesObj);
			drawPath();
			addChild(this.lucas);
			
		}
		
		private function endGame():void
		{
			this.lucas.lucasMc.stop();
			this.lucas.gameEnd = true;
			for(var i=0;i<this.grid.tilesObj.length;i++)
			{
				var tmpT:Tile = this.grid.returnTile(i,true);
				if(tmpT.hasTubeTile == true)
				{
					if(tmpT.curTubeTile.powerPoint != 'false' && tmpT.curTubeTile.powerSource == false)
					{
						score++;
					}
				}
			}
			
			var timePlayed:int = Math.ceil((getTimer()-beginTime)*10);
			score += bonusPoints/timePlayed;
			
			var sw:Sprite = _hs.submitHS(score);
			if(sw !=null){
				sw.x = (this.width - sw.width)/2;
				sw.y = 100;
				TweenLite.delayedCall(3,addChild,[sw]);
				sw.addEventListener('closedSubmit',closed);
				
			}  else {
				highscore();
			}
		}
		
		private function closed(e:Event)
		{
			highscore();
		}
		

		private function placeTubeTile(e:Event):void
		{
			trace('hastubetile: '+this.grid.clickedTile.hasTubeTile);
			if(this.Control.trashMode == false)
			{
				if(this.grid.clickedTile.hasTubeTile == false)
				{
					var tmpMc:TubeTile = this.Control.tubeTilesOrder.shift();
					tmpMc.tileNr = this.grid.clickedTile.tileNr;
					//tmpMc.addChild(tmpMc.overlay);
					//tmpMc.curTubeTile.visible = false;
					//tmpMc.width = 80;
					//tmpMc.height = 80;
					TweenLite.killTweensOf(tmpMc);
					tmpMc.x = 0;
					tmpMc.y = 0;
					tmpMc.removeChild(tmpMc.background);
					//	tmpMc.alpha = 0.5;
					
					this.grid.tilesObj[this.grid.clickedTile.tileNr-1].setTubeTile(tmpMc);
					this.grid.tilesObj[this.grid.clickedTile.tileNr-1].hasTubeTile = true;
				
					trace('-------------------goandcheckpower-------------------');
					this.checkPower(this.grid.clickedTile.tileNr);
					
					this.Control.addTubeTile();

				}
			}
			else
			{
				if(this.grid.clickedTile.hasTubeTile==true)
				{
					clearTubeTile(this.grid.clickedTile.tileNr);
					removeTubeTile(this.grid.clickedTile.tileNr);
				}
			}
		}
		
		private function clearTubeTile(tileNr:int):void
		{
			var tbt:Tile = this.grid.returnTile(tileNr);
			if(tbt.hasTubeTile == true)
			{
				tbt.curTubeTile.powerPoint = 'false';
				tbt.curTubeTile.curTubeTile.visible = true;
				
				if(tbt.curTubeTile.tempLine !=null)
				{
					tbt.curTubeTile.removeChild(tbt.curTubeTile.tempLine);
				}
				tbt.curTubeTile.tempLine = null;
				if(tbt.curTubeTile.outputTile != -1)
				{
					clearTubeTile(tbt.curTubeTile.outputTile);
					tbt.curTubeTile.outputTile = -1;
				}
			}
			
			//var surroundingTiles:Object = this.grid.getSurroundingTiles(tileNr);
			//var tileLeft:Tile = surroundingTiles.tileLeft;
			//var tileTop:Tile = surroundingTiles.tileTop;
			//var tileRight:Tile = surroundingTiles.tileRight;
			//var tileBottom:Tile = surroundingTiles.tileBottom;
			
			
			/*if(tileLeft != null)
			{
				checkPower(tileLeft.tileNr);
			}
			
			if(tileRight != null)
			{
				checkPower(tileRight.tileNr);
			}
			
			if(tileTop != null)
			{
				checkPower(tileTop.tileNr);
			}
			
			if(tileBottom != null)
			{
				checkPower(tileBottom.tileNr);
			}*/
			
		}
		
		private function removeTubeTile(tileNr:int):void
		{
			this.grid.returnTile(tileNr).removeTubeTile();
		}
		
		private function checkPower(tileNr:int):void
		{
			var curTile:Tile = this.grid.returnTile(tileNr);

			if(curTile.hasTubeTile == true)
			{
				trace('checking power realy');
				var currentTubeTile:TubeTile = curTile.curTubeTile;
				var curTileNr:int = curTile.tileNr;
				
				var surroundingTiles:Object = this.grid.getSurroundingTiles(curTileNr);
				
				var tileLeft:Tile = surroundingTiles.tileLeft;
				var tileTop:Tile = surroundingTiles.tileTop;
				var tileRight:Tile = surroundingTiles.tileRight;
				var tileBottom:Tile = surroundingTiles.tileBottom;
				var inputPoint:String;
				
				/*
				var hadPower:Boolean = false;
				
				trace('before: '+currentTubeTile.powerPoint);
				if(currentTubeTile.powerPoint != 'false')
				{
					currentTubeTile.powerPoint = 'false';
					if(currentTubeTile.tempLine !=null)
					{
						currentTubeTile.removeChild(currentTubeTile.tempLine);
					}
					currentTubeTile.tempLine = null;
					hadPower = true;
				}
				trace('after' + currentTubeTile.powerPoint);*/
				
				//check links
				if(tileLeft != null)
				{
					trace('left', tileLeft.hasTubeTile);
					if(tileLeft.hasTubeTile == true)
					{
						trace('lefthastubetile');
						if(tileLeft.curTubeTile.powerPoint != 'false')
						{
							trace('haspowerpoint');
							inputPoint = this.mirrorOutput2input(tileLeft.curTubeTile.powerPoint);
							if(currentTubeTile[inputPoint] != 'false')
							{
								trace('powerfromleft');
								tileLeft.curTubeTile.outputTile = curTileNr;
								currentTubeTile.stroom(inputPoint);
							}
						}
					}
				}
				
				//check rechts
				if(tileRight != null)
				{
					trace('right');
					if(tileRight.hasTubeTile == true)
					{
						trace('righthastubetile');
						if(tileRight.curTubeTile.powerPoint != 'false')
						{
							trace('haspowerpoint');
							inputPoint = this.mirrorOutput2input(tileRight.curTubeTile.powerPoint);
							if(currentTubeTile[inputPoint] != 'false')
							{
								trace('powerfromright');
								tileRight.curTubeTile.outputTile = curTileNr;
								currentTubeTile.stroom(inputPoint);
							}
						}
					}
				}
				
				//check onder
				if(tileBottom != null)
				{
					trace('bottom');
					if(tileBottom.hasTubeTile == true)
					{
						trace('bottomhastubetile');
						if(tileBottom.curTubeTile.powerPoint != 'false')
						{
							trace('haspowerpoint');
							inputPoint = this.mirrorOutput2input(tileBottom.curTubeTile.powerPoint);
							if(currentTubeTile[inputPoint] != 'false')
							{
								trace('powerfrombottom');
								tileBottom.curTubeTile.outputTile = curTileNr;
								currentTubeTile.stroom(inputPoint);
							}
						}
					}
				}
				
				//check boven
				if(tileTop != null)
				{
					trace('top');
					if(tileTop.hasTubeTile == true)
					{
						trace('tophastubetile');
						if(tileTop.curTubeTile.powerPoint != 'false')
						{
							trace('haspowerpoint');
							inputPoint = this.mirrorOutput2input(tileTop.curTubeTile.powerPoint);
							if(currentTubeTile[inputPoint] != 'false')
							{
								trace('powerfromtop');
								tileTop.curTubeTile.outputTile = curTileNr;
								currentTubeTile.stroom(inputPoint);
							}
						}
					}
				}
				
				if(currentTubeTile.tileNr == this.grid.powerEndTile-1 && currentTubeTile.powerPoint != 'false')
				{
					//END GAME;
					trace('END THE GAME');
					this.endGame();
				}
				else
				{
						
					trace('END: '+currentTubeTile.powerPoint);
					switch(currentTubeTile.powerPoint)
					{
						case 'left':
							if(tileLeft != false)
							{
								checkPower(tileLeft.tileNr);
							}
							break;
						
						case 'right':
							if(tileRight != null)
							{
								checkPower(tileRight.tileNr);
							}
							break;
						
						case 'top':
							if(tileTop != null)
							{
								checkPower(tileTop.tileNr);
							}
							break;
						
						case 'bottom':
							if(tileBottom != null)
							{
								checkPower(tileBottom.tileNr);
							}
							break;
						/*
						case 'false':
							if(hadPower == true)
							{
								trace("hadd power, not anymore, removing tile: "+curTile.tileNr);
								clearTubeTile(curTile.tileNr);
							}
							break;
						*/
						default:
							break;
					}
				}
				
			}
		}
		
		private function mirrorOutput2input(output:String):String
		{
			var input:String;
			
			switch(output)
			{
				case 'left':
					input = 'right';
					break;
				
				case 'right':
					input = 'left';
					break;
				
				case 'top':
					input = 'bottom';
					break;
				
				case 'bottom':
					input = 'top';
					break;
				
				default:
					break;
			}
			
			return input;
		}
		
		private function drawPath():void
		{
			var startTile:* = this.grid.tilesObj[this.lucas.pathStartTile-1];
			
			var tempMc:Sprite = new Sprite();
			tempMc.graphics.lineStyle(5, 0x444444,1,false,"normal",null, JointStyle.ROUND);
			tempMc.graphics.moveTo(startTile.x + (startTile.width/2), startTile.y + (startTile.height/2));
			//tempMc.graphics.lineTo(this.grid.tilesObj[this.lucas.pathStartTile].x+10, this.grid.tilesObj[this.lucas.pathStartTile].y+100);
			//tempMc.graphics.curveTo(startTile.x + (startTile.width/2), startTile.y - (startTile.height/2), startTile.x + startTile.width, startTile.y - (startTile.height/2));
				
			for(var i:int=0;i<this.lucas.path.length-1;i++)
			{
				if(i==0){ continue }
				var curTile:* = this.grid.tilesObj[this.lucas.path[i]-1];
				var prevTile:* = this.grid.tilesObj[this.lucas.path[i-1]-1];
				var nextTile:* = this.grid.tilesObj[this.lucas.path[i+1]-1];
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
			//tmpmc.width = 80;
			//tmpmc.height = 80;
			//G.setColomColor(2, 0x2244FF, 0.5);
			//G.setColomColor(3, 0x2244FF, 0.5);
			//G.setColomColor(4, 0x2244FF, 0.5);
			G.setColom(2, maze_tapijtblauw);
			G.setColom(3, maze_tapijtblauw);
			G.setColom(4, maze_tapijtblauw);
			
			//Teken zilvere ruimte
			G.setColom(6, maze_tapijtzilver);
			G.setColom(7, maze_tapijtzilver);
			
			//Teken oranje ruimte
			G.setColom(9, maze_tapijtoranje);
			G.setColom(10, maze_tapijtoranje);
			
			//Teken rode ruimte
			G.setColom(12, maze_tapijtrood);
			G.setColom(13, maze_tapijtrood);

			//Teken gangpad
			G.setRow(5, maze_hall);
			G.setRow(6, maze_hall);
			//G.setRowColor(5, 0x555555);
			//G.setRowColor(6, 0x555555);
		}
		
		
		public function play():void
		{
			
		}
		
		public function stop(force:Boolean = false):void
		{
			
		}
		
		public function howTo():String
		{
			return 'Lucas probeert een boek te stelen van de Mediatheek, het doel van deze game is om de beveiligings poortjes aan te sluiten voordat Lucas deze bereikt.\n\Aan de rechterkant van het scherm zijn blokken met een stuk kabel te zien die op het scherm geplaatst kunnen worden.\n\nKlik op een plek op het scherm om de kabel zo te plaatsen dat deze de elektriciteitsbron met de poortjes verbind.\n\nGebruik de prullenbak om een ander blok te krijgen of om een eerder geplaatst blok te wissen.\n\nZorg dat Lucas de kabel niet doorkruist, anders knipt hij deze door en ben je af! ';
		}
		
		public function highscore():void
		{
			var hsL:Sprite = _hs.highScoreList();
			hsL.x = (this.width-hsL.width)/2;
			hsL.y = (this.height-hsL.height)/2;
			
			addChild(hsL);
		}
	}
}