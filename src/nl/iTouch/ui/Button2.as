package nl.iTouch.ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.iTouch.iButton;
	import nl.iTouch.snake.Snake;
	
	public class Button2 extends Sprite
	{	
		private var knop:MovieClip;
		public function Button2(){
			knop = new SnakeButton();
			addChild(new iButton(knop)); 
			
			knop.addEventListener(MouseEvent.CLICK, Buttonfunction);
			
		}
		
		public function Buttonfunction(e:MouseEvent):void
		{
			this.parent.dispatchEvent(new Event(Interface.START_SNAKE));
		}
		public function setPos(_x:int,_y:int):void
		{
			x = _x;
			y = _y;
		}
	}
}