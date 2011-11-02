package nl.iTouch.maze
{
	import flash.display.MovieClip;
	
	public class Tile extends MovieClip
	{
		public var solid:Boolean = false;
		public var hasTubeTile:Boolean = false;
		public var tileNr:int;
		public var tileIndexNr:int;
		public var curTubeTile:TubeTile;
		public var curChild:MovieClip;
		
		public function Tile(nr:int)
		{
			this.tileNr = nr;
			this.tileIndexNr = nr-1;
			this.width = 80;
			this.height = 80;
		}
		
		public function setTubeTile(tb:TubeTile):void
		{
			this.curTubeTile = tb;
			this.curTubeTile.width = 80;
			this.curTubeTile.height = 80;
			addChild(this.curTubeTile);
			this.hasTubeTile = true;
		}
		
		public function setChild(ch:MovieClip):void
		{
			this.curChild = ch;
			addChild(ch);
		}
		
		public function removeTubeTile():void
		{
			this.removeChild(this.curTubeTile);
			this.hasTubeTile = false;
		}
	}
}