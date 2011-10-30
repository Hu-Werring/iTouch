package nl.iTouch.ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import nl.iTouch.guessgame.GuessGame;
	import nl.iTouch.iButton;
	
	public class Button3 extends Sprite
	{
		private var knop:MovieClip;
		public function Button3(){ 
			knop = new GButton();
			addChild(new iButton (knop));
			
			knop.addEventListener(MouseEvent.CLICK, Buttonfunction);
		}
		
		public function Buttonfunction(e:MouseEvent)
		{
			addChild(new GuessGame());
		}
		
		public function setPos(_x:int,_y:int):void
		{
			x = _x;
			y = _y;
		}
	}
}