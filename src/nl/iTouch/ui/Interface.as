package nl.iTouch.ui
{
	import com.fullsizeBackgroundImage.fullsizeBackgroundImage;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Interface extends Sprite
	{
		public function Interface()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			
			
			addChild(new fullsizeBackgroundImage('UIV2.jpg',0,0));
			var button1:Button1 = new Button1();
			var button2:Button2 = new Button2();
			var button3:Button3 = new Button3();
			button1.setPos(300,300);
			button2.setPos(600,300);
			button3.setPos(300,600);
			addChild( button1);
			addChild( button2);
			addChild( button3);
		}
	}
}