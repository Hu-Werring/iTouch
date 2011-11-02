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
			cred.width = 1280;
			cred.height = 1024;
			addChild(cred);	
			var back:HomeButton = new HomeButton();
			back.x = 900;
			back.y = 800;
			back.width = 200;
			back.height = 90;
			new iButton(back);
			addChild(back);
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
		
		public function highscore():void
		{
		}
	}
}