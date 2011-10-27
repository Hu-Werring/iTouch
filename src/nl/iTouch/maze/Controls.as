package nl.iTouch.maze
{
	import flash.display.*;
	import flash.events.MouseEvent;
	
	public class Controls extends MovieClip
	{
		public function Controls()
		{
			graphics.beginFill(0x000000);
			graphics.drawRect(0,0,160,1024);
			graphics.endFill();
			this.x = 1120;
			this.y = 0;
			
			var tubeTilesHolder:Sprite = new Sprite();
			tubeTilesHolder.graphics.beginFill(0xFF0000);
			tubeTilesHolder.graphics.drawRect(0,0,this.width-40, this.height-350);
			tubeTilesHolder.graphics.endFill();
			tubeTilesHolder.width = this.width - 40;
			tubeTilesHolder.height = this.height - 350;
			tubeTilesHolder.x = 20;
			tubeTilesHolder.y = 20;
			
			addChild(tubeTilesHolder);
			
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
		}
		
		private function nextTubeTile(e:MouseEvent):void
		{
			trace('nexttubetile');
		}
		
		private function trashTubeTile(e:MouseEvent):void
		{
			trace('trashed');
		}
	}
}