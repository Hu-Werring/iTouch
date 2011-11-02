package nl.iTouch
{
	import flash.display.Sprite;
	import flash.events.*;
	
	
	public class Credits extends Sprite implements Game
	{
		public function Credits()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var cred:CreditsImage = new CreditsImage();
			cred.width = 1300;
			cred.height = 1024;
			cred.x=25;
			addChild(cred);	
			var Logo:LogoImage = new LogoImage();
			Logo.x = 600;
			Logo.width = 400;
			Logo.height = 330;
			Logo.y = 400;
			addChild(Logo);
		}
		
		public function play():void
		{
		}
		
		public function stop(force:Boolean=false):void
		{
		}
		
		public function howTo():void
		{
		}
		
		public function gotoHome(e:MouseEvent):void
		{
			dispatchEvent(new Event('BACK'));
		}
		
		public function highscore():void
		{
		}
	}
}