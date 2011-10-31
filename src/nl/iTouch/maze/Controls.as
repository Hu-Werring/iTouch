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
		
		public function Controls()
		{
			graphics.beginFill(0x000000);
			graphics.drawRect(0,0,160,1024);
			graphics.endFill();
			this.x = 1120;
			this.y = 0;
			
			var tubeTiles:Array = new Array(maze_cross,maze_curveDouble);

			this.tubeTilesHolder = new MovieClip();
			this.tubeTilesHolder.graphics.beginFill(0xFF0000);
			this.tubeTilesHolder.graphics.drawRect(0,0,this.width-40, this.height-439);
			this.tubeTilesHolder.graphics.beginFill(0x00FFFF);
			this.tubeTilesHolder.graphics.drawRect(0,(this.height-439)-(this.width-40),this.width-40,this.width-40);
			this.tubeTilesHolder.graphics.endFill();
			this.tubeTilesHolder.width = this.width - 40;
			this.tubeTilesHolder.height = this.height - 439;
			this.tubeTilesHolder.x = 20;
			this.tubeTilesHolder.y = 20;
			addChild(this.tubeTilesHolder);
			trace(this.tubeTilesHolder.width);
			
			var nextTubeTileBtn:MovieClip = new MovieClip();
			nextTubeTileBtn.graphics.beginFill(0xFF0000);
			nextTubeTileBtn.graphics.drawRect(0,0,this.width-40, this.width-40);
			nextTubeTileBtn.graphics.endFill();
			nextTubeTileBtn.width = this.width - 40;
			nextTubeTileBtn.height = this.width - 40;
			nextTubeTileBtn.x = tubeTilesHolder.x;
			nextTubeTileBtn.y = tubeTilesHolder.height + tubeTilesHolder.y + 20;
			addChild(nextTubeTileBtn);
			
			var trashBin:MovieClip = new MovieClip();
			trashBin.graphics.beginFill(0xFF0000);
			trashBin.graphics.drawRect(0,0,this.width-40, this.width-40);
			trashBin.graphics.endFill();
			trashBin.width = this.width - 40;
			trashBin.height = this.width - 40;
			trashBin.x = tubeTilesHolder.x;
			trashBin.y = nextTubeTileBtn.y + nextTubeTileBtn.height + 20;
			addChild(trashBin);
			
			nextTubeTileBtn.addEventListener(MouseEvent.CLICK, nextTubeTile);
			trashBin.addEventListener(MouseEvent.CLICK, trashTubeTile);
			
			fillTubeTileHolder();
		}
		
		private function nextTubeTile(e:MouseEvent):void
		{
			trace('nexttubetile');
		}
		
		private function trashTubeTile(e:MouseEvent):void
		{
			trace('trashed');
		}
		
		private function fillTubeTileHolder():void
		{	
			var prevHeight:Number = 0;
			//var prevY = 0;

			for(var i:int=0;i<5;i++)
			{
				var tmpTile:MovieClip = new maze_cross();
				tmpTile.width = this.tubeTilesHolder.width - tubeTilePadding;
				tmpTile.height = tmpTile.width;
				tmpTile.x = tubeTilePadding/2;
				tmpTile.y = (tubeTilePadding/2) + prevHeight;
				if(i==4)
				{
					tmpTile.y += (tubeTilePadding/2);
				}
				prevHeight = tmpTile.y + tmpTile.height ;
				//prevY += tmpTile.y;
				trace(prevHeight);
				this.tubeTilesOrder.unshift(tmpTile);
				this.tubeTilesHolder.addChild(tmpTile);
			}	
			
		}
		
		public function addTubeTile():void
		{
			var lastTubeTile:MovieClip = this.tubeTilesOrder[this.tubeTilesOrder.length-1];
			var newTubeTile:MovieClip = new maze_cross();
			newTubeTile.height = lastTubeTile.height;
			newTubeTile.width = lastTubeTile.width;
			newTubeTile.x = lastTubeTile.x;
			newTubeTile.y = (lastTubeTile.y - lastTubeTile.height) - tubeTilePadding;
			this.tubeTilesOrder.push(newTubeTile);
			this.tubeTilesHolder.addChild(newTubeTile)
			//this.moveTubeTiles();
			this.tubeTilesOrder.forEach(moveTubeTile);
			
		}
		
		private function moveTubeTile(tile:MovieClip, index:int, refArray:Array):void
		{
			if(index==0)
			{
				TweenLite.to(tile,1,{y:tile.y+tile.height+ tubeTilePadding});
			}
			else
			{
				TweenLite.to(tile,1,{y:tile.y+tile.height+ (tubeTilePadding/2)});
			}
		}
	}
}