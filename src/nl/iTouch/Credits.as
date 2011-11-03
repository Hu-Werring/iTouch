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

			addChild(cred);	
			var Logo:LogoImage = new LogoImage();
			Logo.x = 550;
			Logo.scaleY = 3;
			Logo.scaleX = 3;
			Logo.y = 400;
			addChild(Logo);
		}
		
		public function play():void
		{
		}
		
		public function stop(force:Boolean=false):void
		{
		}
		
		public function howTo():String
		{
			return '';
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