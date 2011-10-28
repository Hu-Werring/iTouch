package
{
	import com.fullsizeBackgroundImage.fullsizeBackgroundImage;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import nl.iTouch.*;
	import nl.iTouch.ui.Button1;
	import nl.iTouch.ui.Button2;
	import nl.iTouch.ui.Button3;
	
	import org.osmf.layout.ScaleMode;
	
	
	[SWF(frameRate='24',backgroundColor='0xffffff', width="1280", height="1024")]
	public class iTouch extends Sprite
	{
		
		public function iTouch(){
			stage.align = "TL";
			stage.scaleMode = "noScale";
			addChild(new fullsizeBackgroundImage('UserInterface.jpg',0,0));
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