package nl.iTouch.maze
{
	import com.greensock.TweenLite;
	
	import flash.display.*;
	import flash.events.MouseEvent;
	
	public class Controls extends MovieClip
	{
		public var tubeTilesHolder:MovieClip;
		public var tubeTilesOrder:Array = new Array();
		public var tubeTilePadding:int = 10;
		public var tubetilesholderheight:int;
		public var trashMode:Boolean = false;
		
		private var nextTubeTileBtn:MovieClip = new maze_refresh();
		private var nextTubeTileBtnP:MovieClip = new maze_refreshP();
		
		private var	trashBin:MovieClip = new maze_trash();
		private var trashBinP:MovieClip = new maze_trashP();
		
		private var prevY:int = 0;
		private var tubeTilesY:Array = new Array();
	//	private var tubeTiles:Array = new Array(maze_cross, maze_curveDouble1, maze_curveDouble2, maze_curveTL, maze_curveTR, maze_curveBL, maze_curveBR, maze_horizontal, maze_vertical);
		private var tubeTiles:Array = new Array(maze_curveTL, maze_curveTR, maze_curveBL, maze_curveBR, maze_horizontal, maze_vertical);
		
		public function Controls()
		{
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0,0,160,1024);
			graphics.endFill();
			this.x = 1120;
			this.y = 0;
			
			this.tubeTilesHolder = new MovieClip();
			this.tubeTilesHolder.graphics.beginFill(0xFF0000);
			this.tubeTilesHolder.graphics.drawRect(0,0,this.width-40, this.height-439);
			this.tubeTilesHolder.graphics.beginFill(0x00FFFF);
			this.tubeTilesHolder.graphics.drawRect(0,(this.height-439)-(this.width-40),this.width-40,this.width-40);
			this.tubeTilesHolder.graphics.endFill();
			this.tubeTilesHolder.width = this.width - 40;
			this.tubeTilesHolder.height = this.height - 439;
			this.tubetilesholderheight = this.tubeTilesHolder.height;
			this.tubeTilesHolder.x = 20;
			this.tubeTilesHolder.y = 120;
			addChild(this.tubeTilesHolder);
			
			nextTubeTileBtn.graphics.beginFill(0xFF0000);
			nextTubeTileBtn.graphics.drawRect(0,0,this.width-40, this.width-40);
			nextTubeTileBtn.graphics.endFill();
			nextTubeTileBtn.width = this.width - 40;
			nextTubeTileBtn.height = this.width - 40;
			trace(nextTubeTileBtn.width, nextTubeTileBtn.height);
			nextTubeTileBtn.x = tubeTilesHolder.x;
			nextTubeTileBtn.y = tubeTilesHolder.height + tubeTilesHolder.y + 20;
			addChild(nextTubeTileBtn);
			
			var trashBin:MovieClip = new maze_trash();
			//trashBin.graphics.beginFill(0xFF0000);
			//trashBin.graphics.drawRect(0,0,this.width-40, this.width-40);
			//trashBin.graphics.endFill();
			trashBin.width = this.width - 40;
			trashBin.height = this.width - 40;
			trashBin.x = tubeTilesHolder.x;
			trashBin.y = nextTubeTileBtn.y + nextTubeTileBtn.height + 20;
			addChild(trashBin);
			
			nextTubeTileBtn.addEventListener(MouseEvent.MOUSE_DOWN, pressNxtDown);
			nextTubeTileBtn.addEventListener(MouseEvent.MOUSE_UP, pressNxtUp);
			//trashBin.addEventListener(MouseEvent.CLICK, trashTubeTile);
			trashBin.addEventListener(MouseEvent.MOUSE_DOWN, pressTrashDown);
			trashBin.addEventListener(MouseEvent.MOUSE_UP, pressTrashUp);


			
			fillTubeTileHolder();
		}
		
		private function pressNxtDown(e:MouseEvent):void
		{
			nextTubeTileBtn.addChild(nextTubeTileBtnP);
		}
		
		private function pressNxtUp(e:MouseEvent):void
		{
			nextTubeTileBtn.removeChild(nextTubeTileBtnP);
			trace('nexttubetile');
			this.tubeTilesHolder.removeChild(this.tubeTilesOrder.shift());
			this.addTubeTile();
		}
		
		private function pressTrashDown(e:MouseEvent):void
		{
			trashBin.addChild(trashBinP);
			
		}
		
		private function pressTrashUp(e:MouseEvent):void
		{
			this.trashMode = !this.trashMode;
			if(this.trashMode == false)
			{
				trashBin.removeChild(trashBinP);
			}
		}
		
		private function fillTubeTileHolder():void
		{	
			//var prevY = 0;

			for(var i:int=0;i<5;i++)
			{
				var tmpTile:MovieClip = new TubeTile(this.tubeTiles[Math.floor(Math.random()*this.tubeTiles.length)]);
				tmpTile.width = this.tubeTilesHolder.width - tubeTilePadding;
				tmpTile.height = tmpTile.width;
				tmpTile.x = tubeTilePadding/2;
				if(i==0)
				{
					tmpTile.y = this.tubetilesholderheight - tmpTile.height - (tubeTilePadding/2);
					prevY = tmpTile.y - (tubeTilePadding/2);
				}
				else
				{
					tmpTile.y = prevY - tmpTile.height - (tubeTilePadding/2);
					prevY = tmpTile.y
				}
				/*tmpTile.x = tubeTilePadding/2;
				tmpTile.y = (tubeTilePadding/2) + prevHeight;
				if(i==4)
				{
					tmpTile.y += (tubeTilePadding/2);
				}
				prevHeight = tmpTile.y + tmpTile.height ;
				//prevY += tmpTile.y;
				trace(prevHeight);*/
				this.tubeTilesOrder.push(tmpTile);
				this.tubeTilesHolder.addChild(tmpTile);
				
				this.tubeTilesY.push(tmpTile.y);
			}	
			
			
		}
		
		public function addTubeTile():void
		{
			var lastTubeTile:MovieClip = this.tubeTilesOrder[this.tubeTilesOrder.length-1];
			var newTubeTile:MovieClip = new TubeTile(this.tubeTiles[Math.floor(Math.random()*this.tubeTiles.length)]);
			newTubeTile.height = lastTubeTile.height;
			newTubeTile.width = lastTubeTile.width;
			newTubeTile.x = lastTubeTile.x;
			newTubeTile.y = (lastTubeTile.y - lastTubeTile.height) + tubeTilePadding/2;
			this.tubeTilesOrder.push(newTubeTile);
			this.tubeTilesHolder.addChild(newTubeTile)
			//this.moveTubeTiles();
			this.tubeTilesOrder.forEach(moveTubeTile);
			
		}
		
		private function moveTubeTile(tile:MovieClip, index:int, refArray:Array):void
		{
			TweenLite.killTweensOf(tile);
			if(index==0)
			{
				TweenLite.to(tile,1,{y:this.tubeTilesY[index]});
			}
			else
			{
				TweenLite.to(tile,1,{y:tubeTilesY[index]});
			}
		}
	}
}