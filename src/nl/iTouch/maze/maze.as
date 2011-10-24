package nl.iTouch.maze
{
	import nl.iTouch.maze.Grid;
	
	public class maze extends iTouch
	{
		protected var lucas;
		protected var grid:nl.iTouch.maze.Grid;
		
		public function maze()
		{
			//super();
			
			this.grid = new Grid(500, 500, 10, 10);
		}
	}
}