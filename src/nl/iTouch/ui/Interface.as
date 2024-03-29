package nl.iTouch.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Interface extends Sprite
	{
		public static const START_SNAKE:String = 'startSnake';
		public static const START_MAZE:String = 'startMaze';
		public static const START_GUESS:String = 'startGuess';
		public static const START_CREDITS:String = 'startCredits';
		
		public function Interface()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			var button1:Button1 = new Button1();
			var button2:Button2 = new Button2();
			var button3:Button3 = new Button3();
			var button4:Button4 = new Button4();
			var bgui:BackgroundUI= new BackgroundUI;	
			
			button1.setPos(304,346);
			button2.setPos(560,367);
			button3.setPos(818,368);
			button4.setPos(1100,920);
			addChild( bgui);
			addChild( button1);
			addChild( button2);
			addChild( button3);
			addChild( button4);
		}
	}
}