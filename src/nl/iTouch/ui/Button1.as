package nl.iTouch.ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import nl.iTouch.iButton;
	import nl.iTouch.maze.Maze;
	
		
	public class Button1 extends Sprite
	{	
		
		private var knop:MovieClip;
		public function Button1(){
			knop = new MButton();
			addChild(new iButton(knop)); 
			knop.addEventListener(MouseEvent.CLICK, Buttonfunction);
			
		}
		
		public function Buttonfunction(e:MouseEvent)
		{
			addChild(new Maze());
		}
		
		public function setPos(_x:int,_y:int):void
		{
			x = _x;
			y = _y;
		}
	}
}