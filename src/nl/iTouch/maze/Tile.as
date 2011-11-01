package nl.iTouch.maze
{
	import flash.display.MovieClip;
	
	public class Tile extends MovieClip
	{
		public var solid:Boolean = true;
		public var tileNr:int;
		public var tileIndexNr:int;
		
		public function Tile(nr:int)
		{
			this.tileNr = nr;
			this.tileIndexNr = nr-1;
		}
	}
}